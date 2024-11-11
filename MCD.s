/*=======================================================
* Programa:       MCD.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que calcula el maximo
*              comun divisor
*
* Compilación:  as -o MCD.o MCD.s
*               gcc -o MCD MCD.o
* Ejecución:    ./MCD
*
* Código equivalente en C#:
* -----------------------------------------------------
* static void Main()
*    {
*        int a, b;
*        a = 56;
*        b = 98;
*
*        while (a != b)
*        {
*            if (a > b)
*                a = a - b;
*            else
*                b = b - a;
*        }
*
*       Console.WriteLine("El MCD es: " + a);
*    }
*
* ASCIINEMA
* -----------------------------------------------------
*
* -----------------------------------------------------
=========================================================*/


.section .data

  a: .word 56                // Valor inicial de 'a'
  b: .word 98                // Valor inicial de 'b'
  msg_output: .asciz "El MCD es: %d\n"   // Mensaje de salida para el resultado

.section .text

  .global main
  .extern printf

main:

  ldr x0, =a                 // Cargar la dirección de 'a' en x0
  ldr w1, [x0]               // Cargar el valor de 'a' en w1 (registro de 32 bits)

  ldr x0, =b                 // Cargar la dirección de 'b' en x0
  ldr w2, [x0]               // Cargar el valor de 'b' en w2 (registro de 32 bits)

while_loop:

  cmp w1, w2                 // Comparar a con b
  beq end_loop               // Si a == b, salir del bucle
  bgt if_conditional         // Si a > b, ir a if_conditional

  sub w2, w2, w1             // Resta b - a y almacena en b
  b while_loop               // Repetir el bucle

if_conditional:

  sub w1, w1, w2             // Resta a - b y almacena en a
  b while_loop               // Repetir el bucle

end_loop:

  ldr x0, =msg_output        // Cargar la dirección del mensaje en x0
  mov w1, w1                 // El valor de MCD está en w1
  bl printf                  // Llamada a printf para imprimir el resultado

  mov x0, #0                 // Código de estado 0 (indica éxito)
  mov x8, #93                // Número de syscall para 'exit' (93 en ARM64)
  svc 0                      // Llamada al sistema para salir





