; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
#include p18f87k22.inc
	
	EXTERN SCORE_0,SCORE_1,SCORE_2,SCORE_3,SCORE_4,SCORE_5,SCORE_6,SCORE_7,SCORE_8,SCORE_9
	EXTERN GET_SCORE
	
	GLOBAL LOOK_UP_TABLE_ACCESS
    
LKUTBL    udata_acs	
SCORE_TMP_1		    res 1
SCORE_TMP_2		    res 1

; TODO ADD INTERRUPTS HERE IF USED

SCORE_LOOKUP_MODULE CODE                      ; let linker place main program

START

LOOK_UP_TABLE_ACCESS
    


	
	MOVWF	SCORE_TMP_1
	MOVFF	SCORE_TMP_1,SCORE_TMP_2
	
	INCF	SCORE_TMP_1
	INCF	SCORE_TMP_2
	
	;SCORE OF ZERO
	DCFSNZ	SCORE_TMP_1
	CALL	SCORE_0
	DCFSNZ	SCORE_TMP_2
	CALL	SCORE_0
		 

	
	;IF IT IS 1 LIFE 
	DCFSNZ	SCORE_TMP_1
	CALL	SCORE_0
	DCFSNZ	SCORE_TMP_2
	CALL	SCORE_1
		 
	
	;IF IT IS 2 LIVES
	DCFSNZ	SCORE_TMP_1
	CALL	SCORE_0
	DCFSNZ	SCORE_TMP_2
	CALL	SCORE_2
		 
	
	;Score 3
	DCFSNZ	SCORE_TMP_1
	CALL	SCORE_0
	DCFSNZ	SCORE_TMP_2
	CALL	SCORE_3
		 
	
	;Score 4
	DCFSNZ	SCORE_TMP_1
	CALL	SCORE_0
	DCFSNZ	SCORE_TMP_2
	CALL	SCORE_4
		 
	
	;Score 5
	DCFSNZ	SCORE_TMP_1
	CALL	SCORE_0
	DCFSNZ	SCORE_TMP_2
	CALL	SCORE_5
		 
;	
	;Score 6
	DCFSNZ	SCORE_TMP_1
	CALL	SCORE_0
	DCFSNZ	SCORE_TMP_2
	CALL	SCORE_6
		 
	
	;Score 7
	DCFSNZ	SCORE_TMP_1
	CALL	SCORE_0
	DCFSNZ	SCORE_TMP_2
	CALL	SCORE_7
		 
	
	;Score 8
	DCFSNZ	SCORE_TMP_1
	CALL	SCORE_0
	DCFSNZ	SCORE_TMP_2
	CALL	SCORE_8
		 
;	
;	
	;Score 9
	DCFSNZ	SCORE_TMP_1
	CALL	SCORE_0
	DCFSNZ	SCORE_TMP_2
	CALL	SCORE_9
		 
;	
	
	;              
	;Score 9
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_0
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_9
	           
;              
	;Score 10
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_1
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_0
	           
;              
	;Score 11
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_1
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_1
	           
;              
	;Score 12
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_1
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_2
	           
;              
	;Score 13
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_1
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_3
	           
;              
	;Score 14
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_1
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_4
	           
;              
	;Score 15
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_1
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_5
	           
;              
	;Score 16
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_1
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_6
	           
;              
	;Score 17
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_1
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_7
	           
;              
	;Score 18
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_1
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_8
	           
;              
	;Score 19
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_1
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_9
	           
;              
	;Score 20
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_2
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_0
	           
;              
	;Score 21
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_2
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_1
	           
;              
	;Score 22
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_2
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_2
	           
;              
	;Score 23
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_2
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_3
	           
;              
	;Score 24
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_2
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_4
	           
;              
	;Score 25
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_2
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_5
	           
;              
	;Score 26
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_2
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_6
	           
;              
	;Score 27
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_2
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_7
	           
;              
	;Score 28
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_2
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_8
	           
