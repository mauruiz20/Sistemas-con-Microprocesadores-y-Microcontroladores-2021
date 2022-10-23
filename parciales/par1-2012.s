            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
            .equ Tabla, 0x80
            .equ Resultado, 0x90
Tabla:      .byte 0x03,0x07,0x01,0x05,0xFF
Resultado:  .space 1
            .section .text
            .global reset
reset:      LDR R0,=Tabla
            LDR R1,=Resultado
            BL empacar
stop:       B stop

empacar:    PUSH {R4,R5,R6}
            LDRB R4,[R0],#1
            MOV R5,#0x00
lazo_emp:   CMP R4,0xFF
            BEQ fin_emp
            MOV R6,#0x01
            LSL R6,R4
            ORR R5,R6
            LDRB R4,[R0],#1
            B lazo_emp
fin_emp:    STRB R5,[R1]
            POP {R4,R5,R6}
            BX LR