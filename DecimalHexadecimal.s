/*=======================================================
* Programa:       DecimalHexadecimal.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa que resta
*              dos numeros ingresados por
*              el usuario.
*              
* Compilación:  as -o DecimalHexadecimal.o DecimalHexadecimal.s
*               gcc -o DecimalHexadecimal DecimalHexadecimal.o
* Ejecución:    ./DecimalHexadecimal
*
* Código equivalente en C#:
* -----------------------------------------------------
*    static void Main()
*    {
*        int decimalValue = 6719;
*        string hexadecimal = "";
*
*        while (decimalValue > 0)
*        {
*            int remainder = decimalValue % 16;
*            char hexChar = (remainder < 10) ? (char)('0' + remainder) : (char)('A' + (remainder - 10));
*            hexadecimal = hexChar + hexadecimal;
*            decimalValue /= 16;
*        }
*
*        Console.WriteLine(hexadecimal);
*    }
*
*
* ASCIINEMA
* -----------------------------------------------------
* 
* -----------------------------------------------------

=========================================================*/

.section .data
decimalValue: .word 6719            // Valor decimal a convertir
hexBuffer: .space 16                // Espacio para almacenar el resultado en hexadecimal (espacio suficiente para 8 caracteres + 1 byte para nulo)
msg_out: .asciz "El valor decimal a hexadecimal es: %s\n"

.section .text
.global main
.extern printf

main:
    // Cargar el valor decimal (6719)
    ldr x0, =decimalValue           // Cargar la dirección de decimalValue en x0
    ldr x1, [x0]                    // Cargar el valor decimal (6719) en x1

    // Inicializar el índice de los caracteres en el buffer
    mov x2, #0                      // x2 será el índice para la cadena hexBuffer
    mov x3, #16                     // x3 almacena el valor 16 (base hexadecimal)

convert_loop:
    udiv x4, x1, x3                 // x4 = x1 / 16 (cociente)
    mul x5, x4, x3                  // x5 = x4 * 16 (producto de cociente por 16)
    sub x6, x1, x5                  // x6 = x1 - x5 (residuo)

    // Convertir el residuo a un carácter hexadecimal
    cmp x6, #9                      // Si el residuo es menor o igual a 9
    ble store_digit                 // Si es menor o igual a 9, almacenarlo como un dígito
    add x6, x6, #7                  // Si el residuo es mayor que 9, sumamos 7 para obtener 'A' - 'F'

store_digit:
    // Almacenar el carácter hexadecimal en el buffer
    ldr x7, =hexBuffer              // Cargar la dirección de hexBuffer en x7
    add x7, x7, x2                  // Sumar el índice al buffer
    strb w6, [x7]                   // Almacenar el carácter en el buffer

    // Actualizar x1 para la próxima iteración (el cociente)
    mov x1, x4                      // x1 ahora es el cociente (continuamos con el siguiente dígito)
    cmp x1, #0                      // Verificar si el cociente es 0
    bne convert_loop                // Si el cociente no es 0, continuar el bucle

    // Asegurarse de que la cadena termina con un nulo (terminación de cadena)
    ldr x7, =hexBuffer              // Dirección de hexBuffer
    add x7, x7, x2                  // Sumar el índice
    mov w6, #0                      // Valor nulo (0)
    strb w6, [x7]                   // Escribir el carácter nulo al final

    // Imprimir el resultado usando printf
    mov x0, #msg_out                // Mensaje "El valor decimal a hexadecimal es: "
    ldr x1, =hexBuffer              // Dirección de hexBuffer
    bl printf                       // Llamar a printf para imprimir el resultado

    // Salir del programa
    mov x0, #0                      // Código de salida 0 (éxito)
    mov x8, #93                     // Número de syscall para 'exit' (93 en ARM64)
    svc 0                            // Llamada al sistema (salir)


