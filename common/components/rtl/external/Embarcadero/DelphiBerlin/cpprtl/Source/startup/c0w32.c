#include <_startup.h>

MODULE_DATA module_data;

extern GetModuleHandleA(unsigned p1, unsigned p2);
stub_GetModuleHandleA(unsigned p1, unsigned p2)
{
    return GetModuleHandleA(p1, p2);
}

void stub_startup()
{
    _startup(&module_data);
}
unsigned _hInstance;

extern int main();
extern  void (**__argv_expand_ptr)(char *, _PFN_ADDARG);

__acrtused()
{
    __asm {
        push	edx	             ; module handle 
#ifdef  DLL
        mov      edx, [esp+8]        ; Get DLL hInstance
#else 
	push 	0                    ; NULL returns the current module
	call	stub_GetModuleHandleA;
	mov	edx, eax             ;
#endif
	push	0	             ; offet FLAT:module_data 
#ifdef DLL
	mov 	eax, [esp+8]	     ; get mod_handle to 
	mov	_hInstance, eax     ; initialize _hInstance 
#endif
	push    0                    ; NULL returns current module
#ifndef  _UNICODE
        call    stub_GetModuleHandleA
#else
        call    GetModuleHandleW
#endif
	 mov     _hInstance, eax     ;
    }

    module_data.main = main;
    /*    module_data.wild_func = __argv_expand_ptr; */
    __asm {
        push    0                    ; dummy return address
#ifndef  _UNICODE
	call    stub_startup
	/*        jmp     stub_startup */
#else
        jmp     __wstartup
#endif
	mov     eax, 1               ;
    }
}
