;[]-----------------------------------------------------------------[]
;|   STRCMP.ASM -- compare one string to another                     |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 35306 $

	include RULES.ASI

;       Segments Definitions

Header@

;-----------------------------------------------------------------------
;
;Name		strcmp, wcscmp - compare one string to another
;
;Usage		int strcmp(const char *str1, const char str2);
;		int wcscmp(const wchar_t *str1, const wchar_t str2);
;
;Prototype in	string.h
;
;Description	Compare *str1  with *str2, returning  a negative, zero,  or
;		positive integer  according to whether *str1  is less than,
;		equal, or greater than *str2, respectively. This
;		implementation has been optimized for the Pentium processor.
;
;Return value	strcmp return an integer value such as:
;		< 0    if str1 is less than str2
;		= 0    if str1 is the same as str2
;		> 0    if str2 is greater than str2
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
Func@   strcmp, _EXPFUNC, _RTLENTRYF, <pointer str1>, <pointer str2>
else
Func@   wcscmp, _EXPFUNC, _RTLENTRYF, <pointer str1>, <pointer str2>
endif

_str1   EQU  [esp+4]
_str2   EQU  [esp+8]

    mov  ecx, _str1     ; str1
    mov  edx, _str2     ; str2
    push ebx
    xor  eax, eax
    xor  ebx, ebx
PSloop:
    mov  reg_a, [ecx]
    mov  reg_b, [edx]
    sub  eax, ebx
    jne  PSend
    test reg_b,reg_b
    je   PSend

    mov  reg_a, [ecx+ofs_1]
    mov  reg_b, [edx+ofs_1]
    sub  eax, ebx
    jne  PSend
    test reg_b,reg_b
    je   PSend

    mov  reg_a, [ecx+ofs_2]
    mov  reg_b, [edx+ofs_2]
    sub  eax, ebx
    jne  PSend
    test reg_b,reg_b
    je   PSend

    mov  reg_a, [ecx+ofs_3]
    mov  reg_b, [edx+ofs_3]
    sub  eax, ebx
    jne  PSend
    add  ecx, ofs_4
    add  edx, ofs_4
    test reg_b, reg_b
    jne  PSloop

PSend:
     pop ebx
     Return@

ifndef _UNICODE
EndFunc@ strcmp
else
EndFunc@ wcscmp
endif

ifndef _UNICODE
_EXPFUNC __rtl_strcmp
__rtl_strcmp label near
        jmp _strcmp
endif

Code_EndS@

ifndef _UNICODE
; used by the RTL to revector std::strcmp to our definition here.  Which means,
; sadly, that using std::strcmp prevents you from getting the intrinsic.
;alias <__rtl_strcmp>       = <_strcmp>
endif

    end

