;[]-----------------------------------------------------------------[]
;|   CHKSTK.NASM -- allocate local stack space                        |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 2012, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision$

;----------------------------------------------------------------------
; Name          __chkstk - allocate temporary stack memory
;
; Description   _chkstk is a helper function for the compiler.  It is
;               called in the prologue to a function that has more than
;               4K bytes of local variables.  It performs a stack probe
;               by poking all pages in the new stack area.  The number 
;               of bytes that will be allocated is passed in RAX.
;
;----------------------------------------------------------------------

%define PAGE_SIZE 01000h

SECTION .text
global __chkstk
__chkstk:
        lea     r10, [rsp]
	mov	r11, r10
	sub	r11, rax
	and	r11w, 0f000h
	and	r10w, 0f000h
loop1:
	sub	r10, 01000h
        cmp     r10, r11       ; more to go?
        jl      exit
	mov 	qword [r10], 0 ; probe this page
        jmp     loop1
exit:
	ret
