;This is a comment

;Tell to the linker where the entry point of the application is
global _start

_start:
				;Everything under _main: is what will be executed immediately

	mov eax, 0x4		;Moves 0x4 in the register EAX (Used when you initialize a system call). Syscall tables can be found on the references
				;In this case, 0x4 is used for the write syscall.
				;The digits can either be provided in decimal or hexadecimal
				;We will now pass a file descriptor (Not necessary)
				;eax holds the syscall number. ebx holds the first parameter, ecx holds the second parameter
				;edx holds the third parameter, and after edx, we will have to push other parameters to the stack
	mov ebx, 0x1		;Setting file descriptor (fd) (man 2 write and see the parameters of the function)
	mov ecx, string		;Moving string (It is a variable) (Memory location) (For the text that we want to print)
	mov edx, stringL	;String length (Will be used to tell how many bytes we want to print. It will print each character one at a time, until it reaches the last character we want to print)

	int 0x80		;Executes the syscall that is in eax (It will take the parameters, and then it will run)

	mov eax, 0x1		;Syscall for exit
	mov ebx, 0x0		;Returns 0 ((int status) From man 2 exit)
	int 0x80		;Interrupt (Executes the syscall)

;If we were to erase the 3 lines of code above this comment, and try to execute the program, we would get a Segmentation Fault, because
;The program shouldn't exit in that way (A wrong way), but it should exit exactly by calling the syscall exit, and giving it the parameter
;And then execute the syscall

	string: db "Hello World", 0x0a	;db (Define Byte (8 bits) ). 0x0a on the ascii table will be a Line Feed (Newline)
	stringL: equ $-string		;Quick way to get the lenght of a string based on a variable
					;$: is referencing the end of the string (0x0a),
					;then it subtracts the start of the string (Which starts before the character H in "Hello ...")
					;Sets the difference of the memory locations, or the offset, which gives us the amount of bytes of difference
