#include p18f87k22.inc
    
    EXTERN AR_A,AR_B,AR_C,AR_D,AR_E,AR_F,AR_G,AR_H,AR_I,AR_J,AR_K,AR_L,AR_M,AR_N,AR_O,AR_P,AR_Q,AR_R,AR_S,AR_T,AR_U,AR_V,AR_W,AR_X,AR_Y,AR_Z
    EXTERN AR_0,AR_1,AR_2,AR_3,AR_4,AR_5,AR_6,AR_7,AR_8,AR_9,AR__,AR_FILL,AR_CLEAR, AR_EXC
    
    EXTERN AR_FULL_HEART_ICON, AR_EMPTY_HEART_ICON
    
    
    EXTERN LCD_delay_ms,LCD_delay_x4us, GLCD_WRITE_BYTE,E_PULSE,GLCD_CS0,GLCD_CS1, GLCD_CS_BOTH
    
    ;______ LOADING POINTER GETTERS AND SETTERS ______
    EXTERN GET_X_POINTER,SET_X_POINTER, GET_Y_POINTER,SET_Y_POINTER,INC_X_POINTER,INC_Y_POINTER
    EXTERN CLEAR_CS
    
    ;EXTERN SET_Y_POINTER, SET_X_POINTER,CLEAR_PAGE,FILL_PAGE,INC_X_ADDRESS,GET_Y_POINTER
    
    ;GLOBAL LOADING_GRAPHIC
    GLOBAL CG_BLINK_CURSOR, CG_LOADING_BAR, CG_WRITE_LOADING, CG_LOADING_GRAPHIC, CG_WRITE_GAME, CG_REQUEST_KP
    GLOBAL SCORE_0,SCORE_1,SCORE_2,SCORE_3,SCORE_4,SCORE_5,SCORE_6,SCORE_7,SCORE_8,SCORE_9
    
    GLOBAL DISPLAY_SCORE, CG_DISPLAY_MORTALITY , CG_WRITE_0LIVES, CG_WRITE_3LIVES, UPDATE_HIGH_SCORE
    EXTERN GET_SCORE, GET_LIVES, LOOK_UP_TABLE_ACCESS,SET_SCORE, GET_SCORE, EE_READ,EE_WRITE
    
    
    
acs_COMPOUND_GRAPHICS    udata_acs	    
CG_TEMP			    res 1	    ; holds tempory values
CG_COUNTER		    res 1	    ; used as aloop counter
SCORE_TMP_1		    res 1	    ; holds 1st digit of score
SCORE_TMP_2		    res 1	    ;holds second digit of score 
EE_VAL			    RES 1	    ; for evaluating the status of the high score

		    
		    


  
;*******************************************************************************
;lIST OF ROUNTINES DIVIDED BY 'CODE' SEGMENT
			 
;most of these routines are highly repettitve
;and as the have call character repeatedly			    
			    
;COMPOUND_GRAPHICS_TEXT			    
    ;WRITE LOADING
    ;WRITE PARACHUTEs
   
   
   ;WRITE LEVEL 
   ;WRITE SCORE
   ;WRITE LIVES
   ;WRITE GAME
   ;WRITE _OVER
   
   ;CG_request_kp
   
   
   ;BLINK_CURSOR
   
   ;CG_DISPLAY_MORTALITY
;   CG_WRITE_0LIVES, 
;   CG_WRITE_2LIVE
;   CG_WRITE_3LIVES, 
;   UPDATE_HIGH_SCORE
   
   ;DISPLAY_SCORE
  
;*******************************************************************************
   
;====  THIS SECTION DEALS WITH DISPLAYING FORMATTED STRINGS ON THE GLCD  ======    
COMPOUND_GRAPHICS_TEXT    code
   
