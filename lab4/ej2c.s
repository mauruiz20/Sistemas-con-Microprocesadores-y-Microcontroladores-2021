    .cpu cortex-m4  // Indica el procesador de destino
    .syntax unified // Habilita las instrucciones Thumb-2
    .thumb          // Usar instrucciones Thumb y no ARM
    .include "configuraciones/lpc4337.s"
    .include "configuraciones/rutinas.s"
    /****************************************************************************/
    /* Definiciones de macros */
    /****************************************************************************/
    // Recursos utilizados por el led 1
    .equ LED_3_PORT, 2
    .equ LED_3_PIN, 12
    .equ LED_3_BIT, 12
    .equ LED_3_MASK, (1 << LED_3_BIT)
    .equ LED_3_GPIO, 1
    .equ LED_3_OFFSET, ( LED_3_GPIO << 2 )
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
    // Recursos utilizador por el segmento DP
    .equ SEG_DP_PORT, 6
    .equ SEG_DP_PIN, 8
    .equ SEG_DP_BIT, 16
    .equ SEG_DP_MASK, (1 << SEG_DP_BIT)
    .equ SEG_DP_GPIO, 5
    .equ SEG_DP_OFFSET, ( SEG_DP_GPIO << 2)
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
    .word   systick_isr+1   // 15: System tick service routine
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
Digitos:        .space 4
Refresco:       .space 1 
Segundos:       .space 2
Hora:           .space 4   
tabla_7seg:     .byte 0x3F,0x06,0x5B,0x4F,0x66
                .byte 0x6D,0x7D,0x07,0x7F,0x6F                     
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
    // Llama a una subrutina para configurar el systick
    BL systick_init

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

    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
    STR R0,[R1,#(SEG_DP_PORT << 7 | SEG_DP_PIN << 2)]
    // Configura los pines de los digitos 1 al 4 como gpio sin pull-up
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R0,[R1,#(DIG_1_PORT << 7 | DIG_1_PIN << 2)]
    STR R0,[R1,#(DIG_2_PORT << 7 | DIG_2_PIN << 2)]
    STR R0,[R1,#(DIG_3_PORT << 7 | DIG_3_PIN << 2)]
    STR R0,[R1,#(DIG_4_PORT << 7 | DIG_4_PIN << 2)]

    STR R0,[R1,#(LED_3_PORT << 7 | LED_3_PIN << 2)]
    /****************************************************************************/
    // Se apagan los segmentos del GPIO
    LDR R1,=GPIO_CLR0
    LDR R0,=SEG_MASK
    STR R0,[R1,#SEG_OFFSET] 
    LDR R0,=SEG_DP_MASK
    STR R0,[R1,#SEG_DP_OFFSET]
    // Configura los bits gpio de los segmentos como salidas
    LDR R1,=GPIO_DIR0
    LDR R0,=SEG_MASK
    STR R0,[R1,#SEG_OFFSET]
    LDR R0,=SEG_DP_MASK
    STR R0,[R1,#SEG_DP_OFFSET]
    // Configura a los displays como salidas
    LDR R0,=DIG_MASK
    STR R0,[R1,#DIG_OFFSET]
    // Configura al LED 3 como salida
    LDR R0,=LED_3_MASK
    STR R0,[R1,#LED_3_OFFSET]
    /****************************************************************************/
    // Cuenta con clock interno
    LDR R1,=TIMER0_BASE
    MOV R0,#0x00
    STR R0,[R1,#CTCR]

    // Prescaler de 9.500.000 para una frecuencia de 10 Hz
    LDR R0,=#(9500000-1)
    STR R0,[R1,#PR]

    // El valor del periodo para 1 Hz
    LDR R0,=#0          //Suma #10
    STR R0,[R1,#MR0]

    // En el ciclo 86400 reset
    LDR R0,=#864000
    STR R0,[R1,#MR1]

    // Alarma 1
    LDR R0,=#(50 - 10)
    STR R0,[R1,#MR2]

    // Alarma 2
    LDR R0,=#(600 - 10)
    STR R0,[R1,#MR3]

    // El registro de match 0 provoca interrupcion y el match 1 provoca reset
    MOV R0,#(MR0I | MR1R)
    STR R0,[R1,#MCR]

    // Match 2 pone el bit EMR0_2 en 1 y el Match 3 pone el bit EMR0_3 en 1
    MOV R0,#(2 << (4 + (2 * 2)))
    ORR R0,#(2 << (4 + (2 * 3)))
    STR R0,[R1,#EMR]

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
    // Valores inicales de las variables
    MOV R1,#0x3F            // Valor inicial a mostrar en pantalla es el 0 en 7 segmentos
    LDR R0,=Digitos
    STR R1,[R0],#1
    STR R1,[R0],#1
    STR R1,[R0],#1
    STR R1,[R0]
    MOV R1,#0               // El reloj empieza en 00:00
    LDR R0,=Segundos        
    STRH R1,[R0]
    LDR R0,=Hora
    STR R1,[R0]
    MOV R1,#0               // Refresco 4 pantallas (0 - 1 - 2- 3)
    LDR R0,=Refresco
    STRB R1,[R0]
    /************************************************************************************/
main:
    LDR R1,=TIMER0_BASE
    LDR R0,[R1,#EMR]
    TST R0,#(1 << 2)        //Miro el estado del registro Match 2 (alarma 1)
    BNE led3

    LDR R0,[R1,#EMR]
    TST R0,#(1 << 3)        //Miro el estado del registro Match 3 (alarma 2)
    BNE led3
    B main
led3:
    LDR R1,=GPIO_SET0
    LDR R0,=LED_3_MASK
    STR R0,[R1,#LED_3_OFFSET]
    B main
    .pool
    .endfunc
    /************************************************************************************/
    /* Rutina de inicializacion del SysTick */
    /************************************************************************************/
    .func systick_init
systick_init:
    CPSID I                 // Se deshabilitan globalmente las interrupciones
    // Se sonfigura prioridad de la interrupcion
    LDR R1,=SHPR3           // Se apunta al registro de prioridades
    LDR R0,[R1]             // Se cargan las prioridades actuales
    MOV R2,#2               // Se fija la prioridad en 2
    BFI R0,R2,#29,#3        // Se inserta el valor en el campo
    STR R0,[R1]             // Se actualizan las prioridades
    // Se habilita el SysTick con el reloj del nucleo
    LDR R1,=SYST_CSR
    MOV R0,#0x00
    STR R0,[R1]             // Se quita el bit ENABLE
    // Se configura el desborde para un periodo de 1 ms
    LDR R1,=SYST_RVR
    LDR R0,=#(100000 - 1)
    STR R0,[R1]             // Se especifica el valor de RELOAD
    // Se inicializa el valor actual del contador
    LDR R1,=SYST_CVR
    MOV R0,#0
    // Escribir cualquier valor limpia el contador
    STR R0,[R1]             // Se limpia COUNTER y flag COUNT
    // Se habilita el SysTick con el reloj del nucleo
    LDR R1,=SYST_CSR
    MOV R0,#0x07
    STR R0,[R1]             // Se fijan ENABLE, TICKINT y CLOCK_SRC
    CPSIE I                 // Se habilitan globalmente las interrupciones
    BX LR                   // Se retorna al programa principal
    .pool                   // Se almacenan las constantes de codigo
    .endfunc
    /************************************************************************************/
    /* Rutina de servicio para la interrupcion del SysTick */
    /************************************************************************************/
    .func systick_isr
systick_isr:
    PUSH {R4,LR}
    LDR R1,=TIMER0_BASE
    LDR R0,[R1,#MR0]
    MOV R1,#10
    UDIV R0,R0,R1

    //Obtengo la hora
    MOV R1,#3600   //Divido al total de segundos en 3600   
    UDIV R2,R0,R1
    LDR R3,=Hora+2   
    BL modulo      //Divido al resultado en 2 digitos y los almaceno en las variables correspondientes

    //Si la division no es entera obtengo el resto (indica que hay minutos y/o segundos)
    MUL R4,R2,R1      
    SUB R0,R0,R4

    //Obtengo los minutos
    MOV R1,#60      //Divido al total de segundos en 60
    UDIV R2,R0,R1
    LDR R3,=Hora    //Divido el resultado en 2 digitos y los almaceno
    BL modulo

    //Si la division no es entera obtengo el resto (indica que hay segundos)
    MUL R2,R2,R1
    SUB R2,R0,R2
    LDR R3,=Segundos        //Divido el resultado en 2 digitos y los almaceno
    BL modulo

    BL actualiza_digitos    //Convierto los valores de la hora en 7 segmentos
    
    //Se apagan todos los segmentos y digitos
    LDR R1,=GPIO_CLR0              
    MOV R0,#SEG_MASK
    STR R0,[R1,#SEG_OFFSET]
    MOV R0,#DIG_MASK
    STR R0,[R1,#DIG_OFFSET]
    MOV R0,#SEG_DP_MASK
    STR R0,[R1,#SEG_DP_OFFSET]
    //Se obtiene el digito a mostrar en codigo 7 segmentos
    LDR R3,=Refresco
    LDRB R3,[R3]
    LDR R1,=Digitos
    LDRB R0,[R1,R3]
    //Se prenden los segmentos segun la codificacion del digito
    LDR R1,=GPIO_SET0
    STR R0,[R1,#SEG_OFFSET]
    //Se prende el display correspondiente al digito
    LDR R2,=posiciones
    LDR R2,[R2,R3,LSL #2]
    STR R2,[R1,#DIG_OFFSET]
    //Si se prende el display de las unidades de hora prendo el . para separar
    CMP R3,#2
    ITT EQ
    MOVEQ R2,#SEG_DP_MASK
    STREQ R2,[R1,#SEG_DP_OFFSET]
    //Incrementamos el digito a refrescar y si llega a 4 lo reiniciamos a 0
    ADD R3,#1
    CMP R3,#4
    IT EQ
    MOVEQ R3,#0

    LDR R2,=Refresco
    STRB R3,[R2]
    POP {R4,PC}
modulo:     
    PUSH {R4,R5,R6}
    MOV R6,#10       //Modulo 10 permite separar las decenas de las unidades
    UDIV R4,R2,R6    //Calculo cociente
    MUL R5,R4,R6     //Multiplico por el Divisor
    SUB R5,R2,R5     //Resto Dividendo con el producto
    STRB R5,[R3]     //Guardo resultados
    STRB R4,[R3,#1]
    POP {R4,R5,R6}
    BX LR
posiciones:
    .word DIG_1_MASK
    .word DIG_2_MASK
    .word DIG_3_MASK
    .word DIG_4_MASK
    .pool                          // Se almacenan las constantes de codigo
    .endfunc          
    /****************************************************************************/
    /* Rutina de servicio para la interrupcion del timer                        */
    /****************************************************************************/  
    .func timer_isr
timer_isr:
    // Limpio el flag de interrupcion
    LDR R3,=TIMER0_BASE
    LDR R0,[R3,#IR]
    STR R0,[R3,#IR]

    LDR R0,[R3,#MR0]
    ADD R0,#10
    
    LDR R1,[R3,#MR1]
    CMP R0,R1
    IT EQ
    MOVEQ R0,#0

    STR R0,[R3,#MR0]
    .pool
    .endfunc               
    /************************************************************************************/
    .func actualiza_digitos
actualiza_digitos:
    PUSH    {R4}
    LDR     R0,=Digitos
    LDR     R1,=Segundos
    LDRB    R2,[R1],#1
    LDR     R3,=tabla_7seg
    LDRB    R4,[R3,R2]
    STRB    R4,[R0],#1

    LDRB    R2,[R1]
    LDRB    R4,[R3,R2]
    STRB    R4,[R0],#1

    LDR     R1,=Hora
    LDRB    R2,[R1],#1
    LDRB    R4,[R3,R2]
    STRB    R4,[R0],#1

    LDRB    R2,[R1]
    LDRB    R4,[R3,R2]
    STRB    R4,[R0]
    POP     {R4}
    BX      LR
    .pool
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