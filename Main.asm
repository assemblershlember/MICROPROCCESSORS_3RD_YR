	#include p18f87k22.inc
	

;GLOBAL ROUNTINES:	
;+===============+========================================================================+
;| Main.asm      | Description                                                            |
;+===============+========================================================================+
;| GET_Y_POINTER | Moves contents of Y pointer Register into WREG                         |
;+---------------+------------------------------------------------------------------------+
;| SET_Y_POINTER | Moves Contents of WREG into Y_Pointer register and sets GLCD Y ADDRESS |
;+---------------+------------------------------------------------------------------------+
;| SET_X_POINTER | Moves contents of X pointer Register into WREG                         |
;+---------------+------------------------------------------------------------------------+
;| GET_X_POINTER | Moves Contents of WREG into X_Pointer register and sets GLCD X ADDRESS |
;+---------------+------------------------------------------------------------------------+
;| GLCD_SET_Y    | Sets Y ADDRESS of GLCD page(s) that are currently active               |
;+---------------+------------------------------------------------------------------------+
;| GLCD_SET_X    | Sets Y ADDRESS of GLCD page(s) that are currently active               |
;+---------------+------------------------------------------------------------------------+
;| INC_X_POINTER | Increments contents of X_pointer Register                              |
;+---------------+------------------------------------------------------------------------+
;| CLEAR_CS      | Fills CS with Empty columns at a visible rate                          |
;+---------------+------------------------------------------------------------------------+
;| GET_LIVES     | Moves contents of LIVES Register into WREG                             |
;+---------------+------------------------------------------------------------------------+
;| GET_SCORE     | Moves contents of SCORE Register into WREG                             |
;+---------------+------------------------------------------------------------------------+
;| SET_SCORE     | Moves Contents of WREG into SCORE register                             |
;+---------------+------------------------------------------------------------------------+
;| SET_COUNTER   | Moves Contents of WREG into COUNTER register                           |
;+---------------+------------------------------------------------------------------------+

;INTERNAL ROUTINES:
;+----------------+------------------------------------------------------------------------+
;|FALL_SPEED_DELAY| Moves contents of SCORE Register into WREG                             |
;+----------------+------------------------------------------------------------------------+
;|  FILL_CS       | Moves Contents of WREG into SCORE register                             |
;+----------------+------------------------------------------------------------------------+


;+====================+=================================================================================+
;| Notable Labels     |                                                                                 |
;+====================+=================================================================================+
;| SETUP              | very start of code block                                                        |
;+--------------------+---------------------------------------------------------------------------------+
;| RUN_GAME           | calls setup routines for all required source files                              |
;+--------------------+---------------------------------------------------------------------------------+
;| USER_INTERACTION   | Outputs message to LCD asking For interaction, loops until occurs               |
;+--------------------+---------------------------------------------------------------------------------+
;| SPAWN_PARA_TROOPER | starts a new iteration of the game                                              |
;+--------------------+---------------------------------------------------------------------------------+
;| RUN_GAME_OVER      | when user has run out of lives, resets values and returns to SPAWN_PARA_TROOPER |
;+--------------------+---------------------------------------------------------------------------------+


	
;=========================== PROGRAM START =====================================	
	
	
; __________________ LOADING IN ROUTINES FROM GLCD.ASM  ____________________
	EXTERN  LCD_delay_x4us, LCD_delay_ms,LCD_delay	;DELAYS
	EXTERN GLCD_STARTUP	  ; GLCD SETUP ROUTINE (TURN ON AND DISABLE RST)
	
	;WRITING TO GLCD AND CHANGING PAGES
	EXTERN	E_PULSE, GLCD_WRITE_BYTE,GLCD_CS0,GLCD_CS1,GLCD_CS_BOTH

; ______________ LOADING IN KEYPAD ROUTINES FROM PAD.ASM  _______________
	EXTERN KP_SETUP,CHECK_KP,BARGE_SETUP, GET_BARGE_LOC
	
	EXTERN  G_FILL_SEA,PRINT_PARA ; importing graphics rountines
	
;________________ LOADING ROUTINES FROM lEXICON.ASM ROUTINES ________________
	EXTERN LEX_SETUP, LEX_LOAD_SPAWN, LEX_LOAD_RAM , AR_SPAWN_LIST
	
