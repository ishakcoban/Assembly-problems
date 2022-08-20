org 100h
;print Maze Pattern
;-------------------------------------------------------	
    MOV DX,2000h
	MOV BX, 0

MAINLOOP:
	MOV SI, 0
	MOV CX, 5

NEXT:
	MOV AL,INIT[BX][SI]
	out dx,al
	INC SI
	INC DX

	CMP SI, 5
	LOOPNE NEXT

	ADD BX, 5
	CMP BX, 40
	JL MAINLOOP
;print my current point	
;-------------------------------------------------------
    mov dx,2001h;determine the point
    mov di,0;this will use to be old address    
    MOV al,MyPoint 
    out dx,al
    call getInput
     
goloop1:	
    call leftOperation    
    call getInput
goloop2:	
    call rightOperation    
    call getInput
goloop3:
dontGoUp:	
    call upOperation    
    call getInput
goloop4:
dontGoDown:	
    call downOperation    
    call getInput
                   	
    
RET

leftOperation PROC
    
    mov al,bl
    mov bl,5
    mul bl
    mov bl,al
    
    inc di
    mov dx,bp
    
    call findAddress      
    
    MOV al,INIT[bx][si] 
    mov bh,al    
    
    mov al,MyPoint    
    call fillArrayWithMyAddress
    mov dx,bp
    call findAddress
    MOV al,INIT[bx][si] 
    mov bh,al    
    
    mov al,MyPoint
    call fillArrayWithTargetAddress
    mov dx,bp
    call controlMoveHereLeft
    mov dx,bp
    call findAddress
    MOV al,INIT[bx][si] 
    mov bh,al    
    
    mov al,MyPoint
    
    add al,bh
	out dx,al
	
	cmp di,1
	je jump	
	dec di
	mov dx,di	
   
    call findAddress
    
	MOV al,INIT[bx][si] 
    out dx,al 
    jump:
    
mov dx,bp

ret	    
leftOperation ENDP

rightOperation PROC

    mov al,bl
    mov bl,5
    mul bl
    mov bl,al 
    
    inc di
    mov dx,bp
    
    call findAddress      
    
    MOV al,INIT[bx][si] 
    mov bh,al    
    
    mov al,MyPoint    
    call fillArrayWithMyAddress
    mov dx,bp
    call findAddress
    MOV al,INIT[bx][si] 
    mov bh,al    
    
    mov al,MyPoint
    call fillArrayWithTargetAddress
    mov dx,bp
    call controlMoveHereRight
    mov dx,bp
    call findAddress
    MOV al,INIT[bx][si] 
    mov bh,al    
    
    mov al,MyPoint
    
    add al,bh
	out dx,al
	
	cmp di,1
	je jump13	
	dec di
	mov dx,di	
   
    call findAddress
    
	MOV al,INIT[bx][si] 
    out dx,al 
    jump13:
    
mov dx,bp

ret	    
rightOperation ENDP

upOperation PROC
    
    mov al,bl
    mov bl,5
    mul bl
    mov bl,al
    inc di
    mov dx,bp
    
    call findAddress      
    
    MOV al,INIT[bx][si] 
    mov bh,al    
    
    mov al,MyPoint    
    call fillArrayWithMyAddress
    mov dx,bp
    call findAddress
    MOV al,INIT[bx][si] 
    mov bh,al    
    
    mov al,MyPoint
    call fillArrayWithTargetAddress
    mov dx,bp
    call controlMoveHereUP
    mov dx,bp
    call findAddress
    MOV al,INIT[bx][si] 
    mov bh,al    
    
    mov al,MyPoint
    
    add al,bh
	out dx,al
	
	cmp di,1
	je jump2	
	dec di
	mov dx,di	
    
    jump2:
    
mov dx,bp

ret	    
upOperation ENDP

downOperation PROC
    mov al,bl
    mov bl,5
    mul bl
    mov bl,al
    inc di
    mov dx,bp
    inc di
    mov dx,bp
    
    call findAddress      
    
    MOV al,INIT[bx][si] 
    mov bh,al    
    
    mov al,MyPoint    
    call fillArrayWithMyAddress
    mov dx,bp
    call findAddress
    MOV al,INIT[bx][si] 
    mov bh,al    
    
    mov al,MyPoint
    call fillArrayWithTargetAddress
    mov dx,bp
    call controlMoveHereDOWN
    mov dx,bp
    call findAddress
    MOV al,INIT[bx][si] 
    mov bh,al    
    
    mov al,MyPoint
    
    add al,bh
	out dx,al
	
	cmp di,1
	je jump3	
	dec di
	mov dx,di	
   
    jump3:
    
mov dx,bp

ret
downOperation ENDP



getInput PROC
dontGoLeft:
dontGoRight:
fail:
fail1:
fail3:
fail6:
fail9:
fail10:
fail77:
    
    mov ah,00h    	
    INT 16H 

    cmp ah,4Bh;LEFT
    je moveLeft

    cmp ah,48h;UP
    je moveUp

    cmp ah,4Dh;RIGHT
    je moveRight

    cmp ah,50h;DOWN
    je moveDown
    
        
moveLeft:;di eski adres icin bp yeni adres icin
mov sp,dx
push sp
cmp dx,2000h
je dontGoLeft
pop sp
mov di,sp 
sub dx,0001h
mov bp,dx
jmp goloop1

