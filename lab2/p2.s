            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
num64:      .word 0x81000304,0x00200605
num32:      .word 0xA0560102
            .section .text
            .global reset
reset:      LDR R0,=num64       //Direccion de memoria del numero de 64 bits
            LDR R1,=num32       
            LDR R1,[R1]         //Paso el numero de 32 bits por registro
            //PUSH {R0}
            BL suma             //    void suma(int *num64,int num32)
            //POP {R0}

            //LDR R1,[R0]         
            //LDR R2,[R0,#4]
            
stop:       B stop

suma:       LDR R2,[R0]         //Carga de la parte baja
            LDR R3,[R0,#4]      //Carga de la parte alta
            ADDS R2,R2,R1       //Sumo con carry la parte baja con el num de 32 bits
            STR R2,[R0]         //Guardo la parte baja
            ADC R3,0            //Sumo la parte alta con solamente el carry
            STR R3,[R0,#4]      //Guardo la parte alta

            BX LR