;________________ LOADING ROUTINES FROM COMPOUND_GRAPHICS.ASM ROUTINES ________________
	;VISUAL LOADING (SERVES AESTHETIC PURPOSES)
	EXTERN CG_BLINK_CURSOR, CG_LOADING_BAR, CG_WRITE_LOADING, CG_LOADING_GRAPHIC
	EXTERN CG_WRITE_GAME, CG_REQUEST_KP, CG_WRITE_3LIVES
	;GAME MECHANIC CONDITONS AND UPDATING
	EXTERN DISPLAY_SCORE, CG_DISPLAY_MORTALITY, UPDATE_HIGH_SCORE
	
	
;________________ GLOBALISING GETTERS AND SETTERS ________________	
	GLOBAL GET_Y_POINTER, SET_Y_POINTER, GLCD_SET_Y , GLCD_SET_X
	GLOBAL SET_X_POINTER,GET_X_POINTER, INC_X_POINTER, INC_Y_POINTER
	GLOBAL CLEAR_CS
	
	GLOBAL GET_LIVES,GET_SCORE,SET_SCORE, SET_COUNTER
	
	;_____ EEPROM ROUTINES ___
	EXTERN EE_WRITE,EE_READ
	
	
	; USED FOR TESTING READ SPEEDS (FLASH VS SRAM)
;	EXTERN RATE_TEST_ROUTINE


MAIN_0	udata_acs   ; reserve data space in access ram
	
; ______________ RESERVING VARIABLES FOR USE IN FLOW ________________________
	
COUNTER		    res 1   ; reserve one byte for a GENERAL counter variable
delay_count	    res 1   ; reserve one byte for counter in the delay routine
LD_count	    res 1   ; Long delay counter ( visible to human eye)	
    
    
testing		    res 1   ; for testing
;_________________ X & Y POINTER REGISTERS _________________
Y_POINTER	    res 1	; USED IN CODE POINTER FOR GLCD Y POINTER
X_POINTER	    res 1	; USED IN CODE POINTER FOR GLCD x POINTER

Y_POINTER_PARA	    res 1	; PARA SPECIFIC IN CODE POINTER FOR GLCD Y POINTER
X_POINTER_PARA	    res 1	; PARA SPECIFIC IN CODE POINTER FOR GLCD X POINTER
  
Y_COUNTER	    RES 1
X_COUNTER	    RES 1
 
   
   
;__________ GAME DATA REGISTERS __________
PARA_SPAWN_LOC	    res 1   ; HOLDS CURRENT VALUE OF THE SPAWN LOCATION 
BOOL_DEAD_OR_ALIVE  res 1   ; DEPRECATED
NUM_LIVES_LEFT	    res 1   ; HOLDS THE NUMBER OF LIVES LEF TTHE PLAYER HAS
	    
SCORE		    res 1   ; HOLDS THE PALYERS CURRETN SCORE
HIGH_SCORE	    res	1   ; HOLDS HIGHEST SCORE ONCE IMPORTED FROM EEPROM				
VAR_COUNT	    res 1   ;LOOP COUNTER
FALL_RATE	    res 1   ;RATE AT WHICH THE FALL SPEED INCREASES

   

 
rst		    code	0x00    ; reset vector
	
;================================ ROUTINE SETUP ================================
SETUP	
;stp
	call	KP_SETUP	    ; INTIALISE PORTS FOR KEYPAD READING
	
	CALL	LEX_SETUP	    ;SETTING POINTERS TO RAM & CLEARS FSR2 FOR SPAWN LIST
	CALL	LEX_LOAD_SPAWN	    ; LOADING LIST OF SPAWN LOCATIONS INTO FSR2
	CALL	LEX_LOAD_RAM	    ; LOADING CHARATERS AND ICONS INTO RAM
				    ; __ SEVERAL BANKS REQ. __
	
	CALL	GLCD_STARTUP	    ; TURNING ON GLCD AND SETTING RESET PIN HIGH 

	CALL	GLCD_CS_BOTH	    ; ACTIVATE BOTH SIDE OF GLCD (CS )
	CALL	CLEAR_CS	    ; CLEARING RHS
	
	CALL	GLCD_CS0	    ; SETTING LHS AS ACTIVE
	
