;----------------------------------------------------------------------
; getpid.nasm - user-callable entry point to _getpid() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 23.0
; 
;       Copyright (c) 2012, 2015 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision$

extern _getpid
global getpid

SECTION .text
getpid:
	jmp	_getpid
