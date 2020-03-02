    #include p18f87k22.inc
	
    
    
    
    
	;______ SETUP ROUTINES ______
    	GLOBAL LEX_SETUP,LEX_LOAD_SPAWN,LEX_LOAD_RAM	

	;______ MAKING RAM LOCATION EXTERNALLY ACCESSIBLE ______
    	GLOBAL AR_A,AR_B,AR_C,AR_D,AR_E,AR_F,AR_G,AR_H,AR_I,AR_J,AR_K,AR_L,AR_M,AR_N,AR_O,AR_P,AR_Q,AR_R,AR_S,AR_T,AR_U,AR_V,AR_W,AR_X,AR_Y,AR_Z
    	GLOBAL AR_0,AR_1,AR_2,AR_3,AR_4,AR_5,AR_6,AR_7,AR_8,AR_9
	GLOBAL AR__,AR_FILL,AR_CLEAR, AR_EXC
    
    	GLOBAL AR_BARGE_ICON, AR_PARA_ICON, AR_FULL_HEART_ICON, AR_EMPTY_HEART_ICON,AR_SEA_ICON
    	GLOBAL AR_SPAWN_LIST

	;________TIMING TESTING_______
;	global LEX_LOAD_RAM_ICONS_TEST, LEX_LOAD_RAM_ICONS_TEST2
;	extern E_PULSE, LCD_delay_x4us 
	
	
;________ VARIABLES _________		
acs_lex		udata_acs   ; reserve data space in access ram
var		res 1 
LEX_COUNTER	res 1 ; MAX GLCD WIDTH IS 64, 1 BYTE IS SUFFICENT FOR COUNTER

lex_data	code 	

;_______________  Reserving in RAM  __________________
 ; SECTIONS ARE BROKEN UP INTO SUBSECTIONS TO AVOID BANKING OVERFLOW
 
GAME_ICONS	udata	    ; reserve data in RAM FOR ICONS
 
AR_BARGE_ICON		res	0x10    
AR_PARA_ICON		res	0x10	
AR_FULL_HEART_ICON	res	0x10
AR_EMPTY_HEART_ICON	res	0x10
AR_SEA_ICON		res	0x12	
AR_SPAWN_LIST		res	0x30	
	
;AR_SEA_ICON	res	0x10
	
CHAR_SET	udata	; reserve data in RAM FOR CHARACTERS
	
AR_A	 res 0x8
AR_B     res 0x8
AR_C     res 0x8
AR_D     res 0x8
AR_E     res 0x8
AR_F     res 0x8
AR_G     res 0x8
AR_H     res 0x8
AR_I     res 0x8
AR_J     res 0x8
AR_K     res 0x8
AR_L     res 0x8
AR_M     res 0x8
AR_N     res 0x8
AR_O     res 0x8
AR_P     res 0x8
AR_Q     res 0x8
AR_R     res 0x8
AR_S     res 0x8
AR_T     res 0x8
AR_U     res 0x8
AR_V     res 0x8
AR_W     res 0x8
AR_X     res 0x8
AR_Y     res 0x8
AR_Z     res 0x8
;AR_?     res 0x5
AR_EXC     res 0x8
;AR_%     res 0x5
     
NUM_SET	    udata  ;reserve data in RAM FOR NUMBERS
	    
AR_0     res 0x10
AR_1     res 0x10
AR_2     res 0x10
AR_3     res 0x10
AR_4     res 0x10
AR_5     res 0x10
AR_6     res 0x10
AR_7     res 0x10
AR_8     res 0x10
AR_9     res 0x10
AR__	 res 0x10
AR_FILL	 res 0x10
AR_CLEAR res 0x10	 
     

;add GRAPHICS SET LAST 
;GAME OVER SCREEN 

	
	
	
	
;=============================  Loading PM  =============================	
;CODE FLOWS ARE BROKEN UP INTO SUBFLOWS TO AVOID PAGE OVERFLOW ISSUES.
 

 
LEX_PM_LOADING_IN_ICONS    code	 
    