;	CALL RATE_TEST_ROUTINE
	
	goto	RUN_GAME	    ;START MAIN GAME FLOW
	
;===============================================================================	

;=========================== RUN GAME ==========================================
RUN_GAME
	
	CALL	CG_LOADING_GRAPHIC	; VISUAL GRAPHICS DETAILED IN COMPOUND_GRAPHICS.ASM
	
	movlw   .100
	call	LCD_delay_ms	; wait 100ms 
	
	MOVLW	.1
	MOVWF	COUNTER
	
	;SETS RHS DISPLAY TO ACTIVE
	CALL	GLCD_CS1

	
	
	
USER_INTERACTION ; This section is to ensure that the game only starts 
		 ; running when the user is ready. waits for their confirmation 
		 ; via a them holding down the 'F' key on the keypad.
		 
	
	CALL	CG_REQUEST_KP	;outputs graphic to LFT page asking user to
				; hold down the F key
				
	CALL	CHECK_KP	; checks to see if key pad has been pressed
	
	movlw   .50
	call	LCD_delay_ms	; wait 50ms
	
	NOP
	
	MOVLW	.4	    
	CPFSEQ	COUNTER		; IF COUNTER VALUE HAS VALUE 4, its has been set
				; during ' CHECK_kp' because F is being presssed
				   
	BRA	USER_INTERACTION    ; If F is not pressed continues looping

	
	
;>>>>>>>>>>>>> SETTING X and Y Pointers to start <<<<<<<<<<<<<<<<<<
	
	;SETTING Y TO VALUE SENT TO Y POINTER
	MOVLW	0x00	
	MOVWF	Y_POINTER
	CALL	GLCD_SET_Y
	
	;SETTING X TO VALUE SENT TO X POINTER
	MOVLW	0x04
	MOVWF	X_POINTER
	CALL	GLCD_SET_X
	
;----------- Clearing the GLCD's on board RAM -----------
	
	CALL	CLEAR_CS
	movlw   .250
	call	LCD_delay_ms	; wait 50ms

; ================ Printing Sea background and Barge ================	
	call	G_FILL_SEA	; fills bottom of CS1 with 'sea' graphic	
	
	movlw   .250
	call	LCD_delay_ms	; wait 250ms
	
	CALL	BARGE_SETUP	; prints the barge in the center 
				;of the bottom line of CS1
	movlw   .250
	call	LCD_delay_ms	; wait 250ms

;>>>>>>>>>>>>> SETTING INTIAL VALUES <<<<<<<<<<<<<<<<<<
	
	; setting all of the conditional vairable to their start values
	lfsr	FSR2, AR_SPAWN_LIST	   ; setting the File select pointer  
					   ;to the start of the spawn location
					   ; in ACS RAM (see lexicon.asm)

	MOVLW	.101			  ; fall rate is how fast the drop speed
	MOVWF	FALL_RATE		  ; of the parachutist will increase
	
	MOVLW	.0
	MOVWF	SCORE
	
	MOVLW	.3
	MOVWF	NUM_LIVES_LEFT
	
	
	; visual start of the game 
SPAWN_PARA_TROOPER

	MOVF	NUM_LIVES_LEFT,0	    ;CHECKS IF THE PLAYER STILL HAS LIVES
	BZ	RUN_GAME_OVER	    ; ZERO IS NO LIVES LEFT BRANCHES TO GAME OVER
	
	MOVFF   POSTINC2, Y_POINTER_PARA    ;loads the next y location from the
	CALL	GLCD_SET_Y		    ;Spawn list and sets the GLCD
					    ; (post increments the spawn list)
					    
	MOVLW	0x00			    ; sets the GLCD to the stop line.
	MOVWF	X_POINTER
	CALL	GLCD_SET_X
	
;__________	     MOVE DOWN		_______________
	
