;----------------------------------------------------------------------
; close.nasm - user-callable entry point to close() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

extern __close
global close

SECTION .text
close:	
	jmp	__close

