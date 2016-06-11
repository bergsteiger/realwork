;[]-----------------------------------------------------------------[]
;|   _STPCPY.NASM -- copy string src to string dest                  |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

;       Segments Definitions

;-----------------------------------------------------------------------
;
;Name           _stpcpy - copy string src to string dest
;
;Usage          char *_stpcpy (char *dest, const char *src);
;
;Prototype in   string.h
;
;Description    Copy the ASCIIZ string *src to the buffer *dest. It is the
;               callers responsibility  to ensure that the dest buffer is
;               large enough  to contain the  string, and to guard against
;               supplying NULL arguments.  This implementation has been
;		optimized for the Pentium processor.
;
;Return value   pointer to the end of the resulting string.
;
;-----------------------------------------------------------------------

CPU 386

SECTION .text

global _stpcpy
	
_stpcpy:
	mov     eax, [esp+4]	; get dest string
	mov     edx, [esp+8]	; get source string

Again:
	mov	cl, [edx]
	mov	[eax], cl	; move one byte
	test	cl, cl		; was it the end ?
	jz	Exit
	inc	eax

	mov	cl, [edx+1]
	mov	[eax], cl	; move one byte
	test	cl, cl		; was it the end ?
	jz	Exit
	inc	eax

	mov	cl, [edx+2]
	mov	[eax], cl	; first byte
	test	cl, cl		; was it the end ?
	jz	Exit
	inc	eax

	mov	cl, [edx+3]
	add	edx, 4		; interleaved to allow pipelining
	mov     [eax] , cl
	test    cl, cl		; was it the end?
	jz	Exit
	inc	eax

	jmp	Again

Exit:
	ret

	
