global _start

_start:

	mov eax, 0xB	;execve(
	mov ebx, shell	;const char *filename
	mov ecx, 0x0	;const char *const *argv
	mov edx, 0x0	;const char *const *envp);
	int 0x80	;execute system call

	mov eax, 0x1	;exit(
	mov ebx, 0x0	;int error_code);
	int 0x80	;execute system call

	shell: db "/bin/sh"
