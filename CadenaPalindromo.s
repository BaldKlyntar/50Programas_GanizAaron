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
* https://asciinema.org/a/XADrJh0uPIATgdfy0gXRoonHP
* -----------------------------------------------------

=========================================================*/


.section .data
    izq: .word 0                    // Índice izquierdo (inicio de la cadena)
    der: .word 0                    // Índice derecho (final de la cadena)
    msg_true: .asciz "La palabra es un palindromo\n"
    msg_false: .asciz "La palabra no es un palindromo\n"
    format: .asciz "%s"
    palabra: .space 100             // Espacio para 100 caracteres
    msg_prueba: .asciz "La palabra ingresada es: %s\n"
    msg_ingreso: .asciz "Ingrese una palabra: "

.section .text

    .global main
    .extern printf
    .extern scanf

main:
    // Solicitar la entrada del usuario
    ldr x0, =msg_ingreso
    bl printf

    // Leer la cadena y almacenarla en 'palabra'
    ldr x0, =format
    ldr x1, =palabra
    bl scanf

    // Imprimir la cadena ingresada
    ldr x0, =msg_prueba
    ldr x1, =palabra
    bl printf

    // Calcular la longitud de 'palabra'
    ldr x0, =palabra  // Dirección de inicio de 'palabra'
    mov x1, #0        // Contador de tamaño inicializado a 0

count_loop:
    ldrb w2, [x0, x1]        // Cargar un byte desde palabra[x1]
    cbz w2, end_count        // Si el byte es 0, fin de la cadena
    add x1, x1, #1           // Incrementar el contador
    b count_loop             // Repetir el ciclo

end_count:
    // Guardar el tamaño de la cadena en 'der' (derecha)
    ldr x3, =der
    str w1, [x3]  // Almacenar el tamaño (longitud) de la palabra

    // Inicializamos 'izq' y 'der'
    mov x4, #0      // Inicializar 'izq' a 0 (primer índice)
    ldr x3, =der
    ldr w5, [x3]    // Cargar la longitud de la palabra en 'der'
    sub x5, x5, #1  // Ajustar 'der' al último índice de la cadena

    ldr x6, =izq
    str w4, [x6]    // Guardar 'izq' en memoria

    ldr x7, =der
    str w5, [x7]    // Guardar 'der' en memoria

    // Comenzamos la comparación de extremos hacia el centro
compare_loop:
    ldr x0, =izq
    ldr w1, [x0]        // Cargar 'izq' (índice izquierdo)
    ldr x2, =palabra
    uxtw x3, w1         // Extender 'w1' a 64 bits
    add x3, x2, x3      // Dirección de palabra[izq]
    ldrb w3, [x3]       // Cargar palabra[izq] (carácter izquierdo)

    ldr x0, =der
    ldr w1, [x0]        // Cargar 'der' (índice derecho)
    ldr x2, =palabra
    uxtw x3, w1         // Extender 'w1' a 64 bits
    sub x3, x2, x3      // Dirección de palabra[der]
    ldrb w4, [x3]       // Cargar palabra[der] (carácter derecho)

    cmp w3, w4         // Comparar los caracteres
    bne not_palindrome  // Si no son iguales, no es un palíndromo

    // Actualizamos los índices
    ldr x0, =izq
    ldr w1, [x0]        // Cargar 'izq'
    add w1, w1, #1      // Incrementar 'izq'
    str w1, [x0]        // Guardar nuevo 'izq'

    ldr x0, =der
    ldr w1, [x0]        // Cargar 'der'
    sub w1, w1, #1      // Decrementar 'der'
    str w1, [x0]        // Guardar nuevo 'der'

    // Verificar si ya hemos llegado al centro
    ldr x0, =izq
    ldr w1, [x0]        // Cargar 'izq'
    ldr x2, =der
    ldr w3, [x2]        // Cargar 'der'
    cmp w1, w3
    blt compare_loop    // Si 'izq' < 'der', continuar comparando

    // Si hemos recorrido la cadena sin encontrar diferencias, es un palíndromo
    ldr x0, =msg_true
    bl printf
    b exit

not_palindrome:
    // Si encontramos una diferencia, no es un palíndromo
    ldr x0, =msg_false
    bl printf

exit:
    mov x0, #0           // Código de salida 0 (indica éxito)
    mov x8, #93          // Número de syscall para 'exit' (93 en ARM64)
    svc 0                 // Llamada al sistema para salir




    
