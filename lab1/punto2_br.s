        .cpu cortex-m4
        .syntax unified
        .thumb

        .section .data
vector: .hword 3
        .space 6,0x00

        .section .text
        .global reset

reset:  
        LDR R0,=vector
        LDRH R1,[R0],#2
        MOV R2,0x55
lazo:   
        STRH R1,[R0],#2
        SUBS R1,#1
        BNE lazo
stop:   
        B stop    