            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data

vector:     .space 18

            .section .text
            .global reset

reset:      LDR R0,=vector
            MOV R2,#0x08               //Cantidad de elementos del vector
            STRH R2,[R0],#2         

lazo:       MOV R3,#0x55
            STRH R3,[R0],#2
            SUBS R2,#1
            BNE lazo

stop:       B stop