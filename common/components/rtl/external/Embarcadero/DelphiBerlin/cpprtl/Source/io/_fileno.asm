;----------------------------------------------------------------------
; fgetchar.asm - user-callable entry point to _fileno() function.
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
        Entry@ fileno, _fileno, _RTLENTRY, 2
        end

