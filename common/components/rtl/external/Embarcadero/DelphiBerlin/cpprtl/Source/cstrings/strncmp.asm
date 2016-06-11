;[]-----------------------------------------------------------------[]
;|   STRNCMP.ASM -- compare one string to another                    |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 24901 $

        include RULES.ASI

;       Segments Definitions

Header@

;-----------------------------------------------------------------------
;
;Name           strncmp, wcsncmp - compare one string to another
;
;Usage          int strncmp(const char *str1, const char *str2, size_t maxlen);
;		int wcsncmp(const wchar_t *str1, const wchar_t *str2, size_t maxlen);
;
;Prototype in   string.h
;
;
;Description    Compare *str1  with *str2, returning  a negative, zero,  or
;               positive integer  according to whether *str1  is less than,
;               equal, or greater than *str2, respectively.
;
;               At most "maxlen" characters will be compared. A "maxlen" of zero
;               results in an equal compare, i.e. returns a zero.
;
;Return value   strncmp and wcsncmp return an integer value as follows:
;                   < 0 if str1 is less than str2
;                   = 0 if str1 is the same as str2
;                   > 0 if str2 is greater than str2
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


ifndef	_UNICODE
Func@   strncmp, _EXPFUNC, _RTLENTRYF, <pointer str1>, <pointer str2>, <int maxlen>
else
Func@   wcsncmp, _EXPFUNC, _RTLENTRYF, <pointer str1>, <pointer str2>, <int maxlen>
endif

    mov  eax, [esp+4]   ; str1
    mov  edx, [esp+8]   ; str2
    mov  ecx, [esp+12]  ; maxlen

    push edi
    push ebx
    mov  edi, eax

    xor  eax, eax
    xor  ebx, ebx

PSloop:
    dec  ecx
    js   PSend               ; equal

    mov  reg_a, [edi]
    mov  reg_b, [edx]
    sub  eax, ebx
    jne  PSend
    test reg_b, reg_b        ; string end
    je   PSend
    dec  ecx                 ; maxlen reached
    js   PSend

    mov  reg_a, [edi+ofs_1]
    mov  reg_b, [edx+ofs_1]
    sub  eax, ebx
    jne  PSend
    test reg_b, reg_b        ; string end
    je   PSend
    dec  ecx                 ; maxlen reached
    js   PSend

    mov  reg_a, [edi+ofs_2]
    mov  reg_b, [edx+ofs_2]
    sub  eax, ebx
    jne  PSend
    test reg_b, reg_b        ; string end
    je   PSend
    dec  ecx                 ; maxlen reached
    js   PSend

    mov  reg_a, [edi+ofs_3]
    mov  reg_b, [edx+ofs_3]
    sub  eax, ebx
    jne  PSend
    add  edi, ofs_4
    add  edx, ofs_4
    test reg_b, reg_b         ; string end
    jne  PSloop

PSend:
     pop ebx
     pop edi
     Return@

ifndef  _UNICODE
EndFunc@ strncmp
else
EndFunc@ wcsncmp
endif
Code_EndS@

        end
