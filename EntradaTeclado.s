/*=======================================================
* Programa:       EntradaTeclado.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que lee
*              una entrada desde el teclado
*             
*              
* Compilación:  as -o EntradaTeclado.o EntradaTeclado.s
*               gcc -o EntradaTeclado EntradaTeclado.o
* Ejecución:    ./EntradaTeclado
*
* Código equivalente en C#:
* -----------------------------------------------------
*            Console.WriteLine("Ingrese una cadena de caracteres");
*            string palabra = Console.ReadLine();
*            Console.WriteLine(palabra)
*
*
* ASCIINEMA
* -----------------------------------------------------
* 
* -----------------------------------------------------

=========================================================*/


.section .data
    format: .asciz "%s"
    palabra: .space 100             // Espacio para 100 caracteres
    msg_prueba: .asciz "La palabra ingresada es: %s\n"
    msg_ingreso: .asciz "Ingrese una palabra: "

.section .text

    .global main
    .extern printf
    .extern scanf

main:
    // Solicitar la entrada del usuario
    ldr x0, =msg_ingreso
    bl printf

    // Leer la cadena y almacenarla en 'palabra'
    ldr x0, =format
    ldr x1, =palabra
    bl scanf

    // Imprimir la cadena ingresada
    ldr x0, =msg_prueba
    ldr x1, =palabra
    bl printf

    // Salir del programa

    mov     x0, #0 // Código de estado 0 (indica éxito)
    mov     x8, #93 // Número de syscall para 'exit' (93 en ARM64)
    svc     0 // Se realiza la llamda al sistema


