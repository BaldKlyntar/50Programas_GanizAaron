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

        msg_buscar: .asciz "Ingrese el elemento a buscar: \n"
        msg_encontrado: .asciz "Elemento encontrado\n"
        msg_noencontrado: .asciz "No se encontro el elemento\n"

        num_busca: .word 0
        format: .asciz "%d"
        numeros: .word 3, 5, 7, 11, 13
        imprimir_numeros: .asciz "Elementos del arreglo: [%d %d %d %d %d]\n"
        T: .word 5
        flag: .word 0
        Li: .word 0
        Lugar: .word 0

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

        ldr x0, =T
        ldr x1, [x0]

        mov x2, #1

        sub x3, x1, x2
        str x3, [Ls]

while_loop:

	ldr x0, =flag
        ldr x1, [x0]
        cmp x1, #1
        beq end_if

        ldr x0, =Li
        ldr x1, [x0]
        ldr x0, =Ls
        ldr x2, [x0]
        cmp x1, x2
        ble loop
        b end_if


loop:

        ldr x0, =Li
        ldr x1, [x0]
        ldr x0, =Ls
        ldr x2, [x0]

        add x3, x1, x2
        mov x10, #2
        sdiv x4, x3, x10

        str x4, [mitad]

        ldr x0, =mitad
        ldr x1, [x0]
        mov x23, #4
        mul x5, x1, x23

        ldr x15, [x28, x5]
        ldr x0, =num_busca
        ldr x16, [x0]
        cmp x15, x16
        beq if_flag
        b else_flag

if_flag:

        mov x1, #1
        str x1, [flag]
        ldr x0, =mitad
        ldr x1, [x0]
        str x1, [Lugar]
        b while_loop





else_flag:

        ldr x0, =busca
        ldr x1, [x0]

        ldr x0, =mitad
        ldr x1, [x0]
        mov x23, #4
        mul x5, x1, x23
        ldr x15, [x28, x5]
        cmp x1, x15
        bgt if_busca
        b else_busca


if_busca:

        ldr x0, =mitad
        ldr x2, [x0]

        mov x24, #1
        add x3, x24, x2
        str x3, [Li]
        b while_loop

else_busca:

        ldr x0, =mitad
        ldr x2, [x0]

        mov x24, #1
        sub x3, x24, x2
        str x3, [Ls]
        b while_loop

end_if:

        ldr x0, =flag
        ldr x1, [x0]

        mov x20, #1
        cmp x1, x20
        beq true
        b false

true:

        ldr x0, =msg_encontrado
        bl printf
        b end_code

false:


        ldr x0, =msg_noencontrado
        bl printf
        b end_code








end_code:

    // Salir del programa

    mov     x0, #0 // Código de estado 0 (indica éxito)
    mov     x8, #93 // Número de syscall para 'exit' (93 en ARM64)
    svc     0 // Se realiza la llamda al sistema





	
