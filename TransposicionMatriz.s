/*=======================================================
* Programa:       TransposicionMatriz.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que realiza transposicion
*            de matrices
*              
*              
* Compilación:  as -o TransposicionMatriz.o TransposicionMatriz.s
*               gcc -o TransposicionMatriz TransposicionMatriz.o
* Ejecución:    ./TransposicionMatriz
*
* Código equivalente en C#:
* -----------------------------------------------------
*    static void Main()
*   {
*        int[,] matriz = {
*            {1, 2, 3},
*            {4, 5, 6},
*            {7, 8, 9}
*        };
*
*        int[,] transpuesta = new int[3, 3];
*
*        for (int i = 0; i < 3; i++)
*        {
*            for (int j = 0; j < 3; j++)
*            {
*                transpuesta[j, i] = matriz[i, j];
*            }
*        }
*
*        for (int i = 0; i < 3; i++)
*        {
*            for (int j = 0; j < 3; j++)
*            {
*                Console.Write(transpuesta[i, j] + " ");
*            }
*            Console.WriteLine();
*        }
*    }
*
* ASCIINEMA
* -----------------------------------------------------
*
* -----------------------------------------------------

=========================================================*/

	
