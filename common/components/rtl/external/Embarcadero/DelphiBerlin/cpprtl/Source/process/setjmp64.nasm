struc jmp_buf
      j_frame	resq 1
      j_rbx	resq 1
      j_rsp	resq 1
      j_rbp	resq 1	
      j_rsi	resq 1
      j_rdi	resq 1
      j_r12	resq 1
      j_r13	resq 1
      j_r14	resq 1
      j_r15	resq 1
      j_rip	resq 1
      j_mxcsr	resd 1
      j_fpcsr	resw 1
      j_dummy	resw 1
      j_xmm06	reso 1
      j_xmm07	reso 1
      j_xmm08	reso 1
      j_xmm09	reso 1
      j_xmm10	reso 1
      j_xmm11	reso 1
      j_xmm12	reso 1
      j_xmm13	reso 1
      j_xmm14	reso 1
      j_xmm15	reso 1
endstruc

;-----------------------------------------------------------------------
;
;Name            setjmp - nonlocal goto
;
;Usage           #include <setjmp.h>
;                int setjmp(jmp_buf jmpb);
;
;Prototype in    setjmp.h
;
;Description     Saves   current context information     (register,  stack
;                position, and segment values)  in the jmp_buf structure and
;                then returns to the caller.
;
;                Setjmp returns 0 when called directly. The caller of setjmp
;                may be  "returned to" again  by longjmp, when  the function
;                result will never be zero.
;
;                The jmp_buf contains  the entire context necessary for  a C
;                task, including  all segments and  the complete flag  word.
;                Only  the  EX,ECX, and EDX  registers are lost, but then the
;                caller  of setjmp  does not expect them  to be  preserved
;                through a function call.
;
;                On entry, the stack frame looks like:
;
;                top     EIP
;                        jmp_buf pointer
;
;Return value    setjmp returns 0 when it is initially called.
;
;------------------------------------------------------------------------
SECTION .text
global setjmp
setjmp:	
        pop     rdx                     ; get return address
	mov	qword [rcx+j_frame], rsp
      	mov	qword [rcx+j_rbx], rbx
	mov	qword [rcx+j_rbp], rbp
	mov	qword [rcx+j_rsp], rsp
	mov	qword [rcx+j_rsi], rsi
	mov	qword [rcx+j_rdi], rdi
	mov	qword [rcx+j_r12], r12
	mov	qword [rcx+j_r13], r13
	mov	qword [rcx+j_r14], r14
	mov	qword [rcx+j_r15], r15
	mov	qword [rcx+j_rip], rdx
  	stmxcsr dword [rcx+j_mxcsr]  
	fnstcw  word  [rcx+j_fpcsr]  
	movdqu	[rcx+j_xmm06], xmm6
	movdqu 	[rcx+j_xmm07], xmm7
	movdqu 	[rcx+j_xmm08], xmm8
	movdqu 	[rcx+j_xmm09], xmm9
	movdqu 	[rcx+j_xmm10], xmm10
	movdqu 	[rcx+j_xmm11], xmm11
	movdqu 	[rcx+j_xmm12], xmm12
	movdqu 	[rcx+j_xmm13], xmm13
	movdqu 	[rcx+j_xmm14], xmm14
	movdqu 	[rcx+j_xmm15], xmm15
        xor     rax, rax                 ; always return 0
        jmp     rdx                      ; return
