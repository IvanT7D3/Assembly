;Write File
;We will open a file, and then we will overwrite the contents of such file with some other text.

global _start

_start:
	;Open File with write only
	mov eax, 0x5	;Open syscall
	mov ebx, file	;Pathname
	mov ecx, 0x1	;Flags. 1 is write only (O_WRONLY)
	int 0x80	;Execute syscall

	mov esi, eax	;Preserving the open file for later use, moving it from eax to esi. Now esi is where the file descriptor for the opened file is located

	;Write to a file descriptor
	mov eax, 0x4		;Write syscall
	mov ebx, esi		;Write to file descriptor
	mov ecx, string		;Buffer to write from
	mov edx, stringL	;Amount of data to write
	int 0x80		;Execute syscall

	mov eax, 0x06	;Close syscall
	mov ebx, esi	;Passing file descriptor to close in ebx
	int 0x80	;Execute syscall

	;Return with exit code 0
	mov eax, 0x1
	mov ebx, 0x0
	int 0x80

	file: db "./data.txt", 0x0
	string: db "Write to fileeee!", 0x0a	;String we want to put inside of the file descriptor we are writing to. Remember that the entire contents of the file may not be wiped completely after writing to the file (If the file we are writing to, already contains some text).
	stringL equ $-string	;Get string length
