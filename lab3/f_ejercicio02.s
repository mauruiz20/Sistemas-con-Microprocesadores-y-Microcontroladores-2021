    .cpu cortex-m4          // Indica el procesador de destino
    .syntax unified         // Habilita las instrucciones Thumb-2
    .thumb                  // Usar instrucciones Thumb y no ARM

    .include "configuraciones/lpc4337.s"
    .include "configuraciones/rutinas.s"
    .include "configuraciones/ciaa.s"

/****************************************************************************/
/* Definiciones de macros                                                   */
/****************************************************************************/

//RECURSOS UTILIZADOS POR LOS BOTONES -------------------------------------
    //Boton 1
    .equ BOTON_1_PORT,      4
    .equ BOTON_1_PIN,       8
    .equ BOTON_1_BIT,       12
    .equ BOTON_1_MASK,       (1 << BOTON_1_BIT)

    //Boton 2
    .equ BOTON_2_PORT,      4
    .equ BOTON_2_PIN,       9
    .equ BOTON_2_BIT,       13
    .equ BOTON_2_MASK,       (1 << BOTON_2_MASK)

    //Boton 3
    .equ BOTON_3_PORT,      4
    .equ BOTON_3_PIN,       10
    .equ BOTON_3_BIT,       14
    .equ BOTON_3_MASK,      (1 << BOTON_3_MASK)

    //Boton 2
    .equ BOTON_4_PORT,      6
    .equ BOTON_4_PIN,       7
    .equ BOTON_4_BIT,       15
    .equ BOTON_4_MASK,      (1 << BOTON_4_MASK)

    //Recursos para los botones
    .equ BOTON_GPIO,         5
    .equ BOTON_OFFSET,       (BOTON_GPIO << 2)
    .equ BOTON_MASK,         (BOTON_1_MASK | BOTON_2_MASK | BOTON_3_MASK | BOTON_4_MASK)

//RECURSOS UTILIZADOS PARA EL DISPLAY ---------------------------------------------------
    //Recursos para los segmentos
    //Segmento A
    .equ SEG_A_PORT,         4
    .equ SEG_A_PIN,          0
    .equ SEG_A_BIT,          0    
    .equ SEG_A_MASK,         (1 << SEG_A_BIT)

    //Segmento B
    .equ SEG_B_PORT,         4
    .equ SEG_B_PIN,          1
    .equ SEG_B_BIT,          1
    .equ SEG_B_MASK,         (1 << SEG_B_BIT)

    //Segmento C
    .equ SEG_C_PORT,         4
    .equ SEG_C_PIN,          2
    .equ SEG_C_BIT,          2
    .equ SEG_C_MASK,        (1 << SEG_C_BIT)

    //Segmento D
    .equ SEG_D_PORT,         4
    .equ SEG_D_PIN,          3
    .equ SEG_D_BIT,          3
    .equ SEG_D_MASK,        (1 << SEG_D_BIT)

    //Segmento E
    .equ SEG_E_PORT,         4
    .equ SEG_E_PIN,          4
    .equ SEG_E_BIT,          4
    .equ SEG_E_MASK,        (1 << SEG_E_BIT)

    //Segmento F
    .equ SEG_F_PORT,         4
    .equ SEG_F_PIN,          5
    .equ SEG_F_BIT,          5
    .equ SEG_F_MASK,        (1 << SEG_F_BIT)

    //Segmento G
    .equ SEG_G_PORT,         4
    .equ SEG_G_PIN,          6
    .equ SEG_G_BIT,          6
    .equ SEG_G_MASK,        (1 << SEG_G_BIT)

    //GPIO PARA SEGMENTOS A-G
    .equ    SEG_X_GPIO,      2
    .equ    SEG_X_OFFSET,    (SEG_X_GPIO << 2)
    .equ    SEG_X_MASK,      (SEG_A_MASK|SEG_B_MASK|SEG_C_MASK|SEG_D_MASK|SEG_E_MASK|SEG_F_MASK|SEG_G_MASK)
    
    //Segmento DP
    .equ SEG_DP_PORT,         4
    .equ SEG_DP_PIN,          8
    .equ SEG_DP_BIT,          8
    .equ SEG_DP_MASK,         (1 << SEG_DP_BIT)

    .equ SEG_DP_GPIO,          5
    .equ SEG_DP_OFFSET,       (SEG_DP_GPIO << 2)

    //Regurso para ENABLE del DISPLAY 1
    .equ DISPLAY_1_PORT,      0
    .equ DISPLAY_1_PIN,       0
    .equ DISPLAY_1_BIN,       0
    .equ DISPLAY_1_GPIO,      0
    .equ DISPLAY_1_MASK,      (1 << DISPLAY_1_GPIO)
    .equ DISPLAY_1_OFFSET,     (DISPLAY_1_GPIO << 2)

