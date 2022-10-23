        .cpu cortex-m4 // Indica el procesador de destino
        .syntax unified // Habilita las instrucciones Thumb-2
        .thumb // Usar instrucciones Thumb y no ARM
        .include "configuraciones/lpc4337.s"
        .include "configuraciones/rutinas.s"
/****************************************************************************/
/* Definiciones de macros */
/****************************************************************************/
// Recursos utilizados por el canal Rojo del led RGB
        .equ LED_R_PORT, 2
        .equ LED_R_PIN, 0
        .equ LED_R_BIT, 0
        .equ LED_R_MASK, (1 << LED_R_BIT) 
// Recursos utilizados por el canal Verde del led RGB
        .equ LED_G_PORT, 2
        .equ LED_G_PIN, 1
        .equ LED_G_BIT, 1
        .equ LED_G_MASK, (1 << LED_G_BIT)
// Recursos utilizados por el canal Azul del led RGB
        .equ LED_B_PORT, 2
        .equ LED_B_PIN, 2
        .equ LED_B_BIT, 2
        .equ LED_B_MASK, (1 << LED_B_BIT)
// Recursos utilizados por el led RGB
        .equ LED_GPIO, 5
        .equ LED_OFFSET, ( 4 * LED_GPIO )
        .equ LED_MASK, ( LED_R_MASK | LED_G_MASK | LED_B_MASK )
/****************************************************************************/
// Recursos utilizados por el led 1
        .equ LED_1_PORT, 2
        .equ LED_1_PIN, 10
        .equ LED_1_BIT, 14
        .equ LED_1_MASK, (1 << LED_1_BIT)
        .equ LED_1_GPIO, 0
        .equ LED_1_OFFSET, ( LED_1_GPIO << 2)
// Recursos utilizados por el led 2
        .equ LED_2_PORT, 2
        .equ LED_2_PIN, 11
        .equ LED_2_BIT, 11
        .equ LED_2_MASK, (1 << LED_2_BIT)
// Recursos utilizados por el led 3
        .equ LED_3_PORT, 2
        .equ LED_3_PIN, 12
        .equ LED_3_BIT, 12
        .equ LED_3_MASK, (1 << LED_3_BIT)
// Recursos utilizados por los leds 2 y 3
        .equ LED_N_GPIO, 1
        .equ LED_N_OFFSET, ( LED_N_GPIO << 2)
        .equ LED_N_MASK, ( LED_2_MASK | LED_3_MASK )
/****************************************************************************/
// Recursos utilizados por la primera tecla
        .equ TEC_1_PORT, 1
        .equ TEC_1_PIN, 0
        .equ TEC_1_BIT, 4
        .equ TEC_1_MASK, (1 << TEC_1_BIT)
// Recursos utilizados por la segunda tecla
        .equ TEC_2_PORT, 1
        .equ TEC_2_PIN, 1
        .equ TEC_2_BIT, 8
        .equ TEC_2_MASK, (1 << TEC_2_BIT)
// Recursos utilizados por la tercera tecla
        .equ TEC_3_PORT, 1
        .equ TEC_3_PIN, 2
        .equ TEC_3_BIT, 9
        .equ TEC_3_MASK, (1 << TEC_3_BIT)
// Recursos utilizados para la tecla 4
        .equ TEC_4_PORT, 1
        .equ TEC_4_PIN, 6
        .equ TEC_4_BIT, 9
        .equ TEC_4_MASK, (1 << TEC_4_BIT)
        .equ TEC_4_GPIO, 1
        .equ TEC_4_OFFSET, ( TEC_4_GPIO << 2)
// Recursos utilizados por las telcas 1, 2 y 3
        .equ TEC_GPIO, 0
        .equ TEC_OFFSET, ( TEC_GPIO << 2)
        .equ TEC_MASK, ( TEC_1_MASK | TEC_2_MASK | TEC_3_MASK )
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
// Recursos utilizados para el boton 3
        .equ BTN_3_PORT, 4
        .equ BTN_3_PIN, 10
        .equ BTN_3_BIT, 14
        .equ BTN_3_MASK, (1 << BTN_3_BIT)
// Recursos utilizados para el boton 4
        .equ BTN_4_PORT, 6
        .equ BTN_4_PIN, 7
        .equ BTN_4_BIT, 15
        .equ BTN_4_MASK, (1 << BTN_4_BIT)
// Recursos para Aceptar
        .equ BTN_A_PORT, 3
        .equ BTN_A_PIN, 1
        .equ BTN_A_BIT, 8
        .equ BTN_A_MASK, (1 << BTN_A_BIT)
