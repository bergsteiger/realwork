;-----------------------------------------------------------------------
; filename - __memchr.asm
;
; function(s)
;
; jump stub for C++ implementation of memchr()
; jump stub for C++ implementation of _wmemchr()
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

ExtFunc@        memchr, _RTLENTRY
ExtFunc@      _wmemchr, _RTLENTRY

Code_seg@

Func@           @std@memchr$qpxviui, public, pascal
                jmp     memchr@
EndFunc@        @std@memchr$qpxviui
Func@           @std@memchr$qpviui, public, pascal
                jmp     memchr@
EndFunc@        @std@memchr$qpviui

Func@           @std@_wmemchr$qpxbiui, public, pascal
                jmp     _wmemchr@
EndFunc@        @std@_wmemchr$qpxbiui
Func@           @std@_wmemchr$qpbiui, public, pascal
                jmp     _wmemchr@
EndFunc@        @std@_wmemchr$qpbiui

Code_EndS@

end
