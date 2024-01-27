.model small 

.data
far3 DB 'Exit     : ESC', 13, 10, '$'
far1 DB 'Filling  : 1 (True), 0 (False)',13,10,'$'
far2 DB 'Movement : Left, Right, Up, Down',13, 10, '$'
widh equ 50 ; height and width parameters 
new1 dw 0
new2 dw 0 
rwidth equ 46h  
rheight equ 28h 
degisim equ 10 
.code
Start PROC
.STARTUP
code_1:
; first rectangular making
call firstpart  
; string uploading
mov dx, widh 
add dx, new2
mov cx, widh+rwidth 
add cx, new1 
mov al, degisim 
mov bx, widh
add bx, new1
; first making in
start_1: 
mov ah, 0ch 
int 10h
dec cx 
cmp cx, bx
jae start_1
;calling function
call elves
changing:
mov ah, 0ch 
int 10h
dec cx
cmp cx, bx
ja changing
;uploading parameters,Loop to draw the filled rectangle
mov cx, widh 
add cx, new1
mov dx, widh+rheight 
add dx, new2
mov al, degisim 
mov bx, widh
add bx, new2
loop_2:
mov ah, 0ch 
int 10h
dec dx
cmp dx, bx                     
ja loop_2  
; Call the "second" procedure
call second 
; Label for the next part
yeni:
mov ah, 0ch 
;Video interrupt to draw on the screen
int 10h 
; Decrement DX for loop control
dec dx
cmp dx, bx
ja yeni   
; Check for specific keys
mov ah,00h
int 16h
cmp ah, 4dh
je rightflang  
cmp ah, 4bh
je leftshift 
cmp ah, 48h
je uppershift
cmp ah, 50h
je belowshift
cmp al, 31h 
je drawFilledRectangle
cmp al, 30h 
je code_1 
mov ah,0000 
mov al,03
;Video interrupt to clear the screen 
int 10h 
mov ah,0000 
int 16h 
cmp al, 1bh 
;If the user pressed the right arrow key, jump to Shiftfor
je Shiftfor
rightflang:
add new1 ,1h 
jmp code_1
leftshift:
sub new1 ,1h
jmp code_1
uppershift:
sub new2 ,1h
jmp code_1 
belowshift:
add new2 ,1h
jmp code_1 
; Draw a pixel on the screen,decrease the row counter
drawFilledRectangle: 
mov ah, 0000 ; 
mov al, 13h
int 10h 
mov ax, @data
mov ds, ax
mov ah, 09h
lea dx, far1
int 21H
lea dx, far2
int 21H
lea dx, far3
int 21H  
mov cx, 50+rwidth 
add cx, new1
mov dx, 5Bh 
add dx, new2   
mov al, degisim
;If the row counter is greater than or equal to the target, continue the loop 
devam: 
; Handling Movement and Drawing of a Filled Rectangle, using parameters
mov bx, widh
add bx, new1
dec dx 
;DrawFilledRectangle
call lastpart
mov cx, widh+rwidth 
add cx, new1
mov bx, widh
add bx, new2
cmp dx, bx 
jne devam   
mov ah,00h
int 16h
cmp ah, 4dh
je shftrgh  
cmp ah, 4bh
je shftlft 
cmp ah, 48h
; If the row counter is not equal to the target, jump to the loop
je blw
cmp ah, 50h
je aboveshft
cmp al, 30h
je code_1
cmp al, 31h 
je drawFilledRectangle 
mov ah,0000 
mov al,03 
int 10h 
mov ah,0000 
int 16h  
cmp al, 1bh 
je Shiftfor
; Adding 1 for movement while our rectangular is filled
shftrgh:
add new1 ,1h 
jmp drawFilledRectangle
shftlft:
sub new1 ,1h
jmp drawFilledRectangle
blw:
sub new2 ,1h
jmp drawFilledRectangle 
aboveshft:
add new2 ,1h
jmp drawFilledRectangle
Shiftfor:
.EXIT
;Calculate New Coordinates for Horizontal Movement
Start ENDP
elves PROC   
    mov dx, widh+rheight 
    add dx, new2 
    mov cx, widh+rwidth
    add cx, new1
    mov al, degisim 
    mov bx, widh
    add bx, new1      
    ret
elves ENDP
second PROC 
;Calculate New Coordinates for Vertical Movement
    mov cx, widh+rwidth 
    add cx, new1
    mov dx, widh+rheight  
    add dx, new2
    mov al, degisim 
    mov bx, widh
    add bx, new2
    ret   
second ENDP 
lastpart PROC
    sonasama:
;Draw a Filled Rectangle Line by Line  
    mov ah, 0ch 
    int 10h
    dec cx 
    cmp cx, bx
    jae sonasama
    ret
lastpart ENDP
;Initialize Video Mode and Display Instructions
    firstpart PROC
    mov ah, 0000 
    mov al, 13h
    int 10h 
    mov AX, @data
    mov DS, AX
    mov AH, 09H
    lea DX, far2
    int 21h
    lea DX, far1
    int 21h
    lea DX, far3
    int 21h
    firstpart ENDP
    ret
END Start