// Recursos para Cancelar
        .equ BTN_C_PORT, 3
        .equ BTN_C_PIN, 2
        .equ BTN_C_BIT, 9
        .equ BTN_C_MASK, (1 << BTN_C_BIT)   
// Recursos utilizados por los botones
        .equ BTN_N_GPIO, 5
        .equ BTN_N_OFFSET, ( BTN_N_GPIO << 2)
        .equ BTN_N_MASK, ( BTN_1_MASK | BTN_2_MASK | BTN_3_MASK | BTN_4_MASK | BTN_A_MASK | BTN_C_MASK)
/****************************************************************************/
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
/****************************************************************************/
/* Vector de interrupciones */
/****************************************************************************/
        .section .isr // Define una seccion especial para el vector
        .word stack // 0: Initial stack pointer value
        .word reset+1 // 1: Initial program counter value
        .word handler+1 // 2: Non mascarable interrupt service routine
        .word handler+1 // 3: Hard fault system trap service routine
        .word handler+1 // 4: Memory manager system trap service routine
        .word handler+1 // 5: Bus fault system trap service routine
        .word handler+1 // 6: Usage fault system tram service routine
        .word 0 // 7: Reserved entry
        .word 0 // 8: Reserved entry
        .word 0 // 9: Reserved entry
        .word 0 // 10: Reserved entry
        .word handler+1 // 11: System service call trap service routine
        .word 0 // 12: Reserved entry
        .word 0 // 13: Reserved entry
        .word handler+1 // 14: Pending service system trap service routine
        .word systick_isr+1 // 15: System tick service routine
        .word handler+1 // 16: Interrupt IRQ service routine
/****************************************************************************/
/* Definicion de variables globales */
/****************************************************************************/
        .section .data // Define la seccion de variables (RAM)
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
/****************************************************************************/
        // Configura los pines de los leds rgb como gpio sin pull-up
        LDR R1,=SCU_BASE
        MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
        STR R0,[R1,#(4 * (32 * LED_R_PORT + LED_R_PIN))]
        STR R0,[R1,#(4 * (32 * LED_G_PORT + LED_G_PIN))]
        STR R0,[R1,#(4 * (32 * LED_B_PORT + LED_B_PIN))]
        // Se configuran los pines de los leds 1 al 3 como gpio sin pull-up
        MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
        STR R0,[R1,#(LED_1_PORT << 7 | LED_1_PIN << 2)]
        STR R0,[R1,#(LED_2_PORT << 7 | LED_2_PIN << 2)]
        STR R0,[R1,#(LED_3_PORT << 7 | LED_3_PIN << 2)]
/****************************************************************************/
        // Configura los pines de las teclas como gpio con pull-up
        MOV R0,#(SCU_MODE_PULLDOWN | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
        STR R0,[R1,#((TEC_1_PORT << 5 | TEC_1_PIN) << 2)]
        STR R0,[R1,#((TEC_2_PORT << 5 | TEC_2_PIN) << 2)]
        STR R0,[R1,#((TEC_3_PORT << 5 | TEC_3_PIN) << 2)]
        STR R0,[R1,#((TEC_4_PORT << 5 | TEC_4_PIN) << 2)]
/****************************************************************************/
        // Configura los pines de los botones con pull up
        MOV R0,#(SCU_MODE_PULLUP | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
        STR R0,[R1,#((BTN_1_PORT << 5 | BTN_1_PIN) << 2)]
        STR R0,[R1,#((BTN_2_PORT << 5 | BTN_2_PIN) << 2)]
        STR R0,[R1,#((BTN_3_PORT << 5 | BTN_3_PIN) << 2)]
        STR R0,[R1,#((BTN_4_PORT << 5 | BTN_4_PIN) << 2)]
        STR R0,[R1,#((BTN_A_PORT << 5 | BTN_A_PIN) << 2)]
        STR R0,[R1,#((BTN_C_PORT << 5 | BTN_C_PIN) << 2)]
/****************************************************************************/
        // Configura los pines de los digitos 1 al 4 como gpio sin pull-up
        MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
        STR R0,[R1,#(DIG_1_PORT << 7 | DIG_1_PIN << 2)]
        STR R0,[R1,#(DIG_2_PORT << 7 | DIG_2_PIN << 2)]
        STR R0,[R1,#(DIG_3_PORT << 7 | DIG_3_PIN << 2)]
        STR R0,[R1,#(DIG_4_PORT << 7 | DIG_4_PIN << 2)]
/****************************************************************************/
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
/****************************************************************************/
        // Apaga todos los bits gpio de los leds rgb
        LDR R1,=GPIO_CLR0
        LDR R0,=LED_MASK
        STR R0,[R1,#LED_OFFSET]
        // Apagan los bits gpio correspondientes a los leds 1 al 3
        LDR R0,=LED_1_MASK
        STR R0,[R1,#LED_1_OFFSET]

        LDR R0,=LED_N_MASK
        STR R0,[R1,#LED_N_OFFSET]
        // Apagan los segmentos del GPIO
        LDR R0,=SEG_MASK
        STR R0,[R1,#SEG_OFFSET] 

        LDR R0,=SEG_DP_MASK
        STR R0,[R1,#SEG_DP_OFFSET]
        // Apagan los displays
        LDR R0,=DIG_MASK
        STR R0,[R1,#DIG_OFFSET]
/****************************************************************************/
        // Configura los bits gpio de los leds rgb como salidas
        LDR R1,=GPIO_DIR0
        LDR R0,[R1,#LED_OFFSET]
        ORR R0,#LED_MASK
        STR R0,[R1,#LED_OFFSET]
        // Se configuran los bits gpio de los leds 1 a 3 como salidas
        LDR R0,=LED_1_MASK
        STR R0,[R1,#LED_1_OFFSET]

        LDR R0,=LED_N_MASK
        STR R0,[R1,#LED_N_OFFSET]
        // Configura los bits gpio de los segmentos como salidas
        LDR R0,=SEG_MASK
        STR R0,[R1,#SEG_OFFSET]

        LDR R0,[R1,#SEG_DP_OFFSET]
        ORR R0,#SEG_DP_MASK
        STR R0,[R1,#SEG_DP_OFFSET]
        // Configura a los displays como salidas
        LDR R0,=DIG_MASK
        STR R0,[R1,#DIG_OFFSET]
/****************************************************************************/
        // Configura los bits gpio de las teclas como entradas
        LDR R0,[R1,#TEC_OFFSET]
        BIC R0,#TEC_MASK        
        STR R0,[R1,#TEC_OFFSET]

        LDR R0,[R1,#TEC_4_OFFSET]
        BIC R0,#TEC_4_MASK
        STR R0,[R1,#TEC_4_OFFSET]
        // Configura a los botones como entradas
        LDR R0,[R1,#BTN_N_OFFSET]
        BIC R0,#BTN_N_MASK      
        STR R0,[R1,#BTN_N_OFFSET]
/****************************************************************************/
        // Define los punteros para usar en el programa
        LDR R4,=GPIO_PIN0
        LDR R5,=GPIO_NOT0
refrescar:
        B refrescar
stop:
        B stop
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
// Se configura el desborde para un periodo de 100 ms
        LDR R1,=SYST_RVR
        LDR R0,=#(48000000 - 1)
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
        LDR R0,=espera          // Se apunta R0 a la variable espera
        LDRB R1,[R0]            // Se carga el valor de la variable espera
        SUBS R1,#1              // Se decrementa el valor de espera
        BHI systick_exit        // Si Espera > 0 entonces NO pasaron 10 veces
        LDR R1,=GPIO_NOT0       // Se apunta a la base de registros NOT
        MOV R0,#LED_1_MASK      // Se carga la mascara para el LED 1
        STR R0,[R1,#LED_1_OFFSET] // Se invierte el bit GPIO del LED 1    
        MOV R1,#10              // Se recarga la espera con 10 iteraciones
systick_exit:
        STRB R1,[R0]            // Se actualiza la variable espera
        BX LR                   // Se retorna al programa principal
        .pool                   // Se almacenan las constantes de codigo
        .endfunc
/************************************************************************************/
/* Rutina de servicio generica para excepciones */
/* Esta rutina atiende todas las excepciones no utilizadas en el programa. */
/* Se declara como una medida de seguridad para evitar que el procesador */
/* se pierda cuando hay una excepcion no prevista por el programador */
/************************************************************************************/
        .func handler
handler:
        LDR R1,=GPIO_SET0       // Se apunta a la base de registros SET
        MOV R0,#LED_1_MASK      // Se carga la mascara para el LED 1
        STR R0,[R1,#LED_1_OFFSET] // Se activa el bit GPIO del LED 1
        B handler               // Lazo infinito para detener la ejecucion
        .pool                   // Se almacenan las constantes de codigo
        .endfunc