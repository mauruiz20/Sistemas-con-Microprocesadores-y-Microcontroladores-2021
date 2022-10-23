            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
lista1:     .byte 0x01,0x02,0x03,0x04,0x05
lista2:     .byte 0x06,0x07,0x01,0x02,0x09
            .section .text
            .global reset
reset:      MOV R0,#2
            LDR R1,=lista1
            LDR R2,=lista2
            MOV R3,#5

            PUSH {R1,R3}
            BL buscarNro
stop:       B stop

buscarNro:  PUSH {R4,LR}
            LDR R1,[SP,#4]
            LDR R3,[SP,#8]
recorrer:   CBZ R3,final
            LDRB R4,[R1]
            CMP R1,R4

final:      POP {R4,PC}