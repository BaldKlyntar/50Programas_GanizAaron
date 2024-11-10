/*=======================================================
* Programa:       DivisiondosNumeros.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que divide
*              dos numeros ingresados por
*              el usuario.
*              
* Compilación:  as -o DivisiondosNumeros.o DivisiondosNumeros.s
*               gcc -o DivisiondosNumeros DivisiondosNumeros.o
* Ejecución:    ./DivisiondosNumeros
*
* Código equivalente en C#:
* -----------------------------------------------------
*            Console.WriteLine("Ingrese el primer valor");
*            float x = float.Parse(Console.ReadLine());
*
*            Console.WriteLine("Ingrese el segundo valor");
*            float y = float.Parse(Console.ReadLine());
*            float resta = x / y;
*            Console.WriteLine("La division es: {0}", resta);
*
*
* ASCIINEMA
* -----------------------------------------------------
* 
* -----------------------------------------------------

=========================================================*/

.section .data

    num1:    .quad 0  // num1 almacenara el primero valor ingresado por el usuario
    num2:    .quad 0 // num2 almacenara el segundo valor ingresado por el usuario
    msg_div: .asciz "La division es: %lld\n" // Imprimira la cadena de caracteres para el resultado de la division
    format:  .asciz "%lld" // Indica el tipo de formato que recibira la funcion scanf de la libreria c
    msgin: .asciz "Ingresa un valor: " // Cadena para indicar al usuario cuando debe ingresar un valor
    


.section .text

    .global main // Se declara main como global, dando acceso a librerias externas
    .extern printf // Se declara printf, funcion para imprimir cadenas de caracteres como funcion externa
    .extern scanf // Se declara scanf como funcion externa, se utiliza para leer valores de entrada del usuario

main:

    // Lectura del primer numero
    
    ldr x0, =msgin // Se carga la direccion de memoria de la variable msgin en x0
    bl      printf // se llama a la funcion printf para imprimir la cadena de caracteres de msgin
    adr     x0, format // Se guarda en el registro 0 la direccion de la variable format
    adr     x1, num1 // Se guarda en el registro x1 la direccion de la variable num1
    bl      scanf // Se llama a la funcion scanf

    // Lectura del segundo numero
    
    ldr x0, =msgin
    bl      printf
    adr     x0, format
    adr     x1, num2 // Se guarda en el registro x1 la direccion de la variable num2
    bl      scanf


    // División
    
    ldr     x0, =num1
    ldr     x1, [x0]
    ldr     x0, =num2
    ldr     x2, [x0]
    sdiv    x3, x1, x2
    adr     x0, msg_div // Se dividen los valores cargados en x1 y x2, el resultado se almacena en el registro x3
    mov     x1, x3
    bl      printf

    // Salir del programa
    
    mov     x0, #0 // Código de estado 0 (indica éxito)
    mov     x8, #93 // Número de syscall para 'exit' (93 en ARM64)
    svc     0 // Se realiza la llamda al sistema
