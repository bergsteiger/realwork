;----------------------------------------------------------------------
; unlink.nasm - user-callable entry point to unlink() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1996, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

extern _unlink
global unlink

SECTION .text
unlink:	
	jmp	_unlink