PM_SPAWN_LIST
	
	db	0x09,0x20,0x03,0x27,0x32,0x2F,0x23,0x33,0x34,0x2E,0x0D,0x22,0x17,0x07,0x13,0x10,0x2E,0x21,0x30,0x36,0x3A,0x20,0x0F,0x13,0x1C,0x33,0x12,0x10,0x25,0x39,0x34,0x38,0x09,0x20,0x03,0x27,0x32,0x2F,0x23,0x33,0x34,0x2E,0x0D,0x22,0x17,0x07,0x13,0x10,0x2E,0x21,0x30,0x36,0x3A,0x20,0x0F,0x13,0x1C,0x33,0x12,0x10,0x25,0x39,0x34,0x38
	CONSTANT PM_SPAWN_LIST_LENGTH = .64    
 
;=============================    ICONS     =============================
PM_BARGE_ICON
	db	b'11011100',b'11011000',b'11111000',b'11111000',b'11111000',b'11111000',b'11111000',b'11111000',b'11111000',b'11111000',b'11111000',b'11111000',b'11011000',b'11011100'; message, plus carriage return
	CONSTANT PM_BARGE_ICON_LENGTH =.14
	
	
PM_PARA_ICON
	db	b'00010000',b'00001000',b'01101000',b'00001000',b'00010000'
	CONSTANT PM_PARA_ICON_LENGTH = .5
	
PM_EMPTY_HRT_ICON
	db	b'00000000',b'00001110',b'00010001',b'00100001',b'01000010',b'10000100',b'01000010',b'00100001',b'00010001',b'00001110',b'00000000'
	CONSTANT PM_EMPTY_HRT_ICON_LENGTH = .11
	
PM_FULL_HRT_ICON
	db	b'00000000',b'00001110',b'00011111',b'00111111',b'01111110',b'11111100',b'01111110',b'00111111',b'00011111',b'00001110',b'00000000'
	CONSTANT PM_FULL_HRT_ICON_LENGTH = .11	
	
PM_SEA_ICON
	db	 b'11100000',b'11000000',b'11000000',b'11100000',b'11100000',b'11100000',b'11100000',b'11000000'
	CONSTANT PM_SEA_ICON_LENGTH = .8
	

	
	
	
;========================================================================
;############################ NEW CODE BLOCK ############################
;========================================================================

	
LEX_PM_LOADING_IN_LETTERS    code	
	
;====================== FULL CHARACTER SET ===============================
	
PM_A		
	db	b'01111110',b'00001001',b'00001001',b'00001001',b'01111110'
	
PM_B		
	db	b'01111111',b'01001001',b'01001001',b'01001001',b'00110110'
	
PM_C		
	db	b'00111110',b'01000001',b'01000001',b'01000001',b'00100010'
	
PM_D		
	db	b'01111111',b'01000001',b'01000001',b'01000001',b'00111110'
	
PM_E		
	db	b'01111111',b'01001001',b'01001001',b'01001001',b'01000001'
	
PM_F		
	db	b'01111111',b'00001001',b'00001001',b'00001001',b'00000001'
	
PM_G		
	db	b'00111110',b'01000001',b'01001001',b'01001001',b'00111010'
	
PM_H		
	db	b'01111111',b'00001000',b'00001000',b'00001000',b'01111111'
	
PM_I		
	db	b'00000000',b'01000001',b'01111111',b'01000001',b'00000000'
	
PM_J		
	db	b'00110000',b'01000000',b'01000000',b'01000000',b'00111111'
	
PM_K		
	db	b'01111111',b'00001000',b'00010100',b'00100010',b'01000001'
	
PM_L		
	db	b'01111111',b'01000000',b'01000000',b'01000000',b'01000000'
	
PM_M		
	db	b'01111111',b'00000010',b'00001100',b'00000010',b'01111111'
	
PM_N		
	db	b'01111111',b'00000010',b'00000100',b'00001000',b'01111111'
	
PM_O		
	db	b'00111110',b'01000001',b'01000001',b'01000001',b'00111110'
	
PM_P		
	db	b'01111111',b'00001001',b'00001001',b'00001001',b'00000110'
	
PM_Q		
	db	b'00111110',b'01000001',b'01010001',b'00100001',b'01011110'
	
PM_R		
	db	b'01111111',b'00001001',b'00011001',b'00101001',b'01000110'
	
PM_S		
	db	b'00100110',b'01001001',b'01001001',b'01001001',b'00110010'
	
