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

divisores:  PUSH {R4,LR}
            MOV R2,R0       //Copio el contenido de R0 en R2
            MOV R4,#0       //Seteo la Cantidad de divisores encontrados     
            
lazo:       CMP R2,#0       //Si el divisor es 0 se termina
            ITT EQ
            MOVEQ R0,R4     //Valor de retorno en R0
            POPEQ {R4,PC}

            PUSH {R0,R1,R2} //Guardo los valores de los registros
            BL modulo

            CMP R0,#0       //Si el modulo es 0 entonces R1 es divisor de R0
            POP {R0,R1,R2}  //Recupero los valores de los registros
            ITT EQ
            ADDEQ R4,#1         //Aumenta la cantidad de divisores
            STRBEQ R2,[R1],#1   //Guarda el nuevo divisor
            SUB R2,#1           //Decrementa el divisor para seguir comparando

            B lazo

modulo:     //LDRB R0,[SP]
            LDRB R1,[SP,#8]
            UDIV R2,R0,R1    //Calculo cociente
            MUL R2,R2,R1     //Multiplico por el Divisor
            SUB R0,R0,R2     //Resto Dividendo con el producto

            BX LR