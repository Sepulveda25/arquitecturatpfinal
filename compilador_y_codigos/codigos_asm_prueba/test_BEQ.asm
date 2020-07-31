ADDI r1, r1, 0xf ; r1=15
ADDI r2, r2, 0xa ; r2=10
ADDI r3, r3, 0x5 ; r3=5
ADDI r5, r5, 0x1 ;
ADDI r6, r6, 0x1 ;
SUBU r1, r1, r3 ; 1° vez r1=15-5=10. dir destino del salto BEQ
ADDI r4, r4, 0x8 ; r4=8
NOP
BEQ r1, r2, 0xfffc ; r1==r2?
SLLV r5, r5, r6 ; r5=r5<<r6
ADDU r7, r1, r7 ; r7=r1. sale con r1=5
HALT