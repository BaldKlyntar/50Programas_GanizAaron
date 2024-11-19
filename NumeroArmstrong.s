/*=======================================================
* Programa:       NumeroArmstrong.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
* Descripción: Programa que divide
*              dos numeros ingresados por
*              el usuario.
*              
* Compilación:  as -o NumeroArmstrong.o NumeroArmstrong.s
*               gcc -o NumeroArmstrong NumeroArmstrong.o
* Ejecución:    ./NumeroArmstrong
*
* Código equivalente en C#:
* -----------------------------------------------------
*    static void Main()
*   {
*        Console.Write("Ingrese un número: ");
*        int num = int.Parse(Console.ReadLine());
*        int temp = num, suma = 0;
*        int longitud = num.ToString().Length;
*
*        while (temp > 0)
*        {
*            int digito = temp % 10;
*           suma += (int)Math.Pow(digito, longitud);
*            temp /= 10;
*        }
*
*        if (suma == num)
*            Console.WriteLine($"{num} es un número Armstrong.");
*        else
*            Console.WriteLine($"{num} no es un número Armstrong.");
*    }
*
* ASCIINEMA
* -----------------------------------------------------
* 
* -----------------------------------------------------

=========================================================*/



