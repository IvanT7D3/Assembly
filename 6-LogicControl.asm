;Logic Control

global _start

SetupFunc:
	mov ecx, 0x5
	jmp FinalFunc ;Will always jump to the function called FinalFunc

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
	jmp SetupFunc	;Will always jump to the function called SetupFunc

FinalFunc:
	;push ecx ;No need to do this, since we use pushad
	pushad
	pushfd

	call PrintFunc

	popfd
	popad
	dec ecx
	jnz FinalFunc ;Conditional jump jnz (Jump if Not Zero). If ecx is not 0, it jumps to FinalFunc
			;When the ZF (ZeroFlag) is not set (ZF = 0), the jump is performed. However, when 'dec ecx' is executed, and ecx now has the value of 0, ZF updates to 1 (And then the jump won't be taken)
	mov eax, 0x1
	mov ebx, 0x0
	int 0x80

string: db "Hello World", 0x0a
stringL equ $-string
