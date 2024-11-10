/*=======================================================
* Programa:       InvertirCadena.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que invierte una cadena de caracteres
*              
* Compilación:  as -o InvertirCadena.o InvertirCadena.s
*               gcc -o InvertirCadena InvertirCadena.o
* Ejecución:    ./InvertirCadena
*
* Código equivalente en C#:
* -----------------------------------------------------
*
*
* ASCIINEMA
* -----------------------------------------------------
*
* -----------------------------------------------------

=========================================================*/

.section .data


msg: .ascii "Hello, World!\n"
len = . - msg

.section .text

.global _start
_start:

    mov  x0, #1   
    ldr  x1, =msg  
    ldr  x2, =len  
 
    add  X4, X1, 0    
    ldrb w5, [x4]
 
    add X6, x1, x2
    sub X6, X6, #1
 
 
loop:
    sub X6, X6, #1
 
    ldrb w5, [x4] 
    ldrb w7, [x6] 
 
    strb w5, [X6]
    strb w7, [X4]
 
 
    add X4, X4, #1
    cmp X4, X6
    b.lt loop
 
    mov  w8, #64
    svc  #0


    mov    x0, 
    mov    w8,  
    svc    