moveRight:
mov sp,dx
push sp
cmp dx,2027h
je dontGoRight
pop sp
mov di,sp
add dx,0001h 
mov bp,dx
jmp goloop2

moveUp:
cmp myPoint,1h
je dontGoUp
jmp goloop3 

moveDown:
cmp myPoint,1h
je dontGoDown
jmp goloop4 
   
ret	    
getInput ENDP

findAddress PROC
    
    mov ax,0
    mov si,0
    mov bx,0
    mov al,dl
    mov bl,5	
    div bl
    mov cl,ah
    mul bl
    mov bl,al
    mov si,cx

ret	    
findAddress ENDP

fillArrayWithMyAddress PROC
mov si,0
input:

mov cx,0
mov cl,al
push cx
shr al,4

jmp jumpthisrotate 
l4: 
pop cx
sal cl,4
mov bl,00000000b
add cl,bl
shr cl,4
mov al,cl
jumpthisrotate:
number:
cmp al,0
jb input
cmp al,9
ja uppercase
jmp process


uppercase:
cmp al, 0Ah
jb input
cmp al, 0Fh
ja lowercase

jmp process
jmp input

lowercase:
cmp al, 0ah
jb input
cmp al, 0fh
ja input
sub al, 57h
jmp process
jmp input

loop input

process:
mov ch, 4
mov cl, 3
mov bl, al

convert:
mov al, bl
ror al, cl
and al, 01
add al, 30h

mov ah, 02h
mov dl, al
mov [myAddress+si],dl
inc si
dec cl
dec ch
jnz convert
cmp si,8
je f11
jmp l4
f11:
ret	    
fillArrayWithMyAddress ENDP

fillArrayWithTargetAddress PROC
mov si,0
input1:

mov cx,0
mov cl,bh
push cx
shr bh,4
mov al,bh
jmp jumpthisrotate1 
l5:
pop cx
sal cl,4
mov bl,00000000b
add cl,bl
shr cl,4
mov al,cl
jumpthisrotate1:
number1:
cmp al,0
jb input
cmp al,9
ja uppercase1
jmp process1

uppercase1:
cmp al, 0Ah
jb input1
cmp al, 0Fh
ja lowercase1

jmp process1
jmp input1

lowercase1:
cmp al, 0ah
jb input1
cmp al, 0fh
ja input1
sub al, 57h
jmp process1
jmp input1

loop input1

process1:
mov ch, 4
mov cl, 3
mov bl, al

convert1:
mov al, bl
ror al, cl
and al, 01
add al, 30h

mov ah, 02h
mov dl, al
mov [targetAddress+si],dl
inc si
dec cl
dec ch
jnz convert1
cmp si,8
je f22
jmp l5
f22:
ret		    
fillArrayWithTargetAddress ENDP

controlMoveHereRight PROC
    
    mov si,0
    mov cx,8
    l7:
    mov al,myAddress[si]
    
    cmp al,'1'
    je finishh1
    inc si
    loop l7
    finishh1:
    
    cmp targetAddress[si],'0'
    je success1
    dec dx
    dec di
    dec bp
    jne fail1
    success1:
ret    
controlMoveHereRight ENDP 

controlMoveHereLeft PROC
    
    mov si,0
    mov cx,8
    l10:
    mov al,myAddress[si]
    
    cmp al,'1'
    je finishh2
    inc si
    loop l10
    finishh2:
    
    cmp targetAddress[si],'0'
    je success4
    inc dx
    inc di
    inc bp
    jne fail77
    success4:
ret    
controlMoveHereLeft ENDP

controlMoveHereUP PROC
    
    mov si,0
    mov cx,8
    l8:
    mov al,myAddress[si]
    
    cmp al,'1'
    je finishh
    inc si
    loop l8
    finishh:
    inc si   
    cmp targetAddress[si],'0'
    je success
    
    jne fail
    success:
    mov al,myPoint
    shr al,1
    mov myPoint,al
ret    
controlMoveHereUP ENDP

controlMoveHereDOWN PROC
    
    mov si,0
    mov cx,8
    l9:
    mov al,myAddress[si]
    
    cmp al,'1'
    je finishh3
    inc si
    loop l9
    
    finishh3:
    
    dec si
    cmp si,0
    je fail10    
    cmp targetAddress[si],'0'
    je success3    
    jne fail3
    success3:
    
    mov al,myPoint
    sal al,1
    mov myPoint,al
ret    
controlMoveHereDOWN ENDP

INIT DB  0000000B, 0000000B, 0000000B, 0000000B, 0000000B,
     DB  1110111B, 1000001B, 1111001B, 1111011B, 1000001B, 1011111B,
     DB  1011111B, 1010001B, 1010101B, 1000101B, 1111101B, 1000101B,
     DB  1010001B, 1010101B, 1010101B, 1100011B, 1000001B, 1011101B,
     DB  1011101B, 1011101B, 1001001B, 1000101B, 1011101B, 1100001B,
     DB  1101111B, 1000001B, 1010101B, 1010101B, 1010101B, 1111101b,
     DB  0000000B, 0000000B, 0000000B, 0000000B, 0000000B

MyPoint DB 0001000b
myAddress db '        '
targetAddress db '        '