PM_T		
	db	b'00000001',b'00000001',b'01111111',b'00000001',b'00000001'
	
PM_U		
	db	b'00111111',b'01000000',b'01000000',b'01000000',b'00111111'
	
PM_V		
	db	b'00011111',b'00100000',b'01000000',b'00100000',b'00011111'
	
PM_W		
	db	b'01111111',b'00100000',b'00011000',b'00100000',b'01111111'
	
PM_X		
	db	b'01100011',b'00010100',b'00001000',b'00010100',b'01100011'
	
PM_Y		
	db	b'00000111',b'00001000',b'01110000',b'00001000',b'00000111'
	
PM_Z		
	db	b'01100001',b'01010001',b'01001001',b'01000101',b'01000011'
	
;PM_?		
	;;db	b'00000010',b'00000001',b'01010001',b'00001001',b'00000110'
	
PM_EXC		
	db	b'00000000',b'00000000',b'01011111',b'00000000',b'00000000'
	
;PM_%		
	;db	b'01100011',b'00010011',b'00001000',b'01100100',b'01100011'
	
PM_0		
	db	b'00111110',b'01010001',b'01001001',b'01000101',b'00111110'
	
PM_1		
	db	b'00000000',b'01000010',b'01111111',b'01000000',b'00000000'
	
PM_2		
	db	b'01000010',b'01100001',b'01010001',b'01001001',b'01000110'
	
PM_3		
	db	b'01000001',b'01001001',b'01001001',b'01001001',b'00110110'
	
PM_4		
	db	b'00001111',b'00001000',b'00001000',b'00001000',b'01111111'
	
PM_5		
	db	b'01001111',b'01001001',b'01001001',b'01001001',b'00110001'
	
PM_6		
	db	b'00111110',b'01001001',b'01001001',b'01001001',b'00110000'
	
PM_7		
	db	b'00000001',b'00000001',b'01110001',b'00001001',b'00000111'
	
PM_8		
	db	b'00110110',b'01001001',b'01001001',b'01001001',b'00110110'
	
PM_9		
	db	b'00100110',b'01001001',b'01001001',b'01001001',b'00111110'

PM__
	db	b'01000000',b'01000000',b'01000000',b'01000000',b'01000000'
	
PM_FILL
	db	b'01111110',b'01111110',b'01111110',b'01111110',b'01111110'
	
PM_CLEAR
	db	b'00000000',b'00000000',b'00000000',b'00000000',b'00000000'
	
;===============================================================================	

;ROUTINES:
	;LEX_SETUP
	;LEX_LOAD_SPAWN
	;LEX_LOAD_RAM_ICONS
	;LEX_LOAD_RAM_CHAR
	;LEX_LOAD_RAM_NUM
	;LEX_LOAD_
	;LEX_LOAD_RAM_SKULL
	
;======================= LOAD ICONS INTO RAM  ==================================	
LEX_MAIN_RAMIFY    code
    
    
;__________ SETUP __________
LEX_SETUP
    
	; SET RAM TO CORRECT MODE
	bcf	EECON1, CFGS	; point to Flash program memory  
	bsf	EECON1, EEPGD 	; access Flash program memory    
	
	
	; CLEARS FSR2 SETTING IT BACK TO ZERO
	CLRF FSR2
	
	RETURN
;>>>> READING IN PM

LEX_LOAD_RAM ; SINGLE ROUTINE TO LOAD ALL CHARACTERS AND ICONS INTO RAM
	CALL LEX_LOAD_RAM_ICONS
	CALL LEX_LOAD_RAM_CHAR
	CALL LEX_LOAD_RAM_NUM
	;CALL LEX_LOAD_RAM_SKULL
	RETURN
	
	
	;______________ LOAD SPAWN LOCATIONS INTO RAM ______________

LEX_LOAD_SPAWN 
	
	lfsr	FSR2, AR_SPAWN_LIST	;LOADS SPAWN LIST USING FSR3
	movlw	upper(PM_SPAWN_LIST)	; address of data in PM
	movwf	TBLPTRU		    ; load upper bits to TBLPTRU
	movlw	high(PM_SPAWN_LIST)	; address of data in PM
	movwf	TBLPTRH		    ; load high byte to TBLPTRH
	movlw	low(PM_SPAWN_LIST)	; address of data in PM
	movwf	TBLPTRL		    ; load low byte to TBLPTRL
	
	movlw	PM_SPAWN_LIST_LENGTH	; bytes to read
	movwf	LEX_COUNTER	    ; our counter register
