;Saving States And Functions

;When we create a function, we will get a new section of the stack when the function runs. However, when the function returns, it needs to
;put back the registers and the stack in the correct alignment that they were before the function was called, because the function doesn't need them anymore

global _start

PrintText:		;Function called PrintText
        		;The first things we have to do are: Push the EBP register and the ESP register onto the stack (Epilogue)
			;Keeps track of EBP and ESP
	push ebp	;Push ebp onto the stack ESP is the address of the top of the stack
	mov ebp, esp	;Now the ebp register is holding the stack pointer. Now the flags and register data have a certain memory address
			;We can then write our code

	;Simple print statement
	mov eax, 0x4
	mov ecx, string
	mov edx, stringL
	int 0x80
			;We now have to do the Prologue
			;2 ways to do this:
			;1:mov esp, ebp
			;pop ebp

			;2: Let nasm do that, using leave
	leave
	ret		;Return after the call PrintText in the _main function
			;If we don't use ret, and just use leave, the function will be executed infinitely.
			;leave would make us go back to the beginning of _main (Basically an infinite loop)
			;ret makes us go back to the instruction AFTER the call of the function PrintText

_start:

	;Before we make a function call, we need to push onto the stack the registers/all the contents of the registers, and the cpu flags that
	;we will need later. We can do this manually, adding and removing them.
	;But we can use a nasm function to do this.
	;To push something onto the stack, we use: push eax, OR push 0x40 OR push "Text" if we want to push a value onto the stack
	;If we want to pop something from the stack, we use: pop eax, OR pop 0x40 OR pop "Text" if we want to pop a value from the stack

	;Now, to push all the registers before a function call, we can do this by using nasm, and we can use:
	;pushad: Pushing all the registers onto the stack (The function is ending)
	pushad

	;To push the flags onto the stack, we can use pushfd (The function is ending)
	pushfd

	call PrintText

	;REMEMBER THAT THE STACK IS LIFO (Last In, First Out)
	;So, when we complete the function call, we MUST pop first of all the flags (Using popfd, AND then popad):
	popfd ;Popping from the stack all the flags and reset them to what was on the stack
	popad ;Popping from the stack and puts them in the registers

	;At this point, we have a saved state. Everything in between these 2 push and pop, we can do whatever we want to the stack and the registers
	;We must however follow some key important behaviors to make sure that we will always able to return to normal functionality

	;To call a function, we use call and we give it a name or a memory address. Example: (REMEMBER THAT CASE SENSITIVITY IS STILL IMPORTANT)
	;call PrintText

	;Exit with return code 0
	mov eax, 0x1
	mov ebx, 0x0
	int 0x80

	;Defining variables
	string: db "Saving States", 0x0a
	stringL equ $-string
