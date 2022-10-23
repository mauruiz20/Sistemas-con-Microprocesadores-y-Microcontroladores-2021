            .cpu cortex-m4
            .syntax unified
            .thumb

            .section .data
bloque:     .byte 0x0C,0x20,0x44
cadena:     .space 4
            .section .text
            .global reset

reset:      LDR R4,=bloque
            LDR R5,=cadena

            LDRB R0,[R4]        //Primeros 6 bits
            AND R0,0x3F         //Mascara para los 6 primeros bits
            STRB R0,[R5],#1

            LDRB R0,[R4],#1     //Segundos 6 bits
            LSR R0,#6           //Los muevo a la parte baja
            AND R0,0x03         //Mascara de los 2 primeros bits
            LDRB R1,[R4]        //Cargo los 4 bits q faltan
            LSL R1,#2           //Los muevo a la parte alta
            AND R1,0x3C         //Mascara
            ORR R0,R1
            STRB R0,[R5],#1

            LDRB R0,[R4],#1
            LSR R0,#4
            AND R0,0x0F
            LDRB R1,[R4]
            LSL R1,#4
            AND R1,0x30
            ORR R0,R1
            STRB R0,[R5],#1

            LDRB R0,[R4]
            LSR R0,#2
            AND R0,0x3F
            STRB R0,[R5]

stop:       B stop