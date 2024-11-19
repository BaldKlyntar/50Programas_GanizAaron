/*=======================================================
* Programa:       OrdenamientoBurbuja.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que realiza el metodo
*              ordenamiento burbuja
*              
*              
* Compilación:  as -o OrdenamientoBurbuja.o OrdenamientoBurbuja.s
*               ld -o OrdenamientoBurbuja OrdenamientoBurbuja.o
* Ejecución:    ./OrdenamientoBurbuja
*
* Código equivalente en C#:
* -----------------------------------------------------
*  static void Main()
*  {
*        int[] numeros = { 5, 3, 8, 1, 2 };
*        int n = numeros.Length;
*
*        Console.WriteLine("Arreglo ordenado:");
*
*        for (int i = 0; i < n - 1; i++)
*        {
*            for (int j = 0; j < n - i - 1; j++)
*            {
*                if (numeros[j] > numeros[j + 1])
*                {
*                    int temp = numeros[j];
*                    numeros[j] = numeros[j + 1];
*                    numeros[j + 1] = temp;
*                }
*            }
*        }
*
*        foreach (var numero in numeros)
*        {
*            Console.Write(numero + " ");
*        }
*
*        Console.WriteLine();
*    }
*
* ASCIINEMA
* -----------------------------------------------------
* 
* -----------------------------------------------------

=========================================================*/


.section  .data

    msg_ordenado:    .asciz "Arreglo ordenado:\n"   // Mensaje que se mostrará antes de imprimir el array ordenado
    numeros:         .word 5, 3, 8, 1, 2            // Array a ordenar
    T:               .word 5                        // Longitud del array

.section .text
    .global _start

_start:

    // Cargar la longitud del array en w1
    ldr x1, =T                // Dirección de la longitud del array
    ldr w1, [x1]              // Cargar la longitud en el registro w1

ordenar_burbuja_externo:
    sub w2, w1, #1            // w2 = length - 1 (número de pasadas)
    cmp w2, #0                // Si w2 es 0, hemos terminado
    ble fin_ordenamiento      // Salir si w2 es 0 o negativo

    // Establecer el contador para el bucle interno
    mov w3, #0                // Índice inicial del bucle interno

ordenar_burbuja_interno:
    ldr x4, =numeros          // Dirección base del array

    // Calcular la dirección de los elementos a comparar
    lsl w5, w3, #2            // Desplazar w3 para obtener la posición en bytes
    add x6, x4, x5            // Dirección de array[w3]
    add x7, x6, #4            // Dirección de array[w3 + 1]

    // Cargar los valores a comparar
    ldr w8, [x6]              // Valor en array[w3]
    ldr w9, [x7]              // Valor en array[w3 + 1]

    // Comparar los dos valores
    cmp w8, w9
    ble sin_intercambio       // Si array[w3] <= array[w3 + 1], no intercambiar

    // Intercambiar los valores
    str w9, [x6]              // Guardar w9 (valor de array[w3 + 1]) en array[w3]
    str w8, [x7]              // Guardar w8 (valor de array[w3]) en array[w3 + 1]

sin_intercambio:
    add w3, w3, #1            // Incrementar índice interno
    cmp w3, w2                // Verificar si llegamos al final de la pasada
    blt ordenar_burbuja_interno // Si no, repetir el bucle interno

    sub w1, w1, #1            // Decrementar el contador externo (número de pasadas)
    b ordenar_burbuja_externo // Repetir el bucle externo

fin_ordenamiento:
    // Mostrar el mensaje de array ordenado
    mov x0, #1                // Descriptor de archivo para STDOUT
    ldr x1, =msg_ordenado      // Dirección del mensaje "Array ordenado:\n"
    mov x2, #16               // Longitud del mensaje
    mov x8, #64               // Syscall para 'write' (64)
    svc #0                    // Ejecutar syscall

    // Imprimir los elementos del array ordenado
    mov w10, #0               // Inicializar índice en 0

imprimir_array:
    ldr x3, =numeros          // Dirección base del array
    lsl w11, w10, #2          // Desplazamiento de w10 (w11 = w10 * 4 bytes por palabra)
    add x3, x3, x11           // Dirección de array[w10]
    ldr w0, [x3]              // Cargar el valor en w0

    // Convertir el número a texto (para impresión) llamando a la función print_num
    bl imprimir_numero

    add w10, w10, #1          // Incrementar índice
    ldr x1, =T                 // Dirección de la longitud
    ldr w1, [x1]              // Leer la longitud original del array
    cmp w10, w1               // Comparar índice con la longitud del array
    blt imprimir_array        // Repetir si aún hay elementos

    // Terminar el programa
    mov x8, #93               // Syscall para 'exit' (93)
    svc #0                    // Ejecutar syscall


imprimir_numero:
    // Convertir el número a su equivalente ASCII
    add w0, w0, '0'           // Convertir el número a su equivalente ASCII
    mov x1, sp                // Usar la pila para el buffer temporal
    strb w0, [x1, #-1]!       // Guardar el carácter en la pila

    mov x0, #1                // Descriptor de archivo para STDOUT
    mov x2, #1                // Longitud del número convertido
    mov x8, #64               // Syscall para 'write' (64)
    svc #0                    // Ejecutar syscall

	
