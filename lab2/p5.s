            .cpu cortex-m4
            .syntax unified
            .thumb

            .section .data
segundos:   .byte 0xF6,0xB6
            .section .text
            .global reset
reset:      LDR R1,=segundos
            LDR R4,=tabla
            MOV R0,#1
            BL incrementar

stop:       B stop

incrementar:
            LDRB R2,[R1]
            LDRB R3,[R1,#1]

            PUSH {R0,R2,LR}
            BL conversor
            POP {R0,R2,LR}
            PUSH {R0,R3,LR}
            BL conversor
            POP {R0,R3,LR}

            ADD R2,R0       //Incrementa en cantidad R0
            MOV R0,#0       //Setea el valor R0 = 0

            CMP R2,#10      //Comparo si hay desborde las unidades
            ITT EQ
            MOVEQ R2,#0     //Setea las unidades en 0
            ADDEQ R3,#1     //Incrementa las decenas en 1

            LDRB R2,[R4,R2]
            STRB R2,[R1]    //Guarda el nuevo valor de las unidades

            CMP R3,#6       //Comparo si hay desborde en las decenas
            ITT EQ
            MOVEQ R3,#0     //Seteo las decenas en 0
            MOVEQ R0,#1     //Pongo en R0 = 1 indica desborde

            STRB R3,[R1,#1] //Guarda el nuevo valor de las decenas

            LDRB R3,[R4,R3]
            STRB R3,[R1,#1]

            BX LR

conversor:  LDRB R0,[SP,#4]

            CMP R0,#0xFC
            IT EQ
            MOVEQ R0,#0

            CMP R0,#0x60
            IT EQ
            MOVEQ R0,#1

            CMP R0,#0xDA
            IT EQ
            MOVEQ R0,#2

            CMP R0,#0xF2
            IT EQ
            MOVEQ R0,#3

            CMP R0,#0x66
            IT EQ
            MOVEQ R0,#4

            CMP R0,#0xB6
            IT EQ
            MOVEQ R0,#5

            CMP R0,#0xBE
            IT EQ
            MOVEQ R0,#6

            CMP R0,#0xE0
            IT EQ
            MOVEQ R0,#7

            CMP R0,#0xFE
            IT EQ
            MOVEQ R0,#8

            CMP R0,#0xF6
            IT EQ
            MOVEQ R0,#9  

            STRB R0,[SP,#4]  

            BX LR
        
            .pool 
tabla:      .byte 0xFC,0x60,0xDA,0xF2,0x66
            .byte 0xB6,0xBE,0xE0,0xFE,0xF6
