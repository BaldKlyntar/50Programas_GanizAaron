/*=======================================================
* Programa:       InvertirArreglo.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que lee
*              una entrada desde el teclado
*             
*              
* Compilación:  as -o InvertirArreglo.o InvertirArreglo.s
*               gcc -o InvertirArreglo InvertirArreglo.o
* Ejecución:    ./InvertirArreglo
*
* Código equivalente en C#:
* -----------------------------------------------------
*       static void Main(string[] args)
*        {
*            int[] numeros = { 1, 2, 3, 4, 5 };
*
*     
*            for (int i = 0; i < numeros.Length / 2; i++)
*            {
*           
*                int temp = numeros[i];
*                numeros[i] = numeros[numeros.Length - i - 1];
*                numeros[numeros.Length - i - 1] = temp;
*            }
*
*
*            Console.WriteLine("Arreglo invertido:");
*            foreach (int numero in numeros)
*            {
*                Console.Write(numero + " ");
*            }
*        }
*
*
* ASCIINEMA
* -----------------------------------------------------
*  https://asciinema.org/a/YYadxEZ1VXVrNs3jnbxMW8KNw
* -----------------------------------------------------

=========================================================*/

.section .data

numeros:          .word 1, 2, 3, 4, 5
T:                .word 5
imprimir_numeros: .asciz "Elementos del arreglo: [%d %d %d %d %d]\n"
temp:             .word 0

.section .text

.global main
.extern printf
.extern scanf

main:
    // Imprimir los elementos del arreglo antes de invertirlo
    ldr x0, =imprimir_numeros    // Cargar la dirección del mensaje
    ldr x28, =numeros             // Cargar la dirección de los números
    ldr x1, [x28]
    ldr x2, [x28, #4]
    ldr x3, [x28, #8]
    ldr x4, [x28, #12]
    ldr x5, [x28, #16]
    bl printf                    // Llamada a printf para imprimir los números

    // Invertir el arreglo (ciclo for)
    mov x0, #0                    // Inicializar índice de intercambio (i=0)
    mov x1, #4                    // Inicializar índice de intercambio (j=4)

for_loop:
    cmp x0, x1                    // Comparar i y j
    bge end_loop                  // Si i >= j, salir del ciclo

    // Intercambiar los elementos en indices i y j
    ldr w2, [x28, x0, lsl #2]     // Cargar el valor de numeros[i] en w2
    ldr w3, [x28, x1, lsl #2]     // Cargar el valor de numeros[j] en w3
    str w3, [x28, x0, lsl #2]     // Guardar w3 en numeros[i]
    str w2, [x28, x1, lsl #2]     // Guardar w2 en numeros[j]

    // Incrementar i y decrementar j
    add x0, x0, #1
    sub x1, x1, #1

    b for_loop                    // Volver al ciclo

end_loop:
    // Imprimir los elementos del arreglo después de invertirlo
    ldr x0, =imprimir_numeros     // Cargar la dirección del mensaje
    ldr x28, =numeros             // Cargar la dirección de los números
    ldr x1, [x28]
    ldr x2, [x28, #4]
    ldr x3, [x28, #8]
    ldr x4, [x28, #12]
    ldr x5, [x28, #16]
    bl printf                     // Llamada a printf para imprimir los números

    // Salir del programa
    mov x0, #0                    // Código de estado 0 (indica éxito)
    mov x8, #93                   // Número de syscall para 'exit' (93 en ARM64)
    svc 0                          // Llamada al sistema para terminar el programa


        


  

  

  

