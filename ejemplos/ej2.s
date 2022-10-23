            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
base:       .hword 0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08
            .section .text
            .global reset

reset:      LDR R0,=base
            MOV R1,#8
            MOV R2,#0

lazo:       CBZ R1,final
            LDRH R3,[R0],#2
            ADD R2,R3
            SUB R1,#1
            B lazo

final:      LSR R2,#3
stop:       B stop