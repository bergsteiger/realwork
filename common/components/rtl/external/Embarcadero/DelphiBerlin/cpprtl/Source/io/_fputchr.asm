;----------------------------------------------------------------------
; fputchar.asm - user-callable entry point to _fputchar() function.
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
        Entry@ fputchar, _fputchar, _RTLENTRY, 4
        end

