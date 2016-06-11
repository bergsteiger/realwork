	.386
	.MODEL	FLAT

	include rules.asi
	
	PUBLIC		__EH_longjmp, __UnhookERR, ___rtl_unwind
	PUBLIC		___seh_restore_context, ___seh_capture_context
	PUBLIC		___invoke_filter_function
	_EXPFUNC	__Unwind_SjLj_Register, __Unwind_SjLj_Unregister
	EXTRN		____ExceptionHandler
        EXTRN   	RtlUnwind:near

	.CODE

_Unwind_FunctionContext	STRUC
	prev			dd ?
	rtl_handler		dd ?
	resumeLocation		dd ?
	resumeParameters	dd 4 dup (?)
	personality		dd ?
	lsda			dd ?
	jbuf			dd 4 dup (?)
_Unwind_FunctionContext	ENDS
;// 0 prev
	;// 4 rtl_handler
	;; 8 resumeLocation
	;// 12 resumeParameters
	;// 28 personality
	;// 32 lsda
	;// 36 jbuf
__Unwind_SjLj_Register	PROC
	mov eax, [esp+4]
	mov ecx, dword ptr [fs:0]
	mov [eax].prev, ecx
	lea ecx, ____ExceptionHandler 
	mov [eax].rtl_handler, ecx

	;; And now we do a sort of inlined setjmp, saving
	;; ebp, esp
	mov [eax + 0].jbuf, ebp
	mov ecx, esp
	add ecx, 4		;  ditch the return address 
	mov [eax + 4].jbuf, ecx
	
	mov dword ptr[fs:0], eax
	RET
__Unwind_SjLj_Register	ENDP


__Unwind_SjLj_Unregister	PROC

	mov eax, dword ptr [fs:0]
	mov eax, [eax]
	mov dword ptr[fs:0], eax

	RET
__Unwind_SjLj_Unregister	ENDP

__UnhookERR	PROC

	mov ecx, dword ptr [fs:0]
	mov eax, [ecx]
	mov dword ptr[fs:0], eax

	RET
__UnhookERR	ENDP

__EH_longjmp	PROC
	mov	eax, [esp+4]
	mov	ebp, [eax]
	mov	esp, [eax + 4]
	jmp	dword ptr [eax + 8]
__EH_longjmp	ENDP

___rtl_unwind	PROC

        push    ebx
        push    esi
        push    edi
	
	mov	eax, [esp + 16]
	mov	ecx, [esp + 20]
	push	0
        push    eax                     ; descriptor addr
        push    offset FLAT:return      ; target EIP
        push    ecx                     ; target ERR addr
        call    RtlUnwind

return:
        pop     edi
        pop     esi
        pop     ebx
	
        ret
	
___rtl_unwind	ENDP

CONTEXT STRUC
	_ContextFlags	dd ?
	_Dr0	dd ?
	_Dr1	dd ?
	_Dr2	dd ?
	_Dr3	dd ?
	_Dr6	dd ?
	_Dr7	dd ?
	
	_FloatSave db 80 + 32 dup (?)
	
	SegGs	dd ?
	SegFs	dd ?
	SegEs	dd ?
	SegDs	dd ?
	
	_Edi	dd ?
	_Esi	dd ?
	_Ebx	dd ?
	_Edx	dd ?
	_Ecx	dd ?
	_Eax	dd ?

	_Ebp	dd ?
	_Eip	dd ?
	SegCs	dd ?
	EFlags	dd ?
	_Esp	dd ?
	SegSs	dd ?

	ExtendedRegisters db 512 dup (?)
CONTEXT ENDS
	
___seh_capture_context	PROC
	push	ecx
	mov	ecx, [esp + 8]	; context
	mov	[ecx]._Eax, eax
	mov	eax, [esp]	; saved ecx
	mov	[ecx]._Ecx, eax
	mov	[ecx]._Edi, edi
	mov	[ecx]._Esi, esi
	mov	[ecx]._Ebx, ebx
	mov	[ecx]._Edx, edx
	mov	[ecx]._Ebp, ebp
	mov	eax, esp
	add	eax, 8
	mov	[ecx]._Esp, eax
	mov	eax, [esp + 4]	; ret addr
	mov	[ecx]._Eip, eax
	pop	ecx
	ret
___seh_capture_context	ENDP

___seh_restore_context	PROC
	mov	eax, [esp + 8] 	; return result
	mov	ecx, [esp + 4]	; context
	mov	edi, [ecx]._Edi
	mov	esi, [ecx]._Esi
	mov	ebx, [ecx]._Ebx
	mov	edx, [ecx]._Edx
	mov	ebp, [ecx]._Ebp
	mov	esp, [ecx]._Esp
	
	push	[ecx]._Eip
	mov	ecx, [ecx]._Ecx
	ret
___seh_restore_context	ENDP

___invoke_filter_function	PROC
	;; [esp + 4] = ebp
	;; [esp + 8] = exception
	;; [esp + 12] = targetEIP
	mov	eax, [esp + 8]
	mov	ebp, [esp + 4]
	jmp	dword ptr [esp + 12]
___invoke_filter_function	ENDP
	
	END
