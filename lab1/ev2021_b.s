/*  Alumno: Ruiz, Francisco Mauricio
    DNI: 43364379                   
    Evaluativo 2021 - Inciso b)         */
    
            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
vector:     .byte 0x06,0x85,0x78,0xF8,0xE0,0x80
            .section .text
            .global reset
reset:      LDR R0,=vector      //Direccion del vector
            LDR R3,=tabla       //Direccion de la tabla
            MOV R1,#0           //Inicializa R1 en 0

lazo:       LDRB R2,[R0],#1     //Carga del dato n
            CMP R2,0x80         //Comprueba si se llego al final del boque
            BEQ final           //Si es asi se termina la conversion de datos

            TST R2,#0x80        //Comprueba el MSB para ver si el dato es positivo o negativo
            ITTTT NE            //Si es negativo entonces:
            EORNE R2,0x7F       //Intercambia los ceros por unos y unos por ceros, menos el MSB
            ADDNE R2,#1         //Se suma 1 y se obtiene finalmente el Ca2
            STRBNE R2,[R0,#-1]  //Se almacena en la misma direccion de memoria en la que estaba el dato
            ADDNE R1,#1         //Incrementa el contador de elementos negativos
                                //Si es positivo no se realizan cambios
            B lazo

final:      LDRB R1,[R3,R1]     //Carga en R1 la cantidad de elementos negativos convertido a 7 segmentos
stop:       B stop
            .pool
tabla:      .byte 0x3F,0x06,0x5B,0x4F,0x66
            .byte 0x6D,0x7D,0x07,0x7F,0x6F