ADDI r4, r4, 0x1E ; r4=30
ADDI r2, r2, 0x4 ; r2=4 
ADDI r3, r3, 0x5 ; r3=5
SW r4, 0x0(r2) ; memoria[r2+0x0]<=r4
LW r1, 0x0(r2) ;  r1=r4=30
SUBU r5, r1, r3 ; riesgo LDE cuando se lee r1. r5=25=0x19
AND r6, r4, r2 ; r6=0x4
HALT