CG_LOADING_GRAPHIC
	
	CALL CLEAR_CS
	
   	MOVLW 0x00
	CALL SET_Y_POINTER
	
	MOVLW 0x00
	CALL SET_X_POINTER
	
	CALL CG_BLINK_CURSOR
	
	CALL CG_WRITE_LOADING
	
	
	CALL INC_X_POINTER
	
	MOVLW 0x00
	CALL SET_Y_POINTER
	
	CALL CG_WRITE_PARACHUTES
	
	CALL INC_X_POINTER
	MOVLW 0x00
	CALL SET_Y_POINTER
	
	;--------- FANCY LOADING BAR ----- ;
	
	
	CALL CG_LOADING_BAR
	
	CALL GLCD_CS1
	
	MOVLW 0x02
	CALL SET_X_POINTER
	
	MOVLW 0x00
	CALL SET_Y_POINTER
	
	CALL CG_LOADING_BAR
	
	CALL GLCD_CS_BOTH
	CALL CLEAR_CS
	CALL GLCD_CS0

	
	MOVLW	0x04
	CALL	SET_Y_POINTER
	
	MOVLW	0x00
	CALL	SET_X_POINTER
	
	CALL	CG_WRITE_PARACHUTES
	
;------- SCORE -------	
	MOVLW	.18
	CALL	SET_Y_POINTER
	MOVLW	0x02
	CALL	SET_X_POINTER
	
	CALL	CG_WRITE_SCORE
	
	movlw	.5
	lfsr	FSR0, AR_CLEAR
	call	GLCD_WRITE_BYTE
	
;	movlw	.5
;	lfsr	FSR0, AR_0
;	call	GLCD_WRITE_BYTE
;	
;	call	CG_LETTER_SPACE
;	
;	movlw	.5
;	lfsr	FSR0, AR_0
;	call	GLCD_WRITE_BYTE
	
;------ LIVES --------
	MOVLW	.1
	CALL	SET_Y_POINTER
	MOVLW	0x04
	CALL	SET_X_POINTER
	
	CALL	CG_WRITE_3LIVES
	
	movlw   .100
	call	LCD_delay_ms	; wait 50ms
	
;------ HIGH SCORE -------
	
	CALL	CG_WRITE_HS
	
	MOVLW	.51
	CALL	SET_Y_POINTER
	MOVLW	0x06
	CALL	SET_X_POINTER
	
	
	
	;CALL	EE_READ
	MOVLW	.0
	CALL	LOOK_UP_TABLE_ACCESS
	
	;CALL 	UPDATE_HIGH_SCORE
	
	
	
;________ SWITCH TO LHS ___________
;      LOAD SEA AND BARGE 

	RETURN
   
CG_REQUEST_KP
	
	
	CALL CG_PRS_F
	

	MOVLW .35
	CALL SET_Y_POINTER
	MOVLW 0x03
	CALL SET_X_POINTER
	
	movlw   .100
	call	LCD_delay_ms	; wait 50ms
	
	movlw .5
	lfsr FSR0, AR_CLEAR
	call GLCD_WRITE_BYTE
	
	movlw   .100
	call	LCD_delay_ms	; wait 50ms
	
	
	RETURN
	
	
CG_PRS_F
	
	MOVLW .5
	CALL SET_Y_POINTER
	MOVLW 0x03
	CALL SET_X_POINTER
	
	movlw .5
	lfsr FSR0, AR_H
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_O
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_L
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_D
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_CLEAR
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_F
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_CLEAR
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_T
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_O
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	
;---- NEW PAGE -----
	
	MOVLW .15
	CALL SET_Y_POINTER
	MOVLW 0x04
	CALL SET_X_POINTER
	
	
	movlw .5
	lfsr FSR0, AR_S
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_T
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_A
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_R
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_T
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	
	RETURN
   
CG_BLINK_CURSOR ; ROUTINE TO GIVE THE APPEARANCE OF A FLASHING CURSOR
   	;NEED TO RESET Y EACH TIME TO STOP IT PROGRESSING
	MOVLW 0x03
	MOVWF CG_COUNTER
	
	CALL GET_Y_POINTER
	MOVWF CG_TEMP
	
