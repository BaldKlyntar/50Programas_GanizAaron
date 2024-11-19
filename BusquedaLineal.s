/*=======================================================
* Programa:       BusquedaLineal.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que realiza el metodo
*             busqueda lineal
*              
*              
* Compilación:  as -o BusquedaLineal.o BusquedaLineal.s
*               gcc -o BusquedaLineal BusquedaLineal.o
* Ejecución:    ./BusquedaLineal
*
* Código equivalente en C#:
* -----------------------------------------------------
*
* public static void BusquedaSecuencial_Simple(int[] numeros)
* {
*     int pos = 0;
*     bool flag = false;
*     int busca;
*     int T = numeros.Length;
*
*     Console.WriteLine("Ingrese el elemento a buscar: ");
*     busca = int.Parse(Console.ReadLine());
*
*     while(pos < T)
*     {
*         if (numeros[pos] == busca)
*         {
*             flag = true;
*             Console.WriteLine("Elemento {0} encontrado en la posicion {1}", busca, pos);
*
*         }
*
*         pos++;
*     }
*
*     if(flag == false)
*     {
*         Console.WriteLine("El elemento no se ha encontrado");
*     }
*
*
*    
*
*
*     }
*
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/yibv25UD9rhJM3WZusRLRSkXK
* -----------------------------------------------------

=========================================================*/

.section .data

        msg_buscar: .asciz "Ingrese el elemento a buscar: \n"   // Mensaje para pedir al usuario que ingrese el número a buscar
        msg_encontrado: .asciz "Elemento encontrado\n"            // Mensaje cuando el número se encuentra
        msg_noencontrado: .asciz "No se encontro el elemento\n"   // Mensaje cuando el número no se encuentra

        num_busca: .word 0      // Variable para almacenar el número que el usuario quiere buscar
        format: .asciz "%d"     // Formato para leer un número entero
        numeros: .word 3, 5, 7, 11, 13  // El arreglo de números donde se realizará la búsqueda
        imprimir_numeros: .asciz "Elementos del arreglo: [%d %d %d %d %d]\n" // Mensaje para imprimir los números del arreglo
        pos: .word 0    // Posición inicial del arreglo que se está evaluando
        flag: .word 0   // Bandera que indica si el número ha sido encontrado (1) o no (0)
        busca: .word 0  // Variable que almacena el número ingresado por el usuario
        T: .word 5      // Tamaño del arreglo (número de elementos)

.section .bss

        Ls: .space 4     // Espacio para la variable Ls (parece ser utilizada para los límites de la búsqueda)
        busca: .space 4  // Espacio para la variable 'busca' (número que se busca)
        mitad: .space 4  // Espacio para la variable 'mitad' (aunque no se usa en el código actual)

.section .text

        .global main      // Definición del punto de entrada del programa
        .extern printf    // Declaración externa de la función printf
        .extern scanf     // Declaración externa de la función scanf

main:

        // Imprime los números del arreglo
        ldr x0, =imprimir_numeros    // Cargar la dirección del mensaje
        ldr x28, =numeros             // Cargar la dirección del arreglo de números
        ldr x1, [x28]
        ldr x2, [x28, #4]
        ldr x3, [x28, #8]
        ldr x4, [x28, #12]
        ldr x5, [x28, #16]
        bl printf                   // Llamar a printf para imprimir los números

        // Solicitar al usuario que ingrese un número para buscar
        ldr x0, =msg_buscar
        bl printf
        adr x0, format
        adr x1, num_busca
        bl scanf                    // Llamar a scanf para leer el número ingresado

        b while_loop                // Ir al bucle de búsqueda

while_loop:

        // Verificar si la posición actual ha alcanzado el tamaño del arreglo
        ldr x0, =pos
        ldr x1, [x0]

        ldr x0, =T
        ldr x2, [x0]

        cmp x1, x2                // Comparar la posición con el tamaño del arreglo
        blt if_flag                // Si la posición es menor que el tamaño, continuar con la búsqueda
        b end_loop                 // Si se ha llegado al final, salir del bucle

if_flag:

        // Realizar la búsqueda secuencial
        ldr x28, =numeros          // Cargar la dirección del arreglo de números
        ldr x0, =pos
        ldr x1, [x0]               // Cargar la posición actual
        ldr x0, =busca
        ldr x2, [x0]               // Cargar el número a buscar

        mul x5, x1, #4             // Multiplicar la posición por 4 (tamaño de cada entero)
        ldr x6, [x28, x5]          // Cargar el número en la posición correspondiente del arreglo
        cmp x6, x2                 // Comparar el número del arreglo con el número a buscar
        beq flag_find              // Si son iguales, el número ha sido encontrado
        b flag_plus                // Si no son iguales, continuar con la siguiente posición

flag_find:

        mov x5, #1                 // Establecer la bandera en 1 (encontrado)
        ldr x0, =flag
        str x5, [x0]

        ldr x0, =msg_encontrado    // Mostrar mensaje de "Elemento encontrado"
        bl printf
        b flag_plus                // Continuar con la siguiente iteración

flag_plus:

        // Incrementar la posición y continuar la búsqueda
        ldr x0, =pos
        ldr x1, [x0]
        add x2, x1, #1             // Incrementar la posición
        str x2, [x0]               // Almacenar la nueva posición
        b while_loop               // Continuar el bucle

end_loop:

        // Verificar si el número fue encontrado
        ldr x0, =flag
        ldr x1, [x0]
        cmp x1, #0                 // Si flag es 0, no se encontró el número
        beq flag_lost              // Si no se encontró, ir a mostrar "No encontrado"
        b end_code                 // Si se encontró, salir del programa

flag_lost:

        ldr x0, =msg_noencontrado  // Mostrar mensaje de "Elemento no encontrado"
        bl printf

end_code:

        // Terminar el programa
        mov     x0, #0              // Código de estado 0 (indica éxito)
        mov     x8, #93             // Número de syscall para 'exit' (93 en ARM64)
        svc     0                   // Llamar al sistema para terminar el programa

 

 	

	
