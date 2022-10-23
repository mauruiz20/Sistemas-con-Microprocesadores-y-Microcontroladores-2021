/*
    Alumno: Ruiz, Francisco Mauricio
    DNI: 43364379
 */ 
            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
            .section .text
            .global reset
reset:      MOV R0,#5
            BL segmentos

stop:       B stop

segmentos:  PUSH {R4}
            LDR R4,=tabla
            LDRB R0,[R4,R0]
            POP {R4}
            BX LR

            .pool
tabla:      .byte 0x3F,0x06,0x5B,0x4F,0x66
            .byte 0x6D,0x7D,0x07,0x7F,0x67