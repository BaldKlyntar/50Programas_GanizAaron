/*=======================================================
* Programa:       Fibonacci.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa que calcula Fibonacci segun
*              un numero dado
*            
*              
* Compilación:  as -o Fibonacci.o Fibonacci.s
*               gcc -o Fibonacci Fibonacci.o
* Ejecución:    ./Fibonacci
*
* Código equivalente en C#:
* -----------------------------------------------------
*     static void Main()
*    {
*        long a = 0, b = 1, c;
*        int n, i = 2;
*
*        Console.Write("Ingrese el número de términos: ");
*        n = Convert.ToInt32(Console.ReadLine());
*
*        Console.WriteLine("Serie de Fibonacci:");
*        Console.WriteLine($"{a}, {b}");
*
*        while (i < n)
*        {
*            c = a + b;
*            Console.Write($", {c}");
*            a = b;
*            b = c;
*            i++;
*        }
*
*        Console.WriteLine();
*    }
*
*
* ASCIINEMA
* -----------------------------------------------------
*  https://asciinema.org/a/g00sQaXLjEYKea2v6yZtqUpc0
* -----------------------------------------------------

=========================================================*/


.section .data
prompt:     .string "Ingrese el número de términos: "
format:     .string "%ld"
first_nums: .string "%ld, %ld"
next_num:   .string ", %ld"
newline:    .string "\n"


.section .text
.global main
.type main, %function


main:
    // Inicializar a = 0, b = 1
    mov     x19, #0                  // a = 0
    mov     x20, #1                  // b = 1
    str     x19, [sp, #16]           // guardar a
    str     x20, [sp, #24]           // guardar b
    
    // Imprimir "Ingrese el número de términos: "
    adr     x0, prompt
    bl      printf
    
    // Leer el número de términos (n)
    adr     x0, format
    mov     x1, sp                   // Dirección de n
    bl      scanf
    

    adr     x0, newline
    bl      printf
    
    // Imprimir los primeros dos términos de la serie
    adr     x0, first_nums
    mov     x1, x19                  // a
    mov     x2, x20                  // b
    bl      printf
    
    // Inicializar el contador i = 2
    mov     x21, #2                  // i = 2
    str     x21, [sp, #8]            // Guardar i

loop:
    // Mientras i < n, seguir calculando los términos
    ldr     x0, [sp]                 // Cargar n
    cmp     x21, x0                  // Comparar i con n
    b.ge    end                      // Si i >= n, salir
    
    // Calcular el siguiente término c = a + b
    add     x22, x19, x20            // c = a + b
    str     x22, [sp, #32]           // Guardar c
    
    // Imprimir el siguiente término c
    adr     x0, next_num
    mov     x1, x22
    bl      printf
    
    // Actualizar los valores de a y b
    mov     x19, x20                 // a = b
    mov     x20, x22                 // b = c
    
    // Incrementar el contador i
    add     x21, x21, #1
    str     x21, [sp, #8]            // Guardar i
    b       loop                     // Volver al inicio del bucle

end:
    // Imprimir nueva línea
    adr     x0, newline
    bl      printf
