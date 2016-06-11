;----------------------------------------------------------------------
; stat.nasm - user-callable entry point to _stat() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

extern _stat
global stat

SECTION .text
stat:	
	jmp	_stat

