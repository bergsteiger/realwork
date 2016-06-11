;----------------------------------------------------------------------
; read.nasm - user-callable entry point to read() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

extern __read
global read

SECTION .text
read:	
	jmp	__read

