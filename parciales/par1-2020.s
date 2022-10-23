            .cpu cortex-m4
            .syntax unified
            .thumb

            .section .data
datos:      .byte 0x0C,0x20,0x44,0x22,0x33,0x11,0x01
resultado:  .space 8
            .section .text
            .global reset
reset:      LDR R4,=datos
            LDR R5,=resultado
            MOV R6,#7
            BL mime

stop:       B stop

mime:       PUSH {R4,R5,R6,LR}

lazo_mime:  CMP R6,#3
            IT CC
            POPCC {R4,R5,R6,PC}

            BL convertir
            ADD R4,#4
            ADD R5,#4
            SUB R6,#3

            B lazo_mime
   
convertir:  PUSH {R4,R5}

            LDRB R1,[R4]
            AND R1,R1,#0x3F
            STRB R1,[R5],#1

            LDRB R1,[R4]
            LSR R1,#6
            LDRB R2,[R4,#1]!
            LSL R2,#2
            AND R2,R2,#0x3C
            ORR R1,R2
            STRB R1,[R5],#1

            LDRB R1,[R4]
            LSR R1,#4
            LDRB R2,[R4,#1]!
            LSL R2,#4
            AND R2,R2,#0x30
            ORR R1,R2
            STRB R1,[R5],#1

            LDRB R1,[R4]
            LSR R1,#2
            STRB R1,[R5]

            POP {R4,R5}
            BX LR
