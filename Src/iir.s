/*
 * iir.s
 *
 *  Created on: 29/7/2025
 *      Author: Ni Qingqing
 */
.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.global iir

@ Start of executable code
.section .text

@ CG2028 Assignment 1, Sem 1, AY 2025/26
@ (c) ECE NUS, 2025

@ Write Student 1’s Name here: Joel Chin Junwei
@ Write Student 2’s Name here: Sahej Agarwal

@ You could create a look-up table of registers here:

@ R0 N
@ R1 *b
@ R2 *a
@ R3 x_n

@ write your program from here:
.equ N_MAX, 10
.equ X_SIZE, 12


iir:
    PUSH {R14}

    BL SUBROUTINE

    POP {R14}

    BX LR

SUBROUTINE:
    LDR R5, =STORE
    LDR R4, [R5], #96 @ getting the value of NUMS
    STR R3, [R5, R4]!@ put X_n in to the SRAM
    SUB R4, #4
    STR R4, =STORE
    MOV R4, R5
    LDR R6, [R1], #4 @B0
    LDR R7, [R2], #4 @a0
    MUL R3, R6

 LOOP:  LDR R6, [R5, #-48] @ Y
        LDR R8, [R2], #4 @ a
        MLS R3, R6, R8, R3
        LDR R6, [R5], #4 @ x
        LDR R8, [R1], #4 @ b
        MLA R3, R6, R8, R3
        SUBS R0, #1
        BPL LOOP

    SDIV R0, R3, R7
    STR R0, [R4, #-48]
    MOV R1, #100
    SDIV R0, R1
    BX LR


@ static arrays in SRAM
.lcomm STORE 152
.end
