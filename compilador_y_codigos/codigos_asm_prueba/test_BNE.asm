ADDI r1, r1, 0x1
ADDI r2, r2, 0x10 ; seria la i del for, tiene que ser multiplo de 4 para recorrer la memoria
ADDI r4, r4, 0x1
ADDI r5, r5, 0x0 ; en que valor quiero detener el loop
ADDI r2, r2, 0xfffc ; resta 4. dir destino de BNE
SLLV r4, r4, r1 ; r4<<r1
NOP
BNE r2, r5, 0xfffc ; se mueve 4 lugares hacia arriba
SW r4, 0x4(r2) ; memoria[r2+0x4]<=r4
ADDU r6, r4, r7 ; se verifica 2 cosas que salio del loop y en valor de r4. r4=r6=0x10
HALT