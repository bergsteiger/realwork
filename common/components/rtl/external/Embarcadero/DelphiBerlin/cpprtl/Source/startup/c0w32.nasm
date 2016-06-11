struc MODULE_DATA_STRUCT
	;/* address of start of a module's _INIT_ segment */
	;INIT *init_start;
	init_start	resd	1	

	;/* address of end of a module's _INIT_ segment */
	;INIT *init_end;
	init_end	resd	1	

	;/* address of start of a module's _EXIT_ segment */
	;INIT *exit_start;
	exit_start	resd	1	

	;/* address of end of a module's _EXIT_ segment */
	;INIT *exit_end;
	exit_end	resd	1

	;/* flags (see below) */
	;int  flags;
	flags		resd	1

	;/* module handle */
	;int  hmod;
	hmod 		resd	1

	;/* address of main/WinMain/_dllmain function */
	;int  (*main)();
	main_func		resd	1

	;/* address of (EXE only) _matherr function */
	;int  (*matherr)(void *);
	matherr		resd	1

	;/* address of (EXE only) _matherrl function */
	;int  (*matherrl)(void *);
	matherrl	resd	1

	;/* (EXE only) base of stack */
	;long stackbase;
	stackbase	resd	1

	;/* address of (EXE only) address of _fmode variable */
	;int  *fmode;
	fmode		resd	1

	;/* address of ptr to function that will expand wild args */
	;void (**wild_func)(char *, _PFN_ADDARG);
	wild_func	resd	1

	;/* address of ptr to function that will expand wchar_t wild args */
	;void (**wwild_func)(wchar_t *, _PFN_ADDARG);
	wwild_func	resd	1

	;/* address of function that will process cmdline and create argv array */
	;int (*setargv_func)(char *, char *, _PFN_ADDARG);
	setargv_func	resd	1

	;/* address of function to clean up after setargv_func */
	;void (*exitargv_func)(void);
	exitargv_func	resd	1

	;/* address of function that will process cmdline and create wargv array */
	;int (*wsetargv_func)(wchar_t *,wchar_t *, _PFN_ADDARG);
	wsetargv_func	resd	1

	;/* address of function to clean up after wsetargv_func */
	;void (*wexitargv_func)(void);
	wexitargv_func	resd	1

	;/* Address of _fileinfo variable that the user can define. Linking with fileinfo.obj changes this. */
	;int  *pfileinfo
	pfileinfo	resd	1
endstruc

%ifdef  CONSOLE
%define MAIN main
%else
%define MAIN WinMain
%endif

extern MAIN
extern _startup
extern __argv_expand_ptr
extern _handle_setargv
extern _handle_exitargv
extern GetModuleHandleA

SECTION .data
module_data:
 	istruc MODULE_DATA_STRUCT 
	at init_start,		dd 	0
	at init_end,		dd	0	
	at exit_start,		dd	0	
	at exit_end,		dd	0
	at flags,		dd	0
	at hmod, 		dd	0
	at main_func,		dd	0
	at matherr,		dd	0
	at matherrl,		dd	0
	at stackbase,		dd	0
	at fmode,		dd	0
	at wild_func,		dd	0
	at wwild_func,		dd	0
	at setargv_func,	dd	0
	at exitargv_func,	dd	0
	at wsetargv_func,	dd	0
	at wexitargv_func,	dd	0
	at pfileinfo,		dd	0
	iend

;
; The following table is needed only to generate references (with fixupps)
; to the listed symbols.  The dwords don't need to be allocated and aren't
; used again, but this is the only way to guarantee that both EXTDEF and
; FIXUPP records are generated for these symbols.
;
; BEGIN TABLE - misc
;
%ifndef _UNICODE
extern _setargv__
local_setargv	dd      _setargv__    ; for setting up argv[]
extern _setenvp__
local_setenvp	dd      _setenvp__    ; for setting up envp[]
%else
extern __wsetargv__
local_setargv	dd      __wsetargv__   ; for setting up wargv[]
extern __wsetenvp__
local_setenvp	dd      __wsetenvp__   ; for setting up wenvp[]
%endif
extern _fmode

global	_hinstance
_hInstance	dd	0

SECTION .text
global __acrtused
__acrtused:
        push	edx	             ; module handle 
%ifdef  DLL
        mov      edx, [esp+8]        ; Get DLL hInstance
%else 
	push 	0                    ; NULL returns the current module
	call	GetModuleHandleA
	mov	edx, eax        
%endif
	push	0	             ; offet FLAT:module_data 
%ifdef DLL
	mov 	eax, [esp+8]	     ; get mod_handle to 
	mov	_hInstance, eax     ; initialize _hInstance 
%endif
	push    0                    ; NULL returns current module
%ifndef  _UNICODE
        call    GetModuleHandleA
%else
        call    GetModuleHandleW
%endif
	mov     [_hInstance], eax 
	
;	module_data.main = main;
	mov	eax, module_data
	mov	dword [eax+main_func], MAIN
	mov	dword [eax+setargv_func], _handle_setargv    ; setargv_func
	mov	dword [eax+exitargv_func], _handle_exitargv   ; exitargv_func
%ifndef CONSOLE
	mov	dword [eax+flags], 1  ; Windows flag 
%endif	
	mov	dword [eax+fmode], _fmode
	push	eax
        push    0                    ; dummy return address
%ifndef  _UNICODE
	jmp     _startup
%else
        jmp     _wstartup
%endif
	mov     eax, 1
	ret