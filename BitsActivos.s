/*=======================================================
* Programa:       BitsActivos.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa que detecta los bits activos
*              de un valor
*              
*              
* Compilación:  as -o BitsActivos.o BitsActivos.s
*               gcc -o BitsActivos BitsActivos.o
* Ejecución:    ./BitsActivos
*
* Código equivalente en C#:
* -----------------------------------------------------
*    static void Main()
*    {
*        int numero = 29;
*        int contador = 0;
*
*        while (numero > 0)
*        {
*            contador += (numero & 1);
*            numero >>= 1;
*        }
*
*        Console.WriteLine("Cantidad de bits activados: " + contador);
*    }
*
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/YBmaFChZgvuAlYnSHhKf1pmA0
* -----------------------------------------------------

=========================================================*/

.section .data
    numero: .word 29
    msg_out: .asciz "Cantidad de bits activados: %d\n"

.section .text
    .global main
    .extern printf

main:
    ldr x0, =numero            // Cargar la dirección del número
    ldr w1, [x0]               // Cargar el número en w1
    mov w2, #0                 // Contador de bits activados

count_bits:
    and w3, w1, #1             // Obtener el bit menos significativo de w1
    add w2, w2, w3             // Si el bit está activado, incrementamos el contador
    lsr w1, w1, #1             // Desplazar w1 un bit a la derecha
    cmp w1, #0                 // Comprobar si quedan bits por revisar
    bne count_bits             // Si no hemos terminado, continuar el conteo

    ldr x0, =msg_out           // Cargar la dirección del mensaje
    mov x1, w2                 // Pasar el contador a x1 (para printf)
    bl printf                  // Llamar a printf para mostrar el resultado

    mov x0, #0                 // Código de salida
    mov x8, #93                // Syscall para 'exit'
    svc #0                      // Ejecutar syscall