BLNKLP	movlw .4
	lfsr FSR0, AR__
	call GLCD_WRITE_BYTE
	
	movlw   .250
	call	LCD_delay_ms	; wait 50ms
	
	MOVF CG_TEMP, 0
	CALL SET_Y_POINTER
	
	movlw .4
	lfsr FSR0, AR_CLEAR
	call GLCD_WRITE_BYTE
	
	movlw   .250
	call	LCD_delay_ms	; wait 50ms
	movlw   .100
	call	LCD_delay_ms	; wait 50ms
	
	MOVF CG_TEMP, 0
	CALL SET_Y_POINTER

	DECFSZ CG_COUNTER
	BRA BLNKLP
	
	RETURN

CG_LOADING_BAR ; LOADING BAR THAT RUNS FOR .200 MS
	    ; USE WHEN 'LOADING' THE GAME AFTER TURN ON
	
	MOVLW 0x00
	CALL SET_Y_POINTER
	
	movlw .14
	movwf CG_TEMP ; <<<<<<<<<<<<<<

CGLBLP	
	
	movlw .5
	lfsr FSR0, AR_FILL

	call GLCD_WRITE_BYTE
	
	movlw   .100
	call	LCD_delay_ms	; wait 50ms


	DECFSZ CG_TEMP
	bra 	CGLBLP
	
	
	
	RETURN	
	
CG_CLR_PAGE ; SAME PRINCIPLE OF OPERATION AS THE LOADING BAR EXCEPT IT CLEARS
	    ; LOOKS A LITTLE BIT SUSPECT, MAYBE VARY THE LENGTH
	
	MOVLW 0x00
	CALL SET_Y_POINTER
	
	movlw .12
	movwf CG_TEMP ; <<<<<<<<<<<<<<

CGCLRLP	
	
	movlw	.4
	lfsr	FSR0, AR_CLEAR

	call	GLCD_WRITE_BYTE
	
	DECFSZ	CG_TEMP
	bra 	CGCLRLP	
	
	movlw   .250
	call	LCD_delay_ms	; wait 50ms
	
	RETURN
	
	
	
   
CG_LETTER_SPACE ; CREATES A SINGLE ELMENT SPACE 
	;HAS A DELAY FOR SLOWING WRITING OF LETTER
   
	movlw   .20
	call	LCD_delay_ms	; wait WAIT 20 mS
	
	BSF LATB, RB2 ; SET RS LINE HIGH
	BCF LATB, RB3 ; RW Line low 
	; SETTING TO WRITE MODE
	
	movlw   b'00000000'  ; loading instruction in D bus
	movwf	LATD
	
	movlw   .2
	call	LCD_delay_ms	; wait 2ms
	
	call	E_PULSE
	
	movlw   .20
	call	LCD_delay_ms	; wait 20mS
	

	
	
	RETURN
   
CG_WRITE_LOADING ; width = .42
   
	MOVLW 0x00
	CALL SET_Y_POINTER	
	
       	
	lfsr FSR0, AR_L
	movlw .5
	call GLCD_WRITE_BYTE

	call CG_LETTER_SPACE

	lfsr FSR0, AR_O
	movlw .5
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE

	lfsr FSR0, AR_A
	movlw .5
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE

	lfsr FSR0, AR_D
	movlw .5
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	lfsr FSR0, AR_I
	movlw .5
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	

	lfsr FSR0, AR_N
	movlw .5
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	lfsr FSR0, AR_G
	movlw .5
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	RETURN	
	
CG_WRITE_PARACHUTES ; width = .60
   
       	movlw .5
	lfsr FSR0, AR_P
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_A
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_R
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_A
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_C
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_H
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_U
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_T
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_E
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_S
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	
	RETURN

;===============================================================================
	
	
;========  THIS SECTION DEALS WITH DISPLAYING THE HIGHSCORE ON THE GLCD ========
	
	
COMPOUND_GRAPHICS_HIGHSCORING  code

	
	
	
CG_WRITE_SCORE ; width = .30
	
	movlw .5
	lfsr FSR0, AR_S
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_C
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_O
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_R
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_E
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	RETURN
	
	
	
	
UPDATE_HIGH_SCORE
	
	;GETTING CURRENT HIGH SCORE
	CALL	GET_SCORE
	MOVWF	CG_TEMP
	
	CALL	EE_READ
	MOVWF	EE_VAL
	MOVLW	.255
	CPFSEQ	EE_VAL
	BRA	SKP_2_SCORE
	
	MOVLW	.00
	CALL	EE_WRITE
	
	CALL	EE_READ
	
	
