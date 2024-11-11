/*=======================================================
* Programa:       SumaMatrices.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa para la suma de
*              matrices
*             
*              
* Compilación:  as -o SumaMatrices.o SumaMatrices.s
*               gcc -o SumaMatrices SumaMatrices.o
* Ejecución:    ./SumaMatrices
*
* Código equivalente en C#:
* -----------------------------------------------------
*	static void Main()
*    {
*        int[,] matriz1 = {
*            {1, 2, 3},
*            {4, 5, 6},
*            {7, 8, 9}
*        };
*
*        int[,] matriz2 = {
*            {9, 8, 7},
*            {6, 5, 4},
*            {3, 2, 1}
*        };
*
*        int[,] resultado = new int[3, 3];
*
*        for (int i = 0; i < 3; i++)
*        {
*            for (int j = 0; j < 3; j++)
*            {
*                resultado[i, j] = matriz1[i, j] + matriz2[i, j];
*            }
*        }
*
*        for (int i = 0; i < 3; i++)
*       {
*            for (int j = 0; j < 3; j++)
*            {
*                Console.Write(resultado[i, j] + " ");
*           }
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
    .global matrizA, matrizB, resultado

matrizA:
    .word 1, 2, 3
    .word 4, 5, 6
    .word 7, 8, 9

matrizB:
    .word 9, 8, 7
    .word 6, 5, 4
    .word 3, 2, 1

resultado:
    .space 36    // 3x3 = 9 elementos de 4 bytes

.section .text
    .global main

main:
    // Cargar las direcciones de las matrices en registros
    ldr x0, =matrizA           // Dirección de matrizA
    ldr x1, =matrizB           // Dirección de resultado
    ldr x2, =resultado         // Dirección de resultado

    mov w3, #0                 // Índice i (contador de filas)

fila_loop:
    mov w4, #0                 // Índice j (contador de columnas)

columna_loop:
    // Calcular la posición en el arreglo lineal: pos = i * 3 + j
    mov x5, x3                 // x5 = i
    lsl x6, x5, #1             // x6 = i * 2
    add x5, x6, x5             // x5 = i * 3
    add x5, x5, x4             // x5 = i * 3 + j

    // Cargar los elementos de matrizA y matrizB y sumarlos
    ldr w6, [x0, x5, LSL #2]   // w6 = matrizA[i][j]
    ldr w7, [x1, x5, LSL #2]   // w7 = matrizB[i][j]
    add w8, w6, w7             // w8 = matrizA[i][j] + matrizB[i][j]

    // Guardar el resultado en la posición correspondiente
    str w8, [x2, x5, LSL #2]   // resultado[i][j] = matrizA[i][j] + matrizB[i][j]

    add w4, w4, #1             // j++
    cmp w4, #3                 // Comparar j con el tamaño de la fila
    blt columna_loop           // Si j < 3, repetir columna_loop

    add w3, w3, #1             // i++
    cmp w3, #3                 // Comparar i con el tamaño de la columna
    blt fila_loop              // Si i < 3, repetir fila_loop

        // Salir del programa

    mov     x0, #0 // Código de estado 0 (indica éxito)
    mov     x8, #93 // Número de syscall para 'exit' (93 en ARM64)
    svc     0 // Se realiza la llamda al sistema
	
