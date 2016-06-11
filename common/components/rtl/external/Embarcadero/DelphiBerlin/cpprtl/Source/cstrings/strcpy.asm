;[]-----------------------------------------------------------------[]
;|   STRCPY.ASM -- copy string src to string dest                    |
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
;Name           strcpy - copy string src to string dest
;
;Usage          char *strcpy (char *dest, const char *src);
;
;Prototype in   string.h
;
;Description    Copy the ASCIIZ string *src to  the buffer *dest. It is the
;               callers responsibility  to ensure that  the dest buffer  is
;               large enough  to contain the  string, and to  guard against
;               supplying NULL arguments.
;
;Return value   strcpy returns dest.
;
;-----------------------------------------------------------------------

Code_seg@

;* ***** BEGIN LICENSE BLOCK *****
;*
;* The function StrCopy is licensed under the Embarcadero Technologies Inc.
;* license terms.
;*
;* The initial developer of the original code is Fastcode
;*
;* Portions created by the initial developer are Copyright (C) 2002-2004
;* the initial developer. All Rights Reserved.
;*
;* Contributor(s): Aleksandr Sharahov
;*
;* ***** END LICENSE BLOCK ***** *)

Func@   strcpy, _EXPFUNC, _RTLENTRYF, <pointer dest>, <pointer src>

_dest      EQU [esp+4]
_src       EQU [esp+8]

        mov   eax, _dest
        mov   edx, _src

        sub   edx, eax
        test  eax, 1
        jz    @loop
        movzx ecx, byte ptr[eax+edx]
        mov   [eax], cl
        test  ecx, ecx
        jz    @ret
        inc   eax
@loop:
        movzx ecx, byte ptr[eax+edx]
        test  ecx, ecx
        jz    @move0
        movzx ecx, word ptr[eax+edx]
        mov   [eax], cx
        add   eax, 2
        cmp   ecx, 255
        ja    @loop
@ret:
        mov   eax, _dest
        Return@
        nop             ; align @move0
@move0:
        mov   [eax], cl
        mov   eax, _dest
        Return@

EndFunc@ strcpy

_EXPFUNC __rtl_strcpy
__rtl_strcpy label near
        jmp _strcpy
        
;
;  Towards the end of the DeXter release (Borland C++Builder 2006), we found that
;  the visibroker libs had references to the symbol below (npos).  There was a late
;  bug fix to make this value be defined inline, and it didn't get there in time
;  to help the visibroker libs, apparently.  So I put in this terrible hack to
;  provide a definition for the symbol in the RTL DLL.  This should be removed
;  in the next release.
;
_EXPFUNC @std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@npos
@std@%basic_string$c19std@%char_traits$c%17std@%allocator$c%%@npos label near
        dd -1

Code_EndS@

; used by the RTL to revector std::strcpy to our definition here.  Which means,
; sadly, that using std::strcpy prevents you from getting the intrinsic.
;alias <__rtl_strcpy>       = <_strcpy>
        
        end

