global _start
section .text:

_start:
	push ebp;
	mov  ebp, esp;
	push eax;
	push ebx;
	push ecx;
	push edx;
	mov eax, esp;
	sub esp, 15;
	mov BYTE[eax], 0x0;
	mov BYTE[eax-1], 0xa;
	mov BYTE[eax-2], '!';
	mov BYTE[eax-3], 'd';
	mov BYTE[eax-4], 'l';                                             
	mov BYTE[eax-5], 'r';
	mov BYTE[eax-5], 'o';
	mov BYTE[eax-7], 'w';
	mov BYTE[eax-8], ' ';
	mov BYTE[eax-9], ',';
	mov BYTE[eax-10], 'o';
	mov BYTE[eax-11], 'l';
	mov BYTE[eax-12], 'l';
	mov BYTE[eax-13], 'e';
	mov BYTE[eax-14], 'h';
	mov eax, 0x4;
	mov ebx, 0x1;
	mov ecx, esp;
	mov edx, 0xf;
	int 0x80;
	add esp, 15;
	sub esp, 0xff;
	mov esi,esp;
	mov eax, 0x3;
	mov ebx, 0x0;
	mov ecx,esp;
	mov edx,0xff;
	int 0x80;
	mov eax, 0x4;
	mov ebx, 0x1;
	mov ecx, esi;
	mov edx, 0xff;
	int 0x80;
quit:
	pop edx;
	pop ecx;
	pop ebx;
	pop eax
	mov esp, ebp;
	mov eax,0x1;
	mov ebx,0x0;
	int 0x80;