PMSPAWNLP 	
	tblrd*+			    ; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC2    ; move data from TABLAT to W
	decfsz	LEX_COUNTER	    ; count down to zero
	bra	PMSPAWNLP		    ; keep going until finished
	
	RETURN
	
	
;LEX_LOAD_RAM
;	
;	
;	RETURN
	
	
;LEX_LOAD_RAM_ICONS_TEST
;	
;	CLRF FSR0
;	CLRF LEX_COUNTER
;	
;	lfsr	FSR0, AR_PARA_ICON
;	movlw	upper(PM_PARA_ICON)	; address of data in PM
;	movwf	TBLPTRU		    ; load upper bits to TBLPTRU
;	movlw	high(PM_PARA_ICON)	; address of data in PM
;	movwf	TBLPTRH		    ; load high byte to TBLPTRH
;	movlw	low(PM_PARA_ICON)	; address of data in PM
;	movwf	TBLPTRL		    ; load low byte to TBLPTRL
;	
;	movlw	PM_PARA_ICON_LENGTH	; bytes to read
;	movwf	LEX_COUNTER	    ; our counter register
;PMPARLP2 	
;	tblrd*+			    ; one byte from PM to TABLAT, increment TBLPRT
;	movff	TABLAT, POSTINC0    ; move data from TABLAT to W
;	decfsz	LEX_COUNTER	    ; count down to zero
;	bra	PMPARLP2		    ; keep going until finished	
;	
;	return
;
;	
;	
;LEX_LOAD_RAM_ICONS_TEST2	
;	
;	CLRF LEX_COUNTER
;	
;	BSF LATB, RB2 ; SET RS LINE HIGH
;	BCF LATB, RB3 ; RW Line low
;
;	movlw	upper(PM_PARA_ICON)	; address of data in PM
;	movwf	TBLPTRU		    ; load upper bits to TBLPTRU
;	movlw	high(PM_PARA_ICON)	; address of data in PM
;	movwf	TBLPTRH		    ; load high byte to TBLPTRH
;	movlw	low(PM_PARA_ICON)	; address of data in PM
;	movwf	TBLPTRL		    ; load low byte to TBLPTRL
;	
;	movlw	PM_PARA_ICON_LENGTH	; bytes to read
;	movwf	LEX_COUNTER	    ; our counter register
;PMPARLP3	
;	tblrd*+			    ; one byte from PM to TABLAT, increment TBLPRT
;	movff	TABLAT, LATD	    ; move data from TABLAT to W
;	call	E_PULSE
;	movlw   .2
;	call	LCD_delay_x4us	    ; wait 10ms 
;	decfsz	LEX_COUNTER	    ; count down to zero
;	bra	PMPARLP3		    ; keep going until finished	
;		
;	return
;	
	
	
;========================================================================
;############################ NEW CODE BLOCK ############################
;========================================================================
	
	
LEX_LOAD_RAM_ICONS code
 
;______________ LOAD PARACHUTE ICON INTO RAM ______________

LEX_LOAD_RAM_ICONS
	
	CLRF FSR0
	CLRF LEX_COUNTER
	
	lfsr	FSR0, AR_PARA_ICON
	movlw	upper(PM_PARA_ICON)	; address of data in PM
	movwf	TBLPTRU		    ; load upper bits to TBLPTRU
	movlw	high(PM_PARA_ICON)	; address of data in PM
	movwf	TBLPTRH		    ; load high byte to TBLPTRH
	movlw	low(PM_PARA_ICON)	; address of data in PM
	movwf	TBLPTRL		    ; load low byte to TBLPTRL
	
	movlw	PM_PARA_ICON_LENGTH	; bytes to read
	movwf	LEX_COUNTER	    ; our counter register
PMPARLP 	
	tblrd*+			    ; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0    ; move data from TABLAT to W
	decfsz	LEX_COUNTER	    ; count down to zero
	bra	PMPARLP		    ; keep going until finished	
	
	return	

	
	
	
