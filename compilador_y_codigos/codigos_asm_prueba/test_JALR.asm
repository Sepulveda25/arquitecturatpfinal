ADDI r1, r1, 0x24 ; direccion de salto 0x24 
ADDI r2, r2, 0xf 
ADDI r3, r3, 0x5
ADDI r4, r4, 0x1
ADDI r5, r5, 0x1
JALR r9, r1 ; r9=PCactual+8=0x1c 
SLLV r4, r4, r5
ADDI r6, r6, 0xa ; dir de retorno r9=0x1C
ADDI r7, r7, 0xb
ADDI r8, r8, 0xc ; dir 0x24
ADDI r9, r9, 0x0
HALT