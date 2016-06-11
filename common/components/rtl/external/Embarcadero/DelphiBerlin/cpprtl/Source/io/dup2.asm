;----------------------------------------------------------------------
; dup2.asm - user-callable entry point to dup2() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

        include rules.asi
	include entry.inc
        Entry@ dup2, __dup2, _RTLENTRY, 8
        end
