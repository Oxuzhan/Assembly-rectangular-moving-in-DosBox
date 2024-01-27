org 100h ;Set the origin of the program to 100h
.model small ; Use the small memory model                              
.data 

     dataArray db 45, 0, 28, 76, 45, 0, 0, 14, 32, 27, 14, 39, 0, 68, 15, 23, 0, 14, 42, 27
     arraySize equ $ - dataArray
     Say1 DW ?
     Say2 DW ?
     Say3 DW ? ; extra variables defined 2 byte
     
.code
BASLA PROC

mov ax,0000h
mov Say1,ax
mov Say2,ax
mov Say3,ax
mov bl,0 ; making all values to 0  
mov cx,0
mov Say3,OFFSET dataArray+21 ;taking offset  
mov cx, arraySize ; putting arraysize to cx 

 
   anadongu:
         
mov bx, OFFSET dataArray
add bx,  Say2 
mov ax , Say2
mov Say1, 0
dec cx

   cmp ax, 0012h
   je kaydirma
     
; First loop to compare elements
   firstloop:
     
mov al, [bx]
inc Say2

   iceridongu:
   
add bx,1
mov dl,[bx]
inc Say1

cmp Say1,48
je kaydirma

cmp bx,Say3 
je kaydirma ; another loop making swap
 
cmp al,dl
je same
  
cmp cx,0
je kaydirma

cmp cx, Say1
je anadongu ; big loop 
  
jne iceridongu
     
    same:
     
mov [bx],0
jmp iceridongu 
 
; Shift operation    
   kaydirma: ; this one refers to make last step (putting zeros to the right side)

mov ax,0 ; clearing all values to make another step
mov bx,0
mov Say1,0
mov Say2,0
mov Say3,0 
mov cx,0
mov dx,0
      
   dongu_2:
   
mov bx,OFFSET dataArray+1 ; taking offset refer (0)
mov cx,arraySize-2  ; decreasing
                
   dongu:
   
cmp [bx],0
je sifir
inc bx
jmp sondongu

sifir:

inc bx
mov ax,[bx]
dec bx
mov [bx],ax
inc bx
mov [bx],0

sondongu:
 
inc Say1
cmp Say1,235

je cikis

loop dongu

jmp dongu_2
  
cikis:

;Exit program 

    mov ah, 4Ch
    int 21h

.EXIT
BASLA ENDP
END BASLA



