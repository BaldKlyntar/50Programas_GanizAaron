/*=======================================================
* Programa:       LongitudCadena.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa que resta
*              dos numeros ingresados por
*              el usuario.
*              
* Compilación:  as -o LongitudCadena.o LongitudCadena.s
*               gcc -o LongitudCadena LongitudCadena.o
* Ejecución:    ./LongitudCadena
*
* Código equivalente en C#:
* -----------------------------------------------------
*   static void Main()
*    {
*        string input = "Hello, World!";
*        int length = 0;
*        
*        while (input[length] != '\0')
*        {
*            length++;
*        }
*        
*        Console.WriteLine(length);
*    }
*
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/MIkw8EvLBxrPtzNLRjlq0rxGy
* -----------------------------------------------------

=========================================================*/


.section .data
input:  .asciz "Hello, World!"   // Cadena de caracteres de entrada
msg:    .asciz "La longitud de la cadena es: %d\n"  // Mensaje para imprimir

.section .text
.global main
.extern printf

main:
    // Cargar la dirección de la cadena en x0
    ldr x0, =input  

    // Inicializar contador de longitud a 0
    mov x1, #0   

loop:
    // Cargar el siguiente byte de la cadena (carácter actual) en w2
    ldrb w2, [x0, x1]   

    // Comparar el byte con el valor nulo (fin de la cadena)
    cmp w2, #0   

    // Si es nulo, saltar a la etiqueta "done"
    beq done   

    // Incrementar el índice
    add x1, x1, #1   

    // Volver al inicio del bucle
    b loop   

done:

    // Cargar la dirección del mensaje en x1
    ldr x0, =msg
    

    // Llamar a printf para imprimir la longitud
    bl printf  

    // Salir del programa (exit)
    mov x0, #0
    mov x8, #93  // Syscall exit
    svc 0

