            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data          
            .section .text
            .global reset

reset:      MOV R1,#145     //N
            MOV R0,#1       //indice i 
            MOV R3,#0
            
serie:      LSL R4,R0,#1    //Multiplico por 2
            SUB R4,#1       //Resto 1
            ADD R3,R4       //Acumulo la suma

            CMP R1,R3      //Comparo si n^2 <= N
            BMI final

            ADD R0,#1       //Incremento i
            B serie

final:      SUB R0,#1       //Decremento i por que me pase por 1
stop:       B stop