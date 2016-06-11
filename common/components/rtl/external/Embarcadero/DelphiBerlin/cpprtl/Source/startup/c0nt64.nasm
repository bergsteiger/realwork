
;
; We want RIP relative instructions/relocations in here, especially for DLLs.
; Otherwise there are a lot of things that won't work, as 32bit offsets will be
; encoded in instructions that cannot be relocated by the Win64 loader, and technically
; would fail if, for example, a DLL were loaded above the 4G line.
;
default rel

struc MODULE_DATA_STRUCT
	;/* address of start of a module's _INIT_ segment */
	;INIT *init_start;
	init_start	resq	1

	;/* address of end of a module's _INIT_ segment */
	;INIT *init_end;
	init_end	resq	1

	;/* address of start of a module's _EXIT_ segment */
	;INIT *exit_start;
	exit_start	resq	1

	;/* address of end of a module's _EXIT_ segment */
	;INIT *exit_end;
	exit_end	resq	1

	;/* flags (see below) */
	;int  flags;
	flags		resd	1

	;/* _align */
	_align		resd	1

	;/* module handle */
	;void *hmod;
	hmod 		resq	1

	;/* address of main/WinMain/_dllmain function */
	;int  (*main)();
	main_func	resq	1

	;/* address of (EXE only) _matherr function */
	;int  (*matherr)(void *);
	matherr		resq	1

	;/* address of (EXE only) _matherrl function */
	;int  (*matherrl)(void *);
	matherrl	resq	1

	;/* (EXE only) base of stack */
	;void *stackbase;
	stackbase	resq	1

	;/* address of (EXE only) address of _fmode variable */
	;int  *fmode;
	fmode		resq	1

	;/* address of ptr to function that will expand wild args */
	;void (**wild_func)(char *, _PFN_ADDARG);
	wild_func	resq	1

	;/* address of ptr to function that will expand wchar_t wild args */
	;void (**wwild_func)(wchar_t *, _PFN_ADDARG);
	wwild_func	resq	1

	;/* address of function that will process cmdline and create argv array */
	;int (*setargv_func)(char *, char *, _PFN_ADDARG);
	setargv_func	resq	1

	;/* address of function to clean up after setargv_func */
	;void (*exitargv_func)(void);
	exitargv_func	resq	1

	;/* address of function that will process cmdline and create wargv array */
	;int (*wsetargv_func)(wchar_t *,wchar_t *, _PFN_ADDARG);
	wsetargv_func	resq	1

	;/* address of function to clean up after wsetargv_func */
	;void (*wexitargv_func)(void);
	wexitargv_func	resq	1

	;/* Address of _fileinfo variable that the user can define. Linking with fileinfo.obj changes this. */
	;int  *pfileinfo
	pfileinfo	resq	1
endstruc

%ifdef DLL
  %define MAIN DllEntryPoint
  %ifdef _UNICODE
    %define STARTUPD _wstartupd
  %else
    %define STARTUPD _startupd
  %endif
  %define PROCESS_ATTACH 1
  %define PROCESS_DETACH 0
  %define THREAD_ATTACH  2
  %define THREAD_DETACH  3
%else
  %ifdef _UNICODE
    %define STARTUP _wstartup
  %else
    %define STARTUP _startup
  %endif
  %ifdef CONSOLE
    %ifdef _UNICODE
      %define MAIN wmain
    %else
      %define MAIN main
    %endif
  %else
    %ifdef FMX
      %define MAIN _FMXmainThunk
    %else
      %ifdef _UNICODE
	%define MAIN wWinMain
      %else
	%define MAIN WinMain
      %endif
    %endif
  %endif
%endif

%ifdef _UNICODE
%define GETMODULEHANDLE GetModuleHandleW
%else
%define GETMODULEHANDLE GetModuleHandleA
%endif

extern MAIN
%ifndef DLL
extern STARTUP
%else
extern STARTUPD
%endif
extern GETMODULEHANDLE
extern __borland_init_start
extern __borland_init_end
extern __borland_exit_start
extern __borland_exit_end
extern _handle_setargv
extern _handle_exitargv
extern _handle_wsetargv
extern _handle_wexitargv
extern __argv_expand_ptr
extern __CRTL_VCL_Init
extern __CRTL_MEM_UseBorMM
extern __CRTL_VCLLIB_Linkage
extern __tls_get_addr
extern __backpatch_data_references
extern _dbk_fcall_wrapper_addr

SECTION .data
module_data:
	istruc MODULE_DATA_STRUCT
	at init_start,		dq 	0
	at init_end,		dq	0
	at exit_start,		dq	0
	at exit_end,		dq	0
	at flags,		dd	0
        at _align,              dd      0
	at hmod, 		dq	0
	at main_func,		dq	0
	at matherr,		dq	0
	at matherrl,		dq	0
	at stackbase,		dq	0
	at fmode,		dq	0
	at wild_func,		dq	0
	at wwild_func,		dq	0
	at setargv_func,	dq	0
	at exitargv_func,	dq	0
	at wsetargv_func,	dq	0
	at wexitargv_func,	dq	0
	at pfileinfo,		dq	0
	iend

