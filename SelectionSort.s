start_program     			LDR R0, =Price_list				;first element of the Price_list
          							LDR R1, =Item_list				;first item of the Item_list
          							LDR R2, =Heap_Mem 	  			;pointer to the heap section

          							MOV R3,#0
          							MOV R4,#0
           							MOV R5,#28

write_in_heap   				LDR R6,[R0,R3]					;write in the heap section the Price_list
          							STR R6,[R2,R3]
          							ADD R3,R3,#4
          							LDR R8,[R0,R3]
          							STR R8,[R2,R3]
          							ADD R3,R3,#4
          							ADD R4,R4,#1
          							CMP R5,R4
          							BHI write_in_heap

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RESTORE REGISTERS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

restore_registers_one		LDR R0, =Price_list				;first element of the Price_list
          							LDR R1, =Item_list				;first item of the Item_list
          							LDR R2, =Heap_Mem 	  			;pointer to the heap section

          							MOV R4, #28					 	;counter 2
          							MOV R5, #0
          							MOV R10, #0
          							MOV R12,#27

          							MOV R3,R2
          							SUB R2,R2, #8
          							ADD R3,R3, #8

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;IMPLEMENT THE SELECTION SORT ALGORITHM;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

start						        ADD R2,R2, #8
          							ADD R10,R10, #1
          							MOV R5, #0
          							MOV R3,R2
          							SUB R4,R4, #1

loop						        ADD R3,R3, #8
          							ADD R5,R5, #1
          							LDRD R6,R7,[R2]
          							LDRD R8,R9,[R3]
          							CMP R8,R6
          							STRLS R8,[R2]
          							STRLS R9,[R2, #4]
          							STRLS R6,[R3]
          							STRLS R7,[R3, #4]
          							CMP R5,R4
          							BLO loop
          							CMP R10,R12
          							BLO start

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RESTORE REGISTERS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

restore_registers_two		LDR R0, =Price_list				;first element of the Price_list
          							LDR R1, =Item_list				;first item of the Item_list
          							LDR R2, =Heap_Mem 	  			;pointer to the heap section

          							MOV R3, #0
          							MOV R4, #0
          							MOV R5, #0
          							MOV R6, #0
          							MOV R7, #0
          							MOV R8, #0
          							MOV R9, #0
          							MOV R10, #0
          							MOV R11, #0
          							MOV R12, #0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;WORKS ON A SORTED LIST;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

start_calculation			  MOV R12,#2						;R12 -> 2
          							MOV R10,#0						;final result
          							MOV R0,#0						;control on Item_list

start_loop					    LDR R4,[R1]						;R4 -> item tag
          							MOV R8,#27						;number of items to be searched	-1 [last]
          							MOV R9,#0						  ;R9 -> 0 [first]

start_inner_loop			  CMP R9,R8						;first <= last ?
          							BHI no_match
          							ADD R11,R8,R9 					;R11 -> first + last
          							UDIV R7,R11,R12					;R7 -> middle -> first + last / 2
          							LDR R5,[R2,R7,LSL #3]			;R5 -> item tag
          							CMP R4,R5						;compare item tags
          							BEQ end_loop
          							ITTE GE	   						;it's going OK
          							ADDGE R7,R7,#1
          							MOVGE R9,R7
          							SUBLT R7,R7,#1
          							MOVLT R8,R7
          							B start_inner_loop

end_loop					      LSL R7,#3
          							ADD R7,#4
          							LDR R5,[R2,R7]					;R2 -> cost per item  (now it's ok)

          							ADD R1,R1,#4					;increase the pointer on Item_list
          							LDR R4,[R1]			 			;R4 -> number of items to be bought
          							ADD R1,R1,#4					;increase the pointer on Item_list

          							MUL R5,R5,R4					;R5 -> total money on one item
          							ADD R10,R10,R5					;increase R10 -> final result

          							ADD R0,R0,#1					;increase the control on Item_list
          							CMP R0,#4				 		;see if I'm at the end
          							BLO start_loop
          							B InfLoop

no_match					      MOV R10,#0

InfLoop                 B InfLoop

Price_list	DCD 0x018, 138, 0x01A, 2222, 0x01B, 34, 0x01E, 11
			DCD 0x010, 228, 0x012, 7, 0x016, 722, 0x017, 1217
			DCD 0x004, 120, 0x006, 315, 0x007, 1210, 0x00A, 245
			DCD 0x042, 230, 0x045, 1112, 0x047, 2627 , 0x04A, 265
			DCD 0x022, 223, 0x023, 1249, 0x025, 240, 0x027, 112
			DCD 0x036, 3211, 0x039, 112, 0x03C, 719, 0x03E, 661
			DCD 0x02C, 2245, 0x02D, 410, 0x031, 840, 0x033, 945

Item_list 	DCD 0x022, 14, 0x006, 431, 0x03E, 1210, 0x017, 56342


                        ENDP
