data segment
string db 'BASED ADDRESSING','$'
data ends

stack segment stack
dw 20h dup(?)
top label word
stack ends

code segment 
        assume ds:data,cs:code,ss:stack
	p proc far

	mov ax,data
	mov ds,ax

	mov ax,stack
	mov ss,ax
	lea sp,top

	;cx计数字符个数,si定位到最后一个字符

	lea si,string
	mov cx,0
l1:;比较是否到字符串尾
    cmp BYTE PTR [si],'$'
    je input 
    inc si
    inc cx
    jmp l1
input:;指向最后一个字符
    lea si,string
    add si,cx
    dec si
l2:;
    mov dl,[si]
    mov ah,02h
    int 21h
    dec si
    loop l2
exit:;返回终止码
    mov ah,4ch
    int 21h

    p endp
code ends
    end p
