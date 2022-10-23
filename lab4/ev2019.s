        .cpu cortex-m4  // Indica el procesador de destino
        .syntax unified // Habilita las instrucciones Thumb-2
        .thumb          // Usar instrucciones Thumb y no ARM
        .include "configuraciones/lpc4337.s"
        .include "configuraciones/rutinas.s"
/****************************************************************************/
/* Definiciones de macros */
/****************************************************************************/
        // Recursos utilizados por el segmento A
        .equ SEG_A_PORT, 4
        .equ SEG_A_PIN, 0
        .equ SEG_A_BIT, 0
        .equ SEG_A_MASK, (1 << SEG_A_BIT)
        // Recursos utilizados por el segmento B
        .equ SEG_B_PORT, 4
        .equ SEG_B_PIN, 1
        .equ SEG_B_BIT, 1
        .equ SEG_B_MASK, (1 << SEG_B_BIT)
        // Recursos utilizados por el segmento C
        .equ SEG_C_PORT, 4
        .equ SEG_C_PIN, 2
        .equ SEG_C_BIT, 2
        .equ SEG_C_MASK, (1 << SEG_C_BIT)
        // Recursos utilizados por el segmento D
        .equ SEG_D_PORT, 4
        .equ SEG_D_PIN, 3
        .equ SEG_D_BIT, 3
        .equ SEG_D_MASK, (1 << SEG_D_BIT)
        // Recursos utilizados por el segmento E
        .equ SEG_E_PORT, 4
        .equ SEG_E_PIN, 4
        .equ SEG_E_BIT, 4
        .equ SEG_E_MASK, (1 << SEG_E_BIT)
        // Recursos utilizados por el segmento F
        .equ SEG_F_PORT, 4
        .equ SEG_F_PIN, 5
        .equ SEG_F_BIT, 5
        .equ SEG_F_MASK, (1 << SEG_F_BIT)
        // Recursos utilizados por el segmento G
        .equ SEG_G_PORT, 4
        .equ SEG_G_PIN, 6
        .equ SEG_G_BIT, 6
        .equ SEG_G_MASK, (1 << SEG_G_BIT)
        // Recursos utilizados por los segmentos
        .equ SEG_GPIO, 2
        .equ SEG_OFFSET, ( SEG_GPIO << 2)
        .equ SEG_MASK, ( SEG_A_MASK | SEG_B_MASK | SEG_C_MASK | SEG_D_MASK | SEG_E_MASK | SEG_F_MASK | SEG_G_MASK)
/************************************************************************************/
        // Recursos para el digito 1
        .equ DIG_1_PORT, 0
        .equ DIG_1_PIN, 0
        .equ DIG_1_BIT, 0
        .equ DIG_1_MASK, (1 << DIG_1_BIT)
        // Recursos para el digito 2
        .equ DIG_2_PORT, 0
        .equ DIG_2_PIN, 1
        .equ DIG_2_BIT, 1
        .equ DIG_2_MASK, (1 << DIG_2_BIT)
        // Recursos para el digito 3
        .equ DIG_3_PORT, 1
        .equ DIG_3_PIN, 15
        .equ DIG_3_BIT, 2
        .equ DIG_3_MASK, (1 << DIG_3_BIT)
        // Recursos para el digito 4
        .equ DIG_4_PORT, 1
        .equ DIG_4_PIN, 17
        .equ DIG_4_BIT, 3
        .equ DIG_4_MASK, (1 << DIG_4_BIT)
        // Recursos para los digitos
        .equ DIG_GPIO, 0
        .equ DIG_OFFSET, ( DIG_GPIO << 2)
        .equ DIG_MASK, ( DIG_1_MASK | DIG_2_MASK | DIG_3_MASK | DIG_4_MASK )
