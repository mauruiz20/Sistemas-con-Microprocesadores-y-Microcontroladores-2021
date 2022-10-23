            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
            .section .text
            .global reset
reset:      MOV R0,#45      //Dividendo
            MOV R1,#10      //Divisor

            BL modulo       // Resto = Dividendo - Cociente * Divisor

stop:       B stop
modulo:     PUSH {R4}
            UDIV R4,R0,R1    //Calculo cociente
            MUL R4,R4,R1     //Multiplico por el Divisor
            SUB R0,R0,R4     //Resto Dividendo con el producto
            POP {R4}
            
            BX LR