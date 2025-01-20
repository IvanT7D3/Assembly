;Loops

global _start

;Functions should be above the entry point
Print:
		      ;The prologue is what happens at the beginning of a function. Its responsibility is to set up the stack frame of the called function.
	push ebp      ;Save the base pointer
	mov ebp, esp  ;Set up a new base pointer

	;Print string
	mov eax, 0x4
	mov ecx, string
	mov edx, stringL
	int 0x80

	;The epilogue is what happens last in a function, and its purpose is to restore the stack frame of the calling function
	;We can do it using leave, or:
	;mov esp ,ebp
	;pop ebp
	leave
	ret

_start:
	mov ecx, 0x5 ;Set ECX to 5 (Loop | Counter register)
	;In this case the loop will print the string "Loops" 5 times
	;Using the keyword loop in nasm, it will take what is inside of ECX, and start counting down from the number that is inside of ECX
	;When we use loop, we must remember that when ECX finally hits 0, it will set the ZeroFlag
	;This means that when it calls the loop again, it notices that the ZeroFlag is set, and skips the loop

LoopFunc:
	pushad         ;Push all general-purpose registers onto the stack
	pushfd         ;Push the flags register onto the stack

	call Print     ;Call the Print function

	popfd          ;Pop the flags register from the stack
	popad          ;Pop all general-purpose registers from the stack
	loop LoopFunc  ;Loop back to LoopFunc while ecx is not zero
                       ;This is similar to jump not zero (jnz). Just keep in mind for this particular case, that we're using the loop keyword

	;Return
	mov eax, 0x1
	mov ebx, 0x0
	int 0x80

	;Defining variables
	string: db "Loops", 0x0a
	stringL equ $-string
