;----------------------------------------------------------------------
; putw.asm - user-callable entry point to _putw() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1996, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

        include rules.asi
	include entry.inc
        Entry@ putw, _putw, _RTLENTRY, 8
        end

