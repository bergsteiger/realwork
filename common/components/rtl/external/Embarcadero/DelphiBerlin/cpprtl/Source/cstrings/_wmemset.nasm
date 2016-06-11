;----------------------------------------------------------------------
; _wmemset.asm - alternative entry point to wmemset() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 2012, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision$

extern wmemset
global _wmemset

SECTION .text
_wmemset:	
	jmp	wmemset

