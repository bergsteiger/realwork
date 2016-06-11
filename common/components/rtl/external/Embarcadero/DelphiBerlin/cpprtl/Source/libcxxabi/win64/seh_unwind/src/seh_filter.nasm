SECTION .text

global	__invoke_filter_function
__invoke_filter_function:
	; rcx = filter rbp, rdx = unwind_exception, r8 = target_ip
;	push  	rbp
	mov	rbp, rcx
	mov	rax, rdx
	mov	rdx, 2
	jmp	r8
