;[]-----------------------------------------------------------------[]
;|   MEMMOVE.ASM --  copy a block of n bytes from src to dst         |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: 25549 $

        include RULES.ASI

;       Segments Definitions

Header@

;-----------------------------------------------------------------------
;
;Name           memmove - copy a block of n bytes from src to dst
;
;Usage          void *memmove(void *dest, const void *src, size_t n);
;
;Prototype in   mem.h & string.h
;
;Description    memmove copies  a block of n  bytes from src to dest. Even
;               when the source and destination blocks overlap, bytes in
;               the overlapping locations are copied correctly.
;
;Return value   memmove returns dest
;
;-----------------------------------------------------------------------

Code_seg@

;* ***** BEGIN LICENSE BLOCK *****
;*
;* The assembly function Move is licensed under the Embarcadero Technologies Inc.
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

; NOTE: Shared by memcpy and memmove.
Func@   _internal_memmove, _EXPFUNC, fastcall
  cmp     eax, edx
  je      @@Exit ; Source = Dest
  cmp     ecx, 32
  ja      @@LargeMove ; Count > 32 or Count < 0
  sub     ecx, 8
  jg      @@SmallMove
@@TinyMove: ; 0..8 Byte Move
  jmp     dword ptr [@@JumpTable+32+ecx*4]
@@SmallMove: ; 9..32 Byte Move
  fild    qword ptr [eax+ecx] ; Load Last 8
  fild    qword ptr [eax] ; Load First 8
  cmp     ecx, 8
  jle     @@Small16
  fild    qword ptr [eax+8] ; Load Second 8
  cmp     ecx, 16
  jle     @@Small24
  fild    qword ptr [eax+16] ; Load Third 8
  fistp   qword ptr [edx+16] ; Save Third 8
@@Small24:
  fistp   qword ptr [edx+8] ; Save Second 8
@@Small16:
  fistp   qword ptr [edx] ; Save First 8
  fistp   qword ptr [edx+ecx] ; Save Last 8
@@Exit:
  ret
  nop ; 4-Byte Align JumpTable
  nop
@@JumpTable: ; 4-Byte Aligned
  dd      @@Exit, @@M01, @@M02, @@M03, @@M04, @@M05, @@M06, @@M07, @@M08
@@LargeForwardMove: ; 4-Byte Aligned
  push    edx
  fild    qword ptr [eax] ; First 8
  lea     eax, [eax+ecx-8]
  lea     ecx, [ecx+edx-8]
  fild    qword ptr [eax] ; Last 8
  push    ecx
  neg     ecx
  and     edx, -8 ; 8-Byte Align Writes
  lea     ecx, [ecx+edx+8]
  pop     edx
@FwdLoop:
  fild    qword ptr [eax+ecx]
  fistp   qword ptr [edx+ecx]
  add     ecx, 8
  jl      @FwdLoop
  fistp   qword ptr [edx] ; Last 8
  pop     edx
  fistp   qword ptr [edx] ; First 8
  ret
@@LargeMove:
  jng     @@LargeDone ; Count < 0
  cmp     eax, edx
  ja      @@LargeForwardMove
  sub     edx, ecx
  cmp     eax, edx
  lea     edx, dword ptr [edx+ecx]
  jna     @@LargeForwardMove
  sub     ecx, 8 ; Backward Move
  push    ecx
  fild    qword ptr [eax+ecx] ; Last 8
  fild    qword ptr [eax] ; First 8
  add     ecx, edx
  and     ecx, -8 ; 8-Byte Align Writes
  sub     ecx, edx
@BwdLoop:
  fild    qword ptr [eax+ecx]
  fistp   qword ptr [edx+ecx]
  sub     ecx, 8
  jg      @BwdLoop
  pop     ecx
  fistp   qword ptr [edx] ; First 8
  fistp   qword ptr [edx+ecx] ; Last 8
@@LargeDone:
  ret
@@M01:
  movzx   ecx, byte ptr [eax]
  mov     byte ptr [edx], cl
  ret
@@M02:
  movzx   ecx, word ptr [eax]
  mov     word ptr [edx], cx
  ret
@@M03:
  mov     cx, word ptr [eax]
  mov     al, byte ptr [eax+2]
  mov     word ptr [edx], cx
  mov     byte ptr [edx+2], al
  ret
@@M04:
  mov     ecx, dword ptr [eax]
  mov     dword ptr [edx], ecx
  ret
@@M05:
  mov     ecx, dword ptr [eax]
  mov     al, byte ptr [eax+4]
  mov     dword ptr [edx], ecx
  mov     byte ptr [edx+4], al
  ret
@@M06:
  mov     ecx, dword ptr [eax]
  mov     ax, word ptr [eax+4]
  mov     dword ptr [edx], ecx
  mov     word ptr [edx+4], ax
  ret
@@M07:
  mov     ecx, dword ptr [eax]
  mov     eax, dword ptr [eax+3]
  mov     dword ptr [edx], ecx
  mov     dword ptr [edx+3], eax
  ret
@@M08:
  fild    qword ptr [eax]
  fistp   qword ptr [edx]

  ret
EndFunc@ _internal_memmove

Func@   memmove, _EXPFUNC, _RTLENTRYF, <pointer dest>,<pointer src>,<int n>

_dest     EQU [esp+4]
_src      EQU [esp+8]
_n        EQU [esp+12]

        mov     edx,_dest        ; get dest
        mov     eax,_src         ; get src
        mov     ecx,_n           ; get n
        FastCall@ _internal_memmove
        mov     eax,_dest
        Return@

EndFunc@ memmove

Code_EndS@

        end
