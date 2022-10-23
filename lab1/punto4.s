            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
segundos:   .byte 9,5
hora:       .byte 9,5,1,0
            .section .text
            .global reset

reset:      MOV R0,#0           //R0 sera divisor
            LDR R1,=segundos
            LDR R2,=hora
            LDRB R3,[R1]        //Unidades de segundos
            LDRB R4,[R1,#1]     //Decenas de segundos
            LDRB R5,[R2]        //Unidades de minutos
            LDRB R6,[R2,#1]     //Decenas de minutos
            LDRB R7,[R2,#2]     //Unidades de horas
            LDRB R8,[R2,#3]     //Decenas de horas

actualizar: ADD R0,#1

            CMP R0,1000
            ITTT EQ
            MOVEQ R0,#0
            ADDEQ R3,#1
            STRBEQ R3,[R1]

            CMP R3,#10
            ITTTT EQ
            MOVEQ R3,#0
            STRBEQ R3,[R1]
            ADDEQ R4,#1
            STRBEQ R4,[R1,#1]

            CMP R4,#6
            ITTTT EQ
            MOVEQ R4,#0
            STRBEQ R4,[R1,#1]
            ADDEQ R5,#1
            STRBEQ R5,[R2]

            CMP R5,#10
            ITTTT EQ
            MOVEQ R5,#0
            STRBEQ R5,[R2]
            ADDEQ R6,#1
            STRBEQ R6,[R2,#1]

            CMP R6,#6
            ITTTT EQ
            MOVEQ R6,#0
            STRBEQ R6,[R2,#1]
            ADDEQ R7,#1
            STRBEQ R7,[R2,#2]

            CMP R8,#2
            BEQ caso1
            CMP R7,#10          
            ITTTT EQ
            MOVEQ R7,#0
            STRBEQ R7,[R2,#2]
            ADDEQ R8,#1
            STRBEQ R8,[R2,#3]
            B actualizar

caso1:      CMP R7,#4
            ITTTT EQ
            MOVEQ R7,#0
            STRBEQ R7,[R2,#2]
            MOVEQ R8,#0
            STRBEQ R8,[R2,#3]
            B actualizar

stop:       B stop
            