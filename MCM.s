/*=======================================================
* Programa:       MCM.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que calcula el minimo
*              comun multiplo
*
* Compilación:  as -o MCM.o MCM.s
*               gcc -o MCM MCM.o
* Ejecución:    ./MCM
*
* Código equivalente en C#:
* -----------------------------------------------------
*      static void Main()
*    {
*        int a, b;
*        a = 56;
*        b = 98;
*
*        int mcd = a, tempA = a, tempB = b;
*
*        while (tempA != tempB)
*        {
*            if (tempA > tempB)
*                tempA = tempA - tempB;
*            else
*                tempB = tempB - tempA;
*        }
*
*        mcd = tempA;
*
*        int mcm = (a * b) / mcd;
*
*        Console.WriteLine("El MCM es: " + mcm);
*    }
*
* ASCIINEMA
* -----------------------------------------------------
*
* -----------------------------------------------------

=========================================================*/
