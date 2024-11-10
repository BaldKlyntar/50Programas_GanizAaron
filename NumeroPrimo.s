/*=======================================================
* Programa:       NumeroPrimo.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que verifica si un numero
*              es primo
*              
*              
* Compilación:  as -o NumeroPrimo.o NumeroPrimo.s
*               gcc -o NumeroPrimo NumeroPrimo.o
* Ejecución:    ./NumeroPrimo
*
* Código equivalente en C#:
* -----------------------------------------------------
*       static void Main(string[] args)
*        {
*            Console.Write("Ingresa un número: ");
*            int num = int.Parse(Console.ReadLine());
*
*            bool esPrimo = true; // Asumimos que el número es primo
*
*            // Un número menor o igual a 1 no es primo
*            if (num <= 1)
*            {
*                esPrimo = false;
*            }
*            else
*            {
*                // Verificar divisores desde 2 hasta la raíz cuadrada del número
*                for (int i = 2; i <= Math.Sqrt(num); i++)
*                {
*                    if (num % i == 0)
*                    {
*                        esPrimo = false; // Si es divisible por i, no es primo
*                        break; // No es necesario continuar con los demás divisores
*                    }
*                }
*            }
*
*            // Imprimir el resultado
*            if (esPrimo)
*            {
*                Console.WriteLine($"{num} es un número primo.");
*            }
*            else
*            {
*                Console.WriteLine($"{num} no es un número primo.");
*            }
*        }
*            
*
* ASCIINEMA
* -----------------------------------------------------
* 
* -----------------------------------------------------

=========================================================*/

.section .data

    num:        .word 0             // Variable para almacenar el número ingresado
    format:     .asciz "%d"         // Formato para scanf/printf
    msg_input:  .asciz "Ingresa un valor: "
    msg_primo:  .asciz "El número es primo.\n"
    msg_no_primo: .asciz "El número no es primo.\n"

.section .text
    .global main
    .extern printf
    .extern scanf

main:
    // Mostrar mensaje de entrada
    ldr x0, =msg_input         // Cargar dirección de "Ingresa un valor: "
    bl printf

    // Leer un número del usuario
    ldr x0, =format            // Cargar el formato "%d" para scanf
    ldr x1, =num               // Dirección de la variable 'num'
    bl scanf

    // Cargar el número ingresado
    ldr w1, [x1]               // Cargar el valor de 'num' en w1

    // Verificar si el número es primo
    mov w2, #2                 // Empezar a verificar desde 2
    mov w3, #1                 // Asumimos que es primo inicialmente
    cmp w1, #1                 // Si el número es <= 1, no es primo
    ble not_prime

check_prime_loop:
    // Comparar w1 (número ingresado) con w2 (divisor actual)
    udiv w4, w1, w2            // Dividir w1 entre w2, el cociente va en w4
    mul w5, w4, w2             // Multiplicar w4 por w2 para verificar si es divisible
    cmp w5, w1                 // Verificar si w5 (w4 * w2) es igual a w1
    beq not_prime              // Si es igual, no es primo

    add w2, w2, #1             // Incrementar el divisor
    cmp w2, w1                 // Verificar si el divisor es mayor que el número
    blt check_prime_loop       // Si es menor, seguir verificando

    // Si no encontramos ningún divisor, es primo
    b prime

not_prime:
    // Mostrar "El número no es primo."
    ldr x0, =msg_no_primo      // Cargar la dirección de "El número no es primo."
    bl printf
    b end_program

prime:
    // Mostrar "El número es primo."
    ldr x0, =msg_primo         // Cargar la dirección de "El número es primo."
    bl printf

end_program:
    mov x0, #0                 // Código de salida 0
    mov x8, #93                // Número de syscall para exit
    svc 0                       // Llamar a syscall para salir

