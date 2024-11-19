/*=======================================================
* Programa:       ASCIIEntero.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa que convierte un caracter
*              ASCII a entero
*              
*              
* Compilación:  as -o ASCIIEntero.o ASCIIEntero.s
*               gcc -o ASCIIEntero ASCIIEntero.o
* Ejecución:    ./ASCIIEntero
*
* Código equivalente en C#:
* -----------------------------------------------------
* static void Main()
*   {
*        char inputChar = 'A';
*        int asciiValue = 0;
*        
*        asciiValue = inputChar - '0';
*        if (inputChar >= 'A' && inputChar <= 'Z')
*        {
*            asciiValue = inputChar - 'A' + 65;
*        }
*        else if (inputChar >= 'a' && inputChar <= 'z')
*        {
*            asciiValue = inputChar - 'a' + 97;
*        }
*        
*        Console.WriteLine("El valor ASCII de '{0}' es: {1}", inputChar, asciiValue);
*    }
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/ET2LMkembbDCcoQl5opH5fVXz
* -----------------------------------------------------

=========================================================*/


.section .data
    char_input: .asciz "A"  // Carácter de entrada
    msg_output: .asciz "La conversión ASCII a entero es: %d\n"  // Mensaje para imprimir

.section .text
    .global main
    .extern printf

main:
    // Cargar la dirección del carácter en x0
    ldr x0, =char_input      // Cargar la dirección de "A" en x0
    ldrb w1, [x0]            // Cargar el valor del carácter ASCII en w1 (usamos ldrb porque es un byte)

    // Cargar la dirección del mensaje en x0 y el valor ASCII en x1
    ldr x0, =msg_output      // Cargar la dirección del mensaje
    bl printf                // Llamar a printf

    // Salir del programa
    mov x0, #0               // Código de estado 0 (indica éxito)
    mov x8, #93              // Número de syscall para 'exit' (93 en ARM64)
    svc #0                   // Ejecutar syscall

  


