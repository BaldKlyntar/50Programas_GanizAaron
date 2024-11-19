/*=======================================================
* Programa:       OrdenamientoSeleccion.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que realiza el metodo
*              ordenamiento por seleccion
*              
*              
* Compilación:  as -o OrdenamientoSeleccion.o OrdenamientoSeleccion.s
*               gcc -o OrdenamientoSeleccion OrdenamientoSeleccion.o
* Ejecución:    ./OrdenamientoSeleccion
*
* Código equivalente en C#:
* -----------------------------------------------------
* static void Main()
*   {
*        int[] array = { 4, 9, 8, 3, 5 };
*        int length = array.Length;
*
*        for (int i = 0; i < length; i++)
*        {
*            int minIndex = i;
*
*            for (int j = i + 1; j < length; j++)
*            {
*                if (array[j] < array[minIndex])
*                {
*                    minIndex = j;
*                }
*            }
*
*            if (minIndex != i)
*            {
*                int temp = array[i];
*                array[i] = array[minIndex];
*                array[minIndex] = temp;
*            }
*        }
*
*        for (int i = 0; i < length; i++)
*        {
*            Console.WriteLine(array[i]);
*        }
*    }
*
* ASCIINEMA
* -----------------------------------------------------
*https://asciinema.org/a/5QVQiNO61wzvRfbY7835vk3X5
* -----------------------------------------------------

=========================================================*/

.section .data
    array:        .word 4, 9, 8, 3, 5   // Declaración del array a ordenar
    longitud:     .word 5               // Longitud del array

.section .text
    .global _start

_start:
    ldr x1, =longitud                 // Cargar la dirección de la longitud del array en x1
    ldr w1, [x1]                      // Cargar el valor de la longitud del array en w1

inicio_ordenamiento:
    mov w2, #0                        // Inicializar el índice del bucle externo en 0

bucle_externo:
    cmp w2, w1                         // Comparar el índice del bucle con la longitud del array
    bge fin_ordenamiento              // Si el índice es igual o mayor a la longitud, terminar el ordenamiento

    mov w3, w2                        // Suponer que el índice del bucle externo es el mínimo

    mov w4, w2                        // Inicializar el índice para la búsqueda del mínimo en el bucle interno
bucle_interno:
    add w4, w4, #1                    // Incrementar el índice para buscar el siguiente elemento

    cmp w4, w1                        // Si el índice del bucle interno es igual o mayor a la longitud, salir del bucle
    bge fin_bucle_interno

    ldr x5, =array                    // Cargar la dirección base del array en x5
    lsl w6, w3, #2                    // Calcular el desplazamiento de array[w3] (w3 * 4 bytes)
    lsl w7, w4, #2                    // Calcular el desplazamiento de array[w4] (w4 * 4 bytes)
    add x8, x5, x6                    // Dirección de array[w3]
    add x9, x5, x7                    // Dirección de array[w4]

    ldr w10, [x8]                     // Cargar el valor de array[w3] en w10
    ldr w11, [x9]                     // Cargar el valor de array[w4] en w11

    cmp w11, w10                      // Comparar los valores de array[w4] y array[w3]
    bge bucle_interno                 // Si array[w4] >= array[w3], continuar buscando

    mov w3, w4                        // Si array[w4] es menor, actualizar el índice del mínimo a w4

    b bucle_interno                   // Repetir el bucle interior

fin_bucle_interno:
    cmp w3, w2                         // Comparar el índice mínimo con el índice del bucle externo
    beq no_intercambiar_externo       // Si son iguales, no es necesario intercambiar

    ldr x5, =array                    // Cargar la dirección base del array
    lsl w6, w2, #2                    // Calcular el desplazamiento de array[w2] (w2 * 4 bytes)
    lsl w7, w3, #2                    // Calcular el desplazamiento de array[w3] (w3 * 4 bytes)
    add x8, x5, x6                    // Dirección de array[w2]
    add x9, x5, x7                    // Dirección de array[w3]

    ldr w10, [x8]                     // Cargar el valor de array[w2] en w10
    ldr w11, [x9]                     // Cargar el valor de array[w3] en w11
    str w11, [x8]                     // Intercambiar los valores: array[w2] = array[w3]
    str w10, [x9]                     // Intercambiar los valores: array[w3] = array[w2]

no_intercambiar_externo:
    add w2, w2, #1                    // Incrementar el índice del bucle externo
    b bucle_externo                   // Repetir el bucle externo

fin_ordenamiento:
    mov w12, #0                       // Inicializar el índice para imprimir el array ordenado

imprimir_array:
    ldr x3, =array                    // Cargar la dirección base del array
    lsl w13, w12, #2                  // Calcular el desplazamiento de array[w12] (w12 * 4 bytes)
    add x3, x3, x13                   // Dirección de array[w12]
    ldr w0, [x3]                      // Cargar el valor de array[w12] en w0

    bl imprimir_num                   // Llamar a la función para imprimir el número

    add w12, w12, #1                  // Incrementar el índice para imprimir el siguiente elemento
    ldr x1, =longitud                 // Cargar la dirección de la longitud del array
    ldr w1, [x1]                      // Cargar la longitud del array
    cmp w12, w1                       // Comparar el índice con la longitud
    blt imprimir_array                // Repetir si aún hay elementos por imprimir

    mov x8, #93                       // Syscall para salir del programa (exit)
    svc #0                            // Ejecutar la syscall para salir

    add w0, w0, '0'                   // Convertir el número a su representación ASCII
    mov x1, sp                        // Usar la pila como buffer temporal
    strb w0, [x1, #-1]!               // Guardar el carácter en la pila

    mov x0, #1                        // Descriptor de archivo para STDOUT
    mov x2, #1                        // Longitud del número convertido
    mov x8, #64                       // Syscall para escribir en consola (write)
    svc #0                            // Ejecutar la syscall para escribir en consola

    ret                               // Retornar de la función