FALL_PARA   ; drops the paratrooper down one line, keeping it vertical inline.
	;gonna get Y
	MOVFF	Y_POINTER_PARA, Y_POINTER  ; holds intial Y_value from spawn list
	
	;gonna get x
	MOVLW	0x00
	MOVWF	X_POINTER_PARA
	MOVFF	X_POINTER_PARA, X_POINTER
	CALL	GLCD_SET_Y
	CALL	GLCD_SET_X

	CALL	PRINT_PARA		    ; prints parachute Icon
	
LPFLPA	;LOOP FALL PARACHUTE
	
	MOVFF	X_POINTER_PARA, X_POINTER	
	CALL    GLCD_SET_X
	CALL    CLEAR_PAGE
	
	;================= Fall condition ==================
	
	GOTO	QUERY_PARA_SAVED ; subroutine to test if bottom of the screen 
CONT_FALLING			 ; has been reached
	
	;===============================================
	
	INCF	X_POINTER_PARA	; increments the X-pointer (its not auto)
	
					    ;gonna get Y
	MOVFF	Y_POINTER_PARA,Y_POINTER    ;keeps Y tracking vertically
	CALL	GLCD_SET_Y
	
	MOVFF	X_POINTER_PARA, X_POINTER
	CALL	GLCD_SET_X
	CALL	PRINT_PARA		    
	
	CALL	FALL_SPEED_DELAY ; CALLS DELAY THAT 
				 ;DECREASES AS THE SCORE INCREASES
	
	MOVLW	0x07		; If somehow hits the bottom of the game 
	CPFSEQ	X_POINTER_PARA	; this condition will crash the game 
	BRA	LPFLPA		; and restart it from the begining

	goto $
	;goto RUN_GAME	
	
	

RUN_GAME_OVER	    ; sequence for when the maximmum number 
		    ; of lives has been exceeded
	
	CALL	CG_WRITE_GAME	; write 'game over ' to GLCD
	
	;¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬ AESTHETICS ¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬
	movlw   .250
	call	LCD_delay_ms	; wait 
	movlw   .250
	call	LCD_delay_ms	; wait 
	movlw   .250
	call	LCD_delay_ms	; wait 

	CALL	FILL_CS
	
	movlw   .200
	call	LCD_delay_ms	; wait 
	movlw   .250
	call	LCD_delay_ms	; wait 
	movlw   .250
	call	LCD_delay_ms	; wait 
	movlw   .250
	call	LCD_delay_ms	; wait
	
	CALL	CLEAR_CS
	
	movlw   .250
	call	LCD_delay_ms	; wait 
	movlw   .250
	call	LCD_delay_ms	; wait 
	movlw   .250
	call	LCD_delay_ms	; wait
	;¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬¬
	
	CALL	UPDATE_HIGH_SCORE ; checks highscore against current 
				;(see compound_graphics.asm and high_score.asm)
	movlw   .250
	call	LCD_delay_ms	; wait 
	movlw   .250
	call	LCD_delay_ms	; wait
	movlw   .250
	call	LCD_delay_ms	; wait 
	movlw   .250
	call	LCD_delay_ms	; wait
	
;=========  RESET LIFE Icons on RHS =========
	
	CALL	GLCD_CS0
	CALL	CG_WRITE_3LIVES
	CALL	GLCD_CS1
	;RESET SCORE

	GOTO	USER_INTERACTION ; returns to game menu, awaiting user input.

;================================================================
	
	
;================== QUERY PARACHUTE SAVED ========================
QUERY_PARA_SAVED ; this routine is the main game mechanic.
		 ; it establishes if the parachute has hit the water and 'drowned'
		 ; or if the barge has 'saved' it.
	
	MOVLW	0x06	    
	CPFSEQ	X_POINTER_PARA ;CHECK IF PARACHUTE IS ON THE SAME LEVEL AS THE BARGE
	BRA	NOT_LEVEL	; SKIPPED IF THEY ARE EQUAL

	MOVLW	.15		; .15 is the width of the barge
	MOVWF	COUNTER
	
	CALL	GET_BARGE_LOC	; gets the current location of the barge Ref.
	
	DECF	WREG		; accounting for icon reference offset between
	DECF	WREG		; paratrooper and the barge
	
