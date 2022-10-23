            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
base:       .space 1
            .byte 0x03,0x01,0x07     
            .section .text
            .global reset

reset:      LDR R0,=base
            LDRB R1,[R0,#1]
            LDRB R2,[R0,#2]
            CMP R1,R2
            ITE PL
            STRBPL R2,[R0]
            STRBMI R1,[R0]

            LDRB R3,[R0]
            LDRB R4,[R0,#3]
            CMP R4,R3
            ITE PL
            STRBPL R3,[R0]
            STRBMI R4,[R0]
            
stop:       B stop