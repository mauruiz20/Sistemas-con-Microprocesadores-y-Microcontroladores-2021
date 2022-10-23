            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data

vector:     .hword 0x08                     //8 elementos para el vector de 16 bits
            .hword 0x55,0x55,0x55,0x55      
            .hword 0x55,0x55,0x55,0x55      //inicializar los 8 elementos con 0x55
            .align

            .section .text
            .global reset

reset:      LDR R0,#8
        
stop:       B stop
