;[]-----------------------------------------------------------------[]
;|   STRNCAT.ASM -- appends one string to another                    |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 26680 $

        include RULES.ASI

;       Segments Definitions

Header@

;-----------------------------------------------------------------------
;
;Name           strncat, wcsncat - appends strings
;
;Usage          char *strncat(char *destin, const char *source, size_t maxlen);
;               wchar_t *wcsncat(wchar_t *destin, const wchar_t *source, size_t maxlen);
;
;Prototype in   string.h
;
;Description    strncat/wcsncat copies at most maxlen characters of source to the
;               end of destin and then appends a null character. The maximum
;               length of the resulting string is strlen(destin) + maxlen.
;               This implementation has been optimized for the Pentium processor.
;
;Return value   pointer to destin
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
    incEBX EQU  inc ebx
else
    reg_a  EQU  ax
    reg_b  EQU  bx
    ofs_1  EQU  2
    ofs_2  EQU  4
    ofs_3  EQU  6
    ofs_4  EQU  8
    incEBX EQU  add ebx, 2
endif


ifndef _UNICODE
Func@   strncat, _EXPFUNC, _RTLENTRYF, <pointer dest>, <pointer src>, <int maxlen>
else
Func@   wcsncat, _EXPFUNC, _RTLENTRYF, <pointer dest>, <pointer src>, <int maxlen>
endif

_dest     EQU [esp+4]
_src      EQU [esp+8]
_maxlen   EQU [esp+12]

        mov     eax,_dest    ; dest
        mov     edx,_src     ; src
        mov     ecx,_maxlen  ; maxlen

        dec     ecx
        js      @exit        ; nothing to do

        push    ebx

        mov     ebx,eax
        xor     eax,eax
@FindDestEnd:
        cmp     [ebx],reg_a
        je      @begincopy
        cmp     [ebx+ofs_1],reg_a
        je      @begincopy1
        cmp     [ebx+ofs_2],reg_a
        je      @begincopy2
        cmp     [ebx+ofs_3],reg_a
        je      @begincopy3
        add     ebx,ofs_4
        jmp     @FindDestEnd

        nop     ; align @begincopy
@begincopy3: incEBX
@begincopy2: incEBX
@begincopy1: incEBX
@begincopy:                     ; ebx points to terminating null in dest

        mov     reg_a,[edx]
        mov     [ebx],reg_a
        test    reg_a,reg_a
        jz      @return
        dec     ecx
        js      @endcopy1       ; append '\0'

        mov     reg_a,[edx+ofs_1]
        mov     [ebx+ofs_1],reg_a
        test    reg_a,reg_a
        jz      @return
        dec     ecx
        js      @endcopy2       ; append '\0'

        mov     reg_a,[edx+ofs_2]
        mov     [ebx+ofs_2],reg_a
        test    reg_a,reg_a
        jz      @return
        dec     ecx
        js      @endcopy3       ; append '\0'

        mov     reg_a,[edx+ofs_3]
        mov     [ebx+ofs_3],reg_a
        test    reg_a,reg_a
        jz      @return
        dec     ecx
        js      @endcopy4       ; append '\0'

        add     ebx,ofs_4
        add     edx,ofs_4

        jmp     @begincopy

        nop     ;Align @endcopy1 and @return
        nop
@endcopy4: incEBX
@endcopy3: incEBX
@endcopy2: incEBX
@endcopy1: incEBX
        xor     eax,eax
        mov     [ebx],reg_a

@return:
        pop     ebx
        mov     eax,_dest       ; return dest
@exit:
        Return@

ifndef  _UNICODE
EndFunc@ strncat
else
EndFunc@ wcsncat
endif

Code_EndS@

    end

