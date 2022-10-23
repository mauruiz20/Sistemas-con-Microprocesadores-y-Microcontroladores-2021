            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
vector:     .byte 0x06,0x85,0x78,0xF8,0xE0,0x80
            .section .text
            .global reset
reset:      LDR R0,=vector
            MOV R2,#0
            LDR R3,=tabla

lazo:       LDRB R1,[R0]
            CMP R1,0x80
            BEQ final

            TST R1,#128
            ITTT NE
            EORNE R1,#0x7F
            ADDNE R1,#1
            ADDNE R2,#1

            STRB R1,[R0]
            ADD R0,#1
            B lazo

final:      LDRB R1,[R3,R2]
stop:       B stop
            .pool
tabla:      .byte 0x3F,0x06,0x5B,0x4F,0x66
            .byte 0x6D,0x7D,0x07,0x7F,0x6F