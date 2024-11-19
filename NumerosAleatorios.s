/*=======================================================
* Programa:       NumerosAleatorios.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa que resta
*              dos numeros ingresados por
*              el usuario.
*              
* Compilación:  as -o NumerosAleatorios.o NumerosAleatorios.s
*               gcc -o NumerosAleatorios NumerosAleatorios.o
* Ejecución:    ./NumerosAleatorios
*
* Código equivalente en C#:
* -----------------------------------------------------
*    static void Main()
*    {
*        int seed = 12345;
*        Random random = new Random(seed);
*        int randomNumber1 = random.Next(1, 101);
*        int randomNumber2 = random.Next(1, 101);
*        int randomNumber3 = random.Next(1, 101);
*        Console.WriteLine($"Números aleatorios: {randomNumber1}, {randomNumber2}, {randomNumber3}");
*    }
*
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/R2SbR6Ezm7fmJNAWQSYhqi5CH
* -----------------------------------------------------

=========================================================*/
.section .data
    seed:       .word 12345                  // Inicialización de la semilla para el generador de números aleatorios
    rand_val1:  .word 0                      // Espacio reservado para el primer número aleatorio
    rand_val2:  .word 0                      // Espacio reservado para el segundo número aleatorio
    rand_val3:  .word 0                      // Espacio reservado para el tercer número aleatorio
    msg_output: .asciz "Números aleatorios: %d, %d, %d\n"  // Mensaje de salida con formato para `printf`

.section .text
    .global main                             // Declaración global para la función `main`
    .global rand_with_seed                   // Declaración global para la función `rand_with_seed`
    .extern printf                           // Declaración de que `printf` es una función externa (de la biblioteca estándar)

main:
    // Cargar la semilla inicial desde la memoria
    adrp x0, seed              // Carga la página base de la variable `seed` en el registro x0
    add x0, x0, :lo12:seed     // Agrega el offset para obtener la dirección completa de `seed`
    ldr w1, [x0]               // Carga el valor de `seed` en el registro w1

    // Generar el primer número aleatorio
    mov w2, w1                 // Copia la semilla inicial en w2 para pasarla como argumento a `rand_with_seed`
    bl rand_with_seed          // Llama a la función `rand_with_seed`
    adrp x0, rand_val1         // Carga la página base de `rand_val1` en x0
    add x0, x0, :lo12:rand_val1 // Agrega el offset para obtener la dirección completa de `rand_val1`
    str w0, [x0]               // Almacena el resultado de `rand_with_seed` (en w0) en `rand_val1`

    // Generar el segundo número aleatorio
    mov w2, w0                 // Usa el resultado del primer número como nueva semilla
    bl rand_with_seed          // Llama nuevamente a `rand_with_seed`
    adrp x0, rand_val2         // Carga la página base de `rand_val2` en x0
    add x0, x0, :lo12:rand_val2 // Agrega el offset para obtener la dirección completa de `rand_val2`
    str w0, [x0]               // Almacena el resultado en `rand_val2`

    // Generar el tercer número aleatorio
    mov w2, w0                 // Usa el resultado del segundo número como nueva semilla
    bl rand_with_seed          // Llama nuevamente a `rand_with_seed`
    adrp x0, rand_val3         // Carga la página base de `rand_val3` en x0
    add x0, x0, :lo12:rand_val3 // Agrega el offset para obtener la dirección completa de `rand_val3`
    str w0, [x0]               // Almacena el resultado en `rand_val3`

    // Preparar los valores para imprimir con `printf`
    adrp x0, msg_output        // Carga la página base de `msg_output` en x0
    add x0, x0, :lo12:msg_output // Agrega el offset para obtener la dirección completa de `msg_output`
    adrp x1, rand_val1         // Carga la página base de `rand_val1` en x1
    add x1, x1, :lo12:rand_val1 // Agrega el offset para obtener la dirección completa de `rand_val1`
    ldr w1, [x1]               // Carga el valor de `rand_val1` en w1
    adrp x2, rand_val2         // Carga la página base de `rand_val2` en x2
    add x2, x2, :lo12:rand_val2 // Agrega el offset para obtener la dirección completa de `rand_val2`
    ldr w2, [x2]               // Carga el valor de `rand_val2` en w2
    adrp x3, rand_val3         // Carga la página base de `rand_val3` en x3
    add x3, x3, :lo12:rand_val3 // Agrega el offset para obtener la dirección completa de `rand_val3`
    ldr w3, [x3]               // Carga el valor de `rand_val3` en w3
    bl printf                  // Llama a `printf` para imprimir el mensaje y los valores

    // Salir del programa
    mov x0, #0                 // Código de salida 0
    mov x8, #93                // Número de syscall para `exit`
    svc 0                      // Llamada al sistema para salir del programa

rand_with_seed:
    // Generador de números pseudoaleatorios basado en congruencias lineales
    movz w3, #5245             // Multiplicador de congruencia (valor bajo)
    movk w3, #16843, lsl #16   // Multiplicador de congruencia (valor alto)
    mov w4, #12345             // Incremento de congruencia
    mul w0, w2, w3             // Multiplica la semilla por el multiplicador
    add w0, w0, w4             // Suma el incremento
    and w0, w0, #0x7FFFFFFF    // Aplica una máscara para limitar a 31 bits
    mov w3, #100               // Valor límite para el rango aleatorio (100)
    udiv w0, w0, w3            // Divide para reducir el valor al rango deseado (0-99)
    add w0, w0, #1             // Ajusta el rango a 1-100
    ret                        // Retorna el número generado
