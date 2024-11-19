/*=======================================================
* Programa:       SumaNumerosNaturales.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que divide
*              dos numeros ingresados por
*              el usuario.
*              
* Compilación:  as -o SumaNumerosNaturales.o SumaNumerosNaturales.s
*               gcc -o SumaNumerosNaturales SumaNumerosNaturales.o
* Ejecución:    ./SumaNumerosNaturales
*
* Código equivalente en C#:
* -----------------------------------------------------
*       static void Main()
*    {
*        Console.Write("Ingrese la cantidad de números a sumar: ");
*        int n = int.Parse(Console.ReadLine());
*
*        int suma = 0;
*        for (int i = 1; i <= n; i++)
*        {
*            suma += i;
*        }
*
*        Console.Write("La suma de los primeros ");
*        Console.Write(n);
*        Console.Write(" números naturales es: ");
*        Console.WriteLine(suma);
*    }
*
*
* ASCIINEMA
* -----------------------------------------------------
*  https://asciinema.org/a/fwBXZToWilW3JPwbzshfUGzxA
* -----------------------------------------------------

=========================================================*/




.section .data
    msg1:    .asciz "Ingrese la cantidad de números a sumar: "
    msg2:    .asciz "La suma de los primeros "
    msg3:    .asciz " números naturales es: "
    newline: .asciz "\n"
    buffer:  .skip 16
    numstr:  .skip 16

.section .text

  .global _start

_start:
    // Imprimir mensaje de solicitud de entrada
    mov x0, #1              // Descripción del archivo (stdout)
    adr x1, msg1            // Dirección del mensaje
    mov x2, #44             // Longitud del mensaje
    mov x8, #64             // Número de syscall para 'write'
    svc #0                  // Llamada al sistema

    // Leer la entrada del usuario (cantidad de números)
    mov x0, #0              // Descripción del archivo (stdin)
    adr x1, buffer          // Dirección del buffer donde se almacenará la entrada
    mov x2, #16             // Tamaño máximo del buffer
    mov x8, #63             // Número de syscall para 'read'
    svc #0                  // Llamada al sistema

    // Convertir la cadena de texto a un número
    adr x0, buffer          // Dirección del buffer con la entrada
    bl atoi                 // Convierte la cadena a entero y guarda en x0
    mov x19, x0             // Guardar el valor de N en el registro x19

    // Inicializar las variables de la suma y el índice
    mov x20, #0             // Inicializar la suma en 0
    mov x21, #1             // Inicializar el índice i en 1

    // Bucle para calcular la suma de los primeros N números
loop:
    add x20, x20, x21       // suma += i
    add x21, x21, #1        // i++
    cmp x21, x19            // Comparar i con N
    ble loop                // Si i <= N, continuar el bucle

    // Imprimir mensaje antes de mostrar la suma
    mov x0, #1              // Descripción del archivo (stdout)
    adr x1, msg2            // Dirección del mensaje
    mov x2, #22             // Longitud del mensaje
    mov x8, #64             // Número de syscall para 'write'
    svc #0                  // Llamada al sistema

    // Convertir el número N a cadena de texto para imprimir
    mov x0, x19             // Número N
    adr x1, numstr          // Dirección del buffer donde se almacenará la cadena
    bl itoa                 // Convierte el número a cadena

    mov x0, #1              // Descripción del archivo (stdout)
    adr x1, numstr          // Dirección de la cadena convertida
    bl strlen               // Calcular la longitud de la cadena
    mov x2, x0              // Longitud de la cadena
    mov x8, #64             // Número de syscall para 'write'
    svc #0                  // Llamada al sistema

    // Imprimir mensaje final
    mov x0, #1              // Descripción del archivo (stdout)
    adr x1, msg3            // Dirección del mensaje
    mov x2, #22             // Longitud del mensaje
    mov x8, #64             // Número de syscall para 'write'
    svc #0                  // Llamada al sistema

    // Mostrar la suma final
    mov x0, x20             // La suma calculada
    adr x1, buffer          // Dirección del buffer donde se almacenará la cadena
    bl itoa                 // Convertir la suma a cadena

    mov x0, #1              // Descripción del archivo (stdout)
    adr x1, buffer          // Dirección de la cadena convertida
    bl strlen               // Calcular la longitud de la cadena
    mov x2, x0              // Longitud de la cadena
    mov x8, #64             // Número de syscall para 'write'
    svc #0                  // Llamada al sistema

    // Imprimir nueva línea
    mov x0, #1              // Descripción del archivo (stdout)
    adr x1, newline         // Dirección del salto de línea
    mov x2, #1              // Longitud del salto de línea
    mov x8, #64             // Número de syscall para 'write'
    svc #0                  // Llamada al sistema

    // Salir del programa
    mov x0, #0              // Código de salida 0 (indica éxito)
    mov x8, #93             // Número de syscall para 'exit'
    svc #0                  // Llamada al sistema

// Función para calcular la longitud de una cadena
strlen:
    mov x2, #0              // Contador de caracteres
1:
    ldrb w3, [x1, x2]       // Cargar el siguiente byte de la cadena
    cbz w3, 2f              // Si es nulo (fin de cadena), salir
    add x2, x2, #1          // Incrementar el contador
    b 1b                    // Continuar
2:
    mov x0, x2              // Retornar la longitud
    ret

// Función para convertir una cadena a número (atoi)
atoi:
    mov x2, #0              // Inicializar el resultado en 0
    mov x3, #10             // Usar base 10
1:
    ldrb w4, [x0], #1       // Cargar el siguiente carácter
    cmp w4, #0xa            // Verificar si es el final de la cadena
    beq 2f                  // Si es el final, salir
    sub w4, w4, #'0'        // Convertir el carácter a un número
    mul x2, x2, x3          // Multiplicar el resultado por 10
    add x2, x2, x4          // Añadir el dígito al resultado
    b 1b                    // Continuar
2:
    mov x0, x2              // Retornar el número
    ret

// Función para convertir un número a cadena (itoa)
itoa:
    mov x2, #0              // Contador de dígitos
    mov x3, x0              // Copiar el número
    mov x4, #10             // Usar divisor 10
    
    // Contar los dígitos del número
1:
    udiv x3, x3, x4         // Dividir el número por 10
    add x2, x2, #1          // Incrementar el contador de dígitos
    cbnz x3, 1b             // Si no es cero, continuar
     
    // Convertir el número a cadena
    add x1, x1, x2          // Moverse al final del buffer
    strb wzr, [x1]          // Terminar la cadena
    sub x1, x1, #1          // Retroceder al último dígito
    
2:
    udiv x3, x0, x4         // Dividir el número por 10
    msub x5, x3, x4, x0     // Obtener el resto
    add w5, w5, #'0'        // Convertir a ASCII
    strb w5, [x1]           // Almacenar el dígito en el buffer
    sub x1, x1, #1          // Retroceder al siguiente espacio
    mov x0, x3              // Actualizar el número
    cbnz x0, 2b             // Si no es cero, continuar

    add x1, x1, #1          // Ajustar el puntero al inicio de la cadena
    ret


        // Salir del programa
    
    mov     x0, #0 // Código de estado 0 (indica éxito)
    mov     x8, #93 // Número de syscall para 'exit' (93 en ARM64)
    svc     0 // Se realiza la llamda al sistema 