SKP_2_SCORE	
	CPFSLT	CG_TEMP	    ; skip if old score Less than than new score
	BRA	OLD_SCR
	
NEWEE	
	CALL	GET_SCORE
	CALL	EE_WRITE
	
	CALL	GLCD_CS0
	MOVLW	.52
	CALL	SET_Y_POINTER
	MOVLW	0x06
	CALL	SET_X_POINTER
	
	CALL	EE_READ	; CALL	GET_SCORE
	CALL	LOOK_UP_TABLE_ACCESS

	
	CALL	GLCD_CS1
	
	
	
	RETURN
		
OLD_SCR	
	
	CALL	GLCD_CS0
	
	MOVLW	.52
	CALL	SET_Y_POINTER
	MOVLW	0x06
	CALL	SET_X_POINTER
	
	CALL	EE_READ
	CALL	LOOK_UP_TABLE_ACCESS
	
	CALL	GLCD_CS1
	
	
	
	RETURN
	
CG_WRITE_HS ; width = .30
	
	MOVLW	.0
	CALL	SET_Y_POINTER
	MOVLW	0x06
	CALL	SET_X_POINTER
	
	
	movlw	.5
	lfsr	FSR0, AR_T
	call	GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw	.5
	lfsr	FSR0, AR_O
	call	GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw	.5
	lfsr	FSR0, AR_P
	call	GLCD_WRITE_BYTE
	
	call	CG_LETTER_SPACE
	
	call	CG_LETTER_SPACE
	
	call	CG_LETTER_SPACE
	
	movlw	.5
	lfsr	FSR0, AR_S
	call	GLCD_WRITE_BYTE
	
	call	CG_LETTER_SPACE
	
	movlw	.5
	lfsr	FSR0, AR_C
	call	GLCD_WRITE_BYTE
	
	call	CG_LETTER_SPACE
	
	movlw	.5
	lfsr	FSR0, AR_O
	call	GLCD_WRITE_BYTE
	
	call	CG_LETTER_SPACE
	
	movlw	.5
	lfsr	FSR0, AR_R
	call	GLCD_WRITE_BYTE
	
	call	CG_LETTER_SPACE
	
	movlw	.5
	lfsr	FSR0, AR_E
	call	GLCD_WRITE_BYTE
	
	
	

	RETURN
	
	
;===============================================================================
;================================== LIVES ======================================	
	
	
	
COMPOUND_GRAPHICS_LIVESS   code

; ____________ SCORE LOOKUP TABLE __________________	
	
	
CG_WRITE_3LIVES
	
	MOVLW .1
	CALL SET_Y_POINTER
	MOVLW 0x04
	CALL SET_X_POINTER
	
	CALL CG_WRITE_lIVES
	
	movlw .11
	lfsr FSR0, AR_FULL_HEART_ICON
	call GLCD_WRITE_BYTE
	
	movlw   .200 ;<<<<<<<<<<< THIS MAY BE TOO LONG
	call	LCD_delay_ms	; wait 50m
	
	movlw .11
	lfsr FSR0, AR_FULL_HEART_ICON
	call GLCD_WRITE_BYTE
	
	movlw   .200 ;<<<<<<<<<<< THIS MAY BE TOO LONG
	call	LCD_delay_ms	; wait 50m
	
	movlw .11
	lfsr FSR0, AR_FULL_HEART_ICON
	call GLCD_WRITE_BYTE
	
	return
	
CG_WRITE_2LIVES	
	
	
	MOVLW .51
	CALL SET_Y_POINTER
	MOVLW 0x04
	CALL SET_X_POINTER

	
	movlw .11
	lfsr FSR0, AR_EMPTY_HEART_ICON
	call GLCD_WRITE_BYTE
	
	return
	
