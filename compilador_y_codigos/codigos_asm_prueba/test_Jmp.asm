ADDI r1, r1, 0x24 ; direccion de salto
ADDI r2, r2, 0xf 
ADDI r3, r3, 0x5 
ADDI r4, r4, 0x1
ADDI r5, r5, 0x1
J 0x9 ; direccion de salto 0x24 
SLLV r4, r4, r5
ADDI r6, r6, 0xa
ADDI r7, r7, 0xb
ADDI r8, r8, 0xc ; dir 0x24 
ADDI r9, r9, 0xd
HALT