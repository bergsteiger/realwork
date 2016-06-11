;[]-----------------------------------------------------------------[]
;|   CTRL87.ASM -- access floating-point control word                |
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

;---------------------------------------------------------------------
;
;Name           _control87 - access floating-point control word
;
;Usage          unsigned int _control87(unsigned int new, unsigned int mask);
;
;Prototype in   float.h
;
;Description    This function is used to retrieve or change the floating-
;               point control word.
;
;               For every bit that is on in mask, the corresponding bit
;               in the floating-point control word is set to the value
;               of that bit in new.
;
;Return value   The new floating-point control word value is returned.
;
;Notes:
;The Denormal exception is always trapped on the 8087 and 80287, but
;never on the 80387.  The emulator never generates it.
;
;The Invalid exception is always trapped, as FPU stack overflows and
;underflows can sometimes be repaired transparently, but sometimes
;also cause nonrecoverable fatal errors.
;
;Caution:
;The control word should not be changed directly, unless you wish
;to bypass the RTL trap handling.
;
;It is dangerous to unmask an exception unless the status bit is already
;clear.  To be safe, call _clear87() first.
;
;---------------------------------------------------------------------

Code_seg@

ifdef MAGIC
Func@   __control87, _EXPFUNC, _RTLENTRY, <int new>, <int cwmask>
else
Func@   _control87, _EXPFUNC, _RTLENTRY, <int new>, <int cwmask>
endif	
Locals@ <int Control>

        Link@

        fstcw   Control                 ; get current control word
        mov     ecx, cwmask             ; get mask
        fwait
        movzx   eax, word ptr Control   ; get the current CW (zero high word)
        jecxz   no_update		; don't update if mask is zero
        mov     edx, new                ; get new value of CW
        and     edx, ecx                ; apply mask to new value
        not     ecx                     ; invert the mask
        and     eax, ecx                ; clear bits that were 1 in mask
        or      eax, edx                ; insert bits from new value
        mov     Control, ax             ; save low word in memory
        fldcw   Control                 ; then load it into the x87
        mov     _default87@, eax        ; update the RTLs default so that
                                        ;  fpreset uses this new CW
no_update:      
        Unlink@
        Return@

ifdef MAGIC	
EndFunc@ __control87
else
EndFunc@ _control87
endif	
Code_EndS@

        end
