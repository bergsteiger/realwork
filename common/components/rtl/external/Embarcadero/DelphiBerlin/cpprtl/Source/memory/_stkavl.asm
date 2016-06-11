;[]-----------------------------------------------------------------[]
;|   _STKAVL.ASM -- available stack space                            |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1992, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 23293 $

        include RULES.ASI

;       Segments Definitions

Header@

; REGSTACK contains the number of bytes taken up in the stack
; by registers saved in the normal function prologue.  This includes
; space for EBX, ESI, and EDI.

REGSTACK   equ     12

;-----------------------------------------------------------------------
;
;Name           _stackavail - get available stack size
;
;Usage          #include <malloc.h>
;               size_t _stackavail(void);
;
;Prototype in   _malloc.h
;
;Description    This function returns the approximate number of bytes
;               available in the stack for allocation by alloca().
;
;               This is the internal function that corresponds to
;               the user-visible function stackavail().  The prototype
;               for stackavail() appears in malloc.h.
;
;Return value   The number of available stack bytes.
;
;------------------------------------------------------------------------

Code_seg@

;ExtFunc@ TlsGetValue, APIENTRY, 4  ; API function

extrn ___GetStkIndex:proc               ; Gets the _stkindex value (in TLS.C)

Func@   _stackavail, public, _RTLENTRY

        call    ___GetStkIndex          ; Get the stack base value (in TLS.C)
        pop     ecx                     ; get return address
        add     eax, REGSTACK           ; adjust for saved register variables
        cmp     eax, esp                ; is the stack pointer below base?
        ja      nospace                 ; yes - no space available
        neg     eax                     ; no - calculate available space
        add     eax, esp
return:
        jmp     ecx                     ; return, EAX = available space
nospace:
        xor     eax,eax
        jmp     return
EndFunc@ _stackavail
Code_EndS@

        end
