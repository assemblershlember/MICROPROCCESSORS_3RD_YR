	#include p18f87k22.inc
	
	;extern	UART_Setup, UART_Transmit_Message  ; external UART subroutines
	extern  LCD_delay_x4us, LCD_delay_ms,GLCD_WRITE_BYTE, GLCD_WRITE_BYTE_FAST ,LCD_delay	    ; external LCD subroutines
	
	extern G_FILL_SEA
	
	extern E_PULSE, GET_Y_POINTER, SET_Y_POINTER, GLCD_SET_Y, SET_X_POINTER, SET_COUNTER
	
	EXTERN AR_BARGE_ICON
	
	global KP_SETUP,CHECK_KP,BARGE_SETUP, GET_BARGE_LOC ; importing graphics rountines
	

	
ACS_PAD	    udata_acs   ; reserve data space in access ram
	

 ;__________KP__ reservations _________
rownum	    res 1 ; reseve on byte for row hex value
colnum	    res 1 ; resere 1 byte for column variable

total_kp    res 1 ; total key press, result of addition of rownum & colnum
TEMP	    res 1
	
;______________ BARGE RESERVATIONS ___________	
Y_POINTER_BARGE res 1	    
BARGE_TEMP	RES 1
BARGE_COUNTER	RES 1 	
	
;_________ X,Y POINTER BUFFERS______________	
    
    
;rst	code	0    ; reset vector
PAD code 
    
    
;==================== KEYPAD SETUP ======================
    
KP_SETUP
	;SETTING PORTE PULL UPS TO ON
	clrf LATE
	
	banksel PADCFG1 ; PADCFG1 is not in Access Bank
	bsf PADCFG1, REPU, BANKED ; PortE pull-ups on
	movlb 0x00 ; set BSR back to Bank 0
	
	RETURN	
	
	
;========================================================
		    ;KEYPAD ACTION
;========================================================	

CHECK_KP

	;# this will change the start value of W
	; may need to store the OG value of W used in the delay

	MOVWF TEMP

	;setting values of col and row to 0 
	movlw 0x00
	movwf colnum
	movlw 0x00
	movwf rownum
	movlw 0x00
	movwf total_kp
	
    	;SETTING TRISE
	movlw 0x0F ;PINS 4:7 are in
	movwf TRISE
	
		
	movlw .5
	call LCD_delay_x4us
	
	;move value of PORTE into address rownum 
	movff PORTE, rownum
	BTG rownum, 0, 0 ; 
	BTG rownum, 1, 0
	BTG rownum, 2, 0
	BTG rownum, 3, 0

	;flipping pins
	movlw 0xF0 ; PINS 0:3 are in
	movwf TRISE
	
	movlw .5
	call LCD_delay_x4us
	
	;moving new value to second mem location

	movff PORTE, colnum	
	BTG colnum, 4, 0
	BTG colnum, 5, 0
	BTG colnum, 6, 0
	BTG colnum, 7, 0

	;Inverts values of bits & creates 4 cycle delay

	; add the the 'row' & 'column val' to get 'total_kp'
	
	movlw 0x00; clears W

	addwf rownum,0,0;  add row to w 
	addwf colnum,0,0 ; add col to w

	movwf total_kp ; moving back into total_kp
	
	;//////// CHECK IF E IS PRESSED //////////
	movlw 0x14  ; num that correspondes to right
	CPFSEQ total_kp ;see if key press is right
	BRA CHKLFTPRS
	
;	movlw .5
;	call LCD_delay_x4us
	;set E to right
	CALL KP_MOV_RIGHT
	
	;movlw   .20
	;call	LCD_delay_ms	; wait 10ms
	
	
	BRA POSTKP ; THIS IS UNNECCESSARY 
	
	;//////// CHECK IF 4 IS PRESSED //////////
	
CHKLFTPRS
	movlw 0x84 ; num that correspondes to lft
	CPFSEQ total_kp ;see if key press is lft
	BRA CHKFKEYFPRS
	
;	movlw .5
;	call LCD_delay_x4us
	;set 4 to left
	CALL KP_MOV_lEFT
	
	BRA POSTKP
	
	;//////// CHECK IF F KEY IS PRESSED //////////
CHKFKEYFPRS
	movlw 0x18  ; num that correspondes TO F
	CPFSEQ total_kp ;see if key press is F
	BRA POSTKP 
	
;	movlw .5
;	call LCD_delay_x4us
	;set E to right
	MOVLW .4
	CALL SET_COUNTER
	
	;movlw   .20
	;call	LCD_delay_ms	; wait 10ms
	
	
	BRA POSTKP
	
POSTKP
	
	MOVLW 0x00


	RETURN    
;=======================================================
GET_BARGE_LOC
    MOVF Y_POINTER_BARGE, 0
    RETURN
	

	
;================== BARGE SETUP ========================
	
BARGE_SETUP
	
    MOVLW .30
    MOVWF Y_POINTER_BARGE
    CALL PRINT_BARGE
    RETURN	

    
;================= BARGE MOVEMENT =====================

KP_MOV_RIGHT
    
    MOVLW .48  
    CPFSGT Y_POINTER_BARGE
    INCF Y_POINTER_BARGE, 1
    
    ;THIS MIGHT SLOW IT DOWN A WEE BIT
    CALL PRINT_BARGE
    
    RETURN
 
 
KP_MOV_lEFT
    MOVLW 0x01
    CPFSLT Y_POINTER_BARGE
    DECF Y_POINTER_BARGE, 1
    CALL PRINT_BARGE
    
    RETURN    

    
;================== BARGE PRINT ========================    
PRINT_BARGE
    
    CALL G_FILL_SEA
    
    MOVF Y_POINTER_BARGE, 0
    
    CALL SET_Y_POINTER
   
    
    lfsr FSR0, AR_BARGE_ICON
    movlw .14
    call GLCD_WRITE_BYTE_FAST

 
    return    
    
    end    

  
