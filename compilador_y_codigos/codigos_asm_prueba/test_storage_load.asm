ADDI r1, r1, 0x4 
ADDI r2, r2, 0xa 
ADDI r3, r3, 0xf 
ADDI r4, r4, 0x14 
SW r2, 0x0(r1)
SW r3, 0x4(r1)
SW r4, 0x8(r1)
LW r5, 0x0(r1) ; r5=r2
LW r6, 0x4(r1) ; r6=r3
LW r7, 0x8(r1) ; r7=r4
HALT 