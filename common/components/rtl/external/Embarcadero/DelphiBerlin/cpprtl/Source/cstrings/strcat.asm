;[]-----------------------------------------------------------------[]
;|   STRCAT.ASM -- appends one string to another                     |
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
;Name            strcat - appends one string to another
;
;Usage           char *strcat(char *dest, const char *src);
;
;Prototype in    string.h
;
;Description     strcat appends a copy of src to the end of dest. The
;                length of the resulting string is strlen(dest) +
;                strlen(src).
;
;Return value    returns a pointer dest
;
;-----------------------------------------------------------------------

Code_seg@

Func@   strcat, _EXPFUNC, _RTLENTRYF, <pointer dest>, <pointer src>

_dest EQU [esp+4]
_src  EQU [esp+8]

        mov     edx,_dest   ; dest
        mov     ecx,_src    ; src

        xor     eax,eax
        cmp     [edx],al    ; align @FindDestEnd
@FindDestEnd:
        je      @begincopy
        cmp     [edx+1],al
        je      @begincopy1
        cmp     [edx+2],al
        je      @begincopy2
        cmp     [edx+3],al
        je      @begincopy3
        add     edx,4
        cmp     [edx],al    ; align @FindDestEnd
        jmp     @FindDestEnd

        nop                 ; align @begincopy
@begincopy3: inc edx
@begincopy2: inc edx
@begincopy1: inc edx
@begincopy:                     ; edx points to terminating null in dest

        mov     al,byte ptr [ecx]
        mov     [edx],al
        test    al,al
        jz      @return

        mov     al,byte ptr [ecx+1]
        mov     [edx+1],al
        test    al,al
        jz      @return

        mov     al,byte ptr [ecx+2]
        mov     [edx+2],al
        test    al,al
        jz      @return

        mov     al,byte ptr [ecx+3]
        mov     [edx+3],al
        test    al,al
        jz      @return

        add     edx,4
        add     ecx,4

        jmp     @begincopy
        nop                ; align @return
        nop

@return:
        mov     eax,_dest       ; return dest
        Return@

EndFunc@ strcat

Code_EndS@

        end
