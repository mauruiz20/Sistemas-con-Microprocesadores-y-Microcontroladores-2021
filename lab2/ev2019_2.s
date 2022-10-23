            .cpu cortex-m4
            .syntax unified
            .thumb

            .section .data
segundos_hora:  .byte 0x08,0x04
minutos_hora:   .byte 0x09,0x00
segundos_alarma:.byte 0x04,0x01
minutos_alarma: .byte 0x00,0x01
            .section .text
            .global reset
reset:      LDR R1,=segundos_hora
            LDR R2,=segundos_alarma

comparar:   
