;----------------------------------------------------------------------
; open.asm - user-callable entry point to open() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

extern __open
global open

SECTION .text
open:	
	jmp	__open

