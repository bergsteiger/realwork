;----------------------------------------------------------------------
; cwait.nasm - user-callable entry point to _cwait() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 2012, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision$

extern _cwait
global cwait

SECTION .text
cwait:
	jmp	_cwait
