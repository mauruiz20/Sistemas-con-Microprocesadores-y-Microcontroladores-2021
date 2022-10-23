            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
segundos:   .byte 0x08,0x04
minutos:    .byte 0x09,0x00 
            .section .text
            .global reset
reset:      MOV R0,#4
            BL conversor

stop:       B stop
            .pool
tabla:      .byte 0x3F,0x06,0x5B,0x4F,0x66
            .byte 0x6D,0x7D,0x07,0x7F,0x6F
 
retardo:    CBZ R0,fin_retardo
            SUB R0,#1
            B retardo
fin_retardo:
            BX LR

conversor:  PUSH {R4,LR}
            LDR R4,=tabla
            LDRB R0,[R4,R0]
            POP {R4,PC}
            
