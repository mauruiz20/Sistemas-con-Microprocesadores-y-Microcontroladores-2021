            .cpu cortex-m4
            .syntax unified
            .thumb

            .section .data
            .section .text
            .global reset
reset:      MOV R0,#3
            MOV R1,#2

            PUSH {R0,R1}
            BL funcion1
            POP {R0,R1}

            ADD R2,R0,R1
stop:       B stop

funcion1:   MOV R0,#5
            PUSH {R0,LR}
            BL funcion2
            POP {R0,PC}

funcion2:   MOV R1,#4
            PUSH {LR}
            BL funcion3
            POP {PC}

funcion3:   MOV R0,#3
            BX LR