        .cpu cortex-m4 // Indica el procesador de destino
        .syntax unified // Habilita las instrucciones Thumb-2
        .thumb // Usar instrucciones Thumb y no ARM
        .include "configuraciones/lpc4337.s"
        .include "configuraciones/rutinas.s"
/****************************************************************************/
/* Definiciones de macros */
/****************************************************************************/
// Recursos utilizados por el canal Rojo del led RGB
// Numero de puerto de entrada/salida utilizado en el Led Rojo
        .equ LED_R_PORT, 2
// Numero de terminal dentro del puerto de e/s utilizado en el Led Rojo
        .equ LED_R_PIN, 0
// Numero de bit GPIO utilizado en el Led Rojo
        .equ LED_R_BIT, 0
// Mascara de 32 bits con un 1 en el bit correspondiente al Led Rojo 
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
// Numero de puerto GPIO utilizado por los todos leds
        .equ LED_GPIO, 5
// Desplazamiento para acceder a los registros GPIO de los leds
        .equ LED_OFFSET, ( 4 * LED_GPIO )
// Mascara de 32 bits con un 1 en los bits correspondiente a cada led
        .equ LED_MASK, ( LED_R_MASK | LED_G_MASK | LED_B_MASK )
// -------------------------------------------------------------------------
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
// -------------------------------------------------------------------------
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
// Recursos utilizados por el teclado
        .equ TEC_GPIO, 0
        .equ TEC_OFFSET, ( TEC_GPIO << 2)
        .equ TEC_MASK, ( TEC_1_MASK | TEC_2_MASK | TEC_3_MASK )
// Recursos utilizados para la tecla 4
        .equ TEC_4_PORT, 1
        .equ TEC_4_PIN, 6
        .equ TEC_4_BIT, 9
        .equ TEC_4_MASK, (1 << TEC_1_BIT)
        .equ TEC_4_GPIO, 1
        .equ TEC_4_OFFSET, ( TEC_GPIO << 2)
// -------------------------------------------------------------------------
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
// Recursos utilizados por los botones
        .equ BTN_GPIO, 5
        .equ BTN_OFFSET, ( BTN_GPIO << 2)
        .equ BTN_MASK, ( BTN_1_MASK | BTN_2_MASK | BTN_3_MASK | BTN_4_MASK ) // Bit 15 14 13 12 = 0xf000
// -------------------------------------------------------------------------
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
// Recursos utilizados por los segmentos
        .equ SEG_GPIO, 2
        .equ SEG_OFFSET, ( SEG_GPIO << 2)
        .equ SEG_MASK, ( SEG_B_MASK | SEG_C_MASK | SEG_E_MASK | SEG_F_MASK )
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

// Configura los pines de los botones 1 2 3 4 con pull up
        MOV R0,#(SCU_MODE_PULLUP | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
        STR R0,[R1,#((BTN_1_PORT << 5 | BTN_1_PIN) << 2)]
        STR R0,[R1,#((BTN_2_PORT << 5 | BTN_2_PIN) << 2)]
        STR R0,[R1,#((BTN_3_PORT << 5 | BTN_3_PIN) << 2)]
        STR R0,[R1,#((BTN_4_PORT << 5 | BTN_4_PIN) << 2)]

// Se configuran los pines de los segmentos B C E F como gpio sin pull-up
        MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
        STR R0,[R1,#(SEG_B_PORT << 7 | SEG_B_PIN << 2)]
        STR R0,[R1,#(SEG_C_PORT << 7 | SEG_C_PIN << 2)]
        STR R0,[R1,#(SEG_E_PORT << 7 | SEG_E_PIN << 2)]
        STR R0,[R1,#(SEG_F_PORT << 7 | SEG_F_PIN << 2)]

// Configura los pines de los digitos 1 al 4 como gpio sin pull-up
        MOV R0,#(SCU_MODE_PULLUP | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
        STR R0,[R1,#(DIG_1_PORT << 7 | DIG_1_PIN << 2)]
        STR R0,[R1,#(DIG_2_PORT << 7 | DIG_2_PIN << 2)]
        STR R0,[R1,#(DIG_3_PORT << 7 | DIG_3_PIN << 2)]
        STR R0,[R1,#(DIG_4_PORT << 7 | DIG_4_PIN << 2)]

// Se configuran los pines de los leds 1 al 3 como gpio sin pull-up
        MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
        STR R0,[R1,#(LED_3_PORT << 7 | LED_3_PIN << 2)]        
//------------------------------------------------------------------------------
// Se apagan los segmentos del gpio 2
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
// Configura a los displays como salida
        LDR R0,=DIG_MASK
        STR R0,[R1,#DIG_OFFSET]
//------------------------------------------------------------------------------
// Define los punteros para usar en el programa
        LDR R4,=GPIO_PIN0
        LDR R5,=GPIO_NOT0
refrescar:

        LDR R0,[R4,#BTN_OFFSET]

        TST R0,#BTN_1_MASK      
        IT NE
        EORNE R3,#SEG_F_MASK

        TST R0,#BTN_2_MASK
        IT NE
        EORNE R3,#SEG_B_MASK

        TST R0,#BTN_3_MASK
        IT NE
        EORNE R3,#SEG_E_MASK

        TST R0,#BTN_4_MASK
        IT NE
        EORNE R3,#SEG_C_MASK

        STR R3,[R4,#SEG_OFFSET]
        LDR R0,=#0x10000
retardo:
        CMP R0,#0
        BEQ refrescar
        SUB R0,#1
        B retardo
        B refrescar

stop:
        B stop
        .pool // Almacenar las constantes de codigo
        .endfunc     
/************************************************************************************/
/* Rutina de servicio generica para excepciones */
/* Esta rutina atiende todas las excepciones no utilizadas en el programa. */
/* Se declara como una medida de seguridad para evitar que el procesador */
/* se pierda cuando hay una excepcion no prevista por el programador */
/************************************************************************************/
        .func handler
        handler:
        LDR R1,=GPIO_SET0 // Se apunta a la base de registros SET
        MOV R0,#LED_1_MASK // Se carga la mascara para el LED 1
        STR R0,[R1,#LED_1_OFFSET] // Se activa el bit GPIO del LED 1
        B handler // Lazo infinito para detener la ejecucion
        .pool // Se almacenan las constantes de codigo
        .endfunc