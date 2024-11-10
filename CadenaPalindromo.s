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
