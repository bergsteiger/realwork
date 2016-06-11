SECTION .text

global	swab
swab:
	test	r8d, r8d
	jle	.exit
	xor	r10d, r10d
.loop:
	mov	r9b, [rcx+r10]
	mov	al, [rcx+r10+1]
	mov	[rdx+r10], al
	mov	[rdx+r10+1], r9b
	add	r10, 2
	cmp	r10d, r8d
	jl	.loop
.exit:
	ret
