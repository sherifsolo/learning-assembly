global _start
section .data:
newline db 0x0a,0x0d
vseparator db 0x7c
hseparator db 0x71
player1 db 1
player2 db 2
winmsg db  "The winner is palayer: ", 0x0a, 0x0d, 0x00
winmsglen equ $-winmsg 
wlcmmsg db "TICTACTOE::::Player one(1), choose your character X or O: ", 0x0a, 0x0d, 0x00
wlcmmsglen equ $-wlcmmsg
playerprompt db "Which box do you want to mark: ", 0x0a, 0x0d, 0x00
playerpromptlen equ $-playerprompt
gameover db "Game Over.", 0x0a, 0x0d, 0x00
gameoverlen equ $-gameover
draw db "Game over, Draw no winner.", 0x0a, 0x0d, 0x00
drawlen equ $-draw
restart db "Do you want to play another game(y/n): ", 0x0a, 0x0d, 0x00
restartlen equ $-restart
section .bss
board resb 9
player1char dw  ?
player2char dw  ?
winner db  ?
chosenbox dw ?
chosenchar dw ?
currentplayer db ?
section .text:
_start:
	push ebp,
	mov ebp, esp;
teststart:
	mov byte [currentplayer], 1;
	call populateborad;
	call printwelcomemsg;
	call printboard;
	call mainloop;
	jmp quit;
printwelcomemsg:
	push ebp;
	mov ebp, esp;
	lea ecx, wlcmmsg
	mov edx, wlcmmsglen;
	call print;
	lea ecx, player1char;
	mov edx, 2;
	call read;
	cmp byte [player1char], 'X';
	jz setplayer2charO;
	mov byte [player2char], 'X';
	jmp retmain;
setplayer2charO:
	mov byte [player2char], 'O';
retmain:
	pop ebp;
	ret;
populateborad:
	push ebp;
	mov ebp, esp;
	push eax;
	push ebx;
	push ecx;
	push esi;
	mov esi, board;
	mov ecx, 0;
	mov ebx, 0x30;
poploop:
	mov [esi + ecx], ebx;
	inc ecx;
	add ebx, 1;
	cmp ecx, 9;
	jl poploop;
	mov byte [esi +ecx +1], 0x0;
	pop esi;
	pop ecx;
	pop ebx;
	pop eax;
	pop ebp;
	ret;
printboard:
	push ebp;
	mov ebp,esp;
	push eax;
	push ebx;
	push ecx;
	push edx;
	mov edx, 2;
	lea ecx, newline
	call print;
	lea esi, board;
	mov ecx, esi;
	mov edx, 1;
	mov edi, 0;
	mov esi, 3;
boardloop:	 
	call print;
	push ecx;
	lea ecx, vseparator;
	call print;
	pop ecx;
	add ecx, 1;
	add edi, 1;
	cmp edi, esi;
	je printnewline;
cont:
	cmp edi, 9;
	jl boardloop;
	jmp exitboardloop;
printnewline:
	push ecx;
	push edx;
	add esi, 3;
	lea ecx, newline;
	mov edx, 2;
	call print;
	pop edx;
	pop ecx;
	jmp cont;
exitboardloop:
	pop edx;
	pop ecx;
	pop ebx;
	pop eax;
	pop ebp;
	ret;
mainloop:
	call promptbox;
	cmp byte [chosenbox], 0x39;
	ja quit;
	call updateboard;
	call printboard;
	je printnowinner;
	jmp mainloop;
promptbox:
	push ebp;
	mov ebp, esp;
	lea ecx, playerprompt;
	mov edx, playerpromptlen;
	call print;
	lea ecx, chosenbox;
	mov edx, 2;
	call read;
	pop ebp;
	ret
updateboard:
	push ebp;
	push eax;
	push ebx;
	push ecx;
	push edx;
	push esi;
	push edi;
	lea edi, board;
	mov esi, chosenchar;
	call selectplayer;
	mov [esi], eax;
	mov ax, word [chosenbox];
	sub al, 0x30;
	movzx eax, al; 
	mov bl, [esi];
	mov byte [edi+eax], bl;
	pop edi;
	pop esi;
	pop edx;
	pop ecx;
	pop ebx;
	pop eax;
	pop ebp
	ret;
selectplayer:
	push ebp;
	mov ebp, esp;
	cmp byte [currentplayer], 1;
	jg selectplayer2;
	mov eax, [player1char];
	add byte [currentplayer], 1;
	jmp retselectedplayer; 
selectplayer2:
	mov eax, [player2char];
	sub byte [currentplayer], 1;
retselectedplayer:
	pop ebp;
	ret;
printgameover:
	push ebp;
	mov ebp, esp;
	push eax;
	push ebx;
	push ecx;
	push edx;
	mov ecx, gameover;
	mov edx, gameoverlen;
	call print;
	mov ecx, restart;
	mov edx, restartlen;
	call print;
	mov ecx, chosenchar;
	mov word [ecx], 0;
	mov edx, 1;
	call read;
	cmp byte[chosenchar], 'y';
	jne quit;
	pop edx;
	pop ecx;
	pop ebx;
	pop eax;
	pop ebp;
	jmp teststart;
	ret;	
printnowinner:
	push ebp;
	mov ebp, esp;
	push eax;
	push ebx;
	push ecx;
	push edx;
	mov ecx, draw;
	mov edx, drawlen;
	call print;
	mov ecx, restart;
	mov edx, restartlen;
	call print;
	mov ecx, chosenchar;
	mov word [ecx], 0;
	mov edx, 1;
	call read;
	cmp byte[chosenchar], 'y';
	jne quit;
	pop edx;
	pop ecx;
	pop ebx;
	pop eax;
	pop ebp;
	jmp teststart;
	ret;
print:	
	push ebp;
	mov ebp,esp;
	push eax;
	push ebx;
	mov eax, 4;
	mov ebx, 1;
	int 0x80;
	pop ebx;
	pop eax;
	pop ebp;
	ret;
read:
	push ebp;
	mov ebp, esp;
	push eax;
	push ebx;
	mov ebx,2;
	mov eax, 3;
	int 0x80;
	pop ebx;
	pop eax;
	pop ebp
	ret;
quit:
	mov eax, 1;
	mov ebx, 0;
	int 0x80;
