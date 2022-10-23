            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
base:       .byte 0x06,0x7A,0x7B,0x7C,0x00
            .section .text
            .global reset
reset:      LDR R0,=base

lazo:       LDRB R1,[R0],#1
            CBZ R1,stop
            MOV R2,#0
            MOV R3,#8

contar:     CBZ R3,agregar
            LSRS R1,#1
            IT CS
            ADDCS R2,#1
            SUB R3,#1
            B contar

agregar:    TST R2,#1
            ITTT NE
            LDRBNE R1,[R0,#-1]
            ORRNE R1,#128
            STRBNE R1,[R0,#-1]
            B lazo

stop:       B stop