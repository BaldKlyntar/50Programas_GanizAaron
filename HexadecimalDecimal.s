/*======================================================
* Programa:       HexadecimalDecimal.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa que convierte
*              un valor hexadecimal a
*              decimal
*              
* Compilación:  as -o HexadecimalDecimal.o HexadecimalDecimal.s
*               gcc -o HexadecimalDecimal HexadecimalDecimal.o
* Ejecución:    ./HexadecimalDecimal
*
* Código equivalente en C#:
* -----------------------------------------------------
*
* ASCIINEMA
* -----------------------------------------------------
* 
* -----------------------------------------------------

=========================================================*/

.section .data
    prompt:     .asciz "Ingrese un número hexadecimal (sin 0x): "
    buffer:     .skip 17     // Buffer para almacenar la entrada (16 caracteres + null)
    error_msg:  .asciz "Error: Entrada inválida\n"
    result_msg: .asciz "El número en decimal es: "
    newline:    .asciz "\n"
    dec_buffer: .skip 20     // Buffer para el resultado decimal

.section .text
.global _start

_start:
    // Imprimir prompt
    mov x0, #1              // stdout
    adr x1, prompt         // mensaje
    mov x2, #38            // longitud
    mov x8, #64            // syscall write
    svc #0

    // Leer entrada
    mov x0, #0              // stdin
    adr x1, buffer         // buffer
    mov x2, #17            // tamaño máximo
    mov x8, #63            // syscall read
    svc #0

    // Preparar conversión
    adr x19, buffer        // x19 = dirección del buffer
    mov x20, #0            // x20 = resultado
    mov x21, #0            // x21 = contador

convert_loop:
    ldrb w22, [x19, x21]   // Cargar byte
    cmp w22, #10           // Comprobar si es newline
    beq convert_to_ascii
    cmp w22, #0            // Comprobar si es null
    beq convert_to_ascii

    // Multiplicar resultado actual por 16
    lsl x20, x20, #4

    // Convertir carácter a valor
    cmp w22, #'0'
    blt error
    cmp w22, #'9'
    ble convert_digit

    // Si es a-f, convertir a A-F
    cmp w22, #'a'
    blt check_uppercase
    cmp w22, #'f'
    bgt error
    sub w22, w22, #32      // Convertir a-f a A-F
    
check_uppercase:
    cmp w22, #'A'
    blt error
    cmp w22, #'F'
    bgt error
    
    sub w22, w22, #'A'
    add w22, w22, #10
    b add_digit

convert_digit:
    sub w22, w22, #'0'

add_digit:
    add x20, x20, x22      // Añadir dígito al resultado
    add x21, x21, #1       // Incrementar contador
    b convert_loop

convert_to_ascii:
    // Imprimir mensaje de resultado
    mov x0, #1
    adr x1, result_msg
    mov x2, #23
    mov x8, #64
    svc #0

    // Convertir resultado a ASCII
    adr x19, dec_buffer    // Buffer para resultado
    add x19, x19, #19      // Comenzar desde el final
    mov x21, #10           // Divisor
    mov x22, x20           // Copiar número a convertir

convert_decimal:
    mov x20, x22
    udiv x22, x20, x21     // Dividir por 10
    msub x23, x22, x21, x20 // Obtener remainder (módulo)
    add w23, w23, #'0'     // Convertir a ASCII
    strb w23, [x19], #-1   // Guardar dígito y retroceder
    cmp x22, #0            // Si el cociente es 0, terminamos
    bne convert_decimal

    // Calcular longitud del número
    adr x19, dec_buffer
    add x19, x19, #1       // Ajustar puntero
    adr x20, dec_buffer
    add x20, x20, #19
    sub x2, x20, x19       // Longitud = fin - inicio

    // Imprimir número
    mov x0, #1             // stdout
    mov x1, x19            // buffer
    mov x8, #64            // syscall write
    svc #0

    // Imprimir newline
    mov x0, #1
    adr x1, newline
    mov x2, #1
    mov x8, #64
    svc #0

    // Salir normalmente
    mov x0, #0
    mov x8, #93            // syscall exit
    svc #0

error:
    // Imprimir mensaje de error
    mov x0, #1
    adr x1, error_msg
    mov x2, #21
    mov x8, #64
    svc #0
    
    // Salir con error
    mov x0, #1
    mov x8, #93
    svc #0
