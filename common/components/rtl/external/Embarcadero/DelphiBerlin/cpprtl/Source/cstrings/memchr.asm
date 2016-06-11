;[]-----------------------------------------------------------------[]
;|   MEMCHR.ASM -- search for a character                            |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 


; $Revision: 25406 $

        include RULES.ASI

;       Segments Definitions

Header@

;-----------------------------------------------------------------------
;
;Name            memchr, wmemchr - search for a character
;
;Usage           void *memchr(const void *s, int val, size_t n);
;                wchar_t *wmemchr(const wchar_t *s, int val, size_t n);
;
;Prototype in    mem.h & string.h
;
;Description     memchr scans up to n bytes at the memory location s
;                looking for a match to val.
;
;Return value    If  val  was matched then the  return value is a
;                pointer to the first matching position, otherwise it
;                is NULL.
;
;-----------------------------------------------------------------------

Code_seg@

ifndef  _UNICODE
    reg_c  EQU  cl
    ofs_1  EQU  1
    ofs_2  EQU  2
    ofs_3  EQU  3
    ofs_4  EQU  4
    ofs_5  EQU  5
    ofs_6  EQU  6
    ofs_7  EQU  7
    ofs_8  EQU  8
    incEAX EQU  inc eax
else
    reg_c  EQU  cx
    ofs_1  EQU  2
    ofs_2  EQU  4
    ofs_3  EQU  6
    ofs_4  EQU  8
    ofs_5  EQU  10
    ofs_6  EQU  12
    ofs_7  EQU  14
    ofs_8  EQU  16
    incEAX EQU  add eax, 2
endif

ifndef _UNICODE
Func@   memchr, _EXPFUNC, _RTLENTRY, <pointer s>, <int val>, <int n>
else
Func@   wmemchr, _EXPFUNC, _RTLENTRY, <pointer s>, <int val>, <int n>
endif

_s      EQU [esp+4]
_val    EQU [esp+8]
_n      EQU [esp+12]

        ; load parameters
        mov     edx, _n
        mov     eax, _s
        mov     reg_c, _val

Loop8:
        ; Less than 8 chars => use single loop
        sub     edx, 8
        js      SingleLoopStart

        cmp     [eax], reg_c
        je      found
        cmp     [eax+ofs_1], reg_c
        je      found1
        cmp     [eax+ofs_2], reg_c
        je      found2
        cmp     [eax+ofs_3], reg_c
        je      found3
        cmp     [eax+ofs_4], reg_c
        je      found4
        cmp     [eax+ofs_5], reg_c
        je      found5
        cmp     [eax+ofs_6], reg_c
        je      found6
        cmp     [eax+ofs_7], reg_c
        je      found7
        add     eax, ofs_8
        jmp     Loop8

SingleLoopStart:
        add     edx, 7    ; add edx, 8; dec edx
        js      notfound
SingleLoop:
        cmp     [eax], reg_c
        je      found
        incEAX
        dec     edx
        jns     SingleLoop
notfound:
        xor     eax, eax  ; not found, return NULL
        Return@

found7: incEAX
found6: incEAX
found5: incEAX
found4: incEAX
found3: incEAX
found2: incEAX
found1: incEAX
found:
        Return@

ifndef _UNICODE
EndFunc@ memchr
else
EndFunc@ wmemchr

_EXPFUNC __wmemchr
__wmemchr label near
        jmp _wmemchr

endif

Code_EndS@

        end
