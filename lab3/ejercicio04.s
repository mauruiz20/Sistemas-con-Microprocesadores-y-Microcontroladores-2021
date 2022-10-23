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
        .equ LED_1_BIT, 14
        .equ LED_1_MASK, (1 << LED_1_BIT)
        .equ LED_1_GPIO, 0
        .equ LED_1_OFFSET, ( LED_1_GPIO << 2)
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
// Recursos para Cancelar
        .equ CANCELAR_PORT, 3
        .equ CANCELAR_PIN, 2
        .equ CANCELAR_BIT, 9
        .equ CANCELAR_MASK, (1 << CANCELAR_BIT)   
// Recursos para Aceptar y Cancelar
        .equ AC_GPIO, 5
        .equ AC_OFFSET, ( AC_GPIO << 2)
        .equ AC_MASK, ( ACEPTAR_MASK | CANCELAR_MASK )      
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
Refresco:       .space 1
Digitos:        .space 4
Divisor:        .space 2        //#1000
Segundos:       .space 2
Hora:           .space 4   
tabla_7seg:
                .byte 0x3F,0x06,0x5B,0x4F,0x66
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

// Configura los pines de los digitos 1 al 4 como gpio sin pull-up
        MOV     R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
        STR     R0,[R1,#(DIG_1_PORT << 7 | DIG_1_PIN << 2)]
        STR     R0,[R1,#(DIG_2_PORT << 7 | DIG_2_PIN << 2)]
        STR     R0,[R1,#(DIG_3_PORT << 7 | DIG_3_PIN << 2)]
        STR     R0,[R1,#(DIG_4_PORT << 7 | DIG_4_PIN << 2)]

// Configura los pines de los botones Aceptar y Cancelar
        MOV     R0,#(SCU_MODE_PULLUP | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
        STR     R0,[R1,#((ACEPTAR_PORT << 5 | ACEPTAR_PIN) << 2)]
        STR     R0,[R1,#((CANCELAR_PORT << 5 | CANCELAR_PIN) << 2)]
//------------------------------------------------------------------------------
// Se apagan los segmentos del GPIO
        LDR     R1,=GPIO_CLR0
        LDR     R0,=SEG_MASK
        STR     R0,[R1,#SEG_OFFSET] 
        LDR     R0,=SEG_DP_MASK
        STR     R0,[R1,#SEG_DP_OFFSET]
// Configura los bits gpio de los segmentos como salidas
        LDR     R1,=GPIO_DIR0
        LDR     R0,=SEG_MASK
        STR     R0,[R1,#SEG_OFFSET]
        LDR     R0,=SEG_DP_MASK
        STR     R0,[R1,#SEG_DP_OFFSET]
// Configura a los displays como salidas
        LDR     R0,=DIG_MASK
        STR     R0,[R1,#DIG_OFFSET]
// Configura a los botones como entradas
        LDR     R0,[R1,#AC_OFFSET]
        BIC     R0,#AC_MASK      
        STR     R0,[R1,#AC_OFFSET]
//------------------------------------------------------------------------------
// Valores inicales de las variables
        MOV     R1,#0x3F
        LDR     R0,=Digitos
        STR     R1,[R0],#1
        STR     R1,[R0],#1
        STR     R1,[R0],#1
        STR     R1,[R0]
        MOV     R1,#0
        LDR     R0,=Segundos
        STRH    R1,[R0]
        LDR     R0,=Hora
        STR     R1,[R0]
        LDR     R0,=Refresco
        STRB    R1,[R0]
        MOV     R1,#1000
        LDR     R0,=Divisor
        STR     R1,[R0]
        MOV     R3,#0
// Define los punteros para usar en el programa
        LDR     R4,=GPIO_PIN0
refrescar:  
        LDR     R0,[R4,#AC_OFFSET]

        TST     R0,#ACEPTAR_MASK
        IT      NE
        BLNE    pausa

        TST     R0,#CANCELAR_MASK
        IT      NE
        BLNE    reiniciar_reloj
//Se apagan todos los segmentos y digitos
        LDR     R1,=GPIO_CLR0              
        MOV     R0,#SEG_MASK
        STR     R0,[R1,#SEG_OFFSET]
        MOV     R0,#DIG_MASK
        STR     R0,[R1,#DIG_OFFSET]
//Se obtiene el digito a mostrar en codigo 7 segmentos
        LDR     R1,=Digitos
        LDRB    R0,[R1,R3]
//Se prenden los segmentos segun la codificacion del digito
        LDR     R1,=GPIO_SET0
        STR     R0,[R1,#SEG_OFFSET]
//Se prende el display correspondiente al digito
        LDR     R2,=posiciones
        LDR     R2,[R2,R3,LSL #2]
        STR     R2,[R1,#DIG_OFFSET]
//Incrementamos el digito a refrescar y si llega a 4 lo reiniciamos a 0
        ADD     R3,#1
        CMP     R3,#4
        IT      EQ
        MOVEQ   R3,#0
//Establecemos un retardo para el refresco
        LDR     R0,=#0x10000
retardo:
        CMP     R0,#0
        BEQ     refrescar
        SUB     R0,#1
        B       retardo
pausa:
        LDR     R1,=SYST_CSR
        LDR     R2,[R1]
        AND     R2,R2,#0x07
        CMP     R2,#0x07
        ITE     EQ
        MOVEQ   R2,#0x06
        MOVNE   R2,#0x07
        STR     R2,[R1]
        BX      LR
reiniciar_reloj:
        MOV     R1,#0x3F
        LDR     R0,=Digitos
        STR     R1,[R0],#1
        STR     R1,[R0],#1
        STR     R1,[R0],#1
        STR     R1,[R0]
        MOV     R1,#0
        LDR     R0,=Segundos
        STRH    R1,[R0]
        LDR     R0,=Hora
        STR     R1,[R0]
        BX      LR
stop:
        B stop
        .pool                   // Almacenar las constantes de codigo
        .endfunc

posiciones:
        .word   DIG_1_MASK
        .word   DIG_2_MASK
        .word   DIG_3_MASK
        .word   DIG_4_MASK
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
        MOV     R0,#0x07
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
        BL      actualiza_digitos
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

        MOV     R0,#1                //Seteo incremento para los segundos
        PUSH    {LR}
        LDR     R1,=Segundos
        BL      incrementar_sm       //Segundos
    
        LDR     R1,=Hora
        BL      incrementar_sm       //Minutos

        LDR     R1,=Hora
        BL      incrementar_h        //Horas
        POP     {LR}
        BX      LR      
        .endfunc     
/************************************************************************************/
        .func incrementar_sm
incrementar_sm:
        LDRB    R2,[R1]         //Unidades
        LDRB    R3,[R1,#1]      //Decenas
        ADD     R2,R0           //Incrementa en cantidad R0
        MOV     R0,#0           //Setea el valor R0 = 0

        CMP     R2,#10          //Comparo si hay desborde las unidades
        ITT     EQ
        MOVEQ   R2,#0           //Setea las unidades en 0
        ADDEQ   R3,#1           //Incrementa las decenas en 1

        STRB    R2,[R1]         //Guarda el nuevo valor de las unidades

        CMP     R3,#6           //Comparo si hay desborde en las decenas
        ITT     EQ
        MOVEQ   R3,#0           //Seteo las decenas en 0
        MOVEQ   R0,#1           //Pongo en R0 = 1 indica desborde

        STRB    R3,[R1,#1]      //Guarda el nuevo valor de las decenas

        BX      LR
        .endfunc
/************************************************************************************/
        .func incrementar_h
incrementar_h:
        LDRB    R2,[R1,#2]         //Unidades
        LDRB    R3,[R1,#3]         //Decenas
        ADD     R2,R0
        MOV     R0,#0

        CMP     R3,#2
        BEQ     hora24

        CMP     R2,#10
        ITT     EQ
        MOVEQ   R2,#0
        ADDEQ   R3,#1
        BX      LR

hora24: CMP     R2,#4
        ITT     EQ
        MOVEQ   R2,#0
        MOVEQ   R3,#0

        STRB    R2,[R1,#2]
        STRB    R3,[R1,#3]
        BX      LR
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