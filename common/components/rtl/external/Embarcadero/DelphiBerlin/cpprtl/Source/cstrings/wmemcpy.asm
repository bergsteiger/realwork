;[]-----------------------------------------------------------------[]
;|   WMEMCPY.ASM --  copy a block of n words from src to dst         |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1996, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 25406 $

        include RULES.ASI

;       Segments Definitions

Header@

;-----------------------------------------------------------------------
;
;Name           wmemcpy - copy a block of n words from src to dst
;
;Usage          wchar_t *wmemcpy(wchar_t *dest, const wchar_t *src, size_t n);
;
;Prototype in   mem.h & string.h
;
;Description    wmemcpy copies  a block of n words from src to dest.
;                       No overlap checking is performed.
;
;Return value   wmemcpy returns dest
;
;-----------------------------------------------------------------------

Code_seg@

ExtFunc@    _internal_memmove, fastcall

Func@   wmemcpy, _EXPFUNC, _RTLENTRY, <pointer dest>,<pointer src>,<int n>


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

EndFunc@ wmemcpy

_EXPFUNC __wmemcpy
__wmemcpy label near
        jmp _wmemcpy
	
Code_EndS@

        end
