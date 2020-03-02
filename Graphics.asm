#include p18f87k22.inc
    
    
    extern  LCD_delay_x4us, LCD_delay_ms, GLCD_WRITE_BYTE_FAST
    extern E_PULSE, AR_SEA_ICON, AR_PARA_ICON 
    
    global G_FILL_SEA, PRINT_PARA
    
    ;global KP_SETUP,CHECK_KP,BARGE_SETUP, GET_BARGE_LOC 
    
    extern E_PULSE, GET_Y_POINTER, SET_Y_POINTER, GLCD_SET_Y , GLCD_SET_X
    
    
;    GLOBAL RATE_TEST_ROUTINE
;    extern LEX_LOAD_RAM_ICONS_TEST, LEX_LOAD_RAM_ICONS_TEST2
    
acs0	udata_acs
	
GRAPHICS_LOOP_COUNTER res 1
    
Graphics code

PRINT_PARA
    
    	lfsr FSR0, AR_PARA_ICON
	movlw .5
	call GLCD_WRITE_BYTE_FAST
 
 
    RETURN
 
 
 
 
G_FILL_SEA
 
	MOVLW	0x00
	CALL	SET_Y_POINTER
	
	;MOVLW .7
	;CALL GLCD_SET_X
	
	BCF LATB, RB2 ; SET RS LINE LOW
	BCF LATB, RB3 ; RW Line low
	
	movlw   b'10111111'  ; loading instruction in D bus (last 3 bits are X address
	movwf	LATD
	call E_PULSE
	
	
	movlw	.16     ; should this be 8
	movwf	GRAPHICS_LOOP_COUNTER
	
FSEALP	
	
	lfsr FSR0, AR_SEA_ICON
	movlw .8
	call GLCD_WRITE_BYTE_FAST
	
	DECFSZ	GRAPHICS_LOOP_COUNTER
	bra 	FSEALP		
	
	RETURN

	
	
	

;RATE_TEST_ROUTINE
;	
;	
;;SEE HOW LONG THE PTINR PARA ROUTINE TAKES WITH AND OCCILOSCOPE
;	
;
;	call	LEX_LOAD_RAM_ICONS_TEST
;	
;	
;	
;	
;	
;	lfsr	FSR0, AR_PARA_ICON
;	movlw	.5
;	call	GLCD_WRITE_BYTE_FAST
;	
;
;	
;	
;	
;	
;	
;	
;	
;	CALL PRINT_PARA
;	
;	
;
;	call	LEX_LOAD_RAM_ICONS_TEST2
;	
;
;	
;PRINT_PARA_MANUAL_PM
;	
;
;	BSF LATB, RB2 ; SET RS LINE HIGH
;	BCF LATB, RB3 ; RW Line low
;	
;	movlw   b'00010000'  ; loading instruction in D bus
;	movwf	LATD
;	call E_PULSE
;	;movlw   .1
;	;call	LCD_delay_x4us	; wait 10ms 
;	
;	movlw   b'00001000'  ; loading instruction in D bus
;	movwf	LATD
;	call E_PULSE
;;	movlw   .10
;;	call	LCD_delay_x4us	; wait 10ms 
;	movlw   b'01101000'  ; loading instruction in D bus
;	movwf	LATD
;	call E_PULSE
;	;movlw   .1
;	;call	LCD_delay_x4us	; wait 10ms 
;	
;	movlw   b'00001000'  ; loading instruction in D bus
;	movwf	LATD
;	call E_PULSE
;	;movlw   .1
;	;call	LCD_delay_x4us	; wait 10ms 
;	
;	movlw   b'00010000'  ; loading instruction in D bus
;	movwf	LATD
;	call E_PULSE
;	;movlw   .1
;	;call	LCD_delay_x4us	; wait 10ms 
;
;	movlw   b'00010000'  ; loading instruction in D bus
;	movwf	LATD
;	call E_PULSE
;	;movlw   .1
;	;call	LCD_delay_x4us	; wait 10ms 
;	
;	movlw   b'00001000'  ; loading instruction in D bus
;	movwf	LATD
;	call E_PULSE
;;	movlw   .10
;;	call	LCD_delay_x4us	; wait 10ms 
;	movlw   b'01101000'  ; loading instruction in D bus
;	movwf	LATD
;	call E_PULSE
;	;movlw   .1
;	;call	LCD_delay_x4us	; wait 10ms 
;	
;	movlw   b'00001000'  ; loading instruction in D bus
;	movwf	LATD
;	call E_PULSE
;	;movlw   .1
;	;call	LCD_delay_x4us	; wait 10ms 
;	
;	movlw   b'00010000'  ; loading instruction in D bus
;	movwf	LATD
;	call E_PULSE
;	;movlw   .1
;	;call	LCD_delay_x4us	; wait 10ms 
;	
;
;;	GOTO RATE_TEST_ROUTINE
;;	
;	
	

	
    end