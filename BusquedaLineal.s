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
* 
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

	
