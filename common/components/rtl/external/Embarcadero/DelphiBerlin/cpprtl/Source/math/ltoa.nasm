;----------------------------------------------------------------------
; ltoa.nasm - user-callable entry point to _ltoa() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 2014, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: $

extern _ltoa
global ltoa
ltoa:
	jmp _ltoa

