;----------------------------------------------------------------------
; remove.asm - user-callable entry point to _unlink() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

extern _unlink
global remove

SECTION .text
remove:	
	jmp	_unlink
