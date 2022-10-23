            .cpu cortex-m4
            .syntax unified
            .thumb

            .section .data
segundos:   .byte 0x08,0x04
minutos:    .byte 0x09,0x00
            .section .text
            .global reset
reset:      
lazo:       LDR R0,=0x100
            BL demora

            //MOV R0,#5
            //BL conversor

            MOV R0,#1
            LDR R1,=segundos
            BL incrementar

            LDR R1,=minutos
            BL incrementar

            B lazo

stop:       B stop

incrementar:
            LDRB R2,[R1]     //Unidades
            LDRB R3,[R1,#1]  //Decenas
            ADD R2,R0       //Incrementa en cantidad R0
            MOV R0,#0       //Setea el valor R0 = 0

            CMP R2,#10      //Comparo si hay desborde las unidades
            ITT EQ
            MOVEQ R2,#0     //Setea las unidades en 0
            ADDEQ R3,#1     //Incrementa las decenas en 1

            STRB R2,[R1]    //Guarda el nuevo valor de las unidades

            CMP R3,#6       //Comparo si hay desborde en las decenas
            ITT EQ
            MOVEQ R3,#0     //Seteo las decenas en 0
            MOVEQ R0,#1     //Pongo en R0 = 1 indica desborde

            STRB R3,[R1,#1] //Guarda el nuevo valor de las decenas

            BX LR

demora:     CMP R0,#0
            IT EQ
            BXEQ LR
            SUB R0,#1
            B demora

conversor:  LDR R1,=tabla
            LDRB R0,[R1,R0]
            BX LR

            .pool
tabla:      .byte 0x3F,0x06,0x5B,0x4F,0x66
            .byte 0x6D,0x7D,0x07,0x7F,0x6F 
            