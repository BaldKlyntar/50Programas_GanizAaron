/*=======================================================
* Programa:       MultiplicacionMatriz.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa realiza multiplicacion
*            de matrices
*              
*              
* Compilación:  as -o MultiplicacionMatriz.o MultiplicacionMatriz.s
*               gcc -o MultiplicacionMatriz MultiplicacionMatriz.o
* Ejecución:    ./MultiplicacionMatriz
*
* Código equivalente en C#:
* -----------------------------------------------------
*    static void Main()
*   {
*        int[,] matriz1 = {
*            {1, 2, 3},
*            {4, 5, 6}
*        };
*
*        int[,] matriz2 = {
*            {7, 8},
*            {9, 10},
*            {11, 12}
*        };
*
*        int[,] resultado = new int[2, 2];
*
*        for (int i = 0; i < 2; i++)
*        {
*            for (int j = 0; j < 2; j++)
*            {
*                resultado[i, j] = 0;
*                for (int k = 0; k < 3; k++)
*                {
*                    resultado[i, j] += matriz1[i, k] * matriz2[k, j];
*                }
*            }
*        }
*
*        for (int i = 0; i < 2; i++)
*        {
*            for (int j = 0; j < 2; j++)
*            {
*                Console.Write(resultado[i, j] + " ");
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

	
