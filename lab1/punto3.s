            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
base:       .byte 0x06,0x7A,0x7B,0x7C,0x00
            .section .text
            .global reset

reset:      LDR R5,=base        //Uso a R5 como puntero al vector

lazo:       LDRB R0,[R5],#1     //Carga del elemento
            CMP R0,#0x00        //Comparo si llegue al ultimo elemento del vector 0x00
            BEQ stop            //Si llegue termino el programa
            MOV R1,#32          //Sino pongo un contador de 32
            MOV R2,#0           //Contador de unos

contar:     RORS R0,#1          //Desplazo el numero 32 veces para volver al estado original y modifico flags
            BCS incrementa      //Si el carry es 1 cuento 
            SUBS R1,#1          //Decremento el contador 32
            BNE contar          //Si el contador llega a 0 sale y si no repito contar

            TST R2,#1           //Una vez rotado 32 miro cuantos unos se contaron
            BNE impar           //Si es impar la cantidad de unos agrego uno mas en el MSB
            B lazo              //Y si es par no hago nada

impar:      ORR R0,#128         //Agrego el MSB con una mascara
            STRB R0,[R5,#-1]    //Reescribo el numero con su bit de paridad en memoria
            B lazo              

incrementa: ADD R2,#1           //Incremento el contador de unos
            SUB R1,#1           //Decremento el contador 32
            B contar

stop:       B stop