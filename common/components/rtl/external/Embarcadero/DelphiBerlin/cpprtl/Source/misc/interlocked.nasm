;----------------------------------------------------------------------
; interlocked.nasm - support for InterlockedNNNN functions
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 2012, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision$

global InterlockedExchangeAdd

SECTION .text

global InterlockedExchangeAdd
InterlockedExchangeAdd:
	mov   eax,edx
	lock  xadd [rcx],eax
	ret

global InterlockedExchangeAdd64
InterlockedExchangeAdd64:
	mov   rax,rdx
	lock  xadd [rcx],rax
	ret

global InterlockedDecrement
InterlockedDecrement:
	mov   eax, -1
	lock  xadd [rcx],eax
	dec   eax
	ret

global InterlockedDecrement64
InterlockedDecrement64:
	mov   rax, -1
	lock  xadd [rcx],rax
	dec   rax
	ret

global InterlockedIncrement
InterlockedIncrement:
	mov   eax,1
	lock  xadd [rcx],eax
	inc   eax
	ret

global InterlockedIncrement64
InterlockedIncrement64:
	mov   rax,1
	lock  xadd [rcx],rax
	inc   rax
	ret

global InterlockedCompareExchange
InterlockedCompareExchange:
	mov   eax,r8d
	lock  cmpxchg [rcx],edx
	ret

global InterlockedCompareExchange64
InterlockedCompareExchange64:
	mov   rax,r8
	lock  cmpxchg [rcx],rdx
	ret

global InterlockedCompareExchangePointer
InterlockedCompareExchangePointer:
	mov   rax,r8
	lock  cmpxchg [rcx],rdx
	ret

global InterlockedExchangePointer
InterlockedExchangePointer:
	lock  xchg [rcx],rdx
	mov   rax,rdx
	ret

global InterlockedExchange
InterlockedExchange:
	lock  xchg [rcx],edx
	mov   eax,edx
	ret

global InterlockedExchange64
InterlockedExchange64:
	lock  xchg [rcx],rdx
	mov   rax,rdx
	ret
