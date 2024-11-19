/*=======================================================
* Programa:       OperacionesLogicas.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa que resta
*              dos numeros ingresados por
*              el usuario.
*              
* Compilación:  as -o OperacionesLogicas.o OperacionesLogicas.s
*               gcc -o OperacionesLogicas OperacionesLogicas.o
* Ejecución:    ./OperacionesLogicas
*
* Código equivalente en C#:
* -----------------------------------------------------
*    static void Main()
*    {
*        int a = 5;  
*        int b = 3;  
*
*        int andResult = a & b;  
*        int orResult = a | b;   
*        int xorResult = a ^ b; 
*
*       Console.WriteLine($"AND: {andResult}");
*        Console.WriteLine($"OR: {orResult}");
*        Console.WriteLine($"XOR: {xorResult}");
*    }
*
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/QrhCl2j1Oc4qVQiZ35bqvBa8K
* -----------------------------------------------------

=========================================================*/

    .section .data
    msg_and:    .asciz "AND Result: %d\n"
    msg_or:     .asciz "OR Result: %d\n"
    msg_xor:    .asciz "XOR Result: %d\n"
    a: .word 5
    b: .word 3

    .section .text
    .global main
    .extern printf

main:
    // Inicializar los valores
    ldr x0, =a              // Cargar la dirección de 'a'
    ldr x29, [x0]            // Cargar el valor de 'a' en x1 (registro de 64 bits)

    ldr x0, =b              // Cargar la dirección de 'b'
    ldr x28, [x0]            // Cargar el valor de 'b' en x2 (registro de 64 bits)

    // Operación AND
    and x3, x29, x28          // x3 = a & b (operación AND entre los registros de 64 bits)
    ldr x0, =msg_and
    mov x1, x3              // Mover el resultado de AND a x1 para printf
    bl printf               // Imprimir el resultado

        // Operación OR
    orr x4, x29, x28          // x3 = a | b (operación OR entre los registros de 64 bits)
    ldr x0, =msg_or
    mov x1, x4              // Mover el resultado de OR a x1 para printf
    bl printf               // Imprimir el resultado

    // Operación XOR
    eor x5, x29, x28          // x3 = a ^ b (operación XOR entre los registros de 64 bits)
    ldr x0, =msg_xor
    mov x1, x5              // Mover el resultado de XOR a x1 para printf
    bl printf               // Imprimir el resultado

    // Salir del programa
    mov x0, #0
    mov x8, #93
    svc 0

    


