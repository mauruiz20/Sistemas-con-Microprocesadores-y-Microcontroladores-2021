            .cpu cortex-m4
            .syntax unified
            .thumb

            .section .data
base:       .space 20
numero:     .space 1
maximo:     .space 1
            .section .text
            .global reset
reset:      MOV R0,#255
            LDR R1,=base
            LDR R2,=numero
            LDR R3,=maximo

            BL mayor
stop:       B stop

mayor:      PUSH {R4,R5,LR}
            MOV R4,#0       //Mayor cantidad de divisores

lazo_may:   CMP R0,#0
            BEQ fin
            
            PUSH {R0,R1,R2,R3}
            BL divisores
            CMP R0,R4
            ITT PL
            MOVPL R4,R0
            LDRBPL R5,[SP]
            
            POP {R0,R1,R2,R3}
            SUB R0,#1

            B lazo_may

fin:        STRB R4,[R3]
            STRB R5,[R2]
            POP {R4,R5,PC}

divisores:  PUSH {R4,LR}
            MOV R2,R0
            MOV R4,#0       //Cantidad de divisores encontrados     
            
lazo_div:   CMP R2,#0       //Si el divisor es 0 se termina
            ITT EQ
            MOVEQ R0,R4     //Valor de retorno
            POPEQ {R4,PC}

            PUSH {R0,R1,R2} //Guardo los valores de los registros
            BL modulo

            CMP R0,#0       //Si el modulo es 0 entonces R1 es divisor de R0
            POP {R0,R1,R2}  //Recupero los valores de los registros
            ITT EQ
            ADDEQ R4,#1         //Aumenta la cantidad de divisores
            STRBEQ R2,[R1],#1   //Guarda el nuevo divisor
            SUB R2,#1           //Decrementa el divisor para seguir comparando

            B lazo_div

modulo:     //LDRB R0,[SP]
            LDRB R1,[SP,#8]
            UDIV R2,R0,R1    //Calculo cociente
            MUL R2,R2,R1     //Multiplico por el Divisor
            SUB R0,R0,R2     //Resto Dividendo con el producto

            BX LR