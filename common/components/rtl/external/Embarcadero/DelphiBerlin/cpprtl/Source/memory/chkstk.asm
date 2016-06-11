;[]-----------------------------------------------------------------[]
;|   CHKSTK.ASM -- allocate local stack space                        |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 35746 $

        include RULES.ASI
        include INIT.INC

;       Segments Definitions

        Header@

;----------------------------------------------------------------------
; Name          __chkstk - allocate temporary stack memory
;
; Description   __chkstk is a helper function for the compiler.  It is
;               called in the prologue to a function that has more than
;               4K bytes of local variables.  It performs a stack probe
;               by poking all pages in the new stack area, then allocates
;               the required stack space.  The number of bytes to
;               allocate is passed in EAX.
;
;               A typical function prologue that uses __chkstk looks
;               like this:
;
;                   PUSH    EBP
;                   MOV     EBP,ESP
;                   MOV     EAX,1234H       ; no. of bytes of locals
;                   CALL    __chkstk        ; allocate locals
;----------------------------------------------------------------------

        Code_seg@

Func@   _chkstk, public, cdecl

        push    ecx
        lea     ecx, [esp]+8    ; stack starts at return address
loop1:
        cmp     eax, 1000h      ; more than 4K left?
        jae     probe
        sub     ecx, eax        ; less than 4K - finish adjustment with remainder
        jmp     finished
probe:
        sub     ecx, 1000h      ; adjust new stack by a page
        test    [ecx], eax
        sub     eax, 1000h      ; reduce byte count
        jnz     loop1
finished:
        mov     eax, esp        ; get original stack ponter
        mov     esp, ecx        ; set new stack pointer
        mov     ecx, [eax]      ; saved ECX
        mov     eax, [eax+4]    ; return address
        push    eax             ; last probe
        ret

EndFunc@ _chkstk

        Code_EndS@

;----------------------------------------------------------------------
; Cause the _initstk function to be called at startup time.  This
; will set up things for automatic stack growth and checking.

        InitExt@ _initstk, 0, _RTLENTRY

        end
