            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
base:       .word 0x1A001D05,0x1A002321,0x1000000a,0x01A05FC4,0x01A07C3A
            .section .text
            .global reset
reset:      LDR R1,=base
            MOV R0,#2
            BL salto

            MOV R0,#50
            MOV R1,#2

stop:       B stop

salto:      LDR R1,[R1,R0,LSL #2]
            BX R1