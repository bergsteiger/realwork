;[]-----------------------------------------------------------------[]
;|   WMEMSET.ASM --  sets memory to value (16-bits)                  |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1996, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 30564 $

        include RULES.ASI

;       Segments Definitions

Header@

;-----------------------------------------------------------------------
;
;Name            wmemset - function that sets memory to 16-bit value
;
;Usage           wchar_t *wmemset(wchar_t *src, int c, size_t n);
;
;Prototype in    string.h
;
;Description     sets the n words of the block pointed to by src to c.
;
;Return value    src
;
;-----------------------------------------------------------------------

Code_seg@

;* ***** BEGIN LICENSE BLOCK *****
;*
;* The assembly procedure FillChar is licensed under the Embarcadero Technologies Inc.
;* license terms.
;*
;* The initial developer of the original code is Fastcode
;*
;* Portions created by the initial developer are Copyright (C) 2002-2004
;* the initial developer. All Rights Reserved.
;*
;* Contributor(s): John O'Harrow
;*
;* ***** END LICENSE BLOCK ***** *)

wfillmem PROC                        ; Size = 153 Bytes
        SHL   EDX, 1                 ; Words to Bytes
        CMP   EDX, 32
        JL    @@Small
        MOV   [EAX  ], CX            ; Fill First 8 Bytes
        MOV   [EAX+2], CX
        MOV   [EAX+4], CX
        MOV   [EAX+6], CX
        SUB   EDX, 16
        FLD   QWORD PTR [EAX]
        FST   QWORD PTR [EAX+EDX]    ; Fill Last 16 Bytes
        FST   QWORD PTR [EAX+EDX+8]
        MOV   ECX, EAX
        AND   ECX, 7                 ; 8-Byte Align Writes
        SUB   ECX, 8
        SUB   EAX, ECX
        ADD   EDX, ECX
        ADD   EAX, EDX
        NEG   EDX
@@Loop:
        FST   QWORD PTR [EAX+EDX]    ; Fill 16 Bytes per Loop
        FST   QWORD PTR [EAX+EDX+8]
        ADD   EDX, 16
        JL    @@Loop
        FFREE ST(0)
        FINCSTP
        RET
        NOP
        NOP
        NOP
@@Small:
        TEST  EDX, EDX
        JLE   @@Done
        MOV   [EAX+EDX-2], CX        ; Fill Last Word
        AND   EDX, -2                ; No. of Words to Fill
        NEG   EDX
        LEA   EDX, [@@SmallFill + 60 + EDX * 2]
        JMP   EDX
        NOP                          ; Align Jump Destinations
        NOP
        NOP
        NOP
        NOP
@@SmallFill:
        MOV   [EAX+28], CX
        MOV   [EAX+26], CX
        MOV   [EAX+24], CX
        MOV   [EAX+22], CX
        MOV   [EAX+20], CX
        MOV   [EAX+18], CX
        MOV   [EAX+16], CX
        MOV   [EAX+14], CX
        MOV   [EAX+12], CX
        MOV   [EAX+10], CX
        MOV   [EAX+ 8], CX
        MOV   [EAX+ 6], CX
        MOV   [EAX+ 4], CX
        MOV   [EAX+ 2], CX
        MOV   [EAX   ], CX
        RET                          ; DO NOT REMOVE - This is for Alignment
@@Done:
        RET
wfillmem ENDP

_src      EQU [esp+4]
_c        EQU [esp+8]
_n        EQU [esp+12]

Func@   _wmemset_safe, _EXPFUNC, _RTLENTRYF, <pointer src>,<int c>,<int n>

        mov     edx, _src            ; get src
        mov     ax, _c               ; get word to store
        mov     ecx, _n
        push    edi
        mov     edi, edx
        cld
        rep     stosw                ; store words
        pop     edi
        mov     eax,_src             ; return src
        Return@

EndFunc@ _wmemset_safe

Func@   wmemset, _EXPFUNC, _RTLENTRYF, <pointer src>,<int c>,<int n>

        MOV   CX, _c                  ; get word to store
        MOV   AX, CX
        AND   AX, 7FF8h               ; check for 16 values that will create
        CMP   AX, 7FF0h               ; illegal double values
        je    __wmemset_safe
        MOV   EDX, _n                 ; get the word count
        MOV   EAX, _src               ; get src
        CALL  wfillmem
        MOV   EAX, _src
        Return@
EndFunc@ wmemset

_EXPFUNC __wmemset
__wmemset label near
        jmp _wmemset

Code_EndS@

        end
