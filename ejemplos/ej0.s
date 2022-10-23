            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
num1:       .byte 0xFF,0x02
num2:       .byte 0x02,0x04
res:        .space 2
            .align
            .section .text
            .global reset
reset:      LDR R0,=num1
            LDR R1,=num2
            LDR R2,=res
            LDRB R3,[R0],#1     //Byte menos significativo de num1
            LDRB R4,[R1],#1     //Byte menos significativo de num2
            ADD R3,R4           //Suma de la parte menos significativa         
            MOV R5,#0x0100   
            AND R5,R3
            LSR R5,#8
            AND R3,#0x0F
            STRB R3,[R2],#1     
            LDRB R3,[R0],#1     //Byte mas sign de num1
            LDRB R4,[R1],#1     //Byte mas sign de num2
            ADD R3,R4           //Suma de la parte mas significativa
            ADD R3,R5           //Sumo carry
            STRB R3,[R2]

            LDRB R6,[R2],#-1
            LDRB R7,[R2]
            ORR R6,R7
stop:       B stop
