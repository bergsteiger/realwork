;[]-----------------------------------------------------------------[]
;|   FIBER32.ASM -- routines to get fiber information                |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

        include RULES.ASI

;       Segments Definitions

Header@

Code_seg@

Func@   GetFiberData, _EXPFUNC, _RTLENTRY

        mov     eax,fs:[10h]
        mov     eax,[eax]
        ret
        align   4

EndFunc@ GetFiberData

Func@   GetCurrentFiber, _EXPFUNC, _RTLENTRY

        mov     eax,fs:[10h]
        ret
        align   4

EndFunc@ GetCurrentFiber

Code_EndS@

        end
