/*=======================================================
* Programa:     SumadosNumeros.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa que suma
*              dos numeros ingresados por
*              el usuario.
*              
* Compilación:  as -o SumadosNumeros.o SumadosNumeros.s
*               gcc -o SumadosNumeros SumadosNumeros.o
* Ejecución:    ./SumadosNumeros
*
* Código equivalente en C#:
* -----------------------------------------------------
*            Console.WriteLine("Ingrese el primer valor");
*            float x = float.Parse(Console.ReadLine());
*
*            Console.WriteLine("Ingrese el segundo valor");
*            float y = float.Parse(Console.ReadLine());
*
*            float suma = x + y;
*       
*        
*            
*
*            Console.WriteLine("La suma es: {0}", suma);
*           
*            
*            
*
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/2LgElflbwO28ipuOkZ8N2gb4s
* -----------------------------------------------------

=========================================================*/

// Seccion de datos, aqui se declaran las variables que se
// almacenaran en memoria de manera estatica

.section .data

    num1:    .quad 0  // num1 almacenara el primero valor ingresado por el usuario
    num2:    .quad 0 // num2 almacenara el segundo valor ingresado por el usuario
    msg_sum: .asciz "La suma es: %lld\n" // Imprimira la cadena de caracteres para el resultado de la suma
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

    // Suma
    
    ldr     x0, =num1 // Se carga en el registro x0 la direccion de memoria en la que se encuentra num1
    ldr     x1, [x0] // Se carga en el registro x0 el valor de la variable de num1
    ldr     x0, =num2 // Se carga en el registro x0 la direccion de memoria en la que se encuentra num2
    ldr     x2, [x0] // Se carga en el registro x0 el valor de la variable de num2
    add     x3, x1, x2 // Se suman los valores cargados en x1 y x2, almacenando el resultado en el registro x3
    adr     x0, msg_sum // Se guarda la direccion de msg_sum en el registro x0
    mov     x1, x3 // Se mueve el resultado de la suma almacenado en x3 al registro x1
    bl      printf // Se llama a la funcion externa printf para imprimir la cadena msg_suma con el resultado de la suma


  

    // Salir del programa
    
    mov     x0, #0 // Código de estado 0 (indica éxito)
    mov     x8, #93 // Número de syscall para 'exit' (93 en ARM64)
    svc     0 // Se realiza la llamda al sistema
