;[]-----------------------------------------------------------------[]
;|   FPRESET.ASM -- reset floating-point processor                   |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 28857 $

        include RULES.ASI

;       Segments Definitions

Header@

;----------------------------------------------------------------------
; External variables

Data_Seg@

ExtSym@     _default87, dword, cdecl    ; default x87 control word

Data_EndS@


;--------------------------------------------------------------------------
;
;Name           _fpreset - reinitializes floating point math package
;
;Usage          void _fpreset(void);
;
;Prototype in   float.h
;
;Description    _fpreset  reinitializes the   floating point  math package.
;               This function  is usually used in  conjunction with signal,
;               system, or the exec... or spawn... functions.
;
;Return value   No return value
;
;--------------------------------------------------------------------------

Code_seg@

ifdef MAGIC
ExtFunc@ __control87, _RTLENTRY, 8
Func@   __fpreset, _EXPFUNC, _RTLENTRY
else
ExtFunc@ _control87, _RTLENTRY, 8
Func@   _fpreset, _EXPFUNC, _RTLENTRY
endif	
Locals@ <int Control>

        fninit                          ; FNINIT causes all exceptions to
                                        ; be ignored, FINIT allows exceptions
                                        ; to occur.

        push    dword ptr 1fffh         ; control word mask
;Hack
        push    dword ptr _default87@   ; get default control word
ifdef MAGIC
        Call@   __control87             ; set new control word
else
        Call@   _control87              ; set new control word
endif	

        Return@

ifdef MAGIC
EndFunc@ __fpreset
else
EndFunc@ _fpreset
endif	
Code_EndS@

        end
