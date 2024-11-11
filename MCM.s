/*=======================================================
* Programa:       MCM.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que calcula el minimo
*              comun multiplo
*
* Compilación:  as -o MCM.o MCM.s
*               gcc -o MCM MCM.o
* Ejecución:    ./MCM
*
* Código equivalente en C#:
* -----------------------------------------------------
*      static void Main()
*    {
*        int a, b;
*        a = 56;
*        b = 98;
*
*        int mcd = a, tempA = a, tempB = b;
*
*        while (tempA != tempB)
*        {
*            if (tempA > tempB)
*                tempA = tempA - tempB;
*            else
*                tempB = tempB - tempA;
*        }
*
*        mcd = tempA;
*
*        int mcm = (a * b) / mcd;
*
*        Console.WriteLine("El MCM es: " + mcm);
*    }
*
* ASCIINEMA
* -----------------------------------------------------
*
* -----------------------------------------------------

=========================================================*/


.section .data

  a: .word 56                // Valor inicial de 'a'
  b: .word 95                // Valor inicial de 'b'
  tempA: .word 56            // Copia de 'a' para preservar el valor original
  tempB: .word 98            // Copia de 'b' para preservar el valor original
  mcd: .word 0               // Resultado del MCD
  mcm: .word 0               // Resultado del MCM
  msg_output: .asciz "El MCM es: %d\n"   // Mensaje de salida para el MCM

.section .text

  .global main
  .extern printf

main:

  ldr x0, =tempA             // Cargar la dirección de tempA en x0
  ldr w1, [x0]               // Cargar el valor de tempA en w1

  ldr x0, =tempB             // Cargar la dirección de tempB en x0
  ldr w2, [x0]               // Cargar el valor de tempB en w2

while_loop:

  cmp w1, w2                 // Comparar w1 (tempA) con w2 (tempB)
  beq end_loop               // Si w1 == w2, salir del bucle
  bgt if_conditional         // Si w1 > w2, ir a if_conditional

  sub w2, w2, w1             // Resta w1 de w2 y almacena el resultado en w2
  b while_loop               // Repetir el bucle

if_conditional:

  sub w1, w1, w2             // Resta w2 de w1 y almacena el resultado en w1
  b while_loop               // Repetir el bucle

end_loop:

  ldr x0, =mcd               // Cargar la dirección de mcd en x0
  str w1, [x0]               // Almacenar el valor del MCD en mcd

  ldr w3, [x0]               // Cargar el valor del MCD en w3

  ldr x0, =a                 // Cargar la dirección de 'a' original en x0
  ldr w4, [x0]               // Cargar el valor de 'a' en w4

  ldr x0, =b                 // Cargar la dirección de 'b' original en x0
  ldr w5, [x0]               // Cargar el valor de 'b' en w5

  mul w6, w4, w5             // Multiplicar a * b y almacenar en w6
  sdiv w7, w6, w3            // Dividir el producto por el MCD para obtener el MCM

  ldr x0, =mcm               // Cargar la dirección de mcm en x0
  str w7, [x0]               // Almacenar el MCM en mcm

  ldr x0, =msg_output        // Cargar el mensaje de salida en x0
  mov w1, w7                 // Pasar el valor del MCM en w1
  bl printf                  // Llamar a printf para imprimir el MCM

  mov x0, #0                 // Código de estado 0 (indica éxito)
  mov x8, #93                // Número de syscall para 'exit' (93 en ARM64)
  svc 0                      // Llamada al sistema para salir


  

  

  

  

