;Read File
global _start

;To read, write and close the file, we need to use more than 1 system call. We will use the open, read, write, and close system calls

;First we need to create a section (.bss) (Is at the end of the file), which will contain the contents of the file that we want to print on the screen
;Then We need to open the specified file. (man 2 open) and pass the required parameters

;Second, we need to read the file descriptor (man 2 read) (The file descriptor will be given to us from the open() function)

;Third, we want to transfer the text from our created buffer to the screen (Stdout)

;Four, we want to close the file descriptor (man 2 close)

_start:
	;Open file and get file descriptor
	mov eax, 0x5    ;Open syscall
	mov ebx, file   ;Pathname
	mov ecx, 0x0    ;Flags. 0 is read only (O_RDONLY)
	int 0x80        ;Execute syscall
	mov esi, eax    ;Preserving the open file for later use, moving it from eax to esi. esi is where the file descriptor for the opened file is located

	;Read from the file descriptor into our buffer
	mov eax, 0x3    ;Read syscall
	mov ebx, esi    ;Passing to the function the file descriptor that was returned to us by the open() function
	mov ecx, buffer ;When we read from a file descriptor, we need to store is somewhere in memory when we read it. We tell him the location where we want to store it
	mov edx, 0x400	;We need to give it the size of the buffer that we passed in ecx (0x400)
	int 0x80        ;Execute syscall. Now our buffer will contain the text that is inside of the file (1024 bytes max)

	;Print text from the buffer to the screen
	mov eax, 0x4    ;Write syscall
	mov ebx, 0x1    ;Standard output (Screen)
	mov ecx, buffer ;Takes text from the buffer (Which now stores the text that is inside of the file)
	mov edx, 0x400  ;Writes up to 0x400 bytes from our buffer to the screen
	int 0x80        ;Execute syscall

	;Close file descriptor (The file)
	mov eax, 0x6    ;Close syscall
	mov ebx, esi    ;Passing to the close() function the file descriptor to close
	int 0x80        ;Execute syscall

	;Return with exit code 0
	mov eax, 0x1
	mov ebx, 0x0
	int 0x80

	file: db "./data.txt", 0x0	;0x0 is a null byte. Determines the end of a string

section .bss				  ;Uninitiated section so we can set up in memory an allocation of a buffer size of some kind that we can use later
	buffer resb 0x400		;Create allocation called buffer and reserve (res for reserve, b for byte, and give it (reserve) 1024 bytes) . This way we are reserving 1024 bytes in memory, with a label called buffer, where there will later be the text that we want to print on the screen. If the file contains more than 1024 characters, the program will end up not reading all of them, but just the first 1024 characters.
