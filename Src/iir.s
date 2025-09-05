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
@ R1 *a
@ R2 *b
@ R3 x_n
@ R4 y_n

@ write your program from here:
.equ N_MAX, 10
.equ X_SIZE 12


iir:
 	PUSH {R14}

	BL SUBROUTINE

 	POP {R14}

	BX LR

SUBROUTINE:
	MUL R3, R1
	SDIV R4, R3, R2

	BX LR


@ static arrays in SRAM
.lcomm X_STORE 48
.lcomm Y_STORE 48
.lcomm BEFORE 1
.end
