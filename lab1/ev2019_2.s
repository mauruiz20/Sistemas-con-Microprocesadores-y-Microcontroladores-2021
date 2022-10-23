            .cpu cortex-m4
            .syntax unified
            .thumb

            .section .data
origen:     .byte 5,6,7,9,8
            .space 15,0xFF
            .section .text
            .global reset
reset:      LDR R4,=origen
            LDR R2,=tabla
            
digito1:    LDRB R3,[R4],#1
            CMP R3,0xFF
            BEQ stop
            LDRB R0,[R2,R3]
            MOV R5,#10
            B retardo1  

digito2:    LDRB R3,[R4],#1
            CMP R3,0xFF
            BEQ stop
            LDRB R1,[R2,R3]
            MOV R5,#10
            B retardo2  

retardo1:   CMP R5,#1
            BEQ digito2
            SUB R5,#1
            B retardo1

retardo2:   CMP R5,#1
            BEQ digito1
            SUB R5,#1
            B retardo2

stop:       B stop
            .pool
tabla:      .byte 0x3F,0x06,0x5B,0x4F
            .byte 0x66,0x6D,0x7D,0x07
            .byte 0x7F,0x6F