;----------------------------------------------------------------------
; wopen.asm - user-callable entry points to wopen() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 2008, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

        include rules.asi
        include entry.inc
        Entry@ wopen, __wopen, cdecl
	;;  MS compat 
        Entry@ _wopen, __wopen, cdecl
        end
