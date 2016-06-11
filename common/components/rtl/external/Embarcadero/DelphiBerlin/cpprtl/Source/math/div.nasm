;[]-----------------------------------------------------------------[]
;|   DIV.NASM -- integer division                                     |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 2012, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision$

; Definition of div_t that matches stdlib.h

struc div_t
quot    resd 1
rem     resd 1
endstruc

;-----------------------------------------------------------------------
;
;Name           div - integer division
;               ldiv - long integer division
;
;Usage          div_t div(int numer, int denom);
;               ldiv_t ldiv(long numer, long denom);
;
;Prototype in   stdlib.h
;
;Description    div computes the quotient and  remainder of the division of
;               the numerator  "numer" by the  denominator "denom". If  the
;               result cannot be represented, the behavior is undefined.
;
;               ldiv is similar, except that it operates on long integers.
;
;Return value   div returns a structure of  type div_t, comprising both the
;               quotient and the remainder.  ldiv returns a similar structure
;               of type ldiv_t, whose members are long integers.
;
;-----------------------------------------------------------------------

SECTION .text
global ldiv
ldiv:
	; drop into div -- long is the same size as int
global div
div:
	mov	eax, ecx                ; get numerator
	mov	r8d, edx                ; get denominator
	cdq                             ; convert to quadword EDX:EAX
	idiv    r8d                     ; EAX = quotient, EDX = remainder
	shl	rdx, 32
	or      rax, rdx
	ret
