;Data Types

global _main

_main:
	; Byte: 8 Bits 0x00 (db)
	; Word : 16 bits (dw)
	; Double Word (DWORD) : 32 bits
	; Quad Word : 64 bits
	; Double Quad Word : 128 bits
	;If we are not going to use all of the bytes that we have in the data type that we are using, the ones that we don't use will be replaced with
	;0x00, so that all the data will be used and set by the time it goes into memory

	;Printing the contents of our variables
	mov eax, 0x04 		;Syscall write
	mov ecx, byte1 		;Telling it what to print. We will be messing with the file descriptor this time
	mov edx, byte1L		;Telling it exactly the number of characters to print (length)
	int 0x80		;Executing the syscall

				;NOW EAX WILL NOT CONTAIN 0X04 ANYMORE, SINCE THE SYSCALL HAS BEEN EXECUTED. EAX NOW WILL HAVE ANOTHER VALUE IN IT
				;(IT USUALLY DEPENDS ON WHAT THE RETURN CODE IS)
				;THUS, TO PRINT OTHER THINGS, WE WILL HAVE TO DO: mov eax, 0x04 AGAIN
	mov eax, 0x04
	mov ecx, byte2
	mov edx, byte2L
	int 0x80

	mov eax, 0x04
	mov ecx, word1
	mov edx, word1L
	int 0x80

	;Exiting with return code 0
	mov eax, 0x1
	mov ebx, 0x0
	int 0x80

	;Creating variables
	byte1: db "Hi", 0x0a		;Giving to the variable byte1 (Is 8 bits) the contents that it will hold with a newline (0x0a)
	byte1L equ $-byte1		;Getting the length of the data that we will print

	byte2: db "How", 0x0a		;The same as before
	byte2L equ $-byte2		;The same as before

	word1: dw "Is It Going People?", 0x0a	;Giving to the variable word1 (Is 16 bits) the contents that it will hold with a newline (0x0a)
	word1L equ $-word1			;Getting the length of the data that we want to print
