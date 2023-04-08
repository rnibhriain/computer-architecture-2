.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive


;; Data segment
.data


;; Code segment
.code

public multiple_k_asm					; int factorial (int N)
multiple_k_asm	:

		; push base pointer
		push	ebp
		mov		ebp, esp			; stack frame

		; Function body
		mov		ecx, [ebp+8]			; M
		mov		si, [ebp+12]			; N
		mov		bx,	[ebp+16]			; K
		mov		edi, [ebp+20]		; array*

		mov		eax,2
		mul		ecx
		add		edi, eax
again:
		cmp		cx, si				; while (i < N)
		jae		finish				; {

		mov		ax, cx
		xor		dx, dx
		div		bx
		
		cmp		dx, 0
		jne		els
		; array[i] = 1
		mov		dx, 1
		mov		[edi], dx
		add		edi, 2
		inc		cx
		jmp		again
els:
		; array[i] = 0
		mov		dx, 0
		mov		[edi], dx
		add		edi, 2
		inc		cx
		jmp		again				; }
		

		; Function is exiting

finish:	mov		esp, ebp
		pop		ebp
		ret		


public poly					; int factorial (int N)
poly:

		; push base pointer
		push	ebp
		mov		ebp, esp			; stack frame

		; Function body
		mov		ecx, [ebp+8]

		push	ecx
		push	2
		
		call	pow

		mov		esi, eax

		; Function body
		push	ecx
		push	3

		call	pow

		add		eax, esi
		add		eax, ecx
		add		eax, 1

		; Function is exiting

		mov		esp, ebp
		pop		ebp
		ret		0



pow:
		
		; push base pointer
		push	ebp
		mov		ebp, esp			; stack frame

		push	ecx

		mov		edx, [ebp+8]		; arg0
		mov		ecx, [ebp+12]		; arg1


		; Function body
		mov		ebx, 1				; result = 1
		mov		edi, 1				; for (i =1

for1:
		cmp		edi, edx			;	i <= arg1
		ja		finish1
		imul	ebx, ecx			;		result = result * arg0
		add		edi, 1				;	i++)
		jmp		for1


		; Function is exiting

finish1:
		pop		ecx
		pop		ebp

		mov		eax,	ebx
		ret		


public factorial					; int factorial (int N)
factorial:

		; push base pointer
		push	ebp
		mov		ebp, esp			; stack frame

		; Function body
		mov		eax, [ebp+8]
		dec		eax

		cmp		eax, 0
		je		is_zero

		push	eax
		call	factorial

		imul	eax, [ebp+8]
		jmp		return


is_zero:	mov		eax, 1

		; Function is exiting

return:	mov		esp, ebp
		pop		ebp
		ret		


end