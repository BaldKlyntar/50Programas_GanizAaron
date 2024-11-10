/*=======================================================
* Programa:       CelsiusaFarenheit.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que convierte temperatura
*              celsius a farenheit
*              
*              
* Compilación:  as -o CelsiusaFarenheit.o CelsiusaFarenheit.s
*               gcc -o CelsiusaFarenheit CelsiusaFarenheit.o
* Ejecución:    ./CelsiusaFarenheit
*
* Código equivalente en C#:
* -----------------------------------------------------
*            
*            
*
*            
*            
*            
*            
*
*
* ASCIINEMA
* -----------------------------------------------------
* 
* -----------------------------------------------------

=========================================================*/

.section .data
    format: .asciz "%d"               // Formato para leer un valor entero
    Celsius: .word 0                  // Almacenará el valor en Celsius
    Farenheit: .word 0                // Almacenará el valor convertido a Farenheit
    msg_Conversion: .asciz "Grados Farenheit = %d\n" // Mensaje de conversión
    msg_ingreso: .asciz "Ingrese un valor en Celsius: " // Mensaje para pedir la entrada
    msg_debug: .asciz "Valor de Celsius: %d\n" // Mensaje para depuración

.section .text
    .global main
    .extern printf
    .extern scanf

main:
    // Solicitar la entrada de Celsius
    ldr x0, =msg_ingreso            // Cargar la dirección del mensaje "Ingrese un valor en Celsius"
    bl printf                       // Llamar a printf para mostrar el mensaje

    // Leer el valor en Celsius
    ldr x0, =format                 // Cargar la dirección del formato "%d" (entero)
    ldr x1, =Celsius                // Cargar la dirección de la variable Celsius
    bl scanf                        // Llamar a scanf para leer el valor y almacenarlo en Celsius

    // Depuración: Mostrar el valor leído en Celsius
    ldr x0, =msg_debug              // Cargar el mensaje de depuración
    ldr x1, =Celsius                // Cargar la dirección de la variable Celsius
    ldr x1, [x1]                    // Cargar el valor de Celsius en x1
    bl printf                       // Llamar a printf para mostrar el valor de Celsius

    // Leer el valor de Celsius desde la memoria
    ldr x0, =Celsius                // Dirección de la variable Celsius
    ldr x1, [x0]                    // Cargar el valor de Celsius en x1

    // Constantes para la fórmula de conversión de Celsius a Fahrenheit
    mov x23, #9                     // x23 = 9
    mov x22, #5                     // x22 = 5
    mov x21, #32                    // x21 = 32

    // Realizar la multiplicación C * 9
    mul x10, x1, x23                // x10 = C * 9

    // Dividir por 5
    sdiv x11, x10, x22              // x11 = (C * 9) / 5

    // Sumar 32
    add x12, x11, x21               // x12 = (C * 9 / 5) + 32

    // Guardar el resultado de Fahrenheit en la variable Farenheit
    ldr x0, =Farenheit
    str x12, [x0]                   // Guardar el valor calculado en Farenheit

    // Depuración: Mostrar el valor de Fahrenheit calculado
    ldr x0, =msg_debug              // Cargar el mensaje de depuración
    ldr x1, =Farenheit              // Cargar la dirección de la variable Farenheit
    ldr x1, [x1]                    // Cargar el valor de Farenheit en x1
    bl printf                       // Llamar a printf para mostrar el valor de Farenheit

    // Imprimir el resultado
    ldr x0, =msg_Conversion         // Cargar la dirección del mensaje de conversión
    ldr x1, =Farenheit              // Cargar la dirección de la variable Farenheit
    ldr x1, [x1]                    // Cargar el valor de Farenheit en x1
    bl printf                       // Llamar a printf para imprimir el resultado

    // Salir del programa
    mov x0, #0                      // Código de estado 0 (indica éxito)
    mov x8, #93                     // Número de syscall para 'exit' (93 en ARM64)
    svc 0                            // Llamada al sistema para salir

