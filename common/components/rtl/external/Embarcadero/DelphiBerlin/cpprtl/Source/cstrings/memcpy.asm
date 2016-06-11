;[]-----------------------------------------------------------------[]
;|   MEMCPY.ASM --  copy a block of n bytes from src to dst          |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 


; $Revision: 25391 $

        include RULES.ASI

;       Segments Definitions

Header@

;-----------------------------------------------------------------------
;
;Name           memcpy - copy a block of n bytes from src to dst
;
;Usage          void *memcpy(void *dest, const void *src, size_t n);
;
;Prototype in   mem.h & string.h
;
;Description    memcpy copies  a block of n  bytes from src to dest.
;               No overlap checking is required.
;
;Return value   memcpy returns dest
;
;-----------------------------------------------------------------------

Code_seg@

ExtFunc@    _internal_memmove, fastcall

Func@   memcpy, _EXPFUNC, _RTLENTRY, <pointer dest>,<pointer src>,<int n>

_dest     EQU [esp+4]
_src      EQU [esp+8]
_n        EQU [esp+12]

        mov     edx,_dest        ; get dest
        mov     eax,_src         ; get src
        mov     ecx,_n           ; get n
        FastCall@ _internal_memmove
        mov     eax,_dest
        Return@

EndFunc@ memcpy

Code_EndS@

        end
