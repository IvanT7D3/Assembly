;Arithmetic (Add, Sub, Mult, Divide, Increment, Decrement)

global _start

_start:

	;Add
	mov al, 0x5
	add al, 0x5		;Add 0x5 to get a result of 0xA

				;If we want to add two numbers that are going to be greater than 32 bits, we must set the carry flag to let the CPU know it will overflow the 32 bits
	mov eax,0xffffffff	;Moving MAX in EAX
	stc			;Set CF (Carry Flag) to 1
	adc al, 0xA		;When we do an add, the result of the add, will go into the eax register.
				;Instead of add al, 0xA, we will have to use: adc al 0xA (c for the Carry Flag), so that it will set the Carry Flag
                		;To set the Carry Flag, we can do the following things:
				;1: stc : Sets the Carry Flag
				;2: clc : Clears the Carry Flag. If we have set it before, it will then be unset
				;3: cmc : Compliments the Carry Flag (If it's on, it will turn it off, and if it's off, it will turn it on)
          	      		;To see the flags from GDB: info registers eflags. We will want to see the CF (Carry Flag)
				;We want to set the Carry Flag BEFORE we do adc, which is the add with carry.

				;After noticing that EAX is full with F, and after executing the adc al, 0xA, we will notice that the EAX register
				;was modified. Since we used AL, the first 2 bits of the EAX register were modified, and now include A (adc al, 0xA)
				;Overwriting the first FF.

	mov eax, 0x0		;Set EAX to 0

	;Sub
	mov al, 0x20		;20 (32 in decimal)
	sub al, 0x5		;Subtract 5 from 32
				;To subtract with the carry flag, we can do: sbb eax, 0x5

	mov eax, 0x0		;Set EAX to 0

	;Multiplication (Need to remember a chart. Similar to division)
	; AL * 8 bits = AX
	; AX * 16 bits = DX & AX
	; EAX * 32 bits = EDX & EAX
	mov al, 0xA		;Moving 10 (Decimal) into AL
	mov bl, 0x5		;Moving 5 (Decimal) into BL. We need to move the second value into the BL register that we want to multiply with
	mul bl			;Multiply BL by what is in AL, because the AX register is used to be multiply with what we want
				;mul bl al * bl
				;Remember that BL (EBX) remains with the value of 5. So we must always know and remember what values are in what registers
				;In this case we don't need the carry flag set, because of the table, and in what register it gets bumped to

	mov eax, 0x0		;Moving 0 in EAX and EBX
	mov ebx, 0x0

	;Division
	; AX / 8 bits = AL & AH . AL will hold the answer. The remainder will be in AH
	; DX & AX / 16 bits = AX & DX . Answer will be in AX and remainder in DX
	; EDX & EAX / 32 bits = EAX & EDX . Answer will be in EAX and remained will be in EDX

	mov ax, 0x1000		;4096 in decimal
	xor edx, edx		;Clear EDX so that we can see the remainder
	mov cx, 0x5		;register that we will use to perform the division
				;The result of the division will be 0x333 (819 in decimal) in AX and the remainder of 0x1 is in DX.
	div cx			;This will divide AX by CX. The quotient will be stored in AX (EAX), and the remainder will be in DX (EDX).

	;Increment And Decrement
	mov eax, 0x0
	inc eax			;Increment the value in the eax register by 1
	dec eax			;Decrement the value in the eax register by 1

	;Return code 0
	mov eax, 0x1
	mov ebx, 0x0
	int 0x80
