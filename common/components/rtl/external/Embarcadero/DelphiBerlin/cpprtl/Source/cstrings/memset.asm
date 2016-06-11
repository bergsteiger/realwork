;[]-----------------------------------------------------------------[]
;|   MEMSET.ASM --  sets memory to value                             |
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
;Name		memset - sets memory to value
;
;Usage		void *memset(void *src, int c, size_t n);
;
;Prototype in	mem.h
;
;Description	sets the n bytes of the block pointed to by src to
;		c.  This implementation has been optimized for the
;		Pentium processor.
;
;Return value	src
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

fillmem PROC                         ; Size = 153 Bytes
        CMP   EDX, 32
        MOV   CH, CL                 ; Copy Value into both Bytes of CX
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
        AND   ECX, 7                  ; 8-Byte Align Writes
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
        MOV   [EAX+EDX-1], CL        ; Fill Last Byte
        AND   EDX, -2                ; No. of Words to Fill
        NEG   EDX
        LEA   EDX, [@@SmallFill + 60 + EDX * 2]
        JMP   EDX
        NOP                          ; Align Jump Destinations
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
fillmem ENDP
        
Func@   memset, _EXPFUNC, _RTLENTRYF, <pointer src>,<int c>,<int n>

_src      EQU [esp+4]
_c        EQU [esp+8]
_n        EQU [esp+12]

        MOV   CL, _c                  ; get byte to store
        MOV   EDX, _n                 ; get the byte count
        MOV   EAX, _src               ; get src
        CALL  fillmem
        MOV   EAX, _src
        Return@
EndFunc@ memset

;Func@   _rtl_memset, _EXPFUNC, _RTLENTRYF, <pointer src>,<int c>,<int n>
;        jmp _memset
;EndFunc@ _rtl_memset

_EXPFUNC __rtl_memset
_EXPFUNC __rtl_memset_
__rtl_memset label near
__rtl_memset_ label near
        jmp _memset

Code_EndS@

; used by the compiler to revector calls to the instrinsic memset that we decided
; we didn't want to make inline.
;alias <__rtl_memset>       = <_memset>
; used by the RTL to revector std::memset to our definition here.  Which means,
; sadly, that using std::memset prevents you from getting the intrinsic.
;alias <__rtl_memset_>       = <_memset>
	
        end
