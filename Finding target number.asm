org 100h

mov bl,0
mov ch,0
mov di,0

GeneralLoop:

   MOV AH, 00h       
   INT 1AH          

   mov  ax, dx
   xor  dx, dx
   mov  cx, 10    
   div  cx     

   add  dl, '0'
   mov bh,dl  
    

    
    LEA SI, MESSAGE
    MOV cx, 32
    MOV AH, 0Eh
    GO: LODSB
    INT 10h
    LOOP GO
    
    
    
    mov ah,01h
    int 21h
    mov [MESSAGE+29],al
    
    
    push ax
    
    mov ah, 0Eh       
    mov al, 0Dh
    int 10h
    mov al, 0Ah
    int 10h
	;---------------------------------------------------------------------------------------

    MOV DX, 2037h
    mov cx,0
    mov cl,bh
    mov si,cx
    sub si,'0'
    MOV al,NUMBERS1[si]
	out dx,al

;---------------------------------------------------------------------------------------
     pop ax
	;---------------------------------------------------------------------------------------

    MOV DX, 2032h
    mov cx,0
    mov cl,al
    push ax
    mov si,cx
    sub si,'0'
    MOV al,NUMBERS1[si]
	out dx,al


	
	
	MOV DX, 2030h	
	MOV SI, 0
	MOV bp, 8
	
   
NEXT:
	MOV al,NUMBERS[SI]
	out dx,al
	INC SI
	INC DX
	dec bp
	cmp bp,0
	je finish

	LOOP NEXT
	finish:

   
      
 
    pop ax
    cmp al,bh
    je finishLoop
    jne finishLoop1
    
    
    finishLoop:

    inc di
    
    finishLoop1:    
    inc bl	
	
	;-----------------------------------------------------------------------------
	mov cx,di
	MOV DX, 2040h	
	MOV SI, 0
	MOV bp, 10
    add bl,48
    add cl,48
    MOV [resultMessage1 + 8],cl
    MOV [resultMessage2 + 12],bl
    sub bl,48

    
NEXT2:
    
	MOV AL, resultMessage1[SI]
	out DX,AL
	INC SI
	INC DX
    dec bp
    
    cmp bp,0
    je finishthisLoop
	LOOP NEXT2
	finishthisLoop:
	
	
	MOV DX, 2050H
	MOV SI, 0
	MOV bp, 14

NEXT1:
    
	MOV AL, resultMessage2[SI]
	out DX,AL
	INC SI
	INC DX
	dec bp
	cmp bp,0
    je finishthisLoop1
             
	LOOP NEXT1
	finishthisLoop1:
	;---------------------------------------------------------------------------
	
	

loop GeneralLoop 
    
RET 

resultMessage1  DB 'YOU WIN : ',13,10
resultMessage2  DB 'TOTAL GUESS : ',13,10
MESSAGE DB 'Enter a number between 0-9:    '
NUMBERS	DB 00111110b, 01000000b, 00000000b, 00000000b, 00000000b, 00111001b, 01000000b, 000000000b, 01111111b, 01101111b
NUMBERS1 DB 00111111b, 00000110b, 01011011b, 01001111b, 01100110b, 01101101b, 01111101b, 00000111b, 01111111b, 01101111b












