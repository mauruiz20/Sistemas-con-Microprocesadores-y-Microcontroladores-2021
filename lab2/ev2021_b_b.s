/*
    Alumno: Ruiz, Francisco Mauricio
    DNI: 43364379
 */ 

            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
numero:     .byte 0x1D          //Numero menor o igual que 99
destino:    .space 2            //Bytes para las decenas de numero
            .section .text
            .global reset
reset:      LDR R0,=numero
            LDR R1,=destino
            BL conversion       //El numero se descompone como 2*10 + 9 (ejemplo)

stop:       B stop

conversion: PUSH {R1,R4,LR}     //Guardo estos registros
            LDRB R4,[R0]        //Cargo en R4 el numero

            MOV R0,R4           //Paso por registro el numero
            MOV R1,#10          //Paso por R1 el 10 para calcular el modulo
            BL modulo           //Extraigo la unidad del numero

            POP {R1}            //Recupero la direccion destino
            STRB R0,[R1,#1]     //Guardo la unidad

            MOV R2,#10          
            SUB R4,R0           //Le resto al numero la unidad
            UDIV R0,R4,R2       //Y lo divido por 10 y se obtiene la decena

            STRB R0,[R1]        //Guardo la decena
            POP {R4,PC}

modulo:     PUSH {R4}
            UDIV R4,R0,R1    //Calculo cociente
            MUL R4,R4,R1     //Multiplico por el Divisor
            SUB R0,R0,R4     //Resto Dividendo con el producto
            POP {R4}
            
            BX LR
