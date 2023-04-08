includelib legacy_stdio_definitions.lib
extrn printf : near
extrn scanf : near


;; Data segment
.data
Public inp_int
		inp_int QWORD 0
print_string	BYTE "Please enter an integer: ", 0Ah, 00h
print_string2	BYTE "The sum of the maximum value and user input (%lld, %lld ): %lld\n", 0Ah, 00h
scan_string		BYTE "%lld",0

;; Code segment
.code

public gcd_recursion
gcd_recursion:
		mov[rsp+16], rcx	; preserving a
		mov[rsp+8], rdx		; preserving b
		
		cmp	rdx, 0			; if (b == 0)	
		jne else1			; {
		mov	rax, rcx		;		return a;
		jmp	finish			; }
else1:						; else {	

		mov	r8,rdx			;		save b
		xor rdx,rdx			;		clear the bits 
		mov rax, rcx		;		move b into first parameter
		div r8				;		call div to get the modulus

		mov rcx, r8			;		move back the b param

		sub rsp,40			;		the shadow space
		call gcd_recursion	;		return gcd_recursion(b,a%b);
		add rsp,40			;		restoring shadow space
finish:						; }

		ret


public use_scanf
use_scanf:
		mov[rsp+16], rcx			; preserving array_size
		mov[rsp+8], rdx				; preserving array address


		; for loop to get the max
		xor		r8, r8				; i = 0
		mov		r9, [rdx]			; m = load first array element
for1:
		inc		r8					; i ++
		cmp		r8, rcx				; for (i < array_size)
		jae		next				; {
		mov		r10, [rdx+r8*8]		;	n = load next array element
		cmp		r9, r10				;	if (m < n)
		jg		for1				;	{
		mov		r9, r10				;		m = n
		jmp		for1				;	}
next:								; }


		mov[rsp+16],r9				; save max_value
		sub rsp, 40					; the shadow space
		
		lea rcx, print_string		; 1st argument : string
		call printf					; call the function

		lea	rcx, scan_string		; what we are scanning
		lea	rdx, inp_int			; address to scan into

		call scanf					; call the scan

		mov	rax,[inp_int]			; get inp_int

		add	rsp,40					; restore shadow space

		mov	r9,[rsp+16]				; restore max_value
		add	rax,r9					; get sum of max_value and inp_int

		lea rcx, print_string2		; 1st argument : string
		mov	rdx,r9					; 2nd argument : max_value
		mov r8,[inp_int]			; 3rd argument : inp_int
		mov r9,rax					; 4th argument : sum

		push	rax					; save sum

		sub rsp, 40					; the shadow space
		call printf					; call the function
		add rsp,40					; restore shadow space

		pop		rax					; restore sum

		ret



public min5
min5:

		mov[rsp+32], rcx	; preserving i
		mov[rsp+24], rdx	; preserving j
		mov[rsp+16], r8		; preserving k
		mov[rsp+8], r9		; preserving k
		

		mov r10, r8			; save k
		mov r11, r9			; save l

		; set up to call function
		mov r8, rdx			; c = j
		mov rdx, rcx		; b = i
		mov	rcx, [inp_int]	; a = inp_int
		
		sub rsp, 40			; the shadow space
		call min			; function call

		mov r8, r10			; c = l
		mov rdx, r11		; b = k
		mov rcx, rax		; a = returned value from first function call

		call min			; second function call

		add rsp,40			; restoring shadow space

		ret

min:
		mov[rsp+24], rcx	; preserving a
		mov[rsp+16], rdx	; preserving b
		mov[rsp+8], r8		; preserving c

		mov r9,rdx			; _int64 v = a
		cmp rcx,r9			; if (b < v)
		jge	notlessthan		; {
		mov r9,rcx			;		v = b
notlessthan:				; }
		cmp r8,r9			; if (c < v)
		jge	notlessthan1	; {
		mov r9,r8			;		v = c
notlessthan1:				; }
		mov rax, r9			;	move result into rax
		
		ret

end