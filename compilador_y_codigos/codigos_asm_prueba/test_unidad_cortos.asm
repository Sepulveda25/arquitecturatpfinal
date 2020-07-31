ADDI r1, r1, 0x3 
ADDI r2, r2, 0x7 
ADDU r3, r1, r2 ; corto r1 desde WB y r2 desde MEM
SUBU r5, r3, r1 ; r5=7
HALT