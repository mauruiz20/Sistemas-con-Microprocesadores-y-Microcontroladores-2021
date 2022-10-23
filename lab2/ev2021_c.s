/*
    Alumno: Ruiz, Francisco Mauricio
    DNI: 43364379
 */ 
            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
dia:        .byte 0x1D
mes:        .byte 0x09
destino:    .space 4
            .section .text
            .global reset
reset:      LDR R0,=dia
            BL fecha

stop:       B stop


fecha:      PUSH {LR}
            LDR R1,=destino
            PUSH {R0}
            PUSH {R1}        //Guardo R0,R1

            BL conversion    //Conversion del dia
            POP {R1}         //Recupero RR1

            LDRB R0,[R1]     //Recupero los digitos guardados y los convierto a 7 seg
            BL segmentos
            STRB R0,[R1]

            LDRB R0,[R1,#1]
            BL segmentos
            STRB R0,[R1,#1]

            POP {R0}            //Recupero R0

            ADD R0,#1           //Direccion del mes
            ADD R1,#2           //Aumento la direccion destino en 2

            PUSH {R1}
            BL conversion       //Conversion del mes
            POP {R1}

            LDRB R0,[R1]        //Recupero los digitos guardados y los convierto a 7 seg
            BL segmentos        
            STRB R0,[R1]

            LDRB R0,[R1,#1]
            BL segmentos
            STRB R0,[R1,#1]

            POP {PC}            //Fin del programa

conversion: PUSH {R4,R5,LR}     //Guardo estos registros
            LDRB R4,[R0]        //Cargo en R4 el numero
            MOV R5,R1           //Cargo en R5 la direccion R1

            MOV R0,R4           //Paso por registro el numero
            MOV R1,#10          //Paso por R1 el 10 para calcular el modulo
            BL modulo           //Extraigo la unidad del numero

            STRB R0,[R5,#1]     //Guardo la unidad

            MOV R2,#10          
            SUB R4,R0           //Le resto al numero la unidad
            UDIV R0,R4,R2       //Y lo divido por 10 y se obtiene la decena
  
            STRB R0,[R5]        //Guardo la decena
            POP {R4,R5,PC}

modulo:     PUSH {R4}
            UDIV R4,R0,R1    //Calculo cociente
            MUL R4,R4,R1     //Multiplico por el Divisor
            SUB R0,R0,R4     //Resto Dividendo con el producto
            POP {R4}
            
            BX LR

segmentos:  PUSH {R4}
            LDR R4,=tabla
            LDRB R0,[R4,R0]
            POP {R4}
            BX LR

            .pool
tabla:      .byte 0x3F,0x06,0x5B,0x4F,0x66
            .byte 0x6D,0x7D,0x07,0x7F,0x67 