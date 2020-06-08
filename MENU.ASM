mess macro msg
mov ah,09h
lea dx,msg
int 21h
endm

.model small

.data
msg1 db 0ah,0dh,"MENU $"
msg2 db 0ah,0dh,"1.ADDITION (8 bit) $"
msg3 db 0ah,0dh,"2.SUBTRACTION (8 bit) $"
msg4 db 0ah,0dh,"3.MULTIPLICATION $"
msg5 db 0ah,0dh,"ENTER YOUR CHOICE : $"
msg6 db 0ah,0dh,"ENTER FIRST NUMBER : $"
msg7 db,0ah,0dh,"ENTER SECOND NUMBER : $"
msg8 db,0ah,0dh,"WRONG CHOICE $"
msg9 db,0ah,0dh,"THE RESULT IS $"
N1 db 0h
N2 dw 0000h

.code

mov ax,@data
mov ds,ax

mess msg1
mess msg2
mess msg3
mess msg4
mess msg5

mov ah,01h
int 21h


cmp al,31h
jne ch1

call addition
jmp exitprogram

ch1 : cmp al,32h
	  jne ch2
	  
	  call subtraction 
	  jmp exitprogram
	  
	  
ch2 : cmp al,33h
	  jne exitprogram
	 
	  call multi 
	  jmp exitprogram
	  
exitprogram: mov ah,4ch
             int 21h
			 
			 
proc num near


mov ah,01h
int 21h

cmp al,3ah
jc down1

sub al,07h

down1: and al,0fh

ret 
endp

DISP PROC NEAR

         
         AND CL,0FH
         CMP CL,0AH
         JC DOWN3
        
         ADD CL,07H
        
         DOWN3 : ADD CL,30H
		 
		  MOV DL,CL
		  MOV AH,02H
		  INT 21H

 RET
 ENDP


proc addition near

;Accept first number
mess msg6
call num
rol al,04h
mov bl,al

CALL num
add bl,al

;Accept second number
mess msg7
call num
rol al,04h
mov cl,al

call num
add cl,al

;ADDING 2 8 BIT NUMBERS
add bl,cl

;DISPLAYING
mess msg9

MOV N1,bl
ROR N1,04H
MOV CL,N1
call DISP

MOV CL,BL
CALL DISP

RET
ENDP


PROC subtraction NEAR

;Accept first number
mess msg6
call num
rol al,04h
mov bl,al

CALL num
add bl,al

;Accept second number
mess msg7
call num
rol al,04h
mov cl,al

call num
add cl,al

;Subtracting 2 8 bit numbers
sub bl,cl

;Displaying
mess msg9
MOV N1,bl
ROR N1,04H
MOV CL,N1
CALL DISP

MOV CL,BL
CALL DISP

RET
ENDP

PROC multi NEAR

;Accept first number
mess msg6
call num
rol al,04h
mov bl,al

CALL num
add bl,al

;Accept second number
mess msg7
call num
rol al,04h
mov cl,al

call num
add cl,al

mov al,bl
mul cl
mov N2,ax

;Displaying
 
  mess msg9
  MOV BX,N2
  MOV CH,BH
  ROR CH,04H
  MOV CL,CH
  CALL DISP
  
 
  ROR CH,04H
  MOV CL,CH
  CALL DISP
  
  MOV BX,N2
  MOV CH,BL
  ROR CH,04H
  MOV CL,CH
  CALL DISP
  
  
  ROR CH,04H
  MOV CL,CH
  CALL DISP
  
RET
ENDP


END







