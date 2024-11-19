/*=======================================================
* Programa:       DesplazamientoIzqDer.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa que resta
*              dos numeros ingresados por
*              el usuario.
*              
* Compilación:  as -o DesplazamientoIzqDer.o DesplazamientoIzqDer.s
*               gcc -o DesplazamientoIzqDer DesplazamientoIzqDer.o
* Ejecución:    ./DesplazamientoIzqDer
*
* Código equivalente en C#:
* -----------------------------------------------------
*   static void Main()
*    {
*        int value = 8;
*        
*        int leftShift = value << 2;
*        int rightShift = value >> 2;
*        
*        Console.WriteLine("Left Shift: " + leftShift);
*       Console.WriteLine("Right Shift: " + rightShift);
*    }
*
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/3hcZSQIL5CP0EvmVqt6A2Ak6G
* -----------------------------------------------------

=========================================================*/

.section .data
    msg_out: .asciz "Left Shift: %d\nRight Shift: %d\n"

.section .text
    .global main

main:
    mov x0, #8          // Cargar el valor 8 en x0
    mov x1, #2          // Cargar el número de desplazamientos (2) en x1

    // Desplazamiento a la izquierda
    lsl x2, x0, x1      // Desplazar x0 a la izquierda por el valor en x1 (x0 << 2)
    
    // Desplazamiento a la derecha
    lsr x3, x0, x1      // Desplazar x0 a la derecha por el valor en x1 (x0 >> 2)

    // Imprimir resultados
    mov x0, x2          // Mover el resultado del desplazamiento a la izquierda a x0
    mov x1, x3          // Mover el resultado del desplazamiento a la derecha a x1
    ldr x2, =msg_out    // Cargar la dirección del mensaje
    bl printf           // Llamada a printf para imprimir los resultados

    // Salir del programa
    mov x0, #0          // Código de estado 0 (éxito)
    mov x8, #93         // Número de syscall para 'exit'
    svc 0                // Hacer la llamada al sistema para salir



