            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
base:       .space 20
            .section .text
            .global reset
reset:      MOV R0,#6
            LDR R1,=base
            
            BL divisores

stop:       B stop

divisores:  PUSH {R4,R5,R6,LR}      //Guardo estos registros por el estandar
            MOV R4,R0       //Copio el contenido de R0 en R4                Variable local
            MOV R5,R0       //En R5 voy calculando los posibles divisores   Variable local
            MOV R6,#0       //Seteo la cantidad de divisores en 0           Variable local

lazo:       CMP R5,#0       //Si el divisor es 0 termino la subrutina
            BEQ fin

            PUSH {R1}  //Guardo la direccion de base
            MOV R0,R4   //Paso por parametro el divisor por R0
            MOV R1,R5   //Paso por parametro el dividendo por R1
            BL modulo
            POP {R1}        //Recupero la direccion de base

            CMP R0,#0       //Si el modulo es 0 significa que R5 es divisor de R4
            ITT EQ
            ADDEQ R6,#1       //Incremento la cantidad de divisores
            STRBEQ R5,[R1],#1   //Guardo el divisor en memoria

            SUB R5,#1           //Decremento el divisor
            B lazo              //Salto recursivo

fin:        MOV R0,R6           //Devuelvo en R0 la cantidad de divisores
            POP {R4,R5,R6,PC}   //Recupero los registros del programa principal

modulo:     PUSH {R4}
            UDIV R4,R0,R1    //Calculo cociente
            MUL R4,R4,R1     //Multiplico por el Divisor
            SUB R0,R0,R4     //Resto Dividendo con el producto
            POP {R4}
            
            BX LR

