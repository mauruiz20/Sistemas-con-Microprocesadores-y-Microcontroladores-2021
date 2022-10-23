            .cpu cortex-m4
            .syntax unified
            .thumb

            .section .data
origen:     .byte 5,6,10,14,12
            .space 15,0xFF
            .section .text
            .global reset
reset:      LDR R0,=origen
            LDR R2,=tabla

lazo:       LDRB R3,[R0],#1
            CMP R3,0xFF
            BEQ stop
            LDRB R1,[R2,R3]
            B lazo

stop:       B stop
            .pool
tabla:      .byte 0x3F,0x06,0x5B,0x4F
            .byte 0x66,0x6D,0x7D,0x07
            .byte 0x7F,0x6F,0x77,0x8C
            .byte 0x39,0x5E,0x79,0x71