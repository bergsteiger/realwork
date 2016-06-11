;[]-----------------------------------------------------------------[]
;|   STPCPY.NASM -- copy string src to string dest                   |
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

extern _stpcpy
global stpcpy

stpcpy:	
	jmp _stpcpy

	