;______________ LOAD BARGE ICON INTO RAM ______________
	;CLRF FSR0
	;CLRF LEX_COUNTER
	;CLRF TABLAT
	;CLRF TBLPTRL
	;CLRF TBLPTRH
	;CLRF TBLPTRU
	
	
	lfsr	FSR0, AR_BARGE_ICON
	movlw	upper(PM_BARGE_ICON)	; address of data in PM
	movwf	TBLPTRU		    ; load upper bits to TBLPTRU
	movlw	high(PM_BARGE_ICON)	; address of data in PM
	movwf	TBLPTRH		    ; load high byte to TBLPTRH
	movlw	low(PM_BARGE_ICON)	; address of data in PM
	movwf	TBLPTRL		    ; load low byte to TBLPTRL
	
	movlw	PM_BARGE_ICON_LENGTH	; bytes to read
	movwf	LEX_COUNTER	    ; our counter register
PMBARLP 	
	tblrd*+			    ; one byte from PM to TABLAT, increment TBLPRT
	movff	TABLAT, POSTINC0    ; move data from TABLAT to W
	decfsz	LEX_COUNTER	    ; count down to zero
	bra	PMBARLP		    ; keep going until finished	
		

	
;______________________   LOADING   FULL_HEART_ICON   ______________________			

	lfsr	FSR0, AR_FULL_HEART_ICON	; Loading RAM location: AR_FULL_HEART_ICON
			
	movlw	upper(PM_FULL_HRT_ICON)	;PM_ FULL_HEART_ICON is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_FULL_HRT_ICON)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_FULL_HRT_ICON)	
	movwf	TBLPTRL	; load low byte to TBLPTRL
	
	movlw	PM_FULL_HRT_ICON_LENGTH	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg
			
			
PMCFHRTLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCFHRTLP	
	
	
;______________________   LOADING   EMPTY_HEART_ICON   ______________________			
	
	lfsr	FSR0, AR_EMPTY_HEART_ICON	; Loading RAM location: AR_EMPTY_HRT_ICON
			
	movlw	upper(PM_EMPTY_HRT_ICON)	;PM_ EMPTY_HRT_ICON is address in Program Memory
	movwf	TBLPTRU		    ; load upper bits to TBLPTRU
	movlw	high(PM_EMPTY_HRT_ICON)	
	movwf	TBLPTRH		    ; load high byte to TBLPTRH
	movlw	low(PM_EMPTY_HRT_ICON)	
	movwf	TBLPTRL		    ; load low byte to TBLPTRL
			
	movlw	PM_EMPTY_HRT_ICON_LENGTH	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg
			
			
PMCEHRTLP		
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER		; count down to zero
	bra	PMCEHRTLP	

	
	
;______________________   LOADING   SEA   ______________________			
	
	lfsr	FSR0, AR_SEA_ICON	; Loading RAM location: AR_EMPTY_HRT_ICON
			
	movlw	upper(PM_SEA_ICON)	;PM_ EMPTY_HRT_ICON is address in Program Memory
	movwf	TBLPTRU		    ; load upper bits to TBLPTRU
	movlw	high(PM_SEA_ICON)	
	movwf	TBLPTRH		    ; load high byte to TBLPTRH
	movlw	low(PM_SEA_ICON)	
	movwf	TBLPTRL		    ; load low byte to TBLPTRL
			
	movlw	PM_SEA_ICON_LENGTH	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg
			
			
PMCSEAHRTLP		
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER		; count down to zero
	bra	PMCSEAHRTLP	
	
	RETURN	
	
	
;========================================================================
;############################ NEW CODE BLOCK ############################
;========================================================================
	
;______________________ LOAD CHARACTERS A THROUGH N ______________________

LEX_MAIN_RAMIFY_CHAR_A_N	code	
	

LEX_LOAD_RAM_CHAR ; LOADS THE CHARACTER INFORMATION SPECIFIED IN PM
	;INTO THE RAM LOCATIONS RESERVED.
	
;______________________   LOADING   A   ______________________			
LD_CR_A	lfsr	FSR0, AR_A	; Loading RAM location: AR_A		
	movlw	upper(PM_A)	;PM_ A is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_A)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_A)	
	movwf	TBLPTRL	; load low byte to TBLPTRL	
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCALP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCALP	



