;----------------------------------------------------------------------
; _wremove.nasm - user-callable entry point to _wunlink() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 2012, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

extern _wunlink

SECTION .text
global _wremove
_wremove:	
	jmp	_wunlink
