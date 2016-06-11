;----------------------------------------------------------------------
; _efcvt.nasm - user-callable entry points to _ecvt() and _fcvt() functions.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 2012, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

extern _ecvt
global ecvt
ecvt:
	jmp _ecvt

extern _fcvt
global fcvt
fcvt:
	jmp _fcvt