;______________________   LOADING   B   ______________________			
LD_CR_B	lfsr	FSR0, AR_B	; Loading RAM location: AR_B	
	movlw	upper(PM_B)	;PM_ B is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_B)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_B)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCBLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCBLP	
	
	
;______________________   LOADING   C   ______________________			
LD_CR_C	lfsr	FSR0, AR_C	; Loading RAM location: AR_C
			
	movlw	upper(PM_C)	;PM_ C is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_C)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_C)	
	movwf	TBLPTRL	; load low byte to TBLPTRL	
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCCLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCCLP	
	

	
;______________________   LOADING   D   ______________________			
LD_CR_D	lfsr	FSR0, AR_D	; Loading RAM location: AR_D		
	movlw	upper(PM_D)	;PM_ D is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_D)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_D)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg	
PMCDLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCDLP	

	
LD_CR_E	lfsr	FSR0, AR_E	; Loading RAM location: AR_E		
	movlw	upper(PM_E)	;PM_ E is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_E)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_E)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg	
PMCELP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCELP	

	
;______________________   LOADING   F (respects)  ______________________			
LD_CR_F	lfsr	FSR0, AR_F	; Loading RAM location: AR_F		
	movlw	upper(PM_F)	;PM_ F is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_F)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_F)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCFLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCFLP	


;______________________   LOADING   G   ______________________			
LD_CR_G	lfsr	FSR0, AR_G	; Loading RAM location: AR_G	
	movlw	upper(PM_G)	;PM_ G is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_G)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_G)	
	movwf	TBLPTRL	; load low byte to TBLPTRL	
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg	
PMCGLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCGLP	

	
;______________________   LOADING   H   ______________________			
LD_CR_H	lfsr	FSR0, AR_H	; Loading RAM location: AR_H		
	movlw	upper(PM_H)	;PM_ H is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_H)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_H)	
	movwf	TBLPTRL	; load low byte to TBLPTRL	
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCHLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCHLP	

	
;______________________   LOADING   I   ______________________			
LD_CR_I	lfsr	FSR0, AR_I	; Loading RAM location: AR_I		
	movlw	upper(PM_I)	;PM_ I is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_I)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_I)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCILP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCILP	

	
;______________________   LOADING   J   ______________________			
LD_CR_J	lfsr	FSR0, AR_J	; Loading RAM location: AR_J		
	movlw	upper(PM_J)	;PM_ J is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_J)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_J)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCJLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCJLP	

	
;______________________   LOADING   K   ______________________			
LD_CR_K	lfsr	FSR0, AR_K	; Loading RAM location: AR_K	
	movlw	upper(PM_K)	;PM_ K is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_K)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_K)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCKLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCKLP	

	
;______________________   LOADING   L   ______________________			
LD_CR_L	lfsr	FSR0, AR_L	; Loading RAM location: AR_L		
	movlw	upper(PM_L)	;PM_ L is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_L)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_L)	
	movwf	TBLPTRL	; load low byte to TBLPTRL	
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCLLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCLLP	
    

;______________________   LOADING   M   ______________________			
LD_CR_M	lfsr	FSR0, AR_M	; Loading RAM location: AR_M		
	movlw	upper(PM_M)	;PM_ M is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_M)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_M)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCMLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCMLP	

	
;______________________   LOADING   N   ______________________			
LD_CR_N	lfsr	FSR0, AR_N	; Loading RAM location: AR_N		
	movlw	upper(PM_N)	;PM_ N is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_N)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_N)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg	
PMCNLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCNLP	

;========================================================================
;############################ NEW CODE BLOCK ############################
;========================================================================
	
;______________________ LOAD CHARACTERS O THROUGH Z ______________________

LEX_MAIN_RAMIFY_CHAR_O_Z	code	
	

;______________________   LOADING   O   ______________________			
LD_CR_O	lfsr	FSR0, AR_O	; Loading RAM location: AR_O	
	movlw	upper(PM_O)	;PM_ O is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_O)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_O)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg	
PMCOLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCOLP	


	
;______________________   LOADING   P   ______________________			
LD_CR_P	lfsr	FSR0, AR_P	; Loading RAM location: AR_P	
	movlw	upper(PM_P)	;PM_ P is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_P)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_P)	
	movwf	TBLPTRL	; load low byte to TBLPTRL	
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCPLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCPLP	
	
