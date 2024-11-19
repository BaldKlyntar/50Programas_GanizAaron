/*=======================================================
* Programa:       EscribirArchivo.s
* Autor:        Ganiz Galaz Aaron
* No.Control:   23211003
* Fecha:        09 de Noviembre de 2024
*              
* Compilación:  as -o EscribirArchivo.o EscribirArchivo.s
*               gcc -o EscribirArchivo EscribirArchivo.o
* Ejecución:    ./EscribirArchivo
*
* Código equivalente en C#:
* -----------------------------------------------------
*      static void Main()
*    {
*        string filePath = "output.txt";
*        string content = "Hola, este es un archivo escrito desde C#.";
*
*        File.WriteAllText(filePath, content);
*       Console.WriteLine("Archivo escrito correctamente.");
*    }
*
*
* ASCIINEMA
* -----------------------------------------------------
*  https://asciinema.org/a/oamRc4Qu4fNc1NXNnrNxP98OP
* -----------------------------------------------------

=========================================================*/

.section .data
filename:    .asciz "output.txt"      // Nombre del archivo
message:     .asciz "Hola, mundo!\n" // Mensaje a escribir
msg_length:  .word 13                // Longitud del mensaje

.section .text
.global _start

_start:
    // Llamada al sistema openat() -> abre o crea un archivo
    mov     x8, 56                  // syscall: openat
    mov     x0, -100                // AT_FDCWD (directorio actual)
    ldr     x1, =filename           // Nombre del archivo
    mov     x2, 0x241               // O_CREAT | O_WRONLY | O_TRUNC
    mov     x3, 420                 // Permisos (decimal equivalente a rw-r--r--)
    svc     0                       // Realiza la syscall
    mov     x9, x0                  // Guardar el descriptor de archivo (fd)

    // Llamada al sistema write() -> escribe en el archivo
    mov     x8, 64                  // syscall: write
    mov     x0, x9                  // Descriptor del archivo
    ldr     x1, =message            // Dirección del mensaje
    ldr     w2, =msg_length         // Longitud del mensaje
    svc     0                       // Realiza la syscall

    // Llamada al sistema close() -> cierra el archivo
    mov     x8, 57                  // syscall: close
    mov     x0, x9                  // Descriptor del archivo
    svc     0                       // Realiza la syscall

    // Salida del programa (exit)
    mov     x8, 93                  // syscall: exit
    mov     x0, 0                   // Código de salida
    svc     0
