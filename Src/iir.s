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
	LDR R7, =STORE
	MOV R5, R7
	LDR R4, [R7, #96] @ getting the value of NUMS
	ADD R5, R4
	ADD R5, #96
	STR R3, [R5, #-48] @ put X_n in to the SRAM
	SUBS R4, #4
	ADD R4, R5, #1
	LDR R7, [R1], #4 @ B0
	LDR R8, [R2], #4 @ A0
	MUL R3, R7

	LOOP:
		LDR R11, [R4, #-48] @ X
		LDR R10, [R4], #4 @ Y
		LDR R7, [R1], #4 @ b
		LDR R6, [R2], #4 @a
		MLA R9, R11, R7, R9
		MLS R9, R10, R6, R9
		SUBS R0, #1
		BPL LOOP

	MLA R9, R3, R7, R9
	SDIV R0, R9, R8
	STR R0, [R5]

	BX LR


@ static arrays in SRAM
.lcomm STORE 100
.end