;______________________   LOADING   Q   ______________________			
LD_CR_Q	lfsr	FSR0, AR_Q	; Loading RAM location: AR_Q		
	movlw	upper(PM_Q)	;PM_ Q is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_Q)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_Q)	
	movwf	TBLPTRL	; load low byte to TBLPTRL
			
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg	
PMCQLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCQLP	

	
	
;______________________   LOADING   R   ______________________			
LD_CR_R	lfsr	FSR0, AR_R	; Loading RAM location: AR_R	
	movlw	upper(PM_R)	;PM_ R is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_R)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_R)	
	movwf	TBLPTRL	; load low byte to TBLPTRL
			
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCRLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCRLP	

;______________________   LOADING   S   ______________________	
LD_CR_S	lfsr	FSR0, AR_S	; Loading RAM location: AR_S		
	movlw	upper(PM_S)	;PM_ S is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_S)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_S)	
	movwf	TBLPTRL	; load low byte to TBLPTRL	
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCSLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCSLP	
	
;______________________   LOADING   T   ______________________			
LD_CR_T	lfsr	FSR0, AR_T	; Loading RAM location: AR_T		
	movlw	upper(PM_T)	;PM_ T is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_T)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_T)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCTLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCTLP	

	
;______________________   LOADING   U   ______________________			
LD_CR_U	lfsr	FSR0, AR_U	; Loading RAM location: AR_U		
	movlw	upper(PM_U)	;PM_ U is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_U)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_U)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCULP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCULP	
	
;______________________   LOADING   V   ______________________			
LD_CR_V	lfsr	FSR0, AR_V	; Loading RAM location: AR_V	
	movlw	upper(PM_V)	;PM_ V is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_V)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_V)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCVLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCVLP	

	
;______________________   LOADING   W   ______________________			
LD_CR_W	lfsr	FSR0, AR_W	; Loading RAM location: AR_W		
	movlw	upper(PM_W)	;PM_ W is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_W)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_W)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCWLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCWLP
	
	
;______________________   LOADING   X   ______________________			
LD_CR_X	lfsr	FSR0, AR_X	; Loading RAM location: AR_X		
	movlw	upper(PM_X)	;PM_ X is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_X)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_X)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCXLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCXLP	

	
	
;______________________   LOADING   Y   ______________________			
LD_CR_Y	lfsr	FSR0, AR_Y	; Loading RAM location: AR_Y		
	movlw	upper(PM_Y)	;PM_ Y is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_Y)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_Y)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMCYLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCYLP	
	
	
;______________________   LOADING   Z   ______________________			
LD_CR_Z	lfsr	FSR0, AR_Z	; Loading RAM location: AR_Z		
	movlw	upper(PM_Z)	;PM_ Z is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_Z)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_Z)	
	movwf	TBLPTRL	; load low byte to TBLPTRL	
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg	
PMCZLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCZLP	

	RETURN

;______________________   LOADING   EXC   ______________________			
LD_CR_EXC
	lfsr	FSR0, AR_EXC	; Loading RAM location: AR_Z		
	movlw	upper(PM_EXC)	;PM_ Z is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_EXC)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_EXC)	
	movwf	TBLPTRL	; load low byte to TBLPTRL	
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg	
PMCEXCLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCEXCLP	

	RETURN	
	
	
;========================================================================
;############################ NEW CODE BLOCK ############################
;========================================================================	
	
	
	
;=======================================================================

LEX_MAIN_RAMIFY_NUM	code	
	; LOADING NUMBERS AND SPECIAL CHARACTERS INTO RAM
	
LEX_LOAD_RAM_NUM	
	
;______________________   LOADING   0   ______________________			
LD_CR_0	lfsr	FSR0, AR_0	; Loading RAM location: AR_0		
	movlw	upper(PM_0)	;PM_ 0 is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_0)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_0)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg	
PMC0LP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMC0LP	
	
	
;______________________   LOADING   1   ______________________			
LD_CR_1	lfsr	FSR0, AR_1	; Loading RAM location: AR_1		
	movlw	upper(PM_1)	;PM_ 1 is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_1)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_1)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMC1LP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMC1LP	

	
	
