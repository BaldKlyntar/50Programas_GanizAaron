/*=======================================================
* Programa:       EnteroASCII.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa que resta
*              dos numeros ingresados por
*              el usuario.
*              
* Compilación:  as -o EnteroASCII.o EnteroASCII.s
*               gcc -o EnteroASCII EnteroASCII.o
* Ejecución:    ./EnteroASCII
*
* Código equivalente en C#:
* -----------------------------------------------------
*    static void Main()
*    {
*        int num = 65;
*        char asciiChar = (char)num;
*        Console.WriteLine(asciiChar);
*    }
*
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/7z89JfnsRcptNOapWgXpvZOHK
* -----------------------------------------------------

=========================================================*/

.section .data
    num_input: .word 65        // Entero de entrada (ASCII de 'A')
    msg_output: .asciz "El valor ASCII es: %c\n"

.section .text
    .global main
    .extern printf

main:
    // Cargar la dirección del mensaje en x0
    ldr x0, =msg_output        // Dirección del mensaje

    // Cargar la dirección de num_input en x1
    ldr x1, =num_input         // Cargar la dirección de num_input
    ldr w1, [x1]               // Cargar el valor de num_input en w1 (valor ASCII de 'A')

    // Llamar a printf
    bl printf

    // Salir del programa
    mov x0, #0                 // Código de estado 0 (indica éxito)
    mov x8, #93                // Número de syscall para 'exit' (93)
    svc #0                     // Realizar la llamada al sistema



