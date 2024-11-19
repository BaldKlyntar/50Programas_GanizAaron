/*=======================================================
* Programa:       DecimalBinario.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa que resta
*              dos numeros ingresados por
*              el usuario.
*              
* Compilación:  as -o DecimalBinario.o DecimalBinario.s
*               gcc -o DecimalBinario DecimalBinario.o
* Ejecución:    ./DecimalBinario
*
* Código equivalente en C#:
* -----------------------------------------------------
*    static void Main()
*    {
*        int numeroDecimal = 15;
*        string numeroBinario = Convert.ToString(numeroDecimal, 2);
*        Console.WriteLine($"El número decimal {numeroDecimal} en binario es: {numeroBinario}");
*    }
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/9J0Lpu9QlDtlXGjJl6iWgdeFO
* -----------------------------------------------------

=========================================================*/


.section .data
    decimal: .word 13             // Número decimal a convertir
    bin_result: .space 33         // Espacio para el binario (32 bits + terminador nulo)
    fmt: .asciz "Binario: %s\n"   // Formato para printf

.section .text

    .global main
    .extern printf 
  
main:
    // Cargar el número decimal en el registro W0
    ldr x0, =decimal              // Cargar la dirección de la variable decimal
    ldr w0, [x0]                  // Cargar el valor decimal (32 bits)

    // Inicializar variables
    mov x1, #31                   // Índice para el bit más significativo (31)
    ldr x2, =bin_result           // Dirección del buffer para la cadena binaria

convert_loop:
    and w4, w0, #1                // Obtener el bit menos significativo
    add w4, w4, #48               // Convertirlo a ASCII ('0' o '1')
    strb w4, [x2, x1]             // Almacenar el carácter en la posición actual

    lsr w0, w0, #1                // Desplazar a la derecha (dividir por 2)
    subs x1, x1, #1               // Decrementar el índice
    bpl convert_loop              // Repetir mientras el índice sea >= 0

    // Añadir el terminador nulo
    mov w4, #0                    // Terminador nulo
    strb w4, [x2, #32]            // Guardar el terminador al final

    // Llamar a printf
    ldr x0, =fmt                  // Dirección de la cadena de formato
    ldr x1, =bin_result           // Dirección del resultado binario
    bl printf                     // Llamar a printf

     // Salir del programa
    
    mov     x0, #0 // Código de estado 0 (indica éxito)
    mov     x8, #93 // Número de syscall para 'exit' (93 en ARM64)
    svc     0 // Se realiza la llamda al sistema

