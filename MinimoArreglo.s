/*=======================================================
* Programa:       MinimoArreglo.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que encuentra el
*              valor minimo en un arreglo
*              
*              
* Compilación:  as -o MinimoArreglo.o MinimoArreglo.s
*               gcc -o MinimoArreglo MinimoArreglo.o
* Ejecución:    ./MinimoArreglo
*
* Código equivalente en C#:
* -----------------------------------------------------
*
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/oJiAVV1ycoAKgzMbcOeA1jFcq
* -----------------------------------------------------

=========================================================*/

	
.section .data
    msg_out:       .asciz "El valor minimo  en el arreglo es: "
    numeros:        .word 4, 8, 9, 6, 5    // Array de ejemplo
    T:       .word 5                // Longitud del array

.section .text
    .global _start

_start:

    // Imprime el arreglo
    mov w10, #0                   

print_array:
    ldr x3, =numeros                  
    lsl w11, w10, #2               
    add x3, x3, x11                
    ldr w0, [x3]                  

    // Converte los numeros a texto
    bl print_num


    // Carga el tamaño del array en w1
    ldr x1, =T
    ldr w1, [x1]

    // Configurar el índice y el valor inicial mínimo
    mov w2, #0                     
    ldr x3, =numeros                  
    ldr w4, [x3]                   

find_min:

    lsl w6, w2, #2                  
    add x7, x3, x6                 
    ldr w5, [x7]                   

    cmp w5, w4                      
    bge skip_update               
    mov w4, w5                     

skip_update:
 
    add w2, w2, #1                 
    cmp w2, w1                      
    blt find_min                    

    // Mostrar el mensaje del valor mínimo encontrado
    mov x0, #1                    
    ldr x1, =msg_out               
    mov x2, #30                     
    mov x8, #64                    
    svc #0                          

    // Imprime el valor mínimo
    mov w0, w4                      
    bl print_num                 


    // Terminar el programa
    mov x8, #93                     // Syscall para 'exit' (93)
    svc #0                          // Ejecutar syscall

print_num:
    // Convertir el número a su equivalente ASCII 
    add w0, w0, '0'                 
    mov x1, sp                      
    strb w0, [x1, #-1]!             

    mov x0, #1                     
    mov x2, #1                    
    mov x8, #64                     
    svc #0                          

    ret                             
