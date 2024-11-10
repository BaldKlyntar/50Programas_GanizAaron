/*=======================================================
* Programa:       SumaMatrices.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa para la suma de
*              matrices
*             
*              
* Compilación:  as -o SumaMatrices.o SumaMatrices.s
*               gcc -o SumaMatrices SumaMatrices.o
* Ejecución:    ./SumaMatrices
*
* Código equivalente en C#:
* -----------------------------------------------------
*	static void Main()
*    {
*        int[,] matriz1 = {
*            {1, 2, 3},
*            {4, 5, 6},
*            {7, 8, 9}
*        };
*
*        int[,] matriz2 = {
*            {9, 8, 7},
*            {6, 5, 4},
*            {3, 2, 1}
*        };
*
*        int[,] resultado = new int[3, 3];
*
*        for (int i = 0; i < 3; i++)
*        {
*            for (int j = 0; j < 3; j++)
*            {
*                resultado[i, j] = matriz1[i, j] + matriz2[i, j];
*            }
*        }
*
*        for (int i = 0; i < 3; i++)
*       {
*            for (int j = 0; j < 3; j++)
*            {
*                Console.Write(resultado[i, j] + " ");
*           }
*            Console.WriteLine();
*        }
*    }
*
* ASCIINEMA
* -----------------------------------------------------
* 
* -----------------------------------------------------

=========================================================*/

	
