;[]-----------------------------------------------------------------[]
;|   STRCHR.ASM -- scans a string for the first occurrence of a      |
;|                 given character                                   |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 28523 $

        include RULES.ASI

;       Segments Definitions

Header@

;-----------------------------------------------------------------------
;
;Name		strchr, wcschr - scans a string for the first occurrence of a
;		         given character
;
;Usage		char *strchr(const char *str, int c);
;		wchar_t *wcschr(const wchar_t *str, wchar_t c);
;
;Prototype in	string.h
;
;Description	strchr scans a string in the forward direction, looking for a
;		specific character. strchr finds the first occurrence of the
;		character ch in the string str.
;
;		The null-terminator is considered to be a part of the string,
;		so that, for example
;
;			strchr(strs, 0)
;			wcschr(strs, 0)
;
;		returns a pointer to the terminating null character of the
;		string "strs".  This implementation has been optimized
;		for the Pentium processor.
;
;Return value	strchr  returns a pointer to the first occurrence of the
;		character ch in str; if ch does not occur in str, strchr
;		returns NULL.
;
;-----------------------------------------------------------------------

Code_seg@

ifndef  _UNICODE
    reg_a  EQU  al
    reg_b  EQU  bl
    ofs_1  EQU  1
    ofs_2  EQU  2
    ofs_3  EQU  3
    ofs_4  EQU  4
else
    reg_a  EQU  ax
    reg_b  EQU  bx
    ofs_1  EQU  2
    ofs_2  EQU  4
    ofs_3  EQU  6
    ofs_4  EQU  8
endif



ifndef _UNICODE
Func@   strchr, _EXPFUNC, _RTLENTRYF, <pointer strng>, <int c>
else
Func@   wcschr, _EXPFUNC, _RTLENTRYF, <pointer strng>, <int c>
endif

_strng     EQU [esp+4]
_c         EQU [esp+8]

    mov     edx, _strng          ; get source string
    mov     reg_a, _c            ; search for character
    push    ebx

Again:
    mov     reg_b, [edx]
    cmp     reg_a, reg_b
    je      Found0
    test    reg_b, reg_b
    jz      notfound

    mov     reg_b, [edx+ofs_1]
    cmp     reg_a, reg_b
    je      Found1
    test    reg_b, reg_b
    jz      notfound

    mov     reg_b, [edx+ofs_2]
    cmp     reg_a, reg_b
    je      Found2
    test    reg_b, reg_b
    jz      notfound

    mov     reg_b, [edx+ofs_3]
    cmp     reg_a, reg_b
    je      Found3
    add     edx, ofs_4
    test    reg_b, reg_b
    jnz     Again

notfound:
    xor     eax, eax
    jmp     return

Found0:
    mov     eax, edx
    jmp     return

Found1:
    lea     eax, [edx+ofs_1]
    jmp     return

Found2:
    lea     eax, [edx+ofs_2]
    jmp     return

Found3:
    lea     eax, [edx+ofs_3]

return:
    pop     ebx
    Return@

ifndef _UNICODE
EndFunc@ strchr
else
EndFunc@ wcschr
endif

Code_EndS@

    end
