org 100h


mov di,0
mov bp,4
mov dx,k
L1: 
    mov ax,dx
    div [numbers+di]
    
    cmp ah,0
    je equal
    jmp finish
    
equal:
    mov bl,[numbers2+di]
    call myFunc
finish:
inc di
dec bp
cmp bp,0
je equal2
loop L1

equal2:


ret 

k dw 15
numbers db 2,3,5,10
numbers2 db '2','3','5','10'
message2 DB 'The number can be divided by  ',13,10


myFunc PROC
    
    mov [message2+29],bl
      
 lea si,message2
    mov cx,32
    mov ah,0eh
GO: LODSB  
    INT 10h
    loop GO
ret
myFunc ENDP