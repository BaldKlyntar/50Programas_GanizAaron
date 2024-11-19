/*=======================================================
* Programa:       Factorial.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que divide
*              dos numeros ingresados por
*              el usuario.
*              
* Compilación:  as -o Factorial.o Factorial.s
*               gcc -o Factorial Factorial.o
* Ejecución:    ./Factorial
*
* Código equivalente en C#:
* -----------------------------------------------------
*      static void Main()
*    {
*        Console.Write("Ingrese un número: ");
*        long num = long.Parse(Console.ReadLine());
*        long result = Factorial(num);
*        Console.WriteLine($"El factorial es: {result}");
*    }
*
*    static long Factorial(long n)
*    {
*        if (n <= 1)
*            return 1;
*        return n * Factorial(n - 1);
*
*
*    }
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/fKrjhadfj2dYZy1AN1FFfISBo
* -----------------------------------------------------

=========================================================*/

.section .data
prompt:     .string "Ingrese un número: "    // Mensaje para solicitar el número
format:     .string "%ld"                    // Formato para leer el número ingresado
result:     .string "El factorial es: %ld\n" // Mensaje para mostrar el resultado

.section .text
.global main
.type main, %function
.extern printf
.extern scanf

main:
    // Preparación de la pila - Guardar el frame pointer
    stp     x29, x30, [sp, -16]!    // Guardar el frame pointer y el link register
    mov     x29, sp
    
    // Reservar espacio para la variable 'num'
    sub     sp, sp, #16
    
    // Solicitar al usuario que ingrese un número
    adr     x0, prompt
    bl      printf
    
    // Leer el número ingresado por el usuario
    adr     x0, format
    mov     x1, sp         // Dirección donde se almacenará el número
    bl      scanf
    
    // Llamar a la función factorial con el número ingresado
    ldr     x0, [sp]      // Cargar el número en x0 como parámetro
    bl      factorial     // Llamada a la función factorial
    
    // Mostrar el resultado del factorial
    mov     x1, x0        // Mover el resultado a x1 (segundo argumento de printf)
    adr     x0, result    // Primer argumento de printf (la cadena de formato)
    bl      printf
    
    // Terminar el programa
    mov     w0, #0
    mov     sp, x29
    ldp     x29, x30, [sp], #16
    ret

factorial:
    // Guardar los registros utilizados en la función
    stp     x29, x30, [sp, -16]!
    stp     x19, x20, [sp, -16]!    // Guardar registros adicionales
    mov     x29, sp
    
    // Comprobar si n es menor o igual a 1
    cmp     x0, #1
    b.gt    recurse            // Si n > 1, se hace la llamada recursiva
    mov     x0, #1             // Si n <= 1, retornar 1
    b       end
    
recurse:
    // Realizar la llamada recursiva: return n * factorial(n-1)
    mov     x19, x0            // Guardar n en x19
    sub     x0, x0, #1         // Decrementar n por 1
    bl      factorial          // Llamada recursiva
    mul     x0, x0, x19        // Multiplicar n por factorial(n-1)
    
end:
    // Restaurar los registros antes de regresar
    ldp     x19, x20, [sp], #16
    ldp     x29, x30, [sp], #16
    ret

    // Salir del programa
    mov     x0, #0             // Código de salida 0 (indica éxito)
    mov     x8, #93            // Número de syscall para 'exit' (93 en ARM64)
    svc     0                  // Llamada al sistema para salir

    
