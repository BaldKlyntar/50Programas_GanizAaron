/*=======================================================
* Programa:       BinarioDecimal.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa que convierte un valor
*            de binario a decimal
*              
*              
* Compilación:  as -o BinarioDecimal.o BinarioDecimal.s
*               gcc -o BinarioDecimal BinarioDecimal.o
* Ejecución:    ./BinarioDecimal
*
* Código equivalente en C#:
* -----------------------------------------------------
* static void Main()
*    {
*        string binario = "1101";
*        int decimalValue = 0;
*        int potencia = 0;
*
*        for (int i = binario.Length - 1; i >= 0; i--)
*        {
*            if (binario[i] == '1')
*            {
*                decimalValue += (int)Math.Pow(2, potencia);
*            }
*            potencia++;
*        }
*
*        Console.WriteLine(decimalValue);
*    }
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/jY8cKSv5aQfw09qSfmfkQzfqD
* -----------------------------------------------------

=========================================================*/

.section .data
  binario: .asciz "1101"        // Número binario como cadena de caracteres
  decimal: .word 0              // Almacena el resultado decimal
  potencia: .word 0             // Almacena la potencia de 2
  msg_out: .asciz "El valor binario a decimal es: %d\n"
  length: .word 4               // Longitud del número binario

.section .text
  .global main
  .extern printf

main:
  // Cargar la dirección de la cadena binaria en x0
  ldr x0, =binario              // Dirección de la cadena "1101"
  ldr x1, =length               // Dirección de la longitud de la cadena
  ldr w1, [x1]                  // Cargar la longitud en w1

  // Inicializar el resultado decimal en 0
  mov x2, #0                    // x2 = 0 (resultado final decimal)
  mov x3, #0                    // x3 = 0 (potencia de 2)

binario_loop:
  // Verificar si hemos recorrido toda la cadena binaria
  cmp w1, #0                    // ¿Quedan más bits por procesar?
  beq fin                       // Si no quedan más, terminar el ciclo

  // Cargar el siguiente bit de la cadena binaria
  ldrb w4, [x0], #1             // Cargar el siguiente byte (bit) en w4 y avanzar el puntero

  // Convertir el bit (carácter ASCII) a valor numérico (0 o 1)
  sub w4, w4, #'0'              // Restar '0' (ASCII) para convertir a entero

  // Sumar al resultado (bit * 2^potencia)
  mov w5, w4                    // w5 = bit
  lsl w5, w5, w3                // Desplazar w5 a la posición de la potencia de 2 correspondiente
  add x2, x2, x5                // Sumar el valor al resultado final

  // Incrementar la potencia de 2 (equivalente a multiplicar por 2)
  add w3, w3, #1                // Incrementar la potencia de 2

  // Decrementar la longitud (mover al siguiente bit)
  sub w1, w1, #1

  b binario_loop                // Repetir el ciclo

fin:
  // Imprimir el resultado
  ldr x0, =msg_out              // Cargar el mensaje de salida
  mov x1, x2                    // Cargar el resultado decimal en x1
  bl printf                     // Llamar a printf para imprimir el resultado

  // Salir del programa
  mov x0, #0                    // Código de salida 0
  mov x8, #93                   // Syscall para exit
  svc #0                         // Llamar al sistema operativo





  
