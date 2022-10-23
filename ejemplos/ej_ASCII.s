            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
cadena:     .asciz "SISTEMAS CON MICROPROCESADORES"
caracter:   .ascii "S"
            .section .text
            .global reset

reset:      MOV R0,#0
            LDR R1,=caracter
            LDRB R1,[R1]
            LDR R2,=cadena

lazo:       LDRB R3,[R2],#1
            CMP R3,R1
            IT EQ
            ADDEQ R0,#1
            CBZ R3,stop
            B lazo

stop:       B stop