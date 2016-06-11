;----------------------------------------------------------------------
; open.asm - user-callable entry points to open() function.
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
        Entry@ open, __open, cdecl
	;;  MS compat 
        Entry@ _open, __open, cdecl
        end