/****************************************************************************/
/* Vector de interrupciones                                                 */
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
    .word   handler+1       // 16: Interrupt IRQ service routine

/****************************************************************************/
/* Programa principal                                                       */
/****************************************************************************/

    .global reset           // Define el punto de entrada del código
    .section .text          // Define la sección de código (FLASH)
    .func main              // Inidica al depurador el inicio de una funcion

reset:
    puntero     .req R0
    config      .req R1
    
    // Mueve el vector de interrupciones al principio de la segunda RAM
    LDR R1,=VTOR
    LDR R0,=#0x10080000
    STR R0,[R1]

   //Debo configurar los segmentos verticales del gpio sin resistencia de pull up
   LDR  puntero, =SCU_BASE
   MOV  config, #(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUN0)
   STR  config, [puntero, #(4 * (32 * SEG_B_PORT + SEG_B_PIN))]
   STR  config, [puntero, #(4 * (32 * SEG_C_PORT + SEG_C_PIN))]
   STR  config, [puntero, #(4 * (32 * SEG_E_PORT + SEG_E_PIN))]
   STR  config, [puntero, #(4 * (32 * SEG_F_PORT + SEG_F_PIN))]

   //Configuro también el ENABLE del display
   STR  config, [puntero, #(4 * (32 * DISPLAY_1_PORT + DISPLAY_1_PIN))]

   //Configuro los botones como entradas con pull up
    MOV config,#(SCU_MODE_PULLDOWN | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR config,[puntero,#((TEC_1_PORT << 5 | TEC_1_PIN) << 2)]
    STR config,[puntero,#((TEC_2_PORT << 5 | TEC_2_PIN) << 2)]
    STR config,[puntero,#((TEC_3_PORT << 5 | TEC_3_PIN) << 2)]

    //Ahora apago todos los segmentos del display
    LDR puntero, =GPIO_CLR0
    LDR config, =SEG_X_MASK
    STR config, [puntero, #SEG_X_OFFSET]
    LDR config, =SEG_DP_MASK
    STR config, [puntero, #SEG_DP_OFFSET]

    //Ahora configuto como salidas los segmentos del display
    LDR puntero, =GPIO_DIR0
    LDR config, =SEG_B_MASK
    STR config, [puntero, #SEG_X_OFFSET]

    LDR config, =SEG_C_MASK
    STR config, [puntero, #SEG_X_OFFSET]

    LDR config, =SEG_E_MASK
    STR config, [puntero, #SEG_X_OFFSET]

    LDR config, =SEG_F_MASK
    STR config, [puntero, #SEG_X_OFFSET]

    //Por último, configuro como entradas los botones
    LDR config, [puntero, #BOTON_OFFSET]
    BIC config, #BOTON_MASK
    STR config, [puntero, #BOTON_OFFSET]

    //LISTAS LAS CONFIGURACIONES DE ENTRADAS Y SALIDAS
    //Por último configuro registros para utilizar en el programa

    LDR R4, =GPIO_PIN0
    LDR R5, =GPIO_NOT0

lazo:
    //Primero defino como si estuvieran apagados los segmentos. 
    MOV R1, #0x00
    //Leo el GPIO de las teclas
    LDR R0, [R4, #BOTON_OFFSET]

    //Ahora con TST verifico el estado de cada una de las teclas. 
    //Como las teclas se apretan en 1 entonces:
    //Si la tecla no está apretado vuelvo a hacer el lazo
    TST R0, #BOTON_1_MASK
    IT  NE
    BNE lazo

    TST R0, #BOTON_2_MASK
    IT  NE
    BNE lazo

    TST R0, #BOTON_3_MASK
    IT  NE
    BNE lazo

    TST R0, #BOTON_4_MASK
    IT  NE
    BNE lazo

    //Si llegó acá significa que están todos los botones apretados. 
    ORR R1, #SEG_B_MASK
    ORR R1, #SEG_C_MASK
    ORR R1, #SEG_E_MASK
    ORR R1, #SEG_F_MASK

    STR R3,[R4, #SEG_X_OFFSET]

    B   lazo
    
stop:
    B   stop
    .pool
    .endfunc
    