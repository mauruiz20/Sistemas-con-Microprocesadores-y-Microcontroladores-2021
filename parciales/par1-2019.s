//Ejercicio 3)
/*
Se desea analizar el comportamiento de una señal analógica alterna periódica en función del
tiempo. Para ello se toman un total de 100.000 muestras durante un período de 4 segundos.
Para el proceso se utiliza un conversor analógico digital de 12 bits, el cual envía la información
como un número de 16 bits con los cuatro bits más significativos siempre en cero. El valor
convertido se puede leer en la dirección adc y las muestras deben almacenarse en el vector
muestras.
    a) Determine la frecuencia de muestreo de la señal y el período de tiempo equivalente a cada
        muestra.
    b) Escriba el código ensamblador de una subrutina transparente que lee un valor convertido,
        lo transforma en un número de 16 bits con signo y lo almacena en el lugar correspondiente
        del vector. Indique claramente todas las variables globales que utiliza, los parámetros de la
        subrutina y el resultado de la misma.
    c) Escriba una subrutina transparente reutilizable que detecte el primer cruce por cero de la
        señal a partir de una posición inicial dada del vector muestras. Documente adecuadamente
        los parámetros y resultado de la misma.
    d) Escriba una subrutina transparente reutilizable que calcule el período de la señal analógica
        original.

    Solucion:
    a) 100.000 muestras en 4 segundos -> 25.000 muestras por segundo
        f = 25KHz
        T = 40us
*/
            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
muestras:   .hword 0x0025,0x0F10,0x0822,0x0001,0x09A1
            .space 2
ADCe:        .hword 0x0310
            .section .text
            .global reset
reset:      #LDR R4,=ADCe
            #LDR R5,=muestras
            #MOV R0,#5
            #BL converter

            LDR R4,=muestras
            MOV R5,#1
            MOV R6,#5
            BL cruce

stop:       B stop

converter:  LDRH R1,[R4]
            TST R1,#0x0800
            IT NE
            ORRNE R1,#0xF000
            STRH R1,[R5,R0,LSL #1]
            ADD R0,#1
            BX LR 
cruce:      PUSH {R4,R5,R6}
            SUB R6,R5
            ADD R4,R4,R5,LSL #1
lazo:       SUB R6,#1
            LDRH R0,[R4],#2
            CBZ R0,fin
            CBZ R6,fin
            
            B lazo
fin:        CMP R0,#0
            ITE EQ
            MOVEQ R0,#1
            MOVNE R0,#0
            POP {R4,R5,R6}
            BX LR