/****************************************************************************/
        // Recursos utilizados para el boton 1
        .equ BTN_1_PORT, 4
        .equ BTN_1_PIN, 8
        .equ BTN_1_BIT, 12
        .equ BTN_1_MASK, (1 << BTN_1_BIT)
        // Recursos utilizados para el boton 2
        .equ BTN_2_PORT, 4
        .equ BTN_2_PIN, 9
        .equ BTN_2_BIT, 13
        .equ BTN_2_MASK, (1 << BTN_2_BIT)
        // Recursos utilizados por los botones
        .equ BTN_GPIO, 5
        .equ BTN_OFFSET, ( BTN_GPIO << 2)
        .equ BTN_MASK, ( BTN_1_MASK | BTN_2_MASK )

/****************************************************************************/
/* Vector de interrupciones */
/****************************************************************************/
        .section .isr           // Define una seccion especial para el vector
        .word   stack           //  0: Initial stack pointer value
        .word   reset+1         //  1: Initial program counter value
        .word   handler+1       //  2: Non mascarable interrupt service routine
        .word   handler+1       //  3: Hard fault system trap service routine
        .word   handler+1       //  4: Memory manager system trap service routine
        .word   handler+1       //  5: Bus fault system trap service routine
        .word   handler+1       //  6: Usage fault system tram service routine
        .word   0               //  7: Reserved entry
        .word   0               //  8: Reserved entry
        .word   0               //  9: Reserved entry
        .word   0               // 10: Reserved entry
        .word   handler+1       // 11: System service call trap service routine
        .word   0               // 12: Reserved entry
        .word   0               // 13: Reserved entry
        .word   handler+1       // 14: Pending service system trap service routine
        .word   handler+1       // 15: System tick service routine
        .word   handler+1       // 16: IRQ 0: DAC service routine
        .word   handler+1       // 17: IRQ 1: M0APP service routine
        .word   handler+1       // 18: IRQ 2: DMA service routine
        .word   0               // 19: Reserved entry
        .word   handler+1       // 20: IRQ 4: FLASHEEPROM service routine
        .word   handler+1       // 21: IRQ 5: ETHERNET service routine
        .word   handler+1       // 22: IRQ 6: SDIO service routine
        .word   handler+1       // 23: IRQ 7: LCD service routine
        .word   handler+1       // 24: IRQ 8: USB0 service routine
        .word   handler+1       // 25: IRQ 9: USB1 service routine
        .word   handler+1       // 26: IRQ 10: SCT service routine
        .word   handler+1       // 27: IRQ 11: RTIMER service routine
        .word   timer_isr+1     // 28: IRQ 12: TIMER0 service routine
        .word   handler+1       // 29: IRQ 13: TIMER1 service routine
        .word   handler+1       // 30: IRQ 14: TIMER2 service routine
        .word   handler+1       // 31: IRQ 15: TIMER3 service routine
        .word   handler+1       // 32: IRQ 16: MCPWM service routine
        .word   handler+1       // 33: IRQ 17: ADC0 service routine
        .word   handler+1       // 34: IRQ 18: I2C0 service routine
        .word   handler+1       // 35: IRQ 19: I2C1 service routine
        .word   handler+1       // 36: IRQ 20: SPI service routine
        .word   handler+1       // 37: IRQ 21: ADC1 service routine
        .word   handler+1       // 38: IRQ 22: SSP0 service routine
        .word   handler+1       // 39: IRQ 23: SSP1 service routine
        .word   handler+1       // 40: IRQ 24: USART0 service routine
        .word   handler+1       // 41: IRQ 25: UART1 service routine
        .word   handler+1       // 42: IRQ 26: USART2 service routine
        .word   handler+1       // 43: IRQ 27: USART3 service routine
        .word   handler+1       // 44: IRQ 28: I2S0 service routine
        .word   handler+1       // 45: IRQ 29: I2S1 service routine
        .word   handler+1       // 46: IRQ 30: SPIFI service routine
        .word   handler+1       // 47: IRQ 31: SGPIO service routine
        .word   handler+1       // 48: IRQ 32: PIN_INT0 service routine
        .word   handler+1       // 49: IRQ 33: PIN_INT1 service routine
        .word   handler+1       // 50: IRQ 34: PIN_INT2 service routine
        .word   handler+1       // 51: IRQ 35: PIN_INT3 service routine
        .word   handler+1       // 52: IRQ 36: PIN_INT4 service routine
        .word   handler+1       // 53: IRQ 37: PIN_INT5 service routine
        .word   handler+1       // 54: IRQ 38: PIN_INT6 service routine
        .word   handler+1       // 55: IRQ 39: PIN_INT7 service routine
        .word   handler+1       // 56: IRQ 40: GINT0 service routine
        .word   handler+1       // 56: IRQ 40: GINT1 service routine
