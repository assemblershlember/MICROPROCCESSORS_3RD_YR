#include p18f87k22.inc
    
;___________ globalising delay routines ____________
    global  LCD_delay_x4us , LCD_delay_ms, LCD_delay
;___________ globalising GLCD WRITING routines ___________
    global GLCD_STARTUP,GLCD_WRITE_BYTE,GLCD_WRITE_BYTE_FAST,E_PULSE
;___________ globalising GLCD CS activation/deactivation routines ____________
    GLOBAL GLCD_CS0,GLCD_CS1,GLCD_CS_BOTH
    
    
    extern INC_Y_POINTER

    
acs0    udata_acs   ; named variables in access ram
LCD_cnt_l   res 1   ; reserve 1 byte for variable LCD_cnt_l
LCD_cnt_h   res 1   ; reserve 1 byte for variable LCD_cnt_h
LCD_cnt_ms  res 1   ; reserve 1 byte for ms counter
LCD_tmp	    res 1   ; reserve 1 byte for temporary use
LCD_counter res 1   ; reserve 1 byte for counting through nessage

	constant    LCD_E=5	; LCD enable bit
    	constant    LCD_RS=4	; LCD register select bit

	
;*******************************************************************************
;lIST OF ROUNTINES
	
;GLCD_STARTUP - TURNIGN ON AND INITALISING
	
;GLCD_CS0 - SETS ONLY CS0 ACTIVE
	
;GLCD_CS1 - SETS ONLY CS1 ACTIVE
	
;GLCD_CS_BOTH - SETS BOTH ACITVE AT THE SAME TIME
	
;GLCD_WRITE_BYTE - WRITES BYTES TO GLCD WOITH VISUAL DELAY TO LOOK NICE
	
; GLCD_WRITE_BYTE_FAST - FAST WITH MINIMAL DELAY FOR RAPID ICON PRINTING
   
;Delays 
;LCD_delay_ms  - millisecond  dealy, iterates value of WREG
;LCD_delay_4Xus- 4 micro second dealy, iterates value of WREG
	
;*******************************************************************************	
	

GLCD	code

GLCD_STARTUP ; STARTING UP GLCD
	
	;CLEARING ALL REGISTERS 
	CLRF    LATB
	CLRF	TRISB
	clrf    LATD
	CLRF	TRISD
	
	;BCF LATB, RB5 ; ENABLING THEN DISABLING THE RESET PINT (RB5)
	movlw   .100
	call	LCD_delay_ms	; wait 50ms 
	
	BSF LATB, RB5 ; turning reset pin off
	
	movlw   .100
	call	LCD_delay_ms	; wait 50ms 
	RETURN

; =============== TURN ON CS0 ======================
	

GLCD_CS0 ; SETS ONLY THE LEFT HAND DISPLAY TO BE ACTIVE
	
	
	BCF LATB, RB0 ;CS0 
	BSF LATB, RB1 ;CS1
	
	movlw	.2   ; delay 40us
	call	LCD_delay_ms
	
	movlw   b'00111111'  ; loading requisite instruction into D bus
	movwf	LATD

;	movlw	.20   ; delay 40us
;	call	LCD_delay_ms
	
	BCF LATB, RB2	; SET RS LINE LOW
	BCF LATB, RB3	; RW Line low
	call E_PULSE	
	
	movlw	.2   ; delay 40us
	call	LCD_delay_ms
	RETURN
	
; =============== TURN ON CS1 ======================		
	
GLCD_CS1 ; SETS ONLY THE RIGHT HAND DISPLAY TO BE ACTIVE
	

	BSF LATB, RB0 ;CS0
	BCF LATB, RB1 ;CS1
	
	movlw	.2   ; delay 40us
	call	LCD_delay_ms
	
	movlw   b'00111111'  ; loading requisite instruction into D bus
	movwf	LATD
	
;	movlw	.2   ; delay 40us
;	call	LCD_delay_ms
	
	BCF LATB, RB2	; SET RS LINE LOW
	BCF LATB, RB3	; RW Line low
	call E_PULSE
	
	movlw	.2   ; delay 40us
	call	LCD_delay_ms
	RETURN
	
; ============================ CS1&2 ==========================================	
	
