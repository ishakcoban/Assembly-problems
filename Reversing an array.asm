org 100h
 
MOV CX,5
LEA SI,dizi
LEA DI,tersDizi


L1: 
push AX
lodsb
loop L1

MOV CX,5

L2:
stosb
pop AX
loop L2

ret

dizi db 'world'
tersDizi db 5 dup(?)