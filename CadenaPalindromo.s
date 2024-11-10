/*=======================================================
* Programa:       CadenaPalindromo.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que verifica si una cadena
*              es un palindromo
*              
*              
* Compilación:  as -o CadenaPalindromo.o CadenaPalindromo.s
*               gcc -o CadenaPalindromo CadenaPalindromo.o
* Ejecución:    ./CadenaPalindromo
*
* Código equivalente en C#:
* -----------------------------------------------------
*   public static void Palindromo(string str)
    {
        int izq = 0;
        int der = str.Length - 1;

        while (izq < der)
        {
            if (str[izq] != str[der])
            {
                Console.WriteLine("La cadena no es un palíndromo.");
                return;
            }
            izq++;
            der--;
        }

        Console.WriteLine("La cadena es un palíndromo."); 
    }       
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

    izq: .word 0
    der: .word 0
    msg_true: .asciz "La palabra es un palindromo\n"
    msg_false: .asciz "La palabra no es un palindromo\n"
    format: .asciz "%s"
    palabra: .asciz ""
    msg_ingreso: .asciz "Ingrese una palabra: "

.section .text

    .global main
    .extern printf
    .extern scanf

main:

    ldr x0, =msg_ingreso
    bl printf

    adr x0, format
    adr x1, palabra
    bl scanf



    
