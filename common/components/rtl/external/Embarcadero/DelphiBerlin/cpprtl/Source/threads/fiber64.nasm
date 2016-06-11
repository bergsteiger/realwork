SECTION .text

global NtCurrentTeb
NtCurrentTeb:
        mov     rax, [gs:48]
	ret

global GetCurrentFiber
GetCurrentFiber:
	mov	rax, [gs:32]
	ret

global GetFiberData
GetFiberData:
	mov	rax, [gs:32]
	mov	rax, [rax]
	ret
