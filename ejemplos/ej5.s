            .cpu cortex-m4
            .syntax unified
            .thumb
            .section .data
            .section .text
            .global reset
reset:      MOV R0,#1
            PUSH {R0}
stop:       B stop