org 100h
 
mov si,0
mov di,0 
mov dx,0
 
L1:  
    mov al,[array1 + si]
    
        L2:
    
           
            mov bl,[array2 + di]

            
            cmp al,bl;
            je equal
            mov bp,di
            mov sp,si
            jmp finish                
                            equal:
                            
                            
                            L3:
                            mov al,[array1 + si]
                            mov bl,[array2 + di]
                            
                            cmp al,bl
                            je equal2
                            jmp finish2
                            
                            
                            equal2:
                            inc dx
                            
                            
                            cmp dx,9
                            je equal3
                            
                            inc si
                            inc di
                            
                            loop L3
                            
            
                            
            finish2:
            mov dx,0
            finish:
            mov di,bp
            mov si,sp
            inc di
            cmp di,15
            je equal4     
            
            
        loop L2
             
            

loop L1

equal4: 
equal3:
equal5:
CALL myFunc
 

ret

                              
 
array1 db 'C','O','M','P','U','T','E','R','S'
array2 db 'M','I','C','R','O','C','O','M','P','U','T','E','R','S'
message1 DB 'MICROCOMPUTERS CONTAINS           ',13,10 
message2 DB 'MICROCOMPUTERS DOES NOT CONTAIN           ',13,10


myFunc PROC
    
 cmp dx,9
 je equal6
 jmp notEqual:
 
 equal6:
    
    lea si,message1
    mov di,0
    L4:
        
        mov dl,[array1+di]
        mov [message1 + 24 +di],dl
        inc di               
        cmp di,9
        je equal7
        loop L4
    equal7:
    mov cx,36
    mov ah,0eh
GO1: LODSB  
    INT 10h
    loop GO1
    jmp finished   
notEqual:
    lea si,message2
    mov di,0
    L5:
        
        mov dl,[array1+di]
        mov [message2 + 32 +di],dl
        inc di               
        cmp di,9
        je equal8
        loop L5
    equal8:
    mov cx,48
    mov ah,0eh
GO: LODSB  
    INT 10h
    loop GO

    

finished:

ret
myFunc ENDP