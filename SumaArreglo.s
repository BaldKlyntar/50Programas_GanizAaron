/*=======================================================
* Programa:       SumaArreglo.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa que resta
*              dos numeros ingresados por
*              el usuario.
*              
* Compilación:  as -o SumaArreglo.o SumaArreglo.s
*               gcc -o SumaArreglo SumaArreglo.o
* Ejecución:    ./SumaArreglo
*
* Código equivalente en C#:
* -----------------------------------------------------
*    static void Main()
*   {
*        int[] arr = { 1, 2, 3, 4, 5 };
*        int sum = 0;
*        
*        for (int i = 0; i < arr.Length; i++)
*        {
*            sum += arr[i];
*        }
*        
*        Console.WriteLine(sum);
*    }
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/QjuWASdF5HkDyEpEbqg8S7TMh
* -----------------------------------------------------

=========================================================*/

.section .data
arr:    .quad 1, 2, 3, 4, 5         // Arreglo de enteros de 64 bits
arr_len: .quad 5                    // Longitud del arreglo
msg_out: .asciz "La suma es: %d\n"   // Mensaje de salida

.section .text
.global main
.extern printf

main:
    // Inicializar registros
    ldr x0, =arr          // Dirección del arreglo
    ldr x1, =arr_len      // Dirección de la longitud del arreglo
    ldr x1, [x1]          // Cargar la longitud del arreglo en x1
    mov x2, #0            // Suma inicial (0)

    mov x3, #0            // Contador i (0)

sum_loop:
    cmp x3, x1            // Comparar i con la longitud
    bge end_sum           // Si i >= longitud, salir del bucle

    // Cargar arr[i] en x4 (utilizando registros de 64 bits)
    ldr x4, [x0, x3, lsl #3]   // Desplazamiento de 8 bytes (por cada valor de 64 bits)

    add x2, x2, x4        // sum += arr[i] (sum está en x2)
    add x3, x3, #1        // Incrementar el contador i
    b sum_loop            // Continuar el bucle

end_sum:
    // Mostrar el resultado
    ldr x0, =msg_out      // Cargar la dirección del mensaje
    mov x1, x2            // Pasar la suma a x1
    bl printf             // Llamar a printf

    // Salir del programa
    mov x0, #0            // Código de estado 0
    mov x8, #93           // Número de syscall para 'exit'
    svc #0                // Llamada al sistema para salir





