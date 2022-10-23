            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
base:     .space 10       //Reservo 10 bytes en memoria
            .section .text
            .global reset

reset:      LDR R0,=base        //Puntero al vector
            MOV R1,#4           //Cantidad de elementos
            STRH R1,[R0],#2     //Guardo en 16 bits

lazo:       MOV R2,#0x55        //0x55
            STRH R2,[R0],#2     //Guardo en 16 bits
            SUBS R1,#1          //Decremento R1 como contador
            BNE lazo            //Si no es 0 vuelvo al lazo
            B stop

stop:       B stop