/****************************************************************************/
/* Definicion de variables globales */
/****************************************************************************/
        .section .data          // Define la seccion de variables (RAM)  
numero:         
        .space 1
digito: 
        .space 1
tabla_7seg:
        .byte 0x3F,0x06,0x5B,0x4F,0x66
        .byte 0x6D,0x7D,0x07,0x7F,0x6F       
variables:
    .zero 8
    .equ periodo,    0      // Variable compartida el valor del periodo del PWM
    .equ factor,     4      // Variable compartida con el factor de trabajo del PWM              
/****************************************************************************/
/* Programa principal */
/****************************************************************************/
        .global reset // Define el punto de entrada del codigo
        .section .text // Define la seccion de codigo (FLASH)
        .func main // Inidica al depurador el inicio de una funcion
reset:
        // Mueve el vector de interrupciones al principio de la segunda RAM
        LDR R1,=VTOR
        LDR R0,=#0x10080000
        STR R0,[R1]

        LDR R1,=SCU_BASE

        // Se configuran los pines de los segmentos como gpio sin pull-up
        MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
        STR R0,[R1,#(SEG_A_PORT << 7 | SEG_A_PIN << 2)]
        STR R0,[R1,#(SEG_B_PORT << 7 | SEG_B_PIN << 2)]
        STR R0,[R1,#(SEG_C_PORT << 7 | SEG_C_PIN << 2)]
        STR R0,[R1,#(SEG_D_PORT << 7 | SEG_D_PIN << 2)]
        STR R0,[R1,#(SEG_E_PORT << 7 | SEG_E_PIN << 2)]
        STR R0,[R1,#(SEG_F_PORT << 7 | SEG_F_PIN << 2)]
        STR R0,[R1,#(SEG_G_PORT << 7 | SEG_G_PIN << 2)]
/************************************************************************************/
        // Configura los pines de los digitos 1 al 4 como gpio sin pull-up
        MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
        STR R0,[R1,#(DIG_1_PORT << 7 | DIG_1_PIN << 2)]
        STR R0,[R1,#(DIG_2_PORT << 7 | DIG_2_PIN << 2)]
        STR R0,[R1,#(DIG_3_PORT << 7 | DIG_3_PIN << 2)]
        STR R0,[R1,#(DIG_4_PORT << 7 | DIG_4_PIN << 2)]
/************************************************************************************/
        // Configura los pines de los botones 1 2 3 4 con pull up
        MOV R0,#(SCU_MODE_PULLUP | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
        STR R0,[R1,#((BTN_1_PORT << 5 | BTN_1_PIN) << 2)]
        STR R0,[R1,#((BTN_2_PORT << 5 | BTN_2_PIN) << 2)]
/************************************************************************************/
        // Se apagan los segmentos del GPIO
        LDR R1,=GPIO_CLR0
        LDR R0,=SEG_MASK
        STR R0,[R1,#SEG_OFFSET]
        // Se apagan los display 2 3 y 4 (El 1 es el de la derecha del todo)
        LDR R0,=DIG_MASK
        STR R0,[R1,#DIG_OFFSET]
        // Se encienden displays 1
        LDR R1,=GPIO_SET0
        LDR R0,=DIG_1_MASK
        STR R0,[R1,#DIG_OFFSET]
        // Configura los bits gpio de los botones como entradas
        LDR R1,=GPIO_DIR0
        LDR R0,[R1,#BTN_OFFSET]
        BIC R0,#BTN_MASK        
        STR R0,[R1,#BTN_OFFSET]
        // Configura los bits gpio de los segmentos como salidas
        LDR R0,=SEG_MASK
        STR R0,[R1,#SEG_OFFSET]
        // Configura a los displays como salidas
        LDR R0,=DIG_MASK
        STR R0,[R1,#DIG_OFFSET]
/************************************************************************************/
        // Valores iniciales
        LDR R1,=numero
        MOV R0,#0
        STRB R0,[R1]
        BL actualiza_digito 
        // Banderas para detectar flanco en los botones
        MOV R5,#0
        MOV R6,#0
        // Bandera de prendido o apagado del display
        MOV R7,#0
        // Define los punteros para usar en el programa
        LDR R4,=GPIO_PIN0
/************************************************************************************/
        // Inicialización de las variables con los tiempos del PWM
        LDR R1,=variables
        LDR R0,=#200            //Periodo de 200T
        STR R0,[R1,#periodo]    
        LDR R2,=#1              //Factor inicial de 1T
        STR R2,[R1,#factor]

        // Cuenta con clock interno
        LDR R1,=TIMER0_BASE
        MOV R0,#0x00
        STR R0,[R1,#CTCR]

        // Prescaler de 9500 para una frecuencia de 10 KHz
        LDR R0,=9500
        STR R0,[R1,#PR]

        // La primera interupcion ocurre despues de un factor de trabajo
        STR R2,[R1,#MR1]

        // El registro de match provoca interrupcion
        MOV R0,#(MR1I)
        STR R0,[R1,#MCR]

        // Limpieza del contador
        MOV R0,#CRST
        STR R0,[R1,#TCR]

        // Inicio del contador
        MOV R0,#CEN
        STR R0,[R1,#TCR]

        // Limpieza del pedido pendiente en el NVIC
        LDR R1,=NVIC_ICPR0
        MOV R0,(1 << 12)
        STR R0,[R1]

        // Habilitacion del pedido de interrupcion en el NVIC
        LDR R1,=NVIC_ISER0
        MOV R0,(1 << 12)
        STR R0,[R1]

        CPSIE I     // Rehabilita interrupciones
/************************************************************************************/
main:
        // Comprueba que botones se apretaron
        LDR R0,[R4,#BTN_OFFSET]

        TST R0,#BTN_1_MASK
        ITE EQ
        MOVEQ R5,#0
        BLNE btn1

        // Comprueba que botones se apretaron
        LDR R0,[R4,#BTN_OFFSET]

        TST R0,#BTN_2_MASK
        ITE EQ
        MOVEQ R6,#0
        BLNE btn2

        B main
        .pool
        .endfunc
/************************************************************************************/
/* Funcion retraso permite retrasar el polling en el programa principal */
/************************************************************************************/
        .func retraso
retraso:
        CMP R0,#0
        IT NE
        SUBNE R0,#1
        BNE retraso
        BX LR
        .pool
        .endfunc
/************************************************************************************/
        .func btn1
btn1:   
        PUSH {LR}
        // Si la bandera esta en 0 puedo aumentar, si no es un rebote
        CMP R5,#0
        ITT EQ
        MOVEQ R5,#1     // Seteo bandera en 1
        BLEQ aumentar    // Rutina de aumento de digito
        POP {PC}
        .pool
        .endfunc
/************************************************************************************/
        .func btn2
btn2:   
        PUSH {LR}
        // Si la bandera esta en 0 puedo disminuir, si no es un rebote
        CMP R6,#0
        ITT EQ
        MOVEQ R6,#1     // Seteo bandera en 1
        BLEQ disminuir  // Rutina de disminuir el digito
        POP {PC}
        .pool
        .endfunc
/************************************************************************************/
        .func aumentar
aumentar:
        // Aumenta el Duty Factor en 5T
        LDR R12,=variables
        LDRB R2,[R12,#factor]
        ADD R2,#5

        // Aumento el Digito
        LDR R1,=numero
        LDRB R0,[R1]
        ADD R0,#1
        // Si llega a 10 es un desborde
        CMP R0,#10
        ITT EQ
        MOVEQ R0,#0     // Seteo el Digito a 0
        MOVEQ R2,#1     // Setea el Duty Factor al valor inicial 1T
        STRB R0,[R1]
        STRB R2,[R12,#factor]

        PUSH {LR}
        BL actualiza_digito     // Actualiza el digito a 7 segmentos
        LDR R0,=#0x888888       // Retraso
        BL retraso
        POP {PC}
        .pool
        .endfunc
/************************************************************************************/
        .func disminuir
disminuir:
        LDR R12,=variables
        LDRB R2,[R12,#factor]
        LDR R1,=numero
        LDRB R0,[R1]
        // Si el Digito actual es 0 si disminuyo hay desborde
        CMP R0,#0
        ITTEE EQ
        MOVEQ R0,#9     // Entonces vuelvo a 9
        MOVEQ R2,#46    // Setea el Duty Factor a su valor maximo 46T
        SUBNE R0,#1     // Si no disminuyo en 1 el Digito
        SUBNE R2,#5     // Y disminuyo el Duty Factor en 5T
        STRB R0,[R1]
        STRB R2,[R12,#factor]
        
        PUSH {LR}
        BL actualiza_digito     // Actualiza el digito a 7 segmentos
        LDR R0,=#0x888888       // Retraso
        BL retraso
        POP {PC}
        .pool
        .endfunc
/************************************************************************************/
/* Rutina de convertir el numero a un digito en 7 segmentos */
/************************************************************************************/
        .func actualiza_digito
actualiza_digito:
        LDR R3,=digito
        LDR R2,=tabla_7seg
        LDR R1,=numero
        LDRB R0,[R1]            // Leo el numero
        LDRB R0,[R2,R0]         // Mapeo a su codificacion en 7 segmentos
        STRB R0,[R3]            // Actualizo el Digito

        // Apaga los segmentos
        LDR R1,=GPIO_CLR0      
        LDR R2,=SEG_MASK        
        STR R2,[R1,#SEG_OFFSET]

        // Prendo los segmentos con el Digito en 7 segmentos
        LDR R1,=GPIO_SET0
        STR R0,[R1,#SEG_OFFSET]

        BX LR
        .pool
        .endfunc
/****************************************************************************/
/* Rutina de servicio para la interrupcion del timer                        */
/****************************************************************************/
        .func timer_isr
timer_isr:
        // Limpio el flag de interrupcion
        LDR R1,=TIMER0_BASE
        LDR R0,[R1,#IR]
        STR R0,[R1,#IR]

        // Cargo el factor de trabajo
        LDR R12,=variables
        LDR R2,[R12,#factor]

        // Prendo o Apago el Digito       
        LDR R1,=GPIO_NOT0
        LDR R0,=DIG_1_MASK
        STR R0,[R1,#DIG_OFFSET]
        // Si esta apagado se pone R7 en 1 si esta prendido en 0
        CMP R7,#1
        ITE EQ
        MOVEQ R7,#0
        MOVNE R7,#1

        CMP R7,#1
        ITTE EQ
        // Si esta apagado se utiliza periodo menos el factor de trabajo
        LDREQ R3,[R12,#periodo]
        SUBEQ R3,R2
        // Si esta encendido se utiliza el factor de trabajo
        MOVNE R3,R2

        LDR R1,=TIMER0_BASE
        // Se actualiza el valor de match para la siguiente interrupcion
        LDR R0,[R1,#MR1]
        ADD R0,R3
        STR R0,[R1,#MR1]

        BX  LR
        .pool                   // Almacenar las constantes de código
        .endfunc
/****************************************************************************/
/* Rutina de servicio generica para excepciones                             */
/* Esta rutina atiende todas las excepciones no utilizadas en el programa.  */
/* Se declara como una medida de seguridad para evitar que el procesador    */
/* se pierda cuando hay una excepcion no prevista por el programador        */
/****************************************************************************/
        .func handler
handler:
        LDR R0,=set_led_1       // Apuntar al incio de una subrutina lejana
        BLX R0                  // Llamar a la rutina para encender el led rojo
        B handler               // Lazo infinito para detener la ejecucion
        .pool                   // Almacenar las constantes de codigo
        .endfunc