PASVLLP 	
	ADDLW	0x01
	DCFSNZ	COUNTER,1 ;<- DECREMTS COUNTER AND SKIPS IF NOT ZERO
	BRA	NOT_ABOVE   ; if it hits zero it means the paratrooper
			    ;is not above
	
	CPFSEQ	Y_POINTER_PARA ; <- BARGE ELEMENT STORED IN W 
	BRA	PASVLLP	; is they are equal at any point the para is above
			; and inline with the barge. therefore is saved.
	BRA	IS_ABOVE
	
	
NOT_ABOVE ; condition that is branched too if the icons are not aligned
	
	MOVLW	.250
	call	LCD_delay_ms
	
	DECF	NUM_LIVES_LEFT ; removes a life from the life counter variable
	
	CALL	CG_DISPLAY_MORTALITY	; displays the new # of live on cs0
	
	;BRA SPAWN_PARA_TROOPER
	GOTO	SPAWN_PARA_TROOPER	; spawns a new trooper
	
	
NOT_LEVEL ; icons are not on same line there check not needed.
	GOTO CONT_FALLING		;;# stack error? @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	;GOTO	CONT_FALLING
	
IS_ABOVE    ; are on the same level and aligned
	    ; executinon of saved condition
	
	DECF	FALL_RATE	; DECREASES HANG TIME OF PARA
	INCF	SCORE		;INCREMENT SCORE
	CALL	DISPLAY_SCORE	;display new score on cs0 

	GOTO	SPAWN_PARA_TROOPER  ;spawns new trooper and restarts counting.
	

;=========        VARIABLE DELAY LENGTH      ============
	
FALL_SPEED_DELAY
	MOVFF	FALL_RATE, VAR_COUNT
VDLYLP	
	
	MOVLW	.4
	call	LCD_delay_ms
	;CALL LCD_delay_x4us
	CALL	CHECK_KP
	
	DECFSZ	VAR_COUNT, 1
	BRA	VDLYLP

	RETURN
	


;########################################################	
;		    GENRAL ROUTINES 
;########################################################	
get_set_    code	
;_____GETTERS & SETTERS ____________
; THESE SET AND GET THE VALUES OF THEIR RESPECTIVE VARIABLES
; THEY ARE DESIGNED TO BE USED BY OTHER MODULES TO ACCESS AND MODIFY VARIABLES.
; THEY WORK THROUGH THE WREG
	
	
GET_Y_POINTER	   
	MOVF	Y_POINTER, 0	; MOVES VAL OF Y POINTER INTO WREG
	Return
	
SET_Y_POINTER			   
	MOVWF	Y_POINTER		; sets the val of WREG contents to Y pointer 
	CALL	GLCD_SET_Y		; sets the pointer of the GLCD to val of Y pointer
	RETURN
	
SET_X_POINTER
	MOVWF	X_POINTER		; sets the val of WREG contents to X pointer 
	CALL	GLCD_SET_X		; sets the pointer of the GLCD to val of X pointer
	RETURN
	
GET_X_POINTER
	MOVF	X_POINTER, 0	; MOVES VAL OF X POINTER INTO WREG
	RETURN
	
INC_X_POINTER			; X_POINTER DOESNT AUTO INCREMENT
	MOVLW	0x00		; ROUNTINE TO DO IT SIMPLY
	CALL	GET_X_POINTER	
	ADDLW	.1		; ADDS ONE TO CURRENT VAL OF X POINTER
	CALL	SET_X_POINTER	; SET THIS TO NEW VARIABLE AND GLCD VALUE.
	RETURN
	
INC_Y_POINTER
	MOVLW	0x00
	CALL	GET_Y_POINTER
	ADDLW	.1
	CALL	SET_Y_POINTER
	RETURN
	
GET_SCORE			; MOVES VAL OF SCORE  INTO WREG
	MOVF	SCORE, 0		
	RETURN
	
SET_SCORE
	MOVWF	SCORE		; sets the val of WREG contents to SCORE 
	RETURN
	    
GET_LIVES			; MOVES VAL OF LIVES INTO WREG
	MOVF	NUM_LIVES_LEFT, 0
	RETURN
	
SET_COUNTER
	MOVWF	COUNTER		; sets the val of WREG contents to COUNTER 
	RETURN

	
;_________ FILLS CS BY CYCLING THROUGH PAGES  ____________	
FILL_CS
	;NEED TO SET THAT IT CLEARS CS0 
	movlw	0x07
	movwf	X_POINTER
	
