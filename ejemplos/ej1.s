            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data

num1:       .word 0xFFFFFFFF
num2:       .word 0x00000002
res:        .space 2
            .align
            .section .text
            .global reset

reset:      LDR R0,=num1
            LDR R1,=num2
            LDR R2,=res

            LDR R0,[R0]
            LDR R1,[R1]
            ADDS R0,R1
            STR R0,[R2]
            LDR R3,[R2]

stop:       B stop