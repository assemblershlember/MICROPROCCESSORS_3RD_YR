    #include p18f87k22.inc
    
    GLOBAL EE_READ,EE_WRITE

HIGH_SCR_ACS_VAR    udata_acs   ; named variables in access ram
DATA_EE_DATA	RES 1 

    

;#define                  ;read from the start of EEPROM where the ADC value will be saved
    
 
    CONSTANT DATA_EE_ADDR = 0x40 ; LOCATION AT WHICH THE HIGH SCORE IS SAVED IN EEPROM

PERMA_SAVE    code    
    
EE_READ
    
;write the address to the EEADRH:EEADR register pair, 
;clear the EEPGD control bit (EECON1<7>)
;set control bit, RD (EECON1<0>)
; EEDATA register availible after one cycle
; therefore, it can be read after one NOP instruction.

;need to rst rp0
    
    MOVLW HIGH(DATA_EE_ADDR) ;
    MOVWF EEADRH ; Upper bits of Data Memory Address to read
    MOVLW LOW(DATA_EE_ADDR) ;
    MOVWF EEADR ; Lower bits of Data Memory Address to read
    NOP
    NOP
    
    BCF EECON1, EEPGD ; Point to DATA memory
    BCF EECON1, CFGS ; Access EEPROM
    BSF EECON1, RD ; EEPROM Read
    NOP
    NOP
    MOVF EEDATA, W ; W = EEDATA

 
    
    return                              

    
    
    
EE_WRITE ;Writes one byte to EEPROM at EEPROM_ADDR
    
    movlw 0x06
    MOVWF DATA_EE_DATA
;address must first be written to the EEADRH:EEADR register pair
;and the data written to the EEDATA register.
;The sequence must be followed to initiate the write cycle.
;The write will not begin if this sequence is not exactly followed 
;(write 0x55 to EECON2, write 0xAA to EECON2, then set WR bit) for each byte.
 
;It is strongly recommended that interrupts be disabled during this code segment.
;Additionally, the WREN bit in EECON1 must be set to enable writes. 
;prevents accidental writes to data EEPROM due to unexpected code execution
;The WREN bit should be kept clear at all times, except when updating the EEPROM. 
;The WREN bit is not cleared by hardware.
    
    ;move value from W into EEData
    
    ;BSF	    STATUS, RP0
    
    MOVLW   HIGH(DATA_EE_ADDR) ;
    MOVWF   EEADRH ; Upper bits of Data Memory Address to write
    MOVLW   LOW(DATA_EE_ADDR) ;
    MOVWF   EEADR ; Lower bits of Data Memory Address to write
    
    
    MOVFF   DATA_EE_DATA, EEDATA
    
    BCF	    EECON1, EEPGD ; Point to DATA memory
    BCF	    EECON1, CFGS ; Access EEPROM
    BSF	    EECON1, WREN ; Enable writes

    BCF	    INTCON, GIE ; Disable Interrupts
    MOVLW   0x55 ;
    MOVWF   EECON2 ; Write 55h
    MOVLW   0xAA ;
    MOVWF   EECON2 ; Write 0AAh
    BSF	    EECON1, WR ; Set WR bit to begin write
    BTFSC   EECON1, WR ; Wait for write to complete GOTO $-2
    BSF	    INTCON, GIE ; Enable Interrupts
    ; User code execution
    
    
    
    BCF	    EECON1, WREN ; Disable writes on write complete (EEIF set)
    ;bcf	    PIR6, EEIF
    ;bcf	    STATUS, RP0

    
    return                             
    
    end                                 ;end code   
    
    
