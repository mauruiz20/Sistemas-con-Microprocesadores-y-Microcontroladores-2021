            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
cadena:     .byte 0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08
            .section .text
            .global reset
reset:      LDR R0,=cadena  //Puntero al primer caracter
            ADD R1,R0,#7    //Puntero al ultimo caracter
            BL invertir

stop:       B stop

cambiar:    LDRB R2,[R0]    //Intercambio de caracteres
            LDRB R3,[R1]
            STRB R3,[R0]
            STRB R2,[R1]
            BX LR 

invertir:   CMP R0,R1       //Comparo si los punteros son iguales o se cruzaron (Caso base)
            IT PL
            BXPL LR         //Entonces finalizo

            PUSH {LR}       //Sino Almaceno el LR a stop
            BL cambiar      //Subrutina cambiar con parametros R0,R1
            POP {LR}        //Recupero el LR a stop
            ADD R0,1        //Incremento y decremento los punteros
            SUB R1,1
            B invertir      //Llamada recursiva