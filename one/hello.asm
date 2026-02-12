global _start
section .text:

_start:
	push ebp;
	mov  ebp, esp;
	push eax;
	push ebx;
	push ecx;
	push edx;
	sub esp, 40;
	mov eax, esp;
	mov BYTE[eax], 'H';
	mov BYTE[eax+1], 'e';
	mov BYTE[eax+2], 'l';
	mov BYTE[eax+3], 'l';
	mov BYTE[eax+4], 'o';                                             
	mov BYTE[eax+5], ',';
	mov BYTE[eax+6], ' ';
	mov BYTE[eax+7], 'W';
	mov BYTE[eax+8], 'o';
	mov BYTE[eax+9], 'r';
	mov BYTE[eax+10], 'l';
	mov BYTE[eax+11], 'd';
	mov BYTE[eax+12], '!';
	mov BYTE[eax+13], 0x0a;
	mov BYTE[eax+14], 0x0d;
	mov BYTE[eax+15], 0x0a;
	mov BYTE[eax+16], 0x0d;
	mov byte[eax+17], 'J';
	mov byte[eax+18], 'u';
	mov byte[eax+19], 's';
	mov byte[eax+20], 't';
	mov byte[eax+21], ' ';
	mov byte[eax+22], 'a';
	mov byte[eax+23], ' ';
	mov byte[eax+24], 'n';
	mov byte[eax+25], 'e';
	mov byte[eax+26], 'r';
	mov byte[eax+27], 'd';
	mov byte[eax+28], ' ';
	mov byte[eax+29], 'v';
	mov byte[eax+30], 'e';
	mov byte[eax+31], 'n';
	mov byte[eax+32], 't';
	mov byte[eax+33], 'i';
	mov byte[eax+34], 'n';
	mov byte[eax+35], 'g';
	mov byte[eax+36], '.';
	mov byte[eax+37], 0x0a;
	mov byte[eax+38], 0x0d;
	mov esi,0;
loop:
	add esi,1;
	mov eax, 0x4;
	mov ebx, 0x1;
	mov ecx, esp;
	mov edx, 0x28;
	int 0x80;
	cmp esi, 0x989680;
	jl loop;
	add esp, 0x28;
quit:
	pop edx;
	pop ecx;
	pop ebx;
	pop eax
	mov esp, ebp;
	mov eax,0x1;
	mov ebx,0x0;
	int 0x80;
