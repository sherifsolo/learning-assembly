global _start

section .text:
_start:
	push ebp;
	mov ebp, esp;
	sub esp, 16;
	mov eax,esp;
	mov DWORD[eax], 0x0;
	mov DWORD[esp+4], 0x1;
	mov DWORD[esp+8], 0x0;
	mov byte [esp+12], 0x0a;
	mov byte [esp+13], 0x0d;
	lea esi, [ebp-8];
	mov edi, 0;
loop:	
	mov eax, edi;
	call print_int;
	cmp eax,0;
	jz exit_proc;
	mov [esi], eax;
	mov eax, edi;
	mov ebx, 1;
	call add;
	mov edi, eax;
	cmp edi,9;
	jle loop;
	jmp exit_proc;
add:
	add eax, ebx;
	ret
print_int:
	call convert2_ascii;
	cmp eax,0;
	jz bail;
	mov [esi], eax;
	mov eax, 4;
	mov ebx, 1;
	lea ecx, [esi];
	mov edx, 6;
	int 0x80;
	ret
read:
	mov eax,3;
	mov ebx, 0;
	int 0x80;
	ret;
exit_proc:
	mov ebx,0;
	mov eax,1;
	int 0x80;
;printing numbers in ascii start from 30 = 0 31=1 ....39,
;10 -line feed 13 ---carriage return

convert2_ascii:
    cmp eax, 9        ;
    ja  bail          ; 
    cmp eax, 0        ; 
    jl  bail          ; 
    add eax, 0x30     ; 
    ret
bail:
	mov eax,0;
	ret;
