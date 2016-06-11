; -----------------------------------------------------------------------------------
;
;           CodeGear Delphi Runtime Library
; Copyright(c) 2016 Embarcadero Technologies, Inc.
;              All rights reserved
;
; -----------------------------------------------------------------------------------

    .386
    .MODEL  FLAT

    LOCALS  @@

    PUBLIC  __ClassCreate,__ClassDestroy,__AfterConstruction,__BeforeDestruction,___ClassCreate,___ClassDestroy,___AfterConstruction,___BeforeDestruction


vtAfterConstruction EQU -28
vtBeforeDestruction EQU -24
vtNewInstance       EQU -12
vtFreeInstance      EQU -8

        .DATA

CurrScaledBy dw 10000


        .CODE

__ClassCreate PROC
        ; ->    EAX = pointer to VMT
        ; <-    EAX = pointer to instance
        PUSH    EDX
        PUSH    ECX
        CALL    dword ptr [EAX].vtNewInstance
        POP     ECX
        POP     EDX
        RET
__ClassCreate ENDP


__ClassDestroy  PROC
        ; ->    EAX = pointer to instance
        MOV     EDX,[EAX]
        JMP     dword ptr [EDX].vtFreeInstance
__ClassDestroy  ENDP


__AfterConstruction PROC
        ; ->    EAX = pointer to instance
        PUSH    EAX
        MOV     EDX,[EAX]
        CALL    dword ptr [EDX].vtAfterConstruction
        POP     EAX
        RET
__AfterConstruction ENDP


__BeforeDestruction PROC
        ; ->    EAX  = pointer to instance
        ;       DL   = dealloc flag
        TEST    DL,DL
        JG      @@outerMost
        RET
@@outerMost:
        PUSH    EAX
        PUSH    EDX
        MOV     EDX,[EAX]
        CALL    dword ptr [EDX].vtBeforeDestruction
        POP     EDX
        POP     EAX
        RET
__BeforeDestruction ENDP


___ClassCreate PROC
        JMP __ClassCreate
___ClassCreate ENDP

___ClassDestroy  PROC
        JMP __ClassDestroy
___ClassDestroy  ENDP

___AfterConstruction PROC
        JMP __AfterConstruction
___AfterConstruction ENDP

___BeforeDestruction PROC
        JMP __BeforeDestruction
___BeforeDestruction ENDP



;extern "C" __int64 __cdecl _roundToInt64(long double);
public  __roundToInt64
__roundToInt64  proc    near
        sub     esp, 8
        fld     tbyte ptr [esp + 12]
        fistp   qword ptr [esp]
        pop     eax
        pop     edx
        ret
__roundToInt64  endp


;extern "C" void __fastcall __currMul(const System::Currency c1, System::Currency &c2);
public @__currMul
@__currMul proc near
        push    ebp
        mov     ebp, esp
        fild    qword ptr [eax]
        fild    qword ptr [ebp + 8]
        fmulp   st(1), st
        fidiv   CurrScaledBy
        fistp   qword ptr [eax]
        wait
        pop     ebp
        ret     8
@__currMul endp

        end
