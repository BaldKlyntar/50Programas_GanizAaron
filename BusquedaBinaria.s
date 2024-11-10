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
* 
* -----------------------------------------------------

=========================================================*/





	
