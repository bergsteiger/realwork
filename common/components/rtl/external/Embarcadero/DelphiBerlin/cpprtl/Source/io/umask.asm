;----------------------------------------------------------------------
; umask.asm - user-callable entry point to umask() function.
;----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1992, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

        include rules.asi
        include entry.inc
        Entry@ umask, _umask, _RTLENTRYF, 4
        end
