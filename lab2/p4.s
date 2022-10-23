            .cpu cortex-m4
            .syntax unified
            .thumb

            .section .data
segundos:   .byte 0x08,0x05
minutos:    .byte 0x02,0x01
            .section .text
            .global reset
reset:      LDR R1,=segundos
            MOV R0,#1      //Indico q tiene q aumentar los segundos
            BL incrementar //Segundos

            LDR R1,=minutos
            BL incrementar //Minutos

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