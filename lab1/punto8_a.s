            .cpu cortex-m4
            .syntax unified
            .thumb

            .section .data
            .section .text
            .global reset

reset:      MOV R0,#0         //n < 256
            MOV R1,#145       //N < 65536
            LDR R2,=tabla       

lazo:       LDRH R3,[R2],#2     //Carga del valor de la tabla
            CMP R1,R3           //Comparo N y n^2
            BMI final           //Si n^2 es mayor que N salgo
            ADD R0,#1           //Incremento n
            B lazo

final:      SUB R0,#1           //Decremento n porque me pase por 1
stop:       B stop
            .pool
tabla:      .hword 0,1,4,9,16,25,36,49,64,81,100,121,144,169,196,225,256,289   //... hasta 65025 = 255^2
                        
            