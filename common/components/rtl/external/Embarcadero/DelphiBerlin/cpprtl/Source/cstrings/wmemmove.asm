;[]-----------------------------------------------------------------[]
;|   WMEMMOVE.ASM --  copy a block of n words from src to dst        |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 2009, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision:$

        include RULES.ASI

;       Segments Definitions

Header@

;-----------------------------------------------------------------------
;
;Name           wmemmove - copy a block of n words from src to dst
;
;Usage          wchar_t *wmemmove(wchar_t *dest, const wchar_t *src, size_t n);
;
;Prototype in   mem.h & string.h
;
;Description    wmemmove copies  a block of n words from src to dest.
;               Overlaping blocks are handled.
;
;Return value   wmemmove returns dest
;
;-----------------------------------------------------------------------

Code_seg@

ExtFunc@    _internal_memmove, fastcall

Func@   wmemmove, _EXPFUNC, _RTLENTRY, <pointer dest>,<pointer src>,<int n>


_dest     EQU [esp+4]
_src      EQU [esp+8]
_n        EQU [esp+12]

        mov     edx,_dest        ; get dest
        mov     eax,_src         ; get src
        mov     ecx,_n           ; get n
        add     ecx,ecx          ; n * 2
        jz      @@Leave
        FastCall@ _internal_memmove
@@Leave:
        mov     eax,_dest
        Return@

EndFunc@ wmemmove

Code_EndS@

        end
