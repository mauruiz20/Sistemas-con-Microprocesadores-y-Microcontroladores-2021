            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
base:       .space 1
            .byte 0x03,0x3A,0xAA,0xF2
            .section .text
            .global reset
reset:      LDR R0,=base
            BL mayor
stop:       B stop

            .func mayor
mayor:      PUSH {R4,LR}
            MOV R4,R0
            LDRB R1,[R0,#1]!
            LDRB R2,[R0,#1]!

lazo:       CBZ R1,fin
            LDRB R3,[R0,#1]!
            CMP R2,R3
            IT MI
            MOVMI R2,R3
            SUB R1,#1
            B lazo
fin:        STRB R2,[R4]
            POP {R4,PC}
            .endfunc