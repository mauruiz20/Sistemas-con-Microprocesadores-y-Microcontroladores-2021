            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
base:       .byte 0x01,0x02,0x03,0x04,0x05,0x00
resultado:  .space 2,0x00
            .section .text
            .global reset

reset:      LDR R0,=base
            LDR R1,=resultado
            MOV R3,#0           //Contador de numeros impares
            MOV R4,#0           //Contador de numeros pares

lazo:       LDRB R5,[R0],#1
            CMP R5,0x00
            BEQ final
            TST R5,#1           //Compruebo si el LSB es 0 o 1 para saber si es par o impar respectivamente
            ITE NE          
            ADDNE R3,#1         //Incremento R3 si es impar
            ADDEQ R4,#1         //Incremento R4 si es par
            B lazo

final:      STRB R4,[R1],#1
            STRB R3,[R1]

stop:       B stop