;
; The following table is needed only to generate references (with fixupps)
; to the listed symbols.  The dwords don't need to be allocated and aren't
; used again, but this is the only way to guarantee that both EXTDEF and
; FIXUPP records are generated for these symbols.
;
; BEGIN TABLE - misc
;
%ifndef DLL
%ifndef _UNICODE
extern _setargv__
local_setargv	dq      _setargv__    ; for setting up argv[]
extern _setenvp__
local_setenvp	dq      _setenvp__    ; for setting up envp[]
%else
extern _wsetargv__
local_setargv	dq      _wsetargv__   ; for setting up wargv[]
extern _wsetenvp__
local_setenvp	dq      _wsetenvp__   ; for setting up wenvp[]
%endif
%endif
extern _fmode

extern __CPPdebugHook
extern _turboFloat

global _hInstance
_hInstance	dq	0

_reason		dd	0
_reserved	dq	0

global __isDLL
%ifdef DLL
__isDLL		db	1
%else
__isDLL		db	0
%endif

global __isGUI
%ifndef CONSOLE
__isGUI		db	1
%else
__isGUI		db	0
%endif

global __isVCLPackage
%ifdef PACKAGE
__isVCLPackage	db	1
%else
__isVCLPackage	db	0
%endif

SECTION .text
global __acrtused
%ifdef  DLL
global __dllstartup
__dllstartup:
%endif
__acrtused:
	push    0                    ; Align stack
%ifdef  DLL
	;; RCX = hinst, RDX = reason
	mov	rax, rcx
	mov     [_reason], edx
	mov     [_reserved], r8
%else
	xor     rcx, rcx             ; NULL returns the current module
	call	GETMODULEHANDLE
%endif
	mov     [_hInstance], rax

%ifdef  DLL
	cmp	rdx, PROCESS_ATTACH
	jne	skip_CRTL_init
%endif
        call    __CRTL_VCL_Init
        call    __CRTL_MEM_UseBorMM    ; Call out to potentially
                                       ; re-vector the memory manager

        call    __CRTL_VCLLIB_Linkage  ; Call out to touch a symbol

skip_CRTL_init:

;	Initialize module_data structure
 	lea	rax, [module_data]
	lea	rcx, [MAIN]
 	mov	qword [rax+main_func], rcx

	lea	rcx, [__borland_init_start]
	mov	qword [rax+init_start], rcx
	lea	rcx, [__borland_init_end]
	mov	qword [rax+init_end], rcx
	lea	rcx, [__borland_exit_start]
	mov	qword [rax+exit_start], rcx
	lea	rcx, [__borland_exit_end]
	mov	qword [rax+exit_end], rcx
	lea	rcx, [_handle_setargv]

 	mov	qword [rax+setargv_func], rcx     ; setargv_func
	lea	rcx, [_handle_exitargv]
 	mov	qword [rax+exitargv_func], rcx   ; exitargv_func
	lea	rcx, [_handle_wsetargv]
	mov	qword [rax+wsetargv_func], rcx   ; wsetargv_func
	lea	rcx, [_handle_wexitargv]
 	mov	qword [rax+wexitargv_func], rcx ; wexitargv_func
	lea	rcx, [_fmode]
 	mov	qword [rax+fmode], rcx
%ifndef CONSOLE
	mov	dword [rax+flags], 1  ; Windows flag
%endif
	mov	rcx, rax
%ifndef DLL
        push    0                    ; dummy return address
crtl_startup:
	jmp     STARTUP
%else
	mov     rdx, [_hInstance]
	mov	r8d, [_reason]
	mov	r9, [_reserved]
	call	STARTUPD
	cmp	dword [_reason], PROCESS_DETACH
	jne	Return
	;; process detach so cleanup
Return:
	pop	rcx
	ret
%endif

global _ZN7Sysinit7_GetTlsEv
global ___System__GetTls
___System__GetTls:
_ZN7Sysinit7_GetTlsEv:
	;;  Delphi applies offset after getting base address
	xor rcx, rcx
	jmp __tls_get_addr


%ifdef PACKAGE

extern Initialize
extern Finalize
extern __GetPackageInfoTable
extern __LinkPackage

        lea    rcx, [Initialize]
        lea    rcx, [Finalize]
        lea    rcx, [__GetPackageInfoTable]
        lea    rcx, [__LinkPackage]
        
%endif ; PACKAGE

Link:
	lea     rcx, [__CPPdebugHook]
	lea     rcx, [_turboFloat]
	lea     rcx, [__backpatch_data_references]
        lea     rcx, [_dbk_fcall_wrapper_addr]