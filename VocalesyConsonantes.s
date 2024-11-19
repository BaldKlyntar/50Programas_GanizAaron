/*=======================================================
* Programa:       VocalesyConsonantes.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        06 de Noviembre de 2024
* Descripción: Programa que resta
*              dos numeros ingresados por
*              el usuario.
*              
* Compilación:  as -o VocalesyConsonantes.o VocalesyConsonantes.s
*               gcc -o VocalesyConsonantes VocalesyConsonantes.o
* Ejecución:    ./VocalesyConsonantes
*
* Código equivalente en C#:
* -----------------------------------------------------
*      static void Main()
*    {
*        string input = "Ejemplo de texto";
*        int vowels = 0, consonants = 0;
*        
*        foreach (char c in input)
*        {
*            if ("aeiouAEIOU".IndexOf(c) >= 0)
*                vowels++;
*            else if (char.IsLetter(c))
*                consonants++;
*        }
*
*        Console.WriteLine($"Vocales: {vowels}, Consonantes: {consonants}");
*    }
*
*
* ASCIINEMA
* -----------------------------------------------------
* https://asciinema.org/a/3gWego73jhm7YsZJZRRjcLhFz
* -----------------------------------------------------

=========================================================*/

.section .data
input:      .asciz "Ejemplo de texto"
vowels:     .quad 0
consonants: .quad 0
msg_out:    .asciz "Vocales: %d, Consonantes: %d\n"

.section .text
.global main
.extern printf

main:
    // Inicializar registros
    ldr x0, =input           // Cargar la dirección de la cadena de entrada
    mov x1, #0               // Inicializar contador de vocales (x1)
    mov x2, #0               // Inicializar contador de consonantes (x2)
    
next_char:
    ldrb w3, [x0], #1        // Cargar el siguiente carácter de la cadena
    cmp w3, #0               // Comprobar si hemos llegado al final de la cadena
    beq done                 // Si es el final de la cadena, saltar a done

    // Comprobar si el carácter es una vocal (mayúscula o minúscula)
    cmp w3, #'a'             // Comparar con 'a'
    beq increment_vowel
    cmp w3, #'e'             // Comparar con 'e'
    beq increment_vowel
    cmp w3, #'i'             // Comparar con 'i'
    beq increment_vowel
    cmp w3, #'o'             // Comparar con 'o'
    beq increment_vowel
    cmp w3, #'u'             // Comparar con 'u'
    beq increment_vowel

    cmp w3, #'A'             // Comparar con 'A'
    beq increment_vowel
    cmp w3, #'E'             // Comparar con 'E'
    beq increment_vowel
    cmp w3, #'I'             // Comparar con 'I'
    beq increment_vowel
    cmp w3, #'O'             // Comparar con 'O'
    beq increment_vowel
    cmp w3, #'U'             // Comparar con 'U'
    beq increment_vowel

    // Comprobar si el carácter es una consonante (letra)
    cmp w3, #'a'             // Verificar si es letra (en minúsculas o mayúsculas)
    bge check_consonant      // Si es mayor o igual a 'a', puede ser consonante
    cmp w3, #'A'             // Comparar con 'A'
    bge check_consonant      // Si es mayor o igual a 'A', puede ser consonante

    // Si el carácter no es una letra, continuamos al siguiente
    b next_char

increment_vowel:
    add x1, x1, #1           // Incrementar contador de vocales
    b next_char

check_consonant:
    add x2, x2, #1           // Incrementar contador de consonantes
    b next_char

done:
    // Imprimir resultados
    ldr x0, =msg_out         // Cargar el mensaje
    mov x1, x1               // Pasar el contador de vocales a x1
    mov x2, x2               // Pasar el contador de consonantes a x2
    bl printf                // Llamar a printf

    // Finalizar el programa
    mov x0, #0               // Código de salida 0
    mov x8, #93              // syscall para salir (exit)
    svc #0                    // Realizar la llamada al sistema
