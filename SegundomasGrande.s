/*=======================================================
* Programa:       SegundomasGrande.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa que resta
*              dos numeros ingresados por
*              el usuario.
*              
* Compilación:  as -o SegundomasGrande.o SegundomasGrande.s
*               gcc -o SegundomasGrande SegundomasGrande.o
* Ejecución:    ./SegundomasGrande
*
* Código equivalente en C#:
* -----------------------------------------------------
*      static void Main()
*    {
*        int[] arr = { 12, 35, 1, 10, 34, 1 };
*        int first = int.MinValue, second = int.MinValue;
*
*        for (int i = 0; i < arr.Length; i++)
*        {
*            if (arr[i] > first)
*            {
*                second = first;
*                first = arr[i];
*            }
*            else if (arr[i] > second && arr[i] != first)
*            {
*                second = arr[i];
*            }
*        }
*
*        Console.WriteLine("El segundo elemento más grande es: " + second);
*    }
*
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/Zs6J4LjRMMcmZ1TQ1SGkdTm0X
* -----------------------------------------------------

=========================================================*/

.section .data
arr:    .quad 12, 35, 1, 10, 34, 1      // Arreglo de enteros
len:    .quad 6                         // Longitud del arreglo
msg_out: .asciz "El segundo elemento más grande es: %d\n"

.section .text
.global main
.extern printf

main:
    // Inicializar registros
    mov x0, #0                  // Inicializamos x0 a 0 (primer número más grande)
    mov x1, #0                  // Inicializamos x1 a 0 (segundo número más grande)
    ldr x2, =arr                // Cargar la dirección de arr
    ldr x3, =len                // Cargar la longitud del arreglo
    ldr x3, [x3]                // Cargar la longitud del arreglo en x3
    mov x4, #0                  // Inicializamos el índice i a 0

loop:
    cmp x4, x3                  // Comparar i con la longitud del arreglo
    bge end_loop                // Si i >= len, terminar el ciclo

    ldr x5, [x2, x4, lsl #3]    // Cargar arr[i] en x5 (10 bytes por valor, ya que es un número largo)
    
    cmp x5, x0                  // Comparar arr[i] con el primer número más grande
    ble check_second            // Si arr[i] <= x0, saltar a verificar el segundo más grande

    mov x1, x0                  // Mover el primer número más grande a x1 (segundo más grande)
    mov x0, x5                  // Mover arr[i] al primer número más grande

    b increment_index

check_second:
    cmp x5, x1                  // Comparar arr[i] con el segundo número más grande
    ble increment_index         // Si arr[i] <= x1, continuar con el siguiente

    mov x1, x5                  // Si arr[i] > x1, actualizar el segundo más grande

increment_index:
    add x4, x4, #1              // Incrementar el índice (i++)
    b loop                       // Volver al comienzo del ciclo

end_loop:
    // Mostrar el resultado
    ldr x0, =msg_out            // Cargar la dirección del mensaje
    mov x2, x1                  // Mover el segundo número más grande a x2 para imprimir
    bl printf                   // Llamar a printf

    // Salir del programa
    mov x0, #0                  // Código de salida 0 (indica éxito)
    mov x8, #93                 // Número de syscall para 'exit' (93 en ARM64)
    svc #0                      // Realizar la llamada al sistema para salir




