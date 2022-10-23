            .cpu cortex-m4
            .syntax unified
            .thumb

            .section .data
bloque:     .byte 0x01,0x03,0x05,0x0A,0x03
base:       .space 5
            .section .text
            .global reset

reset:      MOV R0,#5           //Cantidad de elementos
            LDR R1,=bloque
            LDR R2,=base
            STR R1,[R2]         //Direccion del bloque
            LDRB R3,[R1],#1     //Carga del primer elemento
            SUB R0,#1           //n-1 iteraciones

lazo:       CBZ R0,final
            LDRB R4,[R1],#1     //Carga del sig elemento
            ADD R3,R4           //Acumulo la suma en R3
            SUB R0,#1           //Decremento contador
            B lazo

final:      STRB R3,[R2,#4]     //Guardo el res en base+4

stop:       B stop