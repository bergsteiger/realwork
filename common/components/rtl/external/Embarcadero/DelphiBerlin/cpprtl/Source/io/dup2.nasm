;----------------------------------------------------------------------
; dup2.nasm - user-callable entry point to dup2() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 2012, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision$

extern __dup2
global dup2

SECTION .text
dup2:	
	jmp	__dup2

