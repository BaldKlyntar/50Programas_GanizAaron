/*=======================================================
* Programa:       ManipulacionBits.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa que resta
*              dos numeros ingresados por
*              el usuario.
*              
* Compilación:  as -o ManipulacionBits.o ManipulacionBits.s
*               gcc -o ManipulacionBits ManipulacionBits.o
* Ejecución:    ./ManipulacionBits
*
* Código equivalente en C#:
* -----------------------------------------------------
*   static void Main()
*    {
*        int number = 0b10101010; 
*
*        int position = 3; 
*
*        // Establecer el bit
*        number |= (1 << position);
*
*        // Borrar el bit
*        number &= ~(1 << position);
*
*        // Alternar el bit
*        number ^= (1 << position);
*
*        Console.WriteLine(Convert.ToString(number, 2).PadLeft(8, '0'));
*    }
*
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/gtudwFKSnoenbCnIxUv8J9yTD
* -----------------------------------------------------

=========================================================*/

.section .data
number:     .word 0b10101010   // Número inicial: 170 en decimal
position:   .word 3            // Posición del bit a modificar
msg_out:    .asciz "Resultado: %d\n"

.section .text
.global main
.extern printf

main:
    // Cargar número y posición
    ldr x0, =number
    ldr w1, [x0]               // Cargar el número en w1
    ldr x2, =position
    ldr w2, [x2]               // Cargar la posición en w2

    // Establecer el bit: number |= (1 << position)
    mov w3, #1                 // w3 = 1
    lsl w3, w3, w2             // w3 = 1 << position
    orr w1, w1, w3             // w1 |= w3 (establecer el bit)

    // Borrar el bit: number &= ~(1 << position)
    mov w3, #1                 // w3 = 1
    lsl w3, w3, w2             // w3 = 1 << position
    mvn w3, w3                 // w3 = ~(1 << position)
    and w1, w1, w3             // w1 &= w3 (borrar el bit)

    // Alternar el bit: number ^= (1 << position)
    mov w3, #1                 // w3 = 1
    lsl w3, w3, w2             // w3 = 1 << position
    eor w1, w1, w3             // w1 ^= w3 (alternar el bit)

    // Imprimir el resultado
    ldr x0, =msg_out           // Dirección del mensaje
    mov w1, w1                 // Resultado final en w1
    bl printf                  // Llamada a printf

    // Salir del programa
    mov x8, #93                // Número de syscall para exit
    mov x0, #0                 // Código de salida 0
    svc #0



