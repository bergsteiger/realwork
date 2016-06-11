;----------------------------------------------------------------------
; write.nasm - user-callable entry point to write() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

extern __write
global write

SECTION .text
write:	
	jmp	__write

