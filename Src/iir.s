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

iir:
  	PUSH {R4-R9, R14}

 	LDR R5, =STORE @ load memory location of SRAM
   	LDR R4, [R5] @ getting the value of NUMS and offset R5 at the same time
   	ADD R4, #-4 @ updating NUMS
   	STR R4, [R5], #112 @ saving updated NUMS
   	ADD R5, R4 @ offset R5 to the correct memory location for storing
   	STR R3, [R5], #4 @ put x_n in to the SRAM
   	ADD R4, #-4 @ updating NUMS
   	MOV R4, R5 @ saving a copy of R5 for storing y_n later
   	LDR R6, [R1], #4 @ load b0
   	LDR R7, [R2], #4 @ load a0
   	MUL R3, R6 @ x_n * b0

 LOOP:   LDR R6, [R5, #-52] @ load Y
	     LDR R8, [R2], #4 @ load a
	     MLS R3, R6, R8, R3 @ multiply & sub y * a
	     LDR R6, [R5], #4 @ load X and offset R5 at the same time
	     LDR R8, [R1], #4 @ load b
	     MLA R3, R6, R8, R3 @ multiply & add y * b
	     ADDS R0, #-1 @ decrement N
	     BNE LOOP @ loop if N != 0

  	SDIV R0, R3, R7 @ divide by a0
    STR R0, [R4, #-56] @ store result
    MOV R1, #100 @ load value of 100
    SDIV R0, R1 @ divide y_n by 100

  	POP {R4-R9, R14}

 	BX LR

@ static arrays in SRAM
.lcomm STORE 160
.end