;______________________   LOADING   2   ______________________			
LD_CR_2	lfsr	FSR0, AR_2	; Loading RAM location: AR_2		
	movlw	upper(PM_2)	;PM_ 2 is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_2)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_2)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMC2LP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMC2LP	
	

;______________________   LOADING   3   ______________________			
LD_CR_3	lfsr	FSR0, AR_3	; Loading RAM location: AR_3		
	movlw	upper(PM_3)	;PM_ 3 is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_3)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_3)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMC3LP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMC3LP	
	

;______________________   LOADING   4   ______________________			
LD_CR_4	lfsr	FSR0, AR_4	; Loading RAM location: AR_4		
	movlw	upper(PM_4)	;PM_ 4 is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_4)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_4)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMC4LP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMC4LP	

	
;______________________   LOADING   5   ______________________			
LD_CR_5	lfsr	FSR0, AR_5	; Loading RAM location: AR_5		
	movlw	upper(PM_5)	;PM_ 5 is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_5)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_5)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMC5LP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMC5LP	

	
;______________________   LOADING   6   ______________________			
LD_CR_6	lfsr	FSR0, AR_6	; Loading RAM location: AR_6	
	movlw	upper(PM_6)	;PM_ 6 is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_6)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_6)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMC6LP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMC6LP	

	
	
;______________________   LOADING   7   ______________________			
LD_CR_7	lfsr	FSR0, AR_7	; Loading RAM location: AR_7	
	movlw	upper(PM_7)	;PM_ 7 is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_7)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_7)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMC7LP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMC7LP	
	
	
;______________________   LOADING   8   ______________________			
LD_CR_8	lfsr	FSR0, AR_8	; Loading RAM location: AR_8	
	movlw	upper(PM_8)	;PM_ 8 is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_8)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_8)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg				
PMC8LP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMC8LP	

	
;______________________   LOADING   9   ______________________			
LD_CR_9	lfsr	FSR0, AR_9	; Loading RAM location: AR_9
	movlw	upper(PM_9)	;PM_ 9 is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_9)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_9)	
	movwf	TBLPTRL	; load low byte to TBLPTRL		
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMC9LP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMC9LP	


;______________________   LOADING   _   ______________________			
LD_CR__	lfsr	FSR0, AR__	; Loading RAM location: AR__	
	movlw	upper(PM__)	;PM_ _ is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM__)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM__)	
	movwf	TBLPTRL	; load low byte to TBLPTRL	
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg		
PMC_LP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMC_LP	
	
;______________________   LOADING   FILL   ______________________			
LD_CR_FILL	
	lfsr	FSR0, AR_FILL	; Loading RAM location: AR_FILL
	
	movlw	upper(PM_FILL)	;PM_ FILL is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_FILL)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_FILL)	
	movwf	TBLPTRL	; load low byte to TBLPTRL
			
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg
			
			
PMCFILLLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCFILLLP	

	
;______________________   LOADING   CLEAR   ______________________			
LD_CR_CLEAR	
	lfsr	FSR0, AR_CLEAR	; Loading RAM location: AR_CLEAR
		
	movlw	upper(PM_CLEAR)	;PM_ CLEAR is address in Program Memory
	movwf	TBLPTRU	; load upper bits to TBLPTRU
	movlw	high(PM_CLEAR)	
	movwf	TBLPTRH	; load high byte to TBLPTRH
	movlw	low(PM_CLEAR)	
	movwf	TBLPTRL	; load low byte to TBLPTRL
			
	movlw	.5	; Length of Array in PM
	movwf	LEX_COUNTER	; Counter Reg
			
			
PMCCLEARLP			
	tblrd*+		
	movff	TABLAT, POSTINC0    	; move data from TABLAT to FSR0
	decfsz	LEX_COUNTER	; count down to zero
	bra	PMCCLEARLP	
	
	
	RETURN	

	
;========================================================================
;############################ NEW CODE BLOCK ############################
;========================================================================	

	
	
	
	
; =======================================================================
LEX_MAIN_RAMIFY_SKULL_GRAPHIC	code	

	
LEX_LOAD_RAM_SKULL
	
	;INSERT SKULL HERE INNIT.
	
	
	goto $

	
	
	end
	