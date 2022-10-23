            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
origen:     .byte 6,2,5,7
            .space 15,0xFF
            .section .text
            .global reset

reset:      LDR R1,=origen
            LDR R2,=tabla
            
lazo:       LDRB R3,[R1],#1
            CMP R3,0xFF
            BEQ stop
            LDRB R0,[R2,R3]     //En R0 voy mostrando los digitos
            B lazo
            
stop:       B stop

            .pool
tabla:      .byte 0x3F,0x06,0x5B,0x4F,0x66
            .byte 0x6D,0x7D,0x07,0x7F,0x6F