section .text
	global _start

_start:
	push ebp 			; it doesn't work otherwise
	mov ebp, esp		; we can't read directly is esp so we mov in ebp
	add ebp, 4 			; argc is stored 4 bytes later so we add 4
	cmp byte [ebp], 2 	; compare argc with 2
	jne not_equal 		; if argc != 2 => jump to exit

	mov edx, [ebp + 8]  ; we store argv[0] in edx
	cmp byte [edx], 0x34 
	jne not_equal
	cmp byte [edx + 1], 0x32
	jne not_equal

	mov ebx, 1
	mov ecx, msg
	mov edx, len
	mov eax, 0x04
	int 0x80
	mov ebx, 0
	jmp exit

not_equal:
	mov ebx, 1

exit:
	mov eax, 0x01
	int 0x80


section .data
	msg: db "1337", 0x0a
	len: equ $-msg
