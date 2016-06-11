SECTION .text

global _FastMM_FindFirstSetBit
; ecx = bits
_FastMM_FindFirstSetBit:
	mov	rax, rcx
	bsf	eax, eax
	ret

global _FastMM_LockCmpxchg
; cl = compare value
; dl = new value
; r8 = address
_FastMM_LockCmpxchg:
	mov	rax, rcx
	lock cmpxchg [r8], dl
	ret