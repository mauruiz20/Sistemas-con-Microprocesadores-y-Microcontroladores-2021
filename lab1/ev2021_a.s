/*  Alumno: Ruiz, Francisco Mauricio
    DNI: 43364379                   
    Evaluativo 2021 - Inciso a)         */

            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
vector:     .byte 0x06,0x85,0x78,0xF8,0xE0,0x80
            .section .text
            .global reset
reset:      LDR R0,=vector      //Direccion del vector

lazo:       LDRB R1,[R0],#1     //Carga del dato n
            CMP R1,0x80         //Comprueba si se llego al final del boque
            BEQ stop            //Si es asi se finaliza el programa

            TST R1,#0x80        //Comprueba el MSB para ver si el dato es positivo o negativo
            ITTT NE             //Si es negativo entonces:
            EORNE R1,0x7F       //Intercambia los ceros por unos y unos por ceros, menos el MSB
            ADDNE R1,#1         //Se suma 1 y se obtiene finalmente el Ca2
            STRBNE R1,[R0,#-1]  //Se almacena en la misma direccion de memoria en la que estaba el dato
                                //Si es positivo no se realizan cambios
            B lazo

stop:       B stop