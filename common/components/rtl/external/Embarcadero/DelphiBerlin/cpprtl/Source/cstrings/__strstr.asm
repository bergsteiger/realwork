;-----------------------------------------------------------------------
; filename - __strstr.asm
;
; function(s)
;
; jump stub for C++ implementation of strstr()
;-----------------------------------------------------------------------

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $


        include RULES.ASI

;       Segments Definitions

Header@

ExtFunc@        strstr, _RTLENTRY

Code_seg@

Func@           @std@strstr$qpxct1, public, pascal
                jmp     strstr@
EndFunc@        @std@strstr$qpxct1
Func@           @std@strstr$qpcpxc, public, pascal
                jmp     strstr@
EndFunc@        @std@strstr$qpcpxc

Code_EndS@

end