CG_WRITE_1LIVES	
	
	MOVLW .40
	CALL SET_Y_POINTER
	MOVLW 0x04
	CALL SET_X_POINTER
	
	movlw .11
	lfsr FSR0, AR_EMPTY_HEART_ICON
	call GLCD_WRITE_BYTE
	
	return
	
CG_WRITE_0LIVES	
	
	MOVLW .29
	CALL SET_Y_POINTER
	MOVLW 0x04
	CALL SET_X_POINTER
	
	movlw .11
	lfsr FSR0, AR_EMPTY_HEART_ICON
	call GLCD_WRITE_BYTE
	
	return	


	
	
	
CG_WRITE_lIVES ; width = .30
	
	MOVLW .1
	CALL SET_Y_POINTER
	MOVLW 0x04
	CALL SET_X_POINTER
	
	movlw .5
	lfsr FSR0, AR_L
	call GLCD_WRITE_BYTE
	;call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_I
	call GLCD_WRITE_BYTE
	;call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_V
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_E
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_S
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	
	RETURN

	
CG_DISPLAY_MORTALITY
	
	CALL	GLCD_CS0
	CALL GET_LIVES
	MOVWF CG_TEMP
	BZ NO_LIVES_DEAD

	;IF IT IS 1 LIFE 
	DCFSNZ	CG_TEMP
	CALL CG_WRITE_1LIVES
	
	;IF IT IS 2 LIVES
	DCFSNZ CG_TEMP
	CALL CG_WRITE_2LIVES
	
	CALL	GLCD_CS1
	
	RETURN
	
NO_LIVES_DEAD
	
	CALL CG_WRITE_0LIVES
	CALL	GLCD_CS1
	
	RETURN
	

	
	
	
CG_WRITE_GAME ; width = .24
	
	MOVLW .6
	CALL SET_Y_POINTER
	MOVLW 0x01
	CALL SET_X_POINTER

	
	movlw .5
	lfsr FSR0, AR_G
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_A
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_M
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_E
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	;RETURN



;CG_WRITE_OVER ; width = .30
	;INCLUDES SPACE BEFORE 
	;' OVER'
	
	movlw .5
	lfsr FSR0, AR_O
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_V
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_E
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_R
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	movlw .5
	lfsr FSR0, AR_CLEAR
	call GLCD_WRITE_BYTE
	
	call CG_LETTER_SPACE
	
	RETURN
;===========================================================================
	
	
;========  THIS SECTION DEALS WITH DISPLAYING THE SCORE ON THE GLCD ========
	
	
COMPOUND_GRAPHICS_SCORING   code

; ____________ SCORE LOOKUP TABLE __________________	

SCORE_0
	movlw .5
	lfsr FSR0, AR_0
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	RETURN
	
SCORE_1
	movlw .5
	lfsr FSR0, AR_1
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	RETURN
	
SCORE_2
	movlw .5
	lfsr FSR0, AR_2
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	RETURN
	
SCORE_3
	movlw .5
	lfsr FSR0, AR_3
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	RETURN
	
SCORE_4
	movlw .5
	lfsr FSR0, AR_4
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	RETURN		
	
SCORE_5
	movlw .5
	lfsr FSR0, AR_5
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	RETURN
;	
SCORE_6
	movlw .5
	lfsr FSR0, AR_6
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	RETURN	
	
SCORE_7
	movlw .5
	lfsr FSR0, AR_7
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	RETURN	

SCORE_8
	movlw .5
	lfsr FSR0, AR_8
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	RETURN	
	
SCORE_9
	movlw .5
	lfsr FSR0, AR_9
	call GLCD_WRITE_BYTE
	call CG_LETTER_SPACE
	RETURN	

	
	

	
	
DISPLAY_SCORE
	
	CALL	GLCD_CS0
	
	MOVLW	0x02
	CALL	SET_X_POINTER
	
	MOVLW	.52
	CALL	SET_Y_POINTER
	
	
	MOVLW	.52
	CALL	SET_Y_POINTER
	MOVLW	 0x02
	CALL	SET_X_POINTER
   
	CALL	GET_SCORE
	CALL	LOOK_UP_TABLE_ACCESS
	
	CALL	GLCD_CS1
	
	RETURN
	
	
    end