;              
	;Score 29
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_2
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_9
	           
;              
	;Score 30
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_3
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_0
	           
;              
	;Score 31
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_3
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_1
	           
;              
	;Score 32
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_3
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_2
	           
;              
	;Score 33
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_3
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_3
	           
;              
	;Score 34
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_3
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_4
	           
;              
	;Score 35
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_3
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_5
	           
;              
	;Score 36
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_3
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_6
	           
;              
	;Score 37
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_3
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_7
	           
;              
	;Score 38
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_3
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_8
	           
;              
	;Score 39
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_3
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_9
	           
;              
	;Score 40
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_4
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_0
	           
;              
	;Score 41
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_4
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_1
	           
;              
	;Score 42
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_4
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_2
	           
;              
	;Score 43
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_4
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_3
	           
;              
	;Score 44
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_4
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_4
	           
;              
	;Score 45
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_4
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_5
	           
;              
	;Score 46
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_4
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_6
	           
;              
	;Score 47
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_4
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_7
	           
;              
	;Score 48
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_4
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_8
	           
;              
	;Score 49
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_4
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_9
	           
;              
	;Score 50
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_5
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_0
	           
;              
	;Score 51
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_5
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_1
	           
;              
	;Score 52
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_5
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_2
	           
;              
	;Score 53
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_5
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_3
	           
;              
	;Score 54
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_5
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_4
	           
;              
	;Score 55
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_5
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_5
	           
;              
	;Score 56
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_5
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_6
	           
;              
	;Score 57
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_5
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_7
	           
;              
	;Score 58
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_5
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_8
	           
;              
	;Score 59
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_5
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_9
	           
;              
	;Score 60
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_6
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_0
	           

;              
	;Score 61
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_6
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_1
	           
;              
	;Score 62
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_6
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_2
	           
;              
	;Score 63
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_6
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_3
	           
;              
	;Score 64
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_6
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_4
	           
;              
	;Score 65
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_6
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_5
	           
;              
	;Score 66
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_6
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_6
	           
;              
	;Score 67
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_6
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_7
	           
;              
	;Score 68
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_6
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_8
	           
;              
	;Score 69
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_6
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_9
	           
;              
	;Score 70
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_7
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_0
	           
;              
	;Score 71
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_7
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_1
	           
;             
	;Score 72
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_7
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_2
	           
;              
	;Score 73
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_7
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_3
	           
;              
	;Score 74
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_7
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_4
	           
;              
	;Score 75
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_7
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_5
	           
;              
	;Score 76
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_7
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_6
	           
;              
	;Score 77
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_7
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_7
	           
;              
	;Score 78
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_7
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_8
	           
;              
	;Score 79
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_7
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_9
	           
;              
	;Score 80
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_8
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_0
	           
;              
	;Score 81
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_8
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_1
	           
;              
	;Score 82
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_8
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_2
	           
;              
	;Score 83
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_8
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_3
	           
;              
	;Score 84
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_8
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_4
	           
;              
	;Score 85
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_8
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_5
	           
;              
	;Score 86
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_8
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_6
	           
;              
	;Score 87
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_8
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_7
	           
;              
	;Score 88
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_8
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_8
	           
;              
	;Score 89
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_8
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_9
	           
;              
	;Score 90
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_9
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_0
	           
;              
	;Score 91
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_9
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_1
	           
;              
	;Score 92
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_9
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_2
	           
;              
	;Score 93
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_9
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_3
	           
;              
	;Score 94
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_9
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_4
	           
;              
	;Score 95
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_9
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_5
	           
;              
	;Score 96
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_9
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_6
	           
;              
	;Score 97
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_9
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_7
	           
;              
	;Score 98
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_9
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_8
	           
;              
	;Score 99
	DCFSNZ SCORE_TMP_1
	CALL      SCORE_9
	DCFSNZ SCORE_TMP_2
	CALL      SCORE_9
	
	
RET_SCORE
	

	return


    END