GLCD_CS_BOTH ;TURNS BOTH CS DISPLAYS ON
	
	;___________ Turning CS1 Display on ___________
	
	BCF LATB, RB0 ;CS0
	BCF LATB, RB1 ;CS1
	
	movlw	.20   ; delay 40us
	call	LCD_delay_ms
	
	movlw   b'00111111'  ; loading instruction in D bus
	movwf	LATD
	
	movlw	.20   ; delay 40us
	call	LCD_delay_ms
	
	BCF LATB, RB2	; SET RS LINE LOW
	BCF LATB, RB3	; RW Line low
	call E_PULSE
	
	movlw	.20   ; delay 40us
	call	LCD_delay_ms
	RETURN	
	
	
;==================== NORMAL SPEED TEXT OUTPUT =================================
GLCD_WRITE_BYTE ; FIRST BYTE OF MESSAGE AT FSR0
		; length stored in W
	;MOVWF	.5	
	movwf   LCD_counter	
	
	; SETTING RS & RW PINS TO RECIVE (WRITE) MODE
	BSF LATB, RB2 ; SET RS LINE HIGH
	BCF LATB, RB3 ; RW Line low
	
GLCD_LOOP_BLOCK
	; SENDS BYTE STORED AT FSR0 TO GLCD
	MOVFF   POSTINC0, LATD
	
	;movlw	.20   ; delay 40us
	;call	LCD_delay_ms
	
	CALL E_PULSE
	
	movlw	.100   ; delay 40us
	
	call	LCD_delay_x4us
	
	
	decfsz	LCD_counter
	bra	GLCD_LOOP_BLOCK
	
	
	CLRF FSR0
	return
	
;===============================================================================	
	
GLCD_WRITE_BYTE_FAST 
	; FIRST BYTE OF MESSAGE AT FSR0
		; length stored in W
		;WRITES QUICKLY FOR DISPLAYING ICONS
		
	;MOVWF	.5	
	movwf   LCD_counter	
	
	; SETTING RS & RW PINS TO RECIVE (WRITE) MODE
	BSF LATB, RB2 ; SET RS LINE HIGH
	BCF LATB, RB3 ; RW Line low
	
GLCD_LOOP_BLOCK_FST
	; SENDS BYTE STORED AT FSR0 TO GLCD
	MOVFF   POSTINC0, LATD
	
	movlw	.2   ; delay 2
	call	LCD_delay_x4us
	
	CALL E_PULSE
	
;	movlw	.1   ; delay 40us
;	call	LCD_delay_x4us
	
	
	decfsz	LCD_counter
	bra	GLCD_LOOP_BLOCK_FST
	
	
	CLRF FSR0
	return		
	
;===============================================================================	
	
E_PULSE	    ; pulse enable bit GLCD for 500ns
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	NOP
	NOP
	bsf	    LATB, RB4	    ; Take enable high
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	NOP
	NOP
	bcf	    LATB, RB4	    ; Writes data to GLCD on transition
	return
	
	
	
	
	
;========================= DELAY ROUTINE ======================================
	
    
; ** a few delay routines below here as LCD timing can be quite critical ****
LCD_delay_ms		    ; delay given in ms in W
	movwf	LCD_cnt_ms
lcdlp2	movlw	.250	    ; 1 ms delay
	call	LCD_delay_x4us	
	decfsz	LCD_cnt_ms
	bra	lcdlp2
	return
    
LCD_delay_x4us		    ; delay given in chunks of 4 microsecond in W
	movwf	LCD_cnt_l   ; now need to multiply by 16
	swapf   LCD_cnt_l,F ; swap nibbles
	movlw	0x0f	    
	andwf	LCD_cnt_l,W ; move low nibble to W
	movwf	LCD_cnt_h   ; then to LCD_cnt_h
	movlw	0xf0	    
	andwf	LCD_cnt_l,F ; keep high nibble in LCD_cnt_l
	call	LCD_delay
	return

LCD_delay			; delay routine	4 instruction loop == 250ns	    
	movlw 	0x00		; W=0
lcdlp1	
	decf 	LCD_cnt_l,F	; no carry when 0x00 -> 0xff
	subwfb 	LCD_cnt_h,F	; no carry when 0x00 -> 0xff
	bc 	lcdlp1		; carry, then loop again
	return			; carry reset so return


    end


