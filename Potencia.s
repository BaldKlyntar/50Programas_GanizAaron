/*=======================================================
* Programa:       Potencia.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa calcula la potencia de
*              un valor
*              
*              
* Compilación:  as -o Potencia.o Potencia.s
*               gcc -o Potencia Potencia.o
* Ejecución:    ./Potencia
*
* Código equivalente en C#:
* -----------------------------------------------------
*    static void Main()
*    {
*        double x = 2; 
*        int n = 3; 
*        double result = 1;
*
*        for (int i = 0; i < n; i++)
*        {
*            result *= x;
*        }
*
*        Console.WriteLine(result);
*    }
*
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/rruHUk4U3dxSZUqLeGgbX3aln
* -----------------------------------------------------

=========================================================*/

.section .data
  x: .word 2            // Base x
  n: .word 3            // Exponente n
  result: .word 1       // Inicialización de result (1)
  msg_out: .asciz "El resultado final es: %d\n"

.section .text
  .global main
  .extern printf

main:
  // Inicializar registros con valores de x, n y result
  ldr x0, =n            // Cargar dirección de n
  ldr x19, [x0]          // Cargar el valor de n en x1

  ldr x0, =result       // Cargar dirección de result
  ldr x18, [x0]          // Cargar el valor de result en x2 (inicializado en 1)

  ldr x0, =x            // Cargar dirección de x
  ldr x17, [x0]          // Cargar el valor de x en x3

  mov x20, #0           // Inicializar contador (i = 0)

begin_loop:
  cmp x20, x19           // Comparar contador (i) con el exponente (n)
  bge end_loop          // Si i >= n, salir del bucle

for_loop:
  mul x18, x18, x17        // result = result * x (multiplicamos por x)
  add x20, x20, #1      // Incrementar el contador (i)
  cmp x20, x19           // Verificar si hemos alcanzado el exponente
  blt for_loop          // Si i < n, continuar el ciclo

end_loop:
  // Mostrar el resultado final
  ldr x0, =msg_out      // Cargar la dirección del mensaje
  mov x1, x18            // Pasar el valor de result (x2) a x1
  bl printf             // Llamar a printf para mostrar el resultado

  // Salir del programa
  mov x0, #0            // Código de estado 0 (indica éxito)
  mov x8, #93           // Número de syscall para 'exit' (93 en ARM64)
  svc #0                // Realizar la llamada al sistema para salir

