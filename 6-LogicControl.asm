;Logic Control

global _start

SetupFunc:
	mov ecx, 0x5
	jmp FinalFunc ;Always jump to the function called FinalFunc

PrintFunc:
	push ebp
	mov ebp, esp

	mov eax, 0x4
	mov ecx, string
	mov edx, stringL
	int 0x80

	leave
	ret

_start:
	jmp SetupFunc	;Always jump to the function called SetupFunc

FinalFunc:

	;push ecx ;No need to do this, since we use pushad
	pushad
	pushfd

	call PrintFunc

	popfd
	popad
	dec ecx
	jnz FinalFunc ;Conditional Jump (Jump if not zero). If ZF is not 0 it will jump to FinalFunc. If it is 0, it will not jump

	mov eax, 0x1
	mov ebx, 0x0
	int 0x80

string: db "Hello World", 0x0a
stringL equ $-string
