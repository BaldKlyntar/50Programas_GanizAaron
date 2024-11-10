/*=======================================================
* Programa:       EntradaTeclado.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que lee
*              una entrada desde el teclado
*             
*              
* Compilación:  as -o EntradaTeclado.o EntradaTeclado.s
*               gcc -o EntradaTeclado EntradaTeclado.o
* Ejecución:    ./EntradaTeclado
*
* Código equivalente en C#:
* -----------------------------------------------------
*            Console.WriteLine("Ingrese una cadena de caracteres");
*            string palabra = Console.ReadLine();
*            Console.WriteLine(palabra)
*
*
* ASCIINEMA
* -----------------------------------------------------
* 
* -----------------------------------------------------

=========================================================*/

.section .data

  msg_output: .space 100
  msg_input: .asciz "Ingresa una cadena de caracteres: \n"
  format: .asciz "%s"

.section .text

  .global main
  .extern printf
  .extern scanf

main:

  ldr x0, =msg_input
  bl printf

  adr x0, =format
  adr x1, msg_output
  bl scanf

  ldr x0, =msg_output
  bl scanf

      // Salir del programa

    mov     x0, #0 // Código de estado 0 (indica éxito)
    mov     x8, #93 // Número de syscall para 'exit' (93 en ARM64)
    svc     0 // Se realiza la llamda al sistema

