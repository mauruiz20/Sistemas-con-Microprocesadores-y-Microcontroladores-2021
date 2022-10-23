            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
base:       .byte 0x01,0x02,0x83,0x04,0x95,0x00
resultado:  .space 4,0x00
            .section .text
            .global reset

reset:      LDR R0,=base
            LDR R1,=resultado
            MOV R3,#0           //Contador de numeros impares
            MOV R4,#0           //Contador de numeros pares
            MOV R5,#0           //Contador de numeros positivos
            MOV R6,#0           //Contador de numeros negativos

lazo:       LDRSB R2,[R0],#1
            CMP R2,0x00
            BEQ final
            TST R2,#1           //Compruebo si el LSB es 0 o 1 para saber si es par o impar respectivamente
            ITE NE          
            ADDNE R3,#1         //Incremento R3 si es impar
            ADDEQ R4,#1         //Incremento R4 si es par

            TST R2,#0x80        //Compruebo si el MSB es 0 o 1 para saber si es positivo o negativo respectivamente
            ITE NE          
            ADDNE R6,#1         //Incremento R6 si es negativo
            ADDEQ R5,#1         //Incremento R5 si es positivo
            B lazo

final:      STRB R4,[R1],#1
            STRB R3,[R1],#1
            STRB R5,[R1],#1
            STRB R6,[R1]

stop:       B stop