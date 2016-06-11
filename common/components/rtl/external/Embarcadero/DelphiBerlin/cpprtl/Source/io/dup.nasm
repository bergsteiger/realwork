;----------------------------------------------------------------------
; dup2.nasm - user-callable entry point to dup() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 2012, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision$

extern __dup
global dup

SECTION .text
dup:	
	jmp	__dup

