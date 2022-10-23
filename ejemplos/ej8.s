            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
base:       #.byte 0x0A,0x0B,0x0C,0x0D
            .word 0x0D0C0B0A
            .section .text
            .global reset
reset:      LDR R2,=base
            LDR R2,[R2]
            B stop
stop:       B stop