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
* https://asciinema.org/a/bZFrb5UsxMgecOEMF7C5vtl2D
* -----------------------------------------------------

=========================================================*/

.section .data

msg: .ascii "Hello, World!\n"   // Definición del mensaje "Hello, World!" con terminación de línea
len = . - msg                  // Calcula la longitud del mensaje, restando la dirección de msg de la posición actual

.section .text

.global _start
_start:

    mov  x0, #1               // Establece el descriptor de archivo 1 (stdout) en el registro x0 (esto es para printf)
    ldr  x1, =msg             // Carga la dirección del mensaje en el registro x1
    ldr  x2, =len             // Carga la longitud del mensaje en el registro x2

    add  X4, X1, 0            // Copia la dirección de msg (almacenada en x1) a x4
    ldrb w5, [x4]             // Carga el primer byte del mensaje en el registro w5

    add X6, x1, x2            // Calcula la dirección final del mensaje sumando la dirección base (x1) y la longitud (x2)
    sub X6, X6, #1            // Resta 1 a X6 para que apunte al último byte del mensaje (esto es necesario para la inversión de caracteres)

loop:
    sub X6, X6, #1            // Decrementa X6 para apuntar al siguiente byte desde el final
    ldrb w5, [x4]             // Carga el byte apuntado por x4 en el registro w5
    ldrb w7, [x6]             // Carga el byte apuntado por x6 en el registro w7

    strb w5, [X6]             // Almacena el valor de w5 (el byte de la izquierda) en la posición apuntada por X6
    strb w7, [x4]             // Almacena el valor de w7 (el byte de la derecha) en la posición apuntada por x4

    add X4, X4, #1            // Incrementa x4 para apuntar al siguiente byte en el mensaje original
    cmp X4, X6                // Compara si x4 ha alcanzado x6 (fin del intercambio de caracteres)
    b.lt loop                 // Si x4 es menor que x6, continúa el bucle

    mov  w8, #64              // Establece el código de salida (64) en el registro w8
    svc  #0                    // Llama al sistema para terminar el programa (usando la syscall de salida)

    mov    x0, 0              // Limpia el registro x0
    mov    w8, 93             // Configura la syscall de salida (93 es el número de la syscall para 'exit')
    svc     #0                // Llama al sistema para terminar el programa (fin del proceso)