FLRCS0LP 
	CALL	GLCD_SET_X
	CALL	FILL_PAGE
	
	DECFSZ	X_POINTER
	bra 	FLRCS0LP
	
	CALL	GLCD_SET_X
	CALL	FILL_PAGE
	RETURN 
		
;__________ CLEARS CS BY CYCLING THROUGH PAGES _____________	
CLEAR_CS
	;NEED TO SET THAT IT CLEARS CS0 
	movlw	0x07
	movwf	X_POINTER
	
CLRCS0LP 
	CALL	GLCD_SET_X
	CALL	CLEAR_PAGE
	
	DECFSZ	X_POINTER
	bra 	CLRCS0LP
	
	CALL	GLCD_SET_X
	CALL	CLEAR_PAGE
	
	RETURN 
	
	
;________________ CLEAR PAGE ROUTINE _____________	
	
FILL_PAGE
	movlw	.64
	movwf	Y_COUNTER
	
	BSF	LATB, RB2 ; SET RS LINE HIGH
	BCF	LATB, RB3 ; RW Line low
		
FLPGLP	movlw   b'11111111'  ; loading instruction in D bus
	movwf	LATD	
	call	E_PULSE	    
	
	movlw   .2
	call	LCD_delay_ms	; wait 50ms

	DECFSZ	Y_COUNTER
	bra 	FLPGLP		
	
	RETURN
	
	
	
;________________ CLEAR PAGE ROUTINE _____________	
	
CLEAR_PAGE
	movlw .64
	movwf Y_COUNTER
	
	BSF LATB, RB2 ; SET RS LINE HIGH
	BCF LATB, RB3 ; RW Line low
		
CLPGLP	movlw   b'00000000'  ; loading instruction in D bus
	movwf	LATD
	call E_PULSE
	
	movlw   .1
	call	LCD_delay_ms	; wait 50m
	
	DECFSZ Y_COUNTER
	bra 	CLPGLP		
	
	RETURN

	;call WRITE_LEVEL

;______________ SETTERS FOR X ADDRESS AND Y ADDRESS _____________	
	
GLCD_SET_Y ; SETS THE LOCATION OF Y 
	
	BCF	LATB, RB2	    ;SETTING RS LINE LOW
	BCF	LATB, RB3	    ;SETTING RW LINE LOW
	MOVLW	b'00111111'   ; GETTING ONLY BITS  <0:5> FROM Y_POINTER
	ANDWF	Y_POINTER , 0 ; ONLY NEED ADDRESSING FROM 0 TO 63 
	ADDLW	b'01000000'   ; SETS TO CORRET FORM NOW DATA IS SET.
	MOVWF	LATD	    ; MOVE THROUGH DATA BUS
	
	NOP		    ; SOME UNNECCESSSARY DELAYS
	NOP		    ; BUT NOW IM TOO SCARED TO TAKE THEM OUT
	NOP		    ; SO I GUESS THEY'RE GONNA HAVE TO STAY.
	NOP
	
	movlw   .10
	CALL	LCD_delay_x4us	; wait 40 uS
	
	CALL	E_PULSE	    ; TRIGGER E LOADING
	
	movlw   .10
	CALL	LCD_delay_x4us	; wait 40 uS
	
	RETURN
	
	
GLCD_SET_X ;SETS THE LOCATION OF X 
	
	BCF	LATB, RB2
	BCF	LATB, RB3
	MOVLw	b'00000111'   ; GETTING ONLY BITS  <0:3> FROM Y_POINTER, ONLY NEED
	ANDWF	X_POINTER , 0 ; ADDRESSING FROM 0 TO 7 
	ADDLW	b'10111000'   ; SETS TO CORRET FORM NOW DATA IS SET.
	MOVWF	LATD	    ; MOVE THROUGH DATA BUS
	
	movlw  .10		;SUPERLOUS DELAY
	CALL	LCD_delay_x4us	; wait 10 uS
	
	CALL	E_PULSE		; LOAD E 
	
	movlw   .10
	CALL	LCD_delay_x4us	; wait 10 uS
	
	RETURN



	
	
	
	end
