# Microprocessors

Microproccessors Project
3rd Year

Authors: 
John Townsend, Jacob Holleran

============================ PARACHUTES GAME ============================

This project is a 8 big game that requires the player to 'catch' 
falling parachutists with a 'barge' that moves laterally. 

The player has 3 lives. 1 life is lost each time a parachute hits the water.
Each parachute save is +1 point to the score.

Each parachute falls faster than the previous, making the game more challenging 
as the players score gets higher.

If the player loses all of their lives, the game is over and 
they are returned to the game menu.
If they have achived a new high score it will be updated.



This game is written in assembly specifically for a PIC18 F87 K22 Microcontroller. 

COMPILER Toolchain: MPASMWIN(v5.81)

The linker used to generate the executeable hex file / machine code is MPLAB X IDE v5.00. 
(MPLAB X includes:The MPASM™ assembler, the MPLINK™ object linker and the MPLIB™ object librarian)



______________________ PERIPHERALS  _______________________________

These are the required peripherals to guarantee project operation with no modification. 

+==================================+=========+========================+================+
|              HARDWARE            |  PORT   |      Description       | SERIAL NUMBER  |
+==================================+=========+========================+================+
| PIC18F87K22                      |80P TQFP | Microcontroller (MCU)  | PIC18F87K22    |
+----------------------------------+---------+------------------------+----------------+
| 4x4 passive keypad               | PORTE   | Push to make keypad    |           N/A  |
+----------------------------------+---------+------------------------+----------------+
| 128X64 GLCD         DATA BUS     | PORTD   |CN17 Display Connector  |    WDG0151-TMI |
+                                  +---------+			      +		       +
|                     CONTROL BUS  | PORTB   | Dual NT7108C drivers   |                |
+----------------------------------+---------+------------------------+----------------+
| EasyPIC PRO™ v7 Development Board|80P TQFP |                        |           N/A  |
+----------------------------------+---------+------------------------+----------------+

Development Board CN17 Display Connector pin mapping:
+-----------+---------+-------+
| GLCD PIN  |  PORTD  | PORTB |
+-----------+---------+-------+
| CS1       | -       | RB0   |
| CS2       | -       | RB1   |
| RS        | -       | RB2   |
| R/W       | -       | RB3   |
| E         | -       | RB4   |
| RST       | -       | RB5   |
| D<0:7>    | RD<0:7> | -     |
+-----------+---------+-------+

Keypad Mapping for encoded command and expected Port value on key press

  KEYPAD    Command     Hex #  
 -------- ------------ ------- 
  1-3      Null                
  F        Start Game   0x18   
  4        Move right   0x14   
  5-6      null                
  E        Move left    0x84   
  7-D      null                
  A-C      null              


____________________________ Source Files  _______________________________

Here is a list of all of the source files, and a breif description 
as to their purpose and operational hierachy. A detailed view of 
each source file is availbile in the succeding section.

+===================+===+================+=========================================================================================================+
|    Source File    | # | Length (lines) |                                            Brief Description                                            |
+===================+===+================+=========================================================================================================+
| main.asm          | 1 |            628 | Main program flow, where all the routine calls occur from. where the game mechanics and conditions are. |
+-------------------+---+----------------+---------------------------------------------------------------------------------------------------------+
| GLCD.asm          | 2 |            273 | Setup up the GLCD, and commands relating to reading and writing the GLCD. Also delay routines are here. |
+-------------------+---+----------------+---------------------------------------------------------------------------------------------------------+
| Keypad.asm        | 3 |            225 | Decides key presses and moves the barge on the RHS Display.                                             |
+-------------------+---+----------------+---------------------------------------------------------------------------------------------------------+
| graphics.asm      | 4 |            160 | Generates the sea and the barge icons                                                                   |
+-------------------+---+----------------+---------------------------------------------------------------------------------------------------------+
| Lexicon.asm       | 5 |           1272 | Holds the full character & icon set & spawn list. loads all into RAM                                    |
+-------------------+---+----------------+---------------------------------------------------------------------------------------------------------+
| Compound_graphics | 6 |            979 | uses single characters from lexicon to create compound strings.                                         |
+-------------------+---+----------------+---------------------------------------------------------------------------------------------------------+
| Score_lookup.asm  | 7 |            737 | lookup table to take a numeric value stored in WREG and output it to the GLCD as a 2 character number.  |
+-------------------+---+----------------+---------------------------------------------------------------------------------------------------------+
| High_score.asm    | 8 |             48 | Read & Writes High score to EEPROM Memory                                                               |
+-------------------+---+----------------+---------------------------------------------------------------------------------------------------------+

At the start of each source file is a list of all of the subroutines within it.



The following listing only contains global Subrotines:
	
+===============+========================================================================+
| Main.asm      | Description                                                            |
+===============+========================================================================+
| GET_Y_POINTER | Moves contents of Y pointer Register into WREG                         |
+---------------+------------------------------------------------------------------------+
| SET_Y_POINTER | Moves Contents of WREG into Y_Pointer register and sets GLCD Y ADDRESS |
+---------------+------------------------------------------------------------------------+
| SET_X_POINTER | Moves contents of X pointer Register into WREG                         |
+---------------+------------------------------------------------------------------------+
| GET_X_POINTER | Moves Contents of WREG into X_Pointer register and sets GLCD X ADDRESS |
+---------------+------------------------------------------------------------------------+
| GLCD_SET_Y    | Sets Y ADDRESS of GLCD page(s) that are currently active               |
+---------------+------------------------------------------------------------------------+
| GLCD_SET_X    | Sets Y ADDRESS of GLCD page(s) that are currently active               |
+---------------+------------------------------------------------------------------------+
| INC_X_POINTER | Increments contents of X_pointer Register                              |
+---------------+------------------------------------------------------------------------+
| CLEAR_CS      | Fills CS with Empty columns at a visible rate                          |
+---------------+------------------------------------------------------------------------+
| GET_LIVES     | Moves contents of LIVES Register into WREG                             |
+---------------+------------------------------------------------------------------------+
| GET_SCORE     | Moves contents of SCORE Register into WREG                             |
+---------------+------------------------------------------------------------------------+
| SET_SCORE     | Moves Contents of WREG into SCORE register                             |
+---------------+------------------------------------------------------------------------+
| SET_COUNTER   | Moves Contents of WREG into COUNTER register                           |
+---------------+------------------------------------------------------------------------+


