/*=======================================================
* Programa:       BusquedaBinaria.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que realiza el metodo
*              busqueda binaria
*              
*              
* Compilación:  as -o BusquedaBinaria.o BusquedaBinaria.s
*               gcc -o BusquedaBinaria BusquedaBinaria.o
* Ejecución:    ./BusquedaBinaria
*
* Código equivalente en C#:
* -----------------------------------------------------
*       public static void BusquedaBinaria(int[] numeros)
*       {
*
*          int T = numeros.Length;
*           int Lugar = 0;
*           int Li = 0;
*           int Ls = T - 1;
*           int Encontrado = 0;
*           bool flag = false;
*           int busca;
*           int mitad;
*
*           Console.WriteLine("Ingrese el elemento a buscar: ");
*           busca = int.Parse(Console.ReadLine());
*
*           while(Li <= Ls && flag != true)
*           {
*               mitad = (Li + Ls) / 2;
*
*               if (numeros[mitad] == busca)
*               {
*                   flag = true;
*                   Lugar = mitad;
*               }
*               else
*               {
*                   if (busca > numeros[mitad])
*                   {
*                       Li = mitad + 1;
*                   }
*                   else
*                   {
*                       Ls = mitad - 1;
*                   }
*               }
*           }
*
*           if(flag == true)
*           {
*               Console.WriteLine("Elemento {0} encontrado en la posicion {1}", busca, Lugar);
*           }
*           else
*           {
*               Console.WriteLine("No se encontro el elemento");
*           }
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/pslGFewSYfYlyeuj8kRzIc7l6
* -----------------------------------------------------

=========================================================*/

.section .data

        msg_buscar: .asciz "Ingrese el elemento a buscar: \n"      // Mensaje que indica al usuario que ingrese un número a buscar
        msg_encontrado: .asciz "Elemento encontrado\n"             // Mensaje cuando el elemento es encontrado
        msg_noencontrado: .asciz "No se encontro el elemento\n"    // Mensaje cuando el elemento no se encuentra

        num_busca: .word 0                                         // Espacio para almacenar el número ingresado por el usuario
        format: .asciz "%d"                                         // Formato para leer números enteros
        numeros: .word 3, 5, 7, 11, 13                              // Arreglo de números a buscar
        imprimir_numeros: .asciz "Elementos del arreglo: [%d %d %d %d %d]\n"  // Mensaje para imprimir los números del arreglo
        T: .word 5                                                  // Tamaño del arreglo
        flag: .word 0                                               // Bandera para determinar si el número ha sido encontrado
        Li: .word 0                                                 // Límite inferior para la búsqueda binaria
        Lugar: .word 0                                              // Lugar donde se encuentra el número (si se encuentra)
        
.section .bss

        Ls: .space 4                                                // Espacio para almacenar el límite superior en la búsqueda binaria
        busca: .space 4                                             // Espacio para almacenar el número a buscar
        mitad: .space 4                                             // Espacio para almacenar la mitad en la búsqueda binaria

.section .text

    .global main
    .extern printf
    .extern scanf

main:
    // Imprimir el arreglo de números
    ldr x0, =imprimir_numeros    // Cargar la dirección del mensaje
    ldr x28, =numeros             // Cargar la dirección de los números
    ldr x1, [x28]
    ldr x2, [x28, #4]
    ldr x3, [x28, #8]
    ldr x4, [x28, #12]
    ldr x5, [x28, #16]
    bl printf                    // Imprimir los números en el arreglo

    // Solicitar al usuario que ingrese el número a buscar
    ldr x0, =msg_buscar
    bl printf
    adr x0, format
    adr x1, num_busca
    bl scanf                     // Leer el número ingresado por el usuario

    ldr x0, =T
    ldr x1, [x0]

    mov x2, #1

    sub x3, x1, x2
    str x3, [Ls]                 // Establecer el límite superior

while_loop:
    ldr x0, =flag                // Comprobar si el número ha sido encontrado
    ldr x1, [x0]
    cmp x1, #1
    beq end_if                   // Si encontrado, salir del ciclo

    ldr x0, =Li
    ldr x1, [x0]
    ldr x0, =Ls
    ldr x2, [x0]
    cmp x1, x2
    ble loop                     // Si el límite inferior es mayor que el superior, salir

    b end_if

loop:
    ldr x0, =Li                  // Cargar el límite inferior
    ldr x1, [x0]
    ldr x0, =Ls                  // Cargar el límite superior
    ldr x2, [x0]

    add x3, x1, x2
    mov x10, #2
    sdiv x4, x3, x10             // Calcular la mitad del rango

    str x4, [mitad]              // Almacenar la mitad

    ldr x0, =mitad
    ldr x1, [x0]
    mov x23, #4
    mul x5, x1, x23              // Multiplicar por 4 (desplazamiento en el arreglo)

    ldr x15, [x28, x5]           // Cargar el valor del arreglo en la mitad calculada
    ldr x0, =num_busca
    ldr x16, [x0]
    cmp x15, x16                 // Comparar el número de la mitad con el número a buscar
    beq if_flag                  // Si son iguales, marcar el número como encontrado
    b else_flag                  // Sino, continuar con la búsqueda

if_flag:
    mov x1, #1                   // Establecer la bandera de encontrado
    str x1, [flag]
    ldr x0, =mitad
    ldr x1, [x0]
    str x1, [Lugar]              // Almacenar el lugar donde se encontró el número
    b while_loop                 // Volver al ciclo de búsqueda

else_flag:
    ldr x0, =busca
    ldr x1, [x0]

    ldr x0, =mitad
    ldr x1, [x0]
    mov x23, #4
    mul x5, x1, x23              // Multiplicar por 4 (desplazamiento en el arreglo)
    ldr x15, [x28, x5]           // Cargar el valor de la mitad
    cmp x1, x15
    bgt if_busca                 // Si el número en la mitad es mayor, ajustar el límite inferior
    b else_busca                 // Sino, ajustar el límite superior

if_busca:
    ldr x0, =mitad
    ldr x2, [x0]

    mov x24, #1
    add x3, x24, x2
    str x3, [Li]                 // Actualizar el límite inferior
    b while_loop                 // Volver al ciclo de búsqueda

else_busca:
    ldr x0, =mitad
    ldr x2, [x0]

    mov x24, #1
    sub x3, x24, x2
    str x3, [Ls]                 // Actualizar el límite superior
    b while_loop                 // Volver al ciclo de búsqueda

end_if:
    ldr x0, =flag
    ldr x1, [x0]

    mov x20, #1
    cmp x1, x20
    beq true                     // Si se encontró, imprimir mensaje de éxito
    b false                      // Sino, imprimir mensaje de error

true:
    ldr x0, =msg_encontrado
    bl printf                    // Imprimir mensaje de encontrado
    b end_code                   // Terminar el programa

false:
    ldr x0, =msg_noencontrado
    bl printf                    // Imprimir mensaje de no encontrado
    b end_code                   // Terminar el programa

end_code:
    mov x0, #0                   // Código de salida 0
    mov x8, #93                  // Número de syscall para 'exit'
    svc #0                        // Llamar al sistema operativo para terminar





	
