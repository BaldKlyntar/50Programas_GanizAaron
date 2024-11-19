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
*            bool esPrimo = true; 
*
*           
*            if (num <= 1)
*            {
*                esPrimo = false;
*            }
*            else
*            {
*               
*                for (int i = 2; i <= Math.Sqrt(num); i++)
*                {
*                    if (num % i == 0)
*                    {
*                        esPrimo = false; 
*                        break; 
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
* https://asciinema.org/a/MRHGfLT7VK2VNqzOSW1n0Ai3T
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
    ldr x0, =num
    ldr w1, [x0]               // Cargar el número ingresado en w1

    // Verificar si el número es <= 1
    cmp w1, #1
    ble not_prime              // Si el número es <= 1, no es primo

    // Inicializar divisor (w2 = 2)
    mov w2, #2

check_prime_loop:
    // Calcular w1 / w2 (cociente) y w1 % w2 (resto)
    udiv w3, w1, w2            // w3 = w1 / w2
    msub w4, w3, w2, w1        // w4 = w1 - (w3 * w2) (resto)

    // Verificar si el resto es 0
    cmp w4, #0
    beq not_prime              // Si el resto es 0, no es primo

    // Incrementar divisor (w2++)
    add w2, w2, #1

    // Verificar si w2 * w2 > w1 (ya no hay más divisores posibles)
    mul w3, w2, w2
    cmp w3, w1
    ble check_prime_loop       // Si no hemos terminado, continuar

    // Si no encontramos ningún divisor, el número es primo
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
    b end_program

end_program:
    mov x0, #0                 // Código de salida 0
    mov x8, #93                // Número de syscall para exit
    svc 0                      // Llamar a syscall para salir

