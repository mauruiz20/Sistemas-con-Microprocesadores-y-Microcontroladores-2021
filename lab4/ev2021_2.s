    /* Alumno: Ruiz, Francisco Mauricio */
    /* Evaluativo 2021 ejercicio 2) */

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
    // Recursos utilizados por el punto del display
    .equ SEG_DP_PORT, 6
    .equ SEG_DP_PIN, 8
    .equ SEG_DP_MAT, 1
    .equ SEG_DP_TMR, 2
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
    .word   timer0_isr+1    // 28: IRQ 12: TIMER0 service routine
    .word   handler+1       // 29: IRQ 13: TIMER1 service routine
    .word   timer2_isr+1    // 30: IRQ 14: TIMER2 service routine
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

    // Configura el pin del punto como salida TMAT
    LDR R1,=SCU_BASE
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC5)
    STR R0,[R1,#(SEG_DP_PORT << 7 | SEG_DP_PIN << 2)]

    // Configura los pines de los digitos 1 al 4 como gpio sin pull-up
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R0,[R1,#(DIG_1_PORT << 7 | DIG_1_PIN << 2)]
    STR R0,[R1,#(DIG_2_PORT << 7 | DIG_2_PIN << 2)]
    STR R0,[R1,#(DIG_3_PORT << 7 | DIG_3_PIN << 2)]
    STR R0,[R1,#(DIG_4_PORT << 7 | DIG_4_PIN << 2)]

    /****************************************************************************/
    // Se apagan los segmentos del GPIO
    LDR R1,=GPIO_CLR0
    LDR R0,=SEG_MASK
    STR R0,[R1,#SEG_OFFSET] 
    // Configura los bits gpio de los segmentos como salidas
    LDR R1,=GPIO_DIR0
    LDR R0,=SEG_MASK
    STR R0,[R1,#SEG_OFFSET]
    // Configura a los displays como salidas
    LDR R0,=DIG_MASK
    STR R0,[R1,#DIG_OFFSET]
    // Define los punteros para usar en el programa
    LDR R4,=GPIO_PIN0
    /****************************************************************************/
    /* Inicializacion del Timer 0 para el reloj                                 */
    /****************************************************************************/
    // Cuenta con clock interno
    LDR R1,=TIMER0_BASE
    MOV R0,#0x00
    STR R0,[R1,#CTCR]

    // Prescaler de 9.500.000 para una frecuencia de 10 Hz
    LDR R0,=#(9500000-1)
    STR R0,[R1,#PR]

    // El valor del periodo para 1 Hz
    LDR R0,=10
    STR R0,[R1,#MR0]

    // El registro de match 0 provoca reset del contador
    MOV R0,#(MR0R | MR0I)
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

    /****************************************************************************/
    /* Inicializacion del Timer 2 para los puntos                               */
    /****************************************************************************/
    // Inicialización de las variables con los tiempos del PWM
    LDR R1,=variables
    LDR R0,=#240
    STR R0,[R1,#periodo]
    LDR R2,=#1            
    STR R2,[R1,#factor]

    // Cuenta con clock interno
    LDR R1,=TIMER2_BASE
    MOV R0,#0x00
    STR R0,[R1,#CTCR]

    // Prescaler de 9500 para una frecuencia de 1000 KHz
    LDR R0,=95
    STR R0,[R1,#PR]

    // La primera interupcion ocurre despues de un factor de trabajo
    STR R2,[R1,#MR1]

    // El registro de match provoca interrupcion
    MOV R0,#(MR1I)
    STR R0,[R1,#MCR]

    // Define el estado inicial y toggle on match del led
    MOV R0,#(3 << (4 + (2 * SEG_DP_MAT)))
    STR R0,[R1,#EMR]

    // Limpieza del contador
    MOV R0,#CRST
    STR R0,[R1,#TCR]

    // Inicio del contador
    MOV R0,#CEN
    STR R0,[R1,#TCR]

    // Limpieza del pedido pendiente en el NVIC
    LDR R1,=NVIC_ICPR0
    LDR R0,[R1]
    ORR R0,(1 << 14)
    STR R0,[R1]

    // Habilitacion del pedido de interrupcion en el NVIC
    LDR R1,=NVIC_ISER0
    LDR R0,[R1]
    ORR R0,(1 << 14)
    STR R0,[R1]

    CPSIE I     // Rehabilita interrupciones
    /************************************************************************************/
    // Valores inicales de las variables
    MOV R1,#0               // El reloj empieza en 00:00
    LDR R0,=Segundos        
    STRH R1,[R0]
    LDR R0,=Hora
    STR R1,[R0]
    MOV R1,#0               // Refresco 4 pantallas (0 - 1 - 2- 3)
    LDR R0,=Refresco
    STRB R1,[R0]
    BL actualiza_digitos
    /************************************************************************************/
main:
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
    //Se apagan todos los segmentos y digitos
    LDR R1,=GPIO_CLR0              
    MOV R0,#SEG_MASK
    STR R0,[R1,#SEG_OFFSET]
    MOV R0,#DIG_MASK
    STR R0,[R1,#DIG_OFFSET]
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

    //Incrementamos el digito a refrescar y si llega a 4 lo reiniciamos a 0
    ADD R3,#1
    CMP R3,#4
    IT EQ
    MOVEQ R3,#0

    LDR R2,=Refresco
    STRB R3,[R2]
    BX LR     
posiciones:
    .word DIG_1_MASK
    .word DIG_2_MASK
    .word DIG_3_MASK
    .word DIG_4_MASK
    .pool                          // Se almacenan las constantes de codigo
    .endfunc          
    /****************************************************************************/
    /* Rutina de servicio para la interrupcion del timer0                       */
    /****************************************************************************/  
    .func timer0_isr
timer0_isr:
    // Limpio el flag de interrupcion
    LDR R3,=TIMER0_BASE
    LDR R0,[R3,#IR]
    STR R0,[R3,#IR]

    PUSH {LR}
    BL actualiza_reloj        
    BL actualiza_digitos
    POP {PC}
    .pool
    .endfunc       
    /****************************************************************************/
    /* Rutina de servicio para la interrupcion del timer2                       */
    /****************************************************************************/  
    .func timer2_isr
timer2_isr:
    // Limpio el flag de interrupcion
    LDR R1,=TIMER2_BASE
    LDR R0,[R1,#IR]
    STR R0,[R1,#IR]

    PUSH {LR}
    BL intensidad_punto

    // Cargo el factor de trabajo
    LDR R12,=variables
    LDR R2,[R12,#factor]

    // Determino si el punto esta encendido o apagado
    LDR R0,[R1,#EMR]
    TST R0,#(1 << 1)

    ITTE EQ
    // Si esta apagado se utiliza periodo menos el factor de trabajo
    LDREQ R3,[R12,#periodo]
    SUBEQ R3,R2
    // Si esta encendido se utiliza el factor de trabajo
    MOVNE R3,R2

    // Se actualiza el valor de match para la siguiente interrupcion
    LDR R0,[R1,#MR1]
    ADD R0,R3
    STR R0,[R1,#MR1]

    // Retorno
    POP {PC}   
    .pool
    .endfunc
    /************************************************************************************/
    /* Rutina de ajustar la intensidad del punto segun el valor de los segundos         */
    /************************************************************************************/
    .func intensidad_punto
intensidad_punto:
    PUSH {R0,R1,R2,R3}
    LDR R2,=Segundos
    LDRB R0,[R2],#1     //Cargo la unidad de segundo
    LDRB R1,[R2]        //Cargo la decena de segundo
    MOV R3,#10          
    MUL R1,R1,R3        //Multiplico por 10 a la decena
    ADD R0,R0,R1        //Obtengo los segundos en valor decimal

    LDR R12,=variables  //Elijo el paso de intensidad 2T
    LSL R0,#1           //A los segundos lo multiplico por 2
    ADD R0,#1           //Sumo 1
    STR R0,[R12,#factor]//Actualizo la nueva intencidad
    POP {R0,R1,R2,R3}
    BX LR     
    .pool
    .endfunc
    /************************************************************************************/
    /* Rutina Actualización de la Hora                                                  */
    /************************************************************************************/
    .func actualiza_reloj
actualiza_reloj:
    MOV R0,#1               //Seteo incremento para los segundos
    PUSH {LR}
    LDR R1,=Segundos
    BL incrementar_sm       //Segundos

    LDR R1,=Hora
    BL incrementar_sm       //Minutos

    LDR R1,=Hora
    BL incrementar_h        //Horas
    POP {LR}
    BX LR           
    .pool
    .endfunc
    /************************************************************************************/
    /* Rutina para incrementar los segundos y los minutos                               */
    /************************************************************************************/
    .func incrementar_sm
incrementar_sm:
    LDRB R2,[R1]     //Unidades
    LDRB R3,[R1,#1]  //Decenas
    ADD R2,R0        //Incrementa en cantidad R0
    MOV R0,#0        //Setea el valor R0 = 0

    CMP R2,#10       //Comparo si hay desborde las unidades
    ITT EQ
    MOVEQ R2,#0      //Setea las unidades en 0
    ADDEQ R3,#1      //Incrementa las decenas en 1

    STRB R2,[R1]    //Guarda el nuevo valor de las unidades

    CMP R3,#6       //Comparo si hay desborde en las decenas
    ITT EQ
    MOVEQ R3,#0     //Seteo las decenas en 0
    MOVEQ R0,#1     //Pongo en R0 = 1 indica desborde

    STRB R3,[R1,#1] //Guarda el nuevo valor de las decenas

    BX LR
    .pool
    .endfunc
    /************************************************************************************/
    /* Rutina para incrementar la hora                                                  */
    /************************************************************************************/
    .func incrementar_h
incrementar_h:
    LDRB R2,[R1,#2]         //Unidades de hora
    LDRB R3,[R1,#3]         //Decenas de hora
    ADD R2,R0               //Sumo el acarreo
    MOV R0,#0               //Seteo por defecto el valor de retorno      

    CMP R3,#2
    BEQ hora24

    CMP R2,#10
    ITT EQ
    MOVEQ R2,#0
    ADDEQ R3,#1
    BX LR

    hora24: CMP R2,#4
    ITT EQ
    MOVEQ R2,#0
    MOVEQ R3,#0

    STRB R2,[R1,#2]
    STRB R3,[R1,#3]
    BX LR
    .pool
    .endfunc
    /************************************************************************************/
    /* Rutina para transformar la hora a 7 segmentos                                    */
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