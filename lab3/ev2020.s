        .cpu cortex-m4 // Indica el procesador de destino
        .syntax unified // Habilita las instrucciones Thumb-2
        .thumb // Usar instrucciones Thumb y no ARM
        .include "configuraciones/lpc4337.s"
        .include "configuraciones/rutinas.s"
/****************************************************************************/
/* Definiciones de macros */
/****************************************************************************/
// Recursos utilizados por el led 1
        .equ LED_1_PORT, 2
        .equ LED_1_PIN, 10
        .equ LED_1_BIT, 6
        .equ LED_1_MASK, (1 << LED_1_BIT)
        .equ LED_1_GPIO, 0
        .equ LED_1_OFFSET, 1
// Recursos utilizados por el led 2
        .equ LED_2_PORT, 2
        .equ LED_2_PIN, 11
        .equ LED_2_BIT, 11
        .equ LED_2_MASK, (1 << LED_2_BIT)
        .equ LED_2_GPIO, 1
        .equ LED_2_OFFSET, ( LED_2_GPIO << 2)
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
// -------------------------------------------------------------------------
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
// Recursos para Aceptar
        .equ ACEPTAR_PORT, 3
        .equ ACEPTAR_PIN, 1
        .equ ACEPTAR_BIT, 8
        .equ ACEPTAR_MASK, (1 << ACEPTAR_BIT)
        .equ ACEPTAR_GPIO, 5
        .equ ACEPTAR_OFFSET, ( ACEPTAR_GPIO << 2)  
// Recursos utilizados por el boton 1
        .equ BTN_1_PORT, 4
        .equ BTN_1_PIN, 8
        .equ BTN_1_BIT, 12
        .equ BTN_1_MASK, (1 << BTN_1_BIT)
// Recursos utilizados por el boton 2
        .equ BTN_2_PORT, 4
        .equ BTN_2_PIN, 9
        .equ BTN_2_BIT, 13
        .equ BTN_2_MASK, (1 << BTN_2_BIT)
// Recursos de los botones
        .equ BTN_N_GPIO, 5
        .equ BTN_N_OFFSET, ( BTN_N_GPIO << 2)
        .equ BTN_N_MASK, ( BTN_1_MASK | BTN_2_MASK | ACEPTAR_MASK )   
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
        .section .data          // Define la seccion de variables (RAM)
Digitos:        .space 1
Divisor:        .space 2        //#1000
Segundos:       .space 1   
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
        LDR     R1,=VTOR
        LDR     R0,=#0x10080000
        STR     R0,[R1]
// Llama a una subrutina para configurar el systick
        BL      systick_init

        LDR     R1,=SCU_BASE

// Se configuran los pines de los segmentos como gpio sin pull-up
        MOV     R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
        STR     R0,[R1,#(SEG_A_PORT << 7 | SEG_A_PIN << 2)]
        STR     R0,[R1,#(SEG_B_PORT << 7 | SEG_B_PIN << 2)]
        STR     R0,[R1,#(SEG_C_PORT << 7 | SEG_C_PIN << 2)]
        STR     R0,[R1,#(SEG_D_PORT << 7 | SEG_D_PIN << 2)]
        STR     R0,[R1,#(SEG_E_PORT << 7 | SEG_E_PIN << 2)]
        STR     R0,[R1,#(SEG_F_PORT << 7 | SEG_F_PIN << 2)]
        STR     R0,[R1,#(SEG_G_PORT << 7 | SEG_G_PIN << 2)]

        MOV     R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
        STR     R0,[R1,#(SEG_DP_PORT << 7 | SEG_DP_PIN << 2)]

        MOV     R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
        STR     R0,[R1,#(LED_1_PORT << 7 | LED_1_PIN << 2)]
        STR     R0,[R1,#(LED_2_PORT << 7 | LED_1_PIN << 2)]

// Configura los pines de los digitos 1 al 4 como gpio sin pull-up
        MOV     R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
        STR     R0,[R1,#(DIG_1_PORT << 7 | DIG_1_PIN << 2)]
        STR     R0,[R1,#(DIG_2_PORT << 7 | DIG_2_PIN << 2)]
        STR     R0,[R1,#(DIG_3_PORT << 7 | DIG_3_PIN << 2)]
        STR     R0,[R1,#(DIG_4_PORT << 7 | DIG_4_PIN << 2)]

// Configura los pines de los botones
        MOV     R0,#(SCU_MODE_PULLUP | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
        STR     R0,[R1,#((ACEPTAR_PORT << 5 | ACEPTAR_PIN) << 2)]
        STR     R0,[R1,#((BTN_1_PORT << 5 | BTN_1_PIN) << 2)]
        STR     R0,[R1,#((BTN_2_PORT << 5 | BTN_2_PIN) << 2)]
//------------------------------------------------------------------------------
// Se apagan los segmentos del GPIO
        LDR     R1,=GPIO_CLR0
        LDR     R0,=SEG_MASK
        STR     R0,[R1,#SEG_OFFSET] 
        LDR     R0,=SEG_DP_MASK
        STR     R0,[R1,#SEG_DP_OFFSET]
// Se apagan los leds
        LDR     R0,=LED_1_MASK
        STRB    R0,[R1,#LED_1_OFFSET]
        LDR     R0,=LED_2_MASK
        STR     R0,[R1,#LED_2_OFFSET]
// Apago los displays
        LDR     R0,=DIG_MASK
        STRB    R0,[R1,#DIG_OFFSET]
// Enciendo el display de la derecha
        LDR     R1,=GPIO_SET0
        LDR     R0,=DIG_1_MASK
        STRB    R0,[R1,#DIG_OFFSET]
//------------------------------------------------------------------------------
// Configura los bits gpio de los segmentos como salidas
        LDR     R1,=GPIO_DIR0
        LDR     R0,=SEG_MASK
        STR     R0,[R1,#SEG_OFFSET]
        LDR     R0,=SEG_DP_MASK
        STR     R0,[R1,#SEG_DP_OFFSET]
// Configura a los displays como salidas
        LDR     R0,=DIG_MASK
        STRB    R0,[R1,#DIG_OFFSET]
// Configura a los leds como salidas
        LDR     R0,=LED_1_MASK
        STRB    R0,[R1,#LED_1_OFFSET]
        LDR     R0,=LED_2_MASK
        STR     R0,[R1,#LED_2_OFFSET]
// Configura a los botones como entradas
        LDR     R0,[R1,#BTN_N_OFFSET]
        BIC     R0,#BTN_N_MASK      
        STR     R0,[R1,#BTN_N_OFFSET]
//------------------------------------------------------------------------------
// Valores inicales de las variables
        MOV     R1,#3
        LDR     R0,=Segundos
        STRB    R1,[R0]
        BL      actualiza_digito
        MOV     R1,#1000
        LDR     R0,=Divisor
        STRH    R1,[R0]
        MOV     R5,#0
        MOV     R6,#0
// Define los punteros para usar en el programa
        LDR     R4,=GPIO_PIN0
/************************************************************************************/
/* Programa Principal */
/************************************************************************************/
refrescar:  
// Comprueba si se preciona la tecla aceptar
        LDR     R0,[R4,#BTN_N_OFFSET]
        TST     R0,#ACEPTAR_MASK
        IT      NE
        BLNE    iniciar_cuenta
// Actualizo boton 1 por si se presiona antes de 0
        TST     R0,#BTN_1_MASK
        ITE     NE
        MOVNE   R5,#1
        MOVEQ   R5,#0
// Actualizo boton 2 por si se presiona antes de 0
        TST     R0,#BTN_2_MASK
        ITE     NE
        MOVNE   R6,#1
        MOVEQ   R6,#0     
// Si los segundos llegan a 0 paro y veo el ganador
        LDR     R0,=Segundos
        LDRB    R1,[R0]
        CMP     R1,#0
        ITTTT   EQ
        LDREQ   R1,=SYST_CSR            //Para el Systick
        MOVEQ   R0,#0x06
        STREQ   R0,[R1]
        BEQ     ganador

        B refrescar
        BX LR
/************************************************************************************/
iniciar_cuenta:
// Se apagan los leds
        LDR     R1,=GPIO_CLR0
        LDR     R0,=LED_1_MASK
        STRB    R0,[R1,#LED_1_OFFSET]
        LDR     R0,=LED_2_MASK
        STR     R0,[R1,#LED_2_OFFSET]
// Habilito el Systick
        LDR     R1,=SYST_CSR
        MOV     R0,#0x07
        STR     R0,[R1]
// Reinicio la cuenta
        LDR     R0,=Segundos
        MOV     R1,#4
        STRB    R1,[R0] 
        BX      LR
/************************************************************************************/
ganador:
        LDR     R0,=Segundos
        MOV     R1,#4
        STRB    R1,[R0] 

        LDR     R0,[R4,#BTN_N_OFFSET]
// Compruebo si se apreta primero el boton 1
        TST     R0,#BTN_1_MASK
        IT      NE
        BLNE    ganador1
// Compruebo si se apreta primero el boton 2
        TST     R0,#BTN_2_MASK
        IT      NE
        BLNE    ganador2
// Actualizo botones
        TST     R0,#BTN_1_MASK
        ITE     NE
        MOVNE   R5,#1
        MOVEQ   R5,#0
// Actualizo botones
        TST     R0,#BTN_2_MASK
        ITE     NE
        MOVNE   R6,#1
        MOVEQ   R6,#0

        B ganador
ganador1:
// Si el boton 1 presiono desde antes de 0 no gana hasta que suelte
        CMP     R5,#1
        ITTT    NE
        LDRNE   R1,=LED_1_MASK
        STRBNE  R1,[R4,#LED_1_OFFSET]
        BNE     refrescar
        BX      LR
ganador2:
// Si el boton 2 presiono desde antes de 0 no gana hasta que suelte
        CMP     R6,#1
        ITTT    NE
        LDRNE   R1,=LED_2_MASK
        STRNE   R1,[R4,#LED_2_OFFSET]
        BNE     refrescar
        BX      LR
stop:
        B stop
        .pool                   // Almacenar las constantes de codigo
        .endfunc
/************************************************************************************/
/* Rutina de inicializacion del SysTick */
/************************************************************************************/
        .func systick_init
systick_init:
        CPSID I                         // Se deshabilitan globalmente las interrupciones
// Se sonfigura prioridad de la interrupcion
        LDR     R1,=SHPR3               // Se apunta al registro de prioridades
        LDR     R0,[R1]                 // Se cargan las prioridades actuales
        MOV     R2,#2                   // Se fija la prioridad en 2
        BFI     R0,R2,#29,#3            // Se inserta el valor en el campo
        STR     R0,[R1]                 // Se actualizan las prioridades
// Se habilita el SysTick con el reloj del nucleo
        LDR     R1,=SYST_CSR
        MOV     R0,#0x00
        STR     R0,[R1]                 // Se quita el bit ENABLE
// Se configura el desborde para un periodo de 1 ms
        LDR     R1,=SYST_RVR
        LDR     R0,=#(100000 - 1)
        STR     R0,[R1]                 // Se especifica el valor de RELOAD
// Se inicializa el valor actual del contador
        LDR     R1,=SYST_CVR
        MOV     R0,#0
// Escribir cualquier valor limpia el contador
        STR     R0,[R1]                 // Se limpia COUNTER y flag COUNT
// Se habilita el SysTick con el reloj del nucleo
        LDR     R1,=SYST_CSR
        MOV     R0,#0x06
        STR     R0,[R1]                 // Se fijan ENABLE, TICKINT y CLOCK_SRC
        CPSIE I                         // Se habilitan globalmente las interrupciones
        BX      LR                      // Se retorna al programa principal
        .pool                           // Se almacenan las constantes de codigo
        .endfunc
/************************************************************************************/
/* Rutina de servicio para la interrupcion del SysTick */
/************************************************************************************/
        .func systick_isr
systick_isr:
        LDR     R0,=Divisor            
        LDRH    R1,[R0]               //Cargo el valor del Divisor
        SUBS    R1,#1                 //Aumento el Divisor
        BHI     systick_exit          //Si no llego a 1000 no hago nada

        PUSH    {R0, LR}                
        BL      actualiza_reloj        
        BL      actualiza_digito
        POP     {R0, LR}                

        LDR     R1, =#1000             //Reinicio la cuenta

systick_exit:
        STRH    R1,[R0]                // Actualizo Divisor
        BX      LR     
        .pool                          // Se almacenan las constantes de codigo
        .endfunc                
/************************************************************************************/
        .func actualiza_reloj
actualiza_reloj:
        LDR     R0,=Segundos
        LDRB    R1,[R0]
        CMP     R1,#0
        IT      NE
        SUBNE   R1,#1
        STRB    R1,[R0]
        BX      LR      
        .endfunc     
/************************************************************************************/
        .func actualiza_digito
actualiza_digito:
        LDR     R0,=Digitos
        LDR     R1,=Segundos
        LDR     R2,=tabla_7seg
        LDRB    R1,[R1]
        LDRB    R3,[R2,R1]
        STRB    R3,[R0]
//Se prenden los segmentos segun la codificacion del digito
        LDR     R1,=GPIO_CLR0
        LDR     R0,=SEG_MASK
        STR     R0,[R1,#SEG_OFFSET]
        LDR     R1,=GPIO_SET0
        STR     R3,[R1,#SEG_OFFSET]
        BX      LR
        .endfunc
/************************************************************************************/
/* Rutina de servicio generica para excepciones */
/* Esta rutina atiende todas las excepciones no utilizadas en el programa. */
/* Se declara como una medida de seguridad para evitar que el procesador */
/* se pierda cuando hay una excepcion no prevista por el programador */
/************************************************************************************/
        .func handler
handler:
        LDR     R1,=GPIO_SET0           // Se apunta a la base de registros SET
        MOV     R0,#LED_1_MASK          // Se carga la mascara para el LED 1
        STR     R0,[R1,#LED_1_OFFSET]   // Se activa el bit GPIO del LED 1
        B       handler                 // Lazo infinito para detener la ejecucion
        .pool                           // Se almacenan las constantes de codigo
        .endfunc