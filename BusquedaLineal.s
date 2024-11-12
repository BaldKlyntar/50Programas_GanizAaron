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

        msg_buscar: .asciz "Ingrese el elemento a buscar: \n"
        msg_encontrado: .asciz "Elemento encontrado\n"
        msg_noencontrado: .asciz "No se encontro el elemento\n"

        num_busca: .word 0
        format: .asciz "%d"
        numeros: .word 3, 5, 7, 11, 13
        imprimir_numeros: .asciz "Elementos del arreglo: [%d %d %d %d %d]\n"
	pos: .word 0
 	flag: .word 0
  	busca: .word 0
   	T: .word 5
    	

.section .bss

        Ls: .space 4
        busca: .space 4
        mitad: .space 4

.section .text

        .global main
        .extern printf
        .extern scanf


 main:

        ldr x0, =imprimir_numeros    // Cargar la dirección del mensaje
        ldr x28, =numeros             // Cargar la dirección de los números
        ldr x1, [x28]
        ldr x2, [x28, #4]
        ldr x3, [x28, #8]
        ldr x4, [x28, #12]
        ldr x5, [x28, #16]
        bl printf

        ldr x0, =msg_buscar
        bl printf
        adr x0, format
        adr x1, num_busca
        bl scanf
	        b while_loop

while_loop:

        ldr x0, =pos
        ldr x1, [x0]

        ldr x0, =T
        ldr x2, [x0]

        cmp x1, x2
        blt if_flag
        b end_loop

if_flag:

        ldr x28, =numeros
        ldr x0, =pos
        ldr x1, [x0]
        ldr x0, =busca
        ldr x2, [x0]

        mul x5, x1, #4
        ldr x6, [x28, x5]
	cmp x6, x2
        beq flag_find
        b flag_plus

flag_find:

        mov x5, #1
        ldr x0, =flag
        str x5, [x0]

        ldr x0, =msg_encontrado
        bl printf
        b flag_plus


flag_plus:

        ldr x0, =pos
        ldr x1, [x0]
        add x2, x1, #1
        str x2, [x0]

        b while_loop

 end_loop:

        ldr x0, =flag
        ldr x1, [x0]
        cmp x1, #0
        beq flag_lost
        b end_code

flag_lost:

        ldr x0, =msg_noencontrado
        bl printf

end_code:

    mov     x0, #0 // Código de estado 0 (indica éxito)
    mov     x8, #93 // Número de syscall para 'exit' (93 en ARM64)
    svc     0 // Se realiza la llamda al sistema

 

 	

	
