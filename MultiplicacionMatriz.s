/*=======================================================
* Programa:       MultiplicacionMatriz.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa realiza multiplicacion
*            de matrices
*              
*              
* Compilación:  as -o MultiplicacionMatriz.o MultiplicacionMatriz.s
*               gcc -o MultiplicacionMatriz MultiplicacionMatriz.o
* Ejecución:    ./MultiplicacionMatriz
*
* Código equivalente en C#:
* -----------------------------------------------------
*    static void Main()
*   {
*        int[,] matriz1 = {
*            {1, 2, 3},
*            {4, 5, 6}
*        };
*
*        int[,] matriz2 = {
*            {7, 8},
*            {9, 10},
*            {11, 12}
*        };
*
*        int[,] resultado = new int[2, 2];
*
*        for (int i = 0; i < 2; i++)
*        {
*            for (int j = 0; j < 2; j++)
*            {
*                resultado[i, j] = 0;
*                for (int k = 0; k < 3; k++)
*                {
*                    resultado[i, j] += matriz1[i, k] * matriz2[k, j];
*                }
*            }
*        }
*
*        for (int i = 0; i < 2; i++)
*        {
*            for (int j = 0; j < 2; j++)
*            {
*                Console.Write(resultado[i, j] + " ");
*            }
*            Console.WriteLine();
*        }
*    }
*
* ASCIINEMA
* -----------------------------------------------------
* 
* -----------------------------------------------------

=========================================================*/
.section .data
    msg_matriz1_1: .asciz "Matriz 1: [%d %d %d]\n"
    msg_matriz1_2: .asciz "[%d %d %d]\n"
    msg_matriz2_1: .asciz "Matriz 2: [%d %d]\n"
    msg_matriz2_2: .asciz "[%d %d]\n"
    msg_matriz2_3: .asciz "[%d %d]\n"
    msg_resultado: .asciz "Resultado:\n"

    matriz1:
        .word 1, 2, 3
        .word 4, 5, 6

    matriz2:
        .word 7, 8
        .word 9, 10
        .word 11, 12
	
resultado:
	.word 0, 0
	.word 0, 0

.section .text 
    .global main
    .extern printf

main:

    // Imprimir "Matriz 1"
    ldr x0, =msg_matriz1_1        // Cargar el mensaje de la primera fila de la matriz1
    ldr x28, =matriz1              // Cargar la dirección base de matriz1
    ldr x1, [x28]                 // Cargar el primer valor de matriz1 en w1
    ldr x2, [x28, #4]             // Cargar el segundo valor de matriz1 en w2
    ldr x3, [x28, #8]             // Cargar el tercer valor de matriz1 en w3
    bl printf                     // Llamada a printf

    ldr x0, =msg_matriz1_2        // Cargar el mensaje de la segunda fila de la matriz1
    ldr x1, [x28, #12]            // Cargar el cuarto valor de matriz1 en w1
    ldr x2, [x28, #16]            // Cargar el quinto valor de matriz1 en w2
    ldr x3, [x28, #20]            // Cargar el sexto valor de matriz1 en w3
    bl printf                     // Llamada a printf

    // Imprimir "Matriz 2"
    ldr x0, =msg_matriz2_1        // Cargar el mensaje de la primera fila de la matriz2
    ldr x28, =matriz2              // Cargar la dirección base de matriz2
    ldr x1, [x28]                 // Cargar el primer valor de matriz2 en w1
    ldr x2, [x28, #4]             // Cargar el segundo valor de matriz2 en w2
    bl printf                     // Llamada a printf

    ldr x0, =msg_matriz2_2        // Cargar el mensaje de la segunda fila de la matriz2
    ldr x1, [x28, #8]             // Cargar el tercer valor de matriz2 en w1
    ldr x2, [x28, #12]            // Cargar el cuarto valor de matriz2 en w2
    bl printf                     // Llamada a printf

    ldr x0, =msg_matriz2_3        // Cargar el mensaje de la tercera fila de la matriz2
    ldr x1, [x28, #16]            // Cargar el quinto valor de matriz2 en w1
    ldr x2, [x28, #20]            // Cargar el sexto valor de matriz2 en w2
    bl printf                     // Llamada a printf

        // Inicializamos el resultado
    mov x28, #0               // i = 0
    mov x29, #0               // j = 0

    // Cargar la dirección de la matriz1
    ldr x0, =matriz1          // x0 = dirección de matriz1
    ldr x1, =matriz2          // x1 = dirección de matriz2
    ldr x2, =resultado        // x2 = dirección de resultado

    // Bucle i (por filas de matriz1)
loop_i:
    cmp x28, #2               // Comparar i con 2 (número de filas en resultado)
    bge end_program           // Si i >= 2, salir del programa

    mov x29, #0               // j = 0

    // Bucle j (por columnas de matriz2)
loop_j:
    cmp x29, #2               // Comparar j con 2 (número de columnas en resultado)
    bge next_i                // Si j >= 2, pasar al siguiente i

    mov x30, #0               // k = 0
    mov x3, #0                // resultado[i, j] = 0

    // Bucle k (por elementos de la fila de matriz1 y columna de matriz2)
loop_k:
    cmp x30, #3               // Comparar k con 3 (número de elementos en fila de matriz1 y columna de matriz2)
    bge store_result          // Si k >= 3, almacenar el resultado en resultado[i, j]

    // Cargar elementos de matriz1 y matriz2
    ldr w4, [x0, x28, LSL #2] // w4 = matriz1[i, k]
    ldr w5, [x1, x30, LSL #2] // w5 = matriz2[k, j]

    // Multiplicar y acumular en resultado[i, j]
    mul w6, w4, w5            // w6 = matriz1[i, k] * matriz2[k, j]
    add x3, x3, x6            // resultado[i, j] += w6

    // Incrementar k
    add x30, x30, #1          // k++

    b loop_k                  // Volver al bucle k

store_result:
    str w3, [x2, x28, LSL #2] // Almacenar resultado[i, j] en resultado[i, j]

    // Incrementar j
    add x29, x29, #1          // j++

    b loop_j                  // Volver al bucle j

next_i:
    add x28, x28, #1          // i++
    b loop_i                  // Volver al bucle i

end_program:

    // Imprimir resultado
    ldr x0, =msg_resultado    // Cargar el mensaje "Resultado"
    bl printf                 // Llamar a printf

    ldr x15, =resultado        // Cargar la dirección de resultado
    ldr x1, [x15]              // Cargar resultado[0, 0]
    ldr x2, [x15, #4]          // Cargar resultado[0, 1]
    ldr x3, [x15, #8]          // Cargar resultado[1, 0]
    ldr x4, [x15, #12]         // Cargar resultado[1, 1]
    bl printf                 // Llamar a printf para imprimir resultado

    // Salir del programa
    mov x0, #0                // Código de estado 0
    mov x8, #93               // Número de syscall para 'exit' (93 en ARM64)
    svc 0                      // Llamada al sistema para salir

	
