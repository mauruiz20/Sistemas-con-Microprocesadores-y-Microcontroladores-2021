            .cpu cortex-m4
            .syntax unified
            .thumb

            .section .data
bloque:     .space 1            //Reservo 1 byte para el dato mas grande
            .byte 0x03,0x3A,0xAA,0xF2
            .section .text
            .global reset

reset:      LDR R0,=bloque
            LDRB R1,[R0,#1]!     //Cargo en R1 la cantidad de elementos
            CBZ R1,stop          //Si no hay elementos directamente finalizo sin solucion
            SUB R1,#1            //Resto 1 a R1 ya que se hace n-1 comparaciones
            LDRB R2,[R0,#1]!     //Cargo en R2 el primer dato como el mas grande

lazo:       CBZ R1,final
            LDRB R3,[R0,#1]!     //Cargo el siguiente elemento
            CMP R2,R3            //Comparo cual es mas grande
            IT MI                //Si es negativo R3 es mas grande
            LDRBMI R2,[R0]       //Cargo R3 en R2 como el mas grande   
            SUB R1,#1
            B lazo

final:      LDR R0,=bloque      //Reseteo el puntero al bloque
            STRB R2,[R0]        //Guardo en el primer lugar el dato mas grande

stop:       B stop