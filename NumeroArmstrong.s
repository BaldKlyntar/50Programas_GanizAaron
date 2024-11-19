
/*=======================================================
* Programa:       NumeroArmstrong.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
*Descripción: Programa que identifica si
*             un valor es armstrong
*              
*              
* Compilación:  as -o NumeroArmstrong.o NumerosAleatorios.s
*               gcc -o NumeroArmstrong NumerosAleatorios.o
* Ejecución:    ./NumeroArmstrong
*
* Código equivalente en C#:
* -----------------------------------------------------
*
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/R2SbR6Ezm7fmJNAWQSYhqi5CH
* -----------------------------------------------------

=========================================================*/


.section .data
prompt:  .ascii "Ingrese un número: "
yes_msg: .ascii "Es un número de Armstrong\n"
no_msg:  .ascii "No es un número de Armstrong\n"

.section .bss
buffer:  .skip 12

.section .text
.global _start


_start:
    // Mostrar mensaje de entrada
    mov x0, #1              // fd = 1 (stdout)
    ldr x1, =prompt        // mensaje
    mov x2, #19           // longitud del mensaje
    mov x8, #64           // syscall write
    svc #0

    // Leer número
    mov x0, #0            // fd = 0 (stdin)
    ldr x1, =buffer       // buffer para input
    mov x2, #12          // tamaño máximo a leer
    mov x8, #63          // syscall read
    svc #0

    // Convertir string a número
    ldr x1, =buffer
    bl atoi               // Llamar función de conversión
    mov x19, x0          // Guardar número original en x19

    // Contar dígitos
    mov x20, x19         // Copiar número para contar dígitos
    mov x21, #0          // Contador de dígitos
    mov x24, #10         // Constante 10 para divisiones
count_digits:
    cbz x20, check_armstrong    // Si x20 = 0, terminar conteo
    udiv x20, x20, x24         // Dividir por 10
    add x21, x21, #1           // Incrementar contador
    b count_digits

check_armstrong:
    mov x20, x19             // Restaurar número original
    mov x22, #0              // Suma de potencias

process_digit:
    cbz x20, verify          // Si no hay más dígitos, verificar
    mov x23, x20             // Copiar número actual
    udiv x20, x20, x24       // Dividir por 10
    mul x25, x20, x24        // x25 = cociente * 10
    sub x23, x23, x25        // x23 = número - (cociente * 10) = último dígito
    
    // Calcular potencia (x23^x21)
    mov x25, #1              // Resultado de la potencia
    mov x26, x21             // Contador para potencia
power_loop:
    cbz x26, add_power
    mul x25, x25, x23        // Multiplicar por el dígito
    sub x26, x26, #1
    b power_loop

add_power:
    add x22, x22, x25        // Añadir a la suma total
    b process_digit

verify:
    cmp x19, x22             // Comparar número original con suma
    beq is_armstrong
    b not_armstrong

is_armstrong:
    mov x0, #1
    ldr x1, =yes_msg
    mov x2, #25
    mov x8, #64
    svc #0
    b exit

not_armstrong:
    mov x0, #1
    ldr x1, =no_msg
    mov x2, #27
    mov x8, #64
    svc #0

exit:
    mov x0, #0
    mov x8, #93
    svc #0

// Función para convertir ASCII a número
atoi:
    mov x0, #0              // Resultado
    mov x2, #10             // Base 10
atoi_loop:
    ldrb w3, [x1], #1      // Cargar siguiente carácter
    cmp w3, #0xa           // Verificar fin de línea
    beq atoi_done
    cmp w3, #0             // Verificar fin de string
    beq atoi_done
    sub w3, w3, #48        // Convertir ASCII a número
    mul x0, x0, x2         // Multiplicar resultado por 10
    add x0, x0, x3         // Añadir nuevo dígito
    b atoi_loop
atoi_done:
    ret

