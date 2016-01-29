{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{             System Initialization Unit                }
{*******************************************************}

unit SysInit;


interface

{$H+,I-,R-,S-,O+,W-}
{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNSAFE_TYPE OFF}

{$IFDEF CPUX86}
  {$DEFINE X86ASM}
  {$IFNDEF PC_MAPPED_EXCEPTIONS}
    {$DEFINE STACK_BASED_EXCEPTIONS}
  {$ENDIF !PC_MAPPED_EXCEPTIONS}
{$ELSE !CPUX86}
  {$DEFINE PUREPASCAL}
  {$DEFINE X64ASM}
  {$DEFINE PUREPASCAL_X64ONLY}
  {$IFDEF WIN64}
    {$DEFINE TABLE_BASED_EXCEPTIONS}
  {$ENDIF WIN64}
  {$DEFINE DYNARRAYLENGTH64}
{$ENDIF !CPUX86}

{$IFDEF LINUX}
const
  ExeBaseAddress = Pointer($8048000) platform;
{$ENDIF}
{$IFDEF MACOS}
const
  ExeBaseAddress = Pointer($10000) platform;
{$ENDIF}

{$IF defined(EXTERNALLINKER)}
var
  TlsStart: NativeInt;          { Specially handled with TlsLast by the code generator }
{$ENDIF}

var
  ModuleIsLib: Boolean;         { True if this module is a dll (a library or a package) }
  ModuleIsPackage: Boolean;     { True if this module is a package }
  ModuleIsCpp: Boolean;         { True if this module is compiled using C++ Builder }
  TlsIndex: Integer = -1;       { Thread local storage index }
  TlsLast: Byte;                { Set by linker so its offset is last in TLS segment }
  HInstance: HINST;             { Handle of this instance }
  ImageBase: Pointer;           { Special symbol that is actually located at the module load address. @ImageBase. }
  {$EXTERNALSYM ImageBase}
  __ImageBase: Pointer;         { Same as ImageBase, only with a different name }
  {$EXTERNALSYM __ImageBase}
{$IFDEF MSWINDOWS}
  {$EXTERNALSYM HInstance}
  (*$HPPEMIT 'namespace Sysinit' *)
  (*$HPPEMIT '{' *)
  (*$HPPEMIT 'extern PACKAGE HINSTANCE HInstance;' *)
  (*$HPPEMIT '} /* namespace Sysinit */' *)
{$ENDIF}
  DllProc: TDLLProc;            { Called whenever DLL entry point is called }
  { DllProcEx passes the Reserved param provided by WinNT on DLL load & exit }
  DllProcEx: TDLLProcEx absolute DllProc;
  DataMark: Integer = 0;        { Used to find the virtual base of DATA seg }
  CoverageLibraryName: array [0..128] of _AnsiChr = '*'; { initialized by the linker! }
{$IFDEF ELF}
  TypeImportsTable: array [0..0] of Pointer platform;  { VMT and RTTI imports table for exes }
{$ENDIF ELF}
{$IF defined(WIN64) or defined(MACOS)}
  dbkFCallWrapperAddr :Pointer;
{$ENDIF WIN64 or MACOS}
{$IF defined(ELF) or defined(MACOS)}
  _GLOBAL_OFFSET_TABLE_: ARRAY [0..2] OF Cardinal platform;
  (* _DYNAMIC: ARRAY [0..0] OF Elf32_Dyn; *)
{$ENDIF ELF or MACOS}
{$IFDEF PC_MAPPED_EXCEPTIONS}
  TextStartAdj: Byte platform;            { See GetTextStart }
  CodeSegSize: Byte platform;             { See GetTextStart }
function GetTextStart : NativeInt; platform;
{$ENDIF PC_MAPPED_EXCEPTIONS}

const
  PtrToNil: Pointer = nil;     // provides pointer to nil for compiler codegen

{$IF defined(CPUX64)}
                                                                          
// Be careful with using FSSegBase and GSSegBase.
// FS:[x] or GS:[x] memory addresses may be generated but not in all cases.
// If backend decided to use LEA instruction, FS: or GS: prefix will not
// be generated in later code.
const
  FSSegBase: Pointer = nil; // provides FS segment access for compiler codegen
  GSSegBase: Pointer = nil; // provides GS segment access for compiler codegen
{$ENDIF}

function _GetTls: Pointer;

{$IFDEF POSIX}
procedure _GetCallerEIP;
{$ENDIF POSIX}

{
  Startup/shutdown routines, called by the code generator.  These are
  platform specific.
}
{$IF defined(LINUX) or defined(MACOS)}
procedure _InitLib(Context: PInitContext);
function _ExitLib: Integer; cdecl;
function _InitPkg: LongBool;
{$ENDIF LINUX or MACOS}
{$IFDEF MACOS}
procedure _InitExe(InitTable: Pointer; ProgramParams: Pointer);
{$ENDIF MACOS}
{$IFDEF LINUX}
procedure _InitExe(InitTable: Pointer; Argc: Integer; Argp: Pointer);
procedure _start; cdecl;
{$ENDIF LINUX}
{$IFDEF MSWINDOWS}
{$IF defined(CPU386)}
procedure _InitLib;
{$ELSE !CPU386}
procedure _InitLib(Context: PInitContext; InitTable: PackageInfo; AHInst: HINST; Reason: LongWord; Reserved: Pointer);
{$ENDIF !CPU386}
procedure _InitExe(InitTable: Pointer);
function _InitPkg(AHInst: HINST; Reason: Integer; Resvd: Pointer): LongBool; stdcall;
{$ENDIF MSWINDOWS}

procedure _PackageLoad(const Table: PackageInfo);
procedure _PackageUnload(const Table: PackageInfo);

{ Invoked by C++ startup code to allow initialization of VCL global vars }
{$IF defined(CPU386)}
procedure VclInit(isDLL, isPkg: Boolean; hInst: LongInt; isGui: Boolean); cdecl;
{$ELSE}
procedure VclInit(isDLL, isPkg: Boolean; hInst: HINST; isGui: Boolean); cdecl;
{$ENDIF}
procedure VclExit; cdecl;

{$IFDEF POSIX}
function GetThisModuleHandle: LongWord;
{$ENDIF}

{$IFDEF MSWINDOWS}
type
  PImageThunkData = ^TImageThunkData;
  TImageThunkData = record
    case Byte of
      0: (ForwarderString: NativeUInt); // PBYTE
      1: (_Function: NativeUInt);       // PLongWord Function -> _Function
      2: (Ordinal: NativeUInt);
      3: (AddressOfData: NativeUInt);   // PIMAGE_IMPORT_BY_NAME
  end;
  {$EXTERNALSYM TImageThunkData}
  {$EXTERNALSYM PImageThunkData}

  ImgDelayDescr = record
    grAttrs:     LongWord;          { attributes                        }
    szName:      _PAnsiChr;         { pointer to dll name               }
    hmod:        HMODULE;           { address of module handle          }
    pIAT:        PImageThunkData;   { address of the IAT                }
    pINT:        PImageThunkData;   { address of the INT                }
    pBoundIAT:   PImageThunkData;   { address of the optional bound IAT }
    pUnloadIAT:  PImageThunkData;   { address of optional copy of
                                       original IAT                     }
    dwTimeStamp: LongWord;          { 0 if not bound,                   }
                                    { O.W. date/time stamp of DLL bound
                                       to (Old BIND)                    }
  end;
  {$EXTERNALSYM ImgDelayDescr}
  TImgDelayDescr = ImgDelayDescr;
  {$EXTERNALSYM TImgDelayDescr}
  PImgDelayDescr = ^TImgDelayDescr;
  {$EXTERNALSYM PImgDelayDescr}

{ Delay load import hook notifications }

  dliNotification = (
    dliStartProcessing,        	   { used to bypass or note helper only     }
    dliNoteStartProcessing = dliStartProcessing,
    dliNotePreLoadLibrary,         { called just before LoadLibrary, can    }
                                   {  override w/ new HMODULE return val    }
    dliNotePreGetProcAddress,      { called just before GetProcAddress, can }
                                   {  override w/ new Proc address return   }
                                   {  value                                 }
    dliFailLoadLibrary,            { failed to load library, fix it by      }
                                   {  returning a valid HMODULE             }
    dliFailGetProcAddress,         { failed to get proc address, fix it by  }
                                   {  returning a valid Proc address        }
    dliNoteEndProcessing           { called after all processing is done,   }
                                   {  no bypass possible at this point      }
                                   {  except by raise, or
                                       RaiseException.                       }
  );
  {$EXTERNALSYM dliNotification}

  DelayLoadProc = record
    fImportByName:      LongBool;
    case Byte of
      0: (szProcName:   _PAnsiChr);
      1: (dwOrdinal:    LongWord);
  end;
  {$EXTERNALSYM DelayLoadProc}
  TDelayLoadProc = DelayLoadProc;
  {$EXTERNALSYM TDelayLoadProc}
  PDelayLoadProc = ^TDelayLoadProc;
  {$EXTERNALSYM PDelayLoadProc}

  DelayLoadInfo = record
    cb:          LongWord;       { size of structure                 }
    pidd:        PImgDelayDescr; { raw form of data (everything is
                                   there)                            }
    ppfn:        Pointer;        { points to address of function to
                                   load                              }
    szDll:       _PAnsiChr;      { name of dll                       }
    dlp:         TDelayLoadProc; { name or ordinal of procedure      }
    hmodCur:     HMODULE;        { the hInstance of the library we
                                   have loaded                       }
    pfnCur:      Pointer;        { the actual function that will be
                                   called                            }
    dwLastError: LongWord;       { error received (if an error
                                   notification)                     }
  end;
  {$EXTERNALSYM DelayLoadInfo}
  TDelayLoadInfo = DelayLoadInfo;
  {$EXTERNALSYM TDelayLoadInfo}
  PDelayLoadInfo = ^TDelayLoadInfo;
  {$EXTERNALSYM PDelayLoadInfo}

  PfnDliHook = function (dliNotify: dliNotification; pdli: PDelayLoadInfo): Pointer; stdcall;
  {$EXTERNALSYM PfnDliHook}
  TDelayedLoadHook = PfnDliHook;
  {$EXTERNALSYM TDelayedLoadHook}

var
  __pfnDliNotifyHook2: Pointer;
  __pfnDliFailureHook2: Pointer;

procedure __delayLoadHelper2;
procedure __FUnloadDelayLoadedDLL2;
procedure __HrLoadAllImportsForDll;

{ Unload support }

var
  UnloadDelayLoadedDLLPtr: Pointer = @__FUnloadDelayLoadedDLL2;
  DelayLoadHelper: Pointer = @__delayLoadHelper2;
  pfnDliNotifyHook: Pointer = @__pfnDliNotifyHook2;
  pfnDliFailureHook: Pointer = @__pfnDliFailureHook2;
  HrLoadAllImportsForDll: Pointer = @__HrLoadAllImportsForDll;

{ Hook pointers }

{ The "notify hook" gets called for every call to the
   delay load helper.  This allows a user to hook every call and
   skip the delay load helper entirely.

   dliNotify =
   (
       dliNoteStartProcessing   or
       dliNotePreLoadLibrary    or
       dliNotePreGetProcAddress or
       dliNoteEndProcessing
   )

   on this call.
}

function SetDliNotifyHook2(HookProc: TDelayedLoadHook): TDelayedLoadHook;
function DliNotifyHook2: TDelayedLoadHook;
{$EXTERNALSYM SetDliNotifyHook2}
{$EXTERNALSYM DliNotifyHook2}

{ This is the failure hook,

   dliNotify =
   (
       dliFailLoadLibrary       or
       dliFailGetProcAddress
   )
}
function SetDliFailureHook2(HookProc: TDelayedLoadHook): TDelayedLoadHook;
function DliFailureHook2: TDelayedLoadHook;
{$EXTERNALSYM SetDliFailureHook2}
{$EXTERNALSYM DliFailureHook2}

{ takes a pointer to a name to unload, or NULL to unload all the delay load dlls in the list. }

procedure UnloadDelayLoadedDLL2(szDll: _PAnsiChr); stdcall;


{ Snap load support - Load and resolve all delay-loaded entrypoints for the given dll }
procedure LoadAllImportsForDll(szDll: _PAnsiChr); stdcall;

{$IF defined(X86ASM)}
procedure _DelayLoadHelper2;
{$ELSE !PUREPASCAL}
function _DelayLoadHelper2(var Address: Pointer; DelayImportDescriptor: Pointer): Pointer;
{$ENDIF !PUREPASCAL}

{$ENDIF MSWINDOWS}

implementation

{$IFDEF MSWINDOWS}
const
  kernel = 'kernel32.dll';

function InterlockedExchange(var Target: Integer; Value: Integer): Integer; stdcall;
begin
  Result := AtomicExchange(Target, Value);
end;

function FreeLibrary(ModuleHandle: HINST): LongBool; stdcall;
  external kernel name 'FreeLibrary';

function GetModuleFileNameA(Module: Integer; Filename: _PAnsiChr; Size: Integer): Integer; stdcall;
  external kernel name 'GetModuleFileNameA';
function GetModuleFileNameW(Module: Integer; Filename: PWideChar; Size: Integer): Integer; stdcall;
  external kernel name 'GetModuleFileNameW';
{$IFNDEF UNICODE}
function GetModuleFileName(Module: Integer; Filename: _PAnsiChr; Size: Integer): Integer; stdcall;
  external kernel name 'GetModuleFileNameA';
{$ELSE}
function GetModuleFileName(Module: Integer; Filename: PWideChar; Size: Integer): Integer; stdcall;
  external kernel name 'GetModuleFileNameW';
{$ENDIF}

function GetModuleHandleA(ModuleName: _PAnsiChr): HINST; stdcall;
  external kernel name 'GetModuleHandleA';
function GetModuleHandleW(ModuleName: PWideChar): HINST; stdcall;
  external kernel name 'GetModuleHandleW';
{$IFNDEF UNICODE}
function GetModuleHandle(ModuleName: _PAnsiChr): HINST; stdcall;
  external kernel name 'GetModuleHandleA';
{$ELSE}
function GetModuleHandle(ModuleName: PWideChar): HINST; stdcall;
  external kernel name 'GetModuleHandleW';
{$ENDIF}

function LocalAlloc(flags, size: Integer): Pointer; stdcall;
  external kernel name 'LocalAlloc';

function LocalFree(addr: Pointer): Pointer; stdcall;
  external kernel name 'LocalFree';

function TlsAlloc: Integer; stdcall;
  external kernel name 'TlsAlloc';

function TlsFree(TlsIndex: Integer): Boolean; stdcall;
  external kernel name 'TlsFree';

function TlsGetValue(TlsIndex: Integer): Pointer; stdcall;
  external kernel name 'TlsGetValue';

function TlsSetValue(TlsIndex: Integer; TlsValue: Pointer): Boolean; stdcall;
  external kernel name 'TlsSetValue';

function GetCommandLineA: _PAnsiChr; stdcall;
  external kernel name 'GetCommandLineA';
function GetCommandLineW: PWideChar; stdcall;
  external kernel name 'GetCommandLineW';
{$IFNDEF UNICODE}
function GetCommandLine: PAnsiChar; stdcall;
  external kernel name 'GetCommandLineA';
{$ELSE}
function GetCommandLine: PWideChar; stdcall;
  external kernel name 'GetCommandLineW';
{$ENDIF}

function GetLastError: Integer; stdcall;
  external kernel name 'GetLastError';

const
{$IF defined(CPU386)}
  tlsArray      = $2C;    { offset of tls array from FS: }
{$ENDIF}
{$IF defined(CPUX64)}
  tlsArray      = $58;    { offset of tls array from FS: }
{$ENDIF}
  LMEM_ZEROINIT = $40;

{$IFDEF MSWINDOWS}

{$L delayhlp.obj}

procedure LoadLibraryA; external 'kernel32.dll' name 'LoadLibraryA';
procedure lstrcmpiA; external 'kernel32.dll' name 'lstrcmpiA';
procedure RaiseException; external 'kernel32.dll' name 'RaiseException';
procedure GetProcAddress; external 'kernel32.dll' name 'GetProcAddress';
procedure __delayLoadHelper2; external;
procedure __FUnloadDelayLoadedDLL2; external;
procedure __HrLoadAllImportsForDll; external;
procedure ShutdownDelayHelp2; external;

function SetDliNotifyHook2(HookProc: TDelayedLoadHook): TDelayedLoadHook;
begin
  Result := AtomicExchange(PPointer(pfnDliNotifyHook)^, @HookProc);
end;

function DliNotifyHook2: TDelayedLoadHook;
begin
  Result := PPointer(pfnDliNotifyHook)^;
end;

function SetDliFailureHook2(HookProc: TDelayedLoadHook): TDelayedLoadHook;
begin
  Result := AtomicExchange(PPointer(pfnDliFailureHook)^, @HookProc);
end;

function DliFailureHook2: TDelayedLoadHook;
begin
  Result := PPointer(pfnDliFailureHook)^;
end;

                                                                    
{$IF defined(X86ASM)}
procedure _DelayLoadHelper2;
asm
     JMP [delayLoadHelper]
end;
{$ELSE}
function _DelayLoadHelper2(var Address: Pointer; DelayImportDescriptor: Pointer): Pointer;
type
  TDelayLoadHelperProc = function(var Address: Pointer; DelayImportDescriptor: Pointer): Pointer;
begin
  Result := TDelayLoadHelperProc(DelayLoadHelper)(Address, DelayImportDescriptor);
end;
{$ENDIF !PUREPASCAL}

                                                                                          
procedure UnloadDelayLoadedDLL2(szDll: _PAnsiChr);
{$IF defined(X86ASM) or defined(X64ASM)}
asm
{$IF defined(X86ASM)}
     POP EBP
{$ENDIF}
     JMP [UnloadDelayLoadedDLLPtr]
end;
{$ELSE}
type
  TUnloadDelayLoadedDLLProc = procedure(szDll: PAnsiChar);
begin
  TUnloadDelayLoadedDLLProc(UnloadDelayLoadedDLLPtr)(szDll);
end;
{$ENDIF !PUREPASCAL}

procedure LoadAllImportsForDll(szDll: _PAnsiChr); stdcall;
{$IF defined(X86ASM) or defined(X64ASM)}
asm
{$IF defined(X86ASM)}
     POP EBP
{$ENDIF}
     JMP [HrLoadAllImportsForDll]
end;
{$ELSE}
type
  TUnloadDelayLoadedDLLProc = procedure(szDll: _PAnsiChr);
begin
  TUnloadDelayLoadedDLLProc(HrLoadAllImportsForDll)(szDll);
end;
{$ENDIF !PUREPASCAL}

{$ENDIF MSWINDOWS}

function AllocTlsBuffer(Size: Integer): Pointer;
begin
  Result := LocalAlloc(LMEM_ZEROINIT, Size);
end;

var
  tlsBuffer: Pointer;    // RTM32 DOS support
{$ENDIF}

{$IFDEF POSIX}
{$I PosixAPIs.inc}
function TlsGetValue(Key: Integer): Pointer; cdecl;
  external libpthread name _PU + 'pthread_getspecific';

function TlsSetValue(Key: Integer; Ptr: Pointer): Integer; cdecl;
  external libpthread name _PU + 'pthread_setspecific';

function AllocTlsBuffer(Size: Cardinal): Pointer;
begin
  // The C++ rtl handles all tls in a C++ module
  if ModuleIsCpp then
    RunError(226);

  Result := __malloc(Size);
  if Result <> nil then
    FillChar(Result^, Size, 0);
end;

procedure FreeTLSBuffer(ValueInKey: Pointer); export cdecl;
begin
  // The C++ rtl handles all tls in a C++ module
  if ModuleIsCpp then
    RunError(226);
  __free(ValueInKey);
end;

procedure AllocTlsIndex; cdecl export;
begin
  // guaranteed to reach here only once per process
  // The C++ rtl handles all tls in a C++ module
  if ModuleIsCpp then
    RunError(226);
  if pthread_key_create(TlsIndex, FreeTLSBuffer) <> 0 then
  begin
    TlsIndex := -1;
    RunError(226);
  end;
end;

{$IFDEF PIC}
function GetGOT: Pointer; export;
begin
  asm
  MOV Result,EBX
  end;
end;
{$ENDIF PIC}

const
  tlsSizeName = '@Sysinit@tlsSize';

function GetThisModuleHandle: LongWord;
var
  Info: dl_info;
begin
// if (dladdr(@GetThisModuleHandle, Info) = 0) or (Info.BaseAddress = ExeBaseAddress) then
 if (dladdr(UIntPtr(@GetThisModuleHandle), Info) = 0) or (Info.dli_fbase = ExeBaseAddress) then
//    Info.FileName := nil; // if we're not in a library, we must be main exe
//  Result := LongWord(dlopen(Info.Filename, RTLD_LAZY));
    Info.dli_fname := nil; // if we're not in a library, we must be main exe
  Result := LongWord(dlopen(Info.dli_fname, RTLD_LAZY));
  if Result <> 0 then
    dlclose(Result);
end;

{$IFDEF LINUX}
var
                                                                                    
//  InitOnceSemaphore: pthread_once_t = ONCE_INIT;
  InitOnceSemaphore: pthread_once_t = 0;
{$ENDIF LINUX}
{$IFDEF MACOS}
var
  InitOnceSemaphore: pthread_once_t = (__sig: $30B1BCBA);
{$ENDIF MACOS}
{$ENDIF POSIX}

var
  Module: TLibModule = (
    Next: nil;
    Instance: 0;
    CodeInstance: 0;
    DataInstance: 0;
    ResInstance: 0;
    TypeInfo: nil;
    Reserved: 0
{$IFDEF defined(LINUX) or defined(MACOS)}
    ; InstanceVar: nil;
    GOT: 0
{$ENDIF LINUX or MACOS}
{$IFDEF PC_MAPPED_EXCEPTIONS}
    ; CodeSegStart: 0;
    CodeSegEnd: 0
{$ENDIF PC_MAPPED_EXCEPTIONS}
    );

function GetTlsSize: Integer;
{$IF defined(POSIX) and defined(CPUX86)}
asm
        // Use assembler code not to include PIC base gain
        MOV  EAX, offset TlsLast
end;
{$ELSE}
begin
  Result := NativeInt(@TlsLast);
  {$IF DECLARED(TlsStart)}
  Result := Result - NativeInt(@TlsStart);
  {$ENDIF}
end;
{$ENDIF}

procedure       InitThreadTLS;
var
  p: Pointer;
  tlsSize: Integer;
begin
//asm
//int 3
//end;

  tlsSize := GetTlsSize;
  if tlsSize = 0 then  Exit;
{$IFDEF POSIX}
  pthread_once(InitOnceSemaphore, AllocTlsIndex);
{$ENDIF}
  if TlsIndex = -1 then  RunError(226);
  p := AllocTlsBuffer(tlsSize);
  if p = nil then
    RunError(226)
  else
    TlsSetValue(TlsIndex, p);
end;

{$IFDEF MSWINDOWS}
procedure       InitProcessTLS;
begin
  if @TlsLast = nil then
    Exit;
  TlsIndex := TlsAlloc;
  InitThreadTLS;
  tlsBuffer := TlsGetValue(TlsIndex);  // RTM32 DOS support
end;

procedure       ExitThreadTLS;
var
  p: Pointer;
begin
  if @TlsLast = nil then
    Exit;
  if TlsIndex <> -1 then begin
    p := TlsGetValue(TlsIndex);
    if p <> nil then begin
      LocalFree(p);
      TlsSetValue(TlsIndex, nil);
    end;
  end;
end;

procedure       ExitProcessTLS;
begin
  if @TlsLast = nil then
    Exit;
  ExitThreadTLS;
  if TlsIndex <> -1 then
    TlsFree(TlsIndex);
end;
{$ENDIF}

const
  DLL_PROCESS_DETACH = 0;
  DLL_PROCESS_ATTACH = 1;
  DLL_THREAD_ATTACH  = 2;
  DLL_THREAD_DETACH  = 3;

function _GetTls: Pointer;
{$IFDEF POSIX}
begin
  Result := TlsGetValue(TlsIndex);
  if Result = nil then
  begin
    InitThreadTLS;
    Result := TlsGetValue(TlsIndex);
  end;
end;
{$ENDIF POSIX}
{$IFDEF MSWINDOWS}
{$IF defined(CPUX64)}
type
  PPPointerArray = ^PPointerArray;
var
  P: PPointerArray;
begin
  if ModuleIsLib then
  begin
    Result := TlsGetValue(TlsIndex);
    if Result = nil then
    begin
      InitThreadTLS;
      Result := TlsGetValue(TlsIndex);
      if Result = nil then
        Result := tlsBuffer;
    end;
  end
  else
  begin
    //P := PPPointerArray(ReadGSQWord(tlsArray));
    P := PPPointerArray(PByte(@GSSegBase) + tlsArray)^;
    Result := P^[TlsIndex];
  end;
end;
{$ELSE !CPUX64}
asm
        MOV     CL,ModuleIsLib
        MOV     EAX,TlsIndex
        TEST    CL,CL
        JNE     @@isDll
        MOV     EDX,FS:tlsArray
        MOV     EAX,[EDX+EAX*4]
        RET

@@initTls:
        CALL    InitThreadTLS
        MOV     EAX,TlsIndex
        PUSH    EAX
        CALL    TlsGetValue
        TEST    EAX,EAX
        JE      @@RTM32
        RET

@@RTM32:
        MOV     EAX, tlsBuffer
        RET

@@isDll:
        PUSH    EAX
        CALL    TlsGetValue
        TEST    EAX,EAX
        JE      @@initTls
end;
{$ENDIF !CPUX64}

const
  TlsProc: array [DLL_PROCESS_DETACH..DLL_THREAD_DETACH] of procedure =
    (ExitProcessTLS,InitProcessTLS,InitThreadTLS,ExitThreadTLS);
{$ENDIF MSWINDOWS}

{$IFDEF PC_MAPPED_EXCEPTIONS}
const
  UNWINDFI_TOPOFSTACK =   $BE00EF00;

{
  The linker sets the value of TextStartAdj to be the delta between GetTextStart
  and the start of the text segment.  This allows us to get the pointer to the
  start of the text segment in a position independent fashion.
}
function GetTextStart : NativeInt;
asm
        CALL  @@label1
@@label1:
        POP   EAX
        SUB   EAX, 5 + offset TextStartAdj
end;

{
  The linker sets the value of CodeSegSize to the length of the text segment,
  excluding the PC map.  This allows us to get the pointer to the exception
  information that we need at runtime, also in a position independent fashion.
}
function GetTextEnd : NativeInt;
asm
        CALL  GetTextStart
        ADD   EAX, offset CodeSegSize
end;
{$ENDIF PC_MAPPED_EXCEPTIONS}

procedure InitializeModule;
begin
  RegisterModule(@Module);
end;

{$IFDEF POSIX}
procedure FreeLibrary(Handle: LongWord);
begin
   dlclose(Handle);
end;
{$ENDIF POSIX}

procedure UninitializeModule;
begin
  UnregisterModule(@Module);
  if (Module.ResInstance <> Module.Instance) and (Module.ResInstance <> 0) then
    FreeLibrary(Module.ResInstance);
end;

{$IF defined(CPU386)}
procedure VclInit(isDLL, isPkg: Boolean; hInst: LongInt; isGui: Boolean); cdecl;
{$ELSE}
procedure VclInit(isDLL, isPkg: Boolean; hInst: HINST; isGui: Boolean); cdecl;
{$ENDIF}
begin
  ModuleIsLib := isDLL;
  ModuleIsPackage := isPkg;
  IsLibrary := isDLL and not isPkg;
  HInstance := hInst;
  Module.Instance := hInst;
  Module.CodeInstance := 0;
  Module.DataInstance := 0;
  ModuleIsCpp := True;
{$IFDEF defined(LINUX) or defined(MACOS)}
  if ModuleIsLib then
    Module.InstanceVar := @HInstance;
{$IFDEF PIC}
  Module.GOT := UIntPtr(GetGot);
{$ENDIF PIC}
  { Module.CodeSegStart, Module.CodeSegEnd not used:  the C++
    rtl will feed the unwinder. }
{$ENDIF LINUX or MACOS}
  InitializeModule;
  if not ModuleIsLib then
  begin
    Module.CodeInstance := FindHInstance(@VclInit);
    Module.DataInstance := FindHInstance(@DataMark);
{$IFDEF MSWINDOWS}
    CmdLine := GetCommandLine;
    IsConsole := not isGui;
{$ENDIF MSWINDOWS}
  end;
end;

procedure VclExit; cdecl;
var
  P: procedure;
begin
  if not ModuleIsLib then
    while ExitProc <> nil do
    begin
      @P := ExitProc;
      ExitProc := nil;
      P;
    end;
  UnInitializeModule;
end;

{$IFDEF PC_MAPPED_EXCEPTIONS}
procedure RegisterPCMap;
begin
{$IF defined(ELF) or defined(MACOS)}
  SysRegisterIPLookup(GetTextStart,
                      GetTextEnd,
                      Pointer(GetTextEnd),
                      UIntPtr(@_Global_Offset_Table_));
{$ELSE !(ELF or MACOS)}
  SysRegisterIPLookup(GetTextStart,
                      GetTextEnd,
                      Pointer(GetTextEnd),
                      0);
{$ENDIF !(ELF or MACOS)}
end;

procedure UnregisterPCMap;
begin
  SysUnregisterIPLookup(GetTextStart);
end;
{$ENDIF PC_MAPPED_EXCEPTIONS}

{$IFDEF MSWINDOWS}
function _InitPkg(AHInst: HINST; Reason: Integer; Resvd: Pointer): Longbool; stdcall;
begin
  ModuleIsLib := True;
  ModuleIsPackage := True;
  Module.Instance := AHInst;
  Module.CodeInstance := 0;
  Module.DataInstance := 0;
  HInstance := AHInst;
  if @TlsLast <> nil then
    TlsProc[Reason];
  if Reason = DLL_PROCESS_ATTACH then
    InitializeModule
  else if Reason = DLL_PROCESS_DETACH then
    UninitializeModule;
  _InitPkg := True;
end;
{$ENDIF}
{$IF defined(LINUX) or defined(MACOS)}
function _InitPkg: LongBool;
begin
{$IFDEF DEBUG_STARTUP}
asm
INT 3
end;
{$ENDIF DEBUG_STARTUP}
{$IFDEF PC_MAPPED_EXCEPTIONS}
  RegisterPCMap;
{$ENDIF PC_MAPPED_EXCEPTIONS}
  TlsIndex := -1;
  ModuleIsLib := True;
  ModuleIsPackage := True;
  Module.Instance := GetThisModuleHandle;
  Module.InstanceVar := @HInstance;
  Module.CodeInstance := 0;
  Module.DataInstance := 0;
  Module.GOT := UIntPtr(@_Global_Offset_Table_);
{$IFDEF PC_MAPPED_EXCEPTIONS}
  Module.CodeSegStart := GetTextStart;
  Module.CodeSegEnd := GetTextEnd;
{$ENDIF PC_MAPPED_EXCEPTIONS}
  HInstance := Module.Instance;
  InitThreadTLS;
  InitializeModule;
  _InitPkg := True;
end;
{$ENDIF LINUX or MACOS}

procedure _PackageLoad(const Table: PackageInfo);
begin
  System._PackageLoad(Table, @Module);
end;

procedure _PackageUnload(const Table: PackageInfo);
begin
  System._PackageUnload(Table, @Module);
end;

{$IFDEF MSWINDOWS}
{$IF not defined(CPU386)}
                                            
procedure _InitLib(Context: PInitContext; InitTable: PackageInfo; AHInst: HINST; Reason: LongWord; Reserved: Pointer);
begin
  if Reason = DLL_PROCESS_ATTACH then
  begin
    ModuleIsLib := True;
    HInstance := AHInst;
    Module.Instance := AHInst;
    Module.CodeInstance := 0;
    Module.DataInstance := 0;
    Module.TypeInfo := @InitTable.TypeInfo;
    InitializeModule;
  end;
  _StartLib(Context, InitTable, @Module, @TlsProc, DllProcEx, AHInst, Reason, Reserved);
end;
{$ELSE CPU386}
procedure _InitLib;
asm
        { ->    EAX Inittable   }
        {       [EBP+8] Hinst   }
        {       [EBP+12] Reason }
        {       [EBP+16] Resvd  }

        MOV     EDX,offset Module
        CMP     dword ptr [EBP+12],DLL_PROCESS_ATTACH
        JNE     @@notInit

        PUSH    EAX
        PUSH    EDX
        MOV     ModuleIsLib,1
        MOV     ECX,[EBP+8]
        MOV     HInstance,ECX
        MOV     [EDX].TLibModule.Instance,ECX
        MOV     [EDX].TLibModule.CodeInstance,0
        MOV     [EDX].TLibModule.DataInstance,0
        LEA     EAX,[EAX].PackageInfoTable.TypeInfo
        MOV     [EDX].TLibModule.TypeInfo,EAX
        CALL    InitializeModule
        POP     EDX
        POP     EAX

@@notInit:
        PUSH    DllProc
        MOV     ECX,offset TlsProc
        CALL    _StartLib
end;
{$ENDIF CPU386}

// ExitLib is the same as InitLib in Windows.

{$ENDIF MSWINDOWS}

                                                 
{$IF defined(LINUX) or defined(MACOS)}
procedure _InitLib(Context: PInitContext);
begin
{$IFDEF DEBUG_STARTUP}
asm
        INT 3
end;
{$ENDIF DEBUG_STARTUP}
{$IFDEF CPUX86}
  asm
        PUSH    UNWINDFI_TOPOFSTACK
{$IFDEF ALIGN_STACK}
        SUB   ESP, 12
{$ENDIF ALIGN_STACK}
  end;
{$ENDIF CPUX86}
  Context.DLLInitState := DLL_PROCESS_ATTACH;
  TlsIndex := -1;
  ModuleIsLib := True;
  HInstance := GetThisModuleHandle;
  Module.Instance := HInstance;
  Module.InstanceVar := @HInstance;
  Module.CodeInstance := 0;
  Module.DataInstance := 0;
  Module.GOT := UIntPtr(@_Global_Offset_Table_);
{$IFDEF PC_MAPPED_EXCEPTIONS}
  Module.CodeSegStart := GetTextStart;
  Module.CodeSegEnd := GetTextEnd;
{$ENDIF PC_MAPPED_EXCEPTIONS}
  InitializeModule;
  InitThreadTLS;
{$IFDEF PC_MAPPED_EXCEPTIONS}
  RegisterPCMap;
{$ENDIF PC_MAPPED_EXCEPTIONS}
  _StartLib(Context, @Module, DLLProcEx);
{$IFDEF CPUX86}
  asm
{$IFDEF ALIGN_STACK}
        ADD   ESP, 16
{$ELSE !ALIGN_STACK}
        ADD   ESP, 4
{$ENDIF !ALIGN_STACK}
  end;
{$ENDIF CPUX86}
end;

// InnerExitLib provides GOT fixup and global var addressing
function InnerExitLib(Context: PInitContext): Integer;
begin
  Result := 0;
  if ModuleIsPackage then
  begin
    UninitializeModule;
{$IFDEF PC_MAPPED_EXCEPTIONS}
    UnregisterPCMap;
{$ENDIF PC_MAPPED_EXCEPTIONS}
  end
  else
    _StartLib(Context, @Module, DLLProcEx);
end;

                                                
                                                 
{$IF defined(PUREPASCAL) or not defined(CPUX86)}
function _ExitLib: Integer; cdecl;
begin
  Result := 0;
end;
{$ELSE !PUREPASCAL and CPUX86}
function _ExitLib: Integer; cdecl;
asm
{$IFDEF DEBUG_STARTUP}
        INT 3
{$ENDIF DEBUG_STARTUP}
        PUSH    EBP
        MOV     EBP,ESP
        PUSH    UNWINDFI_TOPOFSTACK
        XOR     EAX,EAX
        PUSH    DLL_PROCESS_DETACH    // InitContext.DLLInitState
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        PUSH    EBP
        PUSH    EAX                   // InitContext.Module
        PUSH    EAX                   // InitContext.InitCount
        PUSH    EAX                   // InitContext.InitTable (filled in later)
        PUSH    EAX                   // InitContext.OuterContext
        MOV     EAX,ESP
        CALL    InnerExitLib;
        ADD     ESP, 16
        POP     EBP
        POP     EBX
        POP     ESI
        POP     EDI
        MOV     ESP,EBP
        POP     EBP
end;
{$ENDIF !PUREPASCAL and CPUX86)}
{$ENDIF LINUX or MACOS}

                                                      
{$IFDEF POSIX}
procedure _GetCallerEIP;
{$IFDEF CPUX86}
asm
        MOV     EBX, [ESP]
end;
{$ELSE}
begin
end;
{$ENDIF}
{$ENDIF POSIX}

{$IFDEF WIN64}
procedure __dbkFCallArgs(
  a01: Pointer; a02: Pointer; a03: Pointer; a04:Pointer; a05: Pointer;
  a06: Pointer; a07: Pointer; a08: Pointer; a09:Pointer; a10: Pointer;
  a11: Pointer; a12: Pointer; a13: Pointer; a14:Pointer; a15: Pointer;
  a16: Pointer; a17: Pointer; a18: Pointer; a19:Pointer; a20: Pointer;
  a21: Pointer; a22: Pointer; a23: Pointer; a24:Pointer; a25: Pointer;
  a26: Pointer; a27: Pointer; a28: Pointer; a29:Pointer; a30: Pointer);
begin
end;
procedure __dbk_fcall_wrapper; export;
var p: Pointer;
begin
  try
    __dbkFCallArgs( // reserved stack arg space
      p, p, p, p, p , p, p, p , p, p,
      p, p, p, p, p , p, p, p , p, p,
      p, p, p, p, p , p, p, p , p, p);
  except
    __dbkFCallArgs(
      p, p, p, p, p , p, p, p , p, p,
      p, p, p, p, p , p, p, p , p, p,
      p, p, p, p, p , p, p, p , p, p);
  end;
end;
{$ENDIF WIN64}

                                                            
{$IFDEF MACOS}
{$IF defined(CPUX86) or DEFINED(CPUX64)}
procedure __dbk_fcall_wrapper; export;
begin
  try
    asm
    int 3; int 3; int 3; int 3; int 3; int 3; int 3; int 3; int 3; int 3;
    int 3; int 3
    end;
  except
    asm
    int 3
    end;
  end;
end;
{$ELSE}
procedure __dbkFCallArgs(
  a01: Pointer; a02: Pointer; a03: Pointer; a04:Pointer; a05: Pointer;
  a06: Pointer; a07: Pointer; a08: Pointer; a09:Pointer; a10: Pointer;
  a11: Pointer; a12: Pointer; a13: Pointer; a14:Pointer; a15: Pointer;
  a16: Pointer; a17: Pointer; a18: Pointer; a19:Pointer; a20: Pointer;
  a21: Pointer; a22: Pointer; a23: Pointer; a24:Pointer; a25: Pointer;
  a26: Pointer; a27: Pointer; a28: Pointer; a29:Pointer; a30: Pointer);
begin
end;
procedure __dbk_fcall_wrapper; export;
var
  p: Pointer;
begin
  p := nil;
  try
    __dbkFCallArgs( // reserved stack arg space
      p, p, p, p, p , p, p, p , p, p,
      p, p, p, p, p , p, p, p , p, p,
      p, p, p, p, p , p, p, p , p, p);
  except
    __dbkFCallArgs(
      p, p, p, p, p , p, p, p , p, p,
      p, p, p, p, p , p, p, p , p, p,
      p, p, p, p, p , p, p, p , p, p);
  end;
end;
{$ENDIF}
{$ENDIF MACOS}

{$IFDEF MSWINDOWS}
procedure _InitExe(InitTable: Pointer);
begin
  TlsIndex := 0;
  HInstance := GetModuleHandle(nil);
  Module.Instance := HInstance;
  Module.CodeInstance := 0;
  Module.DataInstance := 0;
  Module.TypeInfo := @PackageInfo(InitTable)^.TypeInfo;
{$IFDEF WIN64}
  dbkFCallWrapperAddr := @__dbk_fcall_wrapper;
{$ENDIF WIN64}
  InitializeModule;
  _StartExe(InitTable, @Module);
end;
{$ENDIF MSWINDOWS}

{$IFDEF LINUX}
procedure InitVmtImports;
var
  P: PNativeInt;
begin
  P := @TypeImportsTable;
  if P = nil then Exit;
  while P^ <> 0 do
  begin
    P^ := NativeInt(dlsym(0, _PAnsiChr(P^)));
    Inc(P);
  end;
end;
{$ENDIF LINUX}

//{$DEFINE DEBUG_STARTUP}
{$IF defined(LINUX) or defined(MACOS)}
{$IFDEF LINUX}
procedure _InitExe(InitTable: Pointer; Argc: Integer; Argp: Pointer); export;
{$ENDIF LINUX}
{$IFDEF MACOS}
procedure _InitExe(InitTable: Pointer; ProgramParams: Pointer); export;
var
  Argc: Integer;
  Argp: Pointer;
{$ENDIF MACOS}
begin
{$IFDEF DEBUG_STARTUP}
  asm
    INT 3
  end;
{$ENDIF DEBUG_STARTUP}
  HInstance := GetThisModuleHandle;
  Module.Instance := HInstance;
  Module.InstanceVar := @HInstance;
  Module.CodeInstance := 0;
  Module.TypeInfo := @PackageInfo(InitTable)^.TypeInfo;
  Module.DataInstance := 0;
{$IFDEF MACOS}
  dbkFCallWrapperAddr := @__dbk_fcall_wrapper;
{$ENDIF MACOS}
  InitializeModule;
  InitThreadTLS;
{$IFDEF PC_MAPPED_EXCEPTIONS}
  RegisterPCMap();
{$ENDIF PC_MAPPED_EXCEPTIONS}
{$IFDEF LINUX}
  InitVmtImports;
{$ENDIF LINUX}
{$IFDEF MACOS}
  {
    The Mac loader sets up argc/argv, et al a little differently.  The stack
    looks like this when the loader hands control over to the image:

    NULL
    ptr -> fully qualified program name
    NULL
    [0..n] pointers -> environment
    NULL
    [0..n] pointers -> arguments
    argc

    The prologue code generated by the compiler for the main program unit
    is special.  It loads EDX with a pointer to the argc location above,
    then aligns the stack to meet the MACH ABI.  We have to parse that pointer
    a little to get the parameters for _StartExe.
  }
  Argc := PInteger(ProgramParams)^;
  Argp := Pointer(PByte(ProgramParams) + Sizeof(Pointer));
{$ENDIF MACOS}
  _StartExe(InitTable, @Module, Argc, Argp);
end;
{$ENDIF LINUX || MACOS}

{$IFDEF LINUX}
var
  InitAddr: Pointer;

function _main(argc: Integer; argv: Pointer; envp: Pointer): Integer; export cdecl;
type
  TInitFunction = function (argc: Integer; argv, envp: Pointer): Integer; cdecl;
  TExternalInit = function (argc: Integer; argv, envp: Pointer; InitExe: TInitFunction): Integer; cdecl;
var
  ExternalInit: TExternalInit;
  InitFunc: TInitFunction;
begin
  @ExternalInit := dlsym(GetThisModuleHandle, 'ExternalInit');
  @InitFunc := InitAddr;
  System.envp := envp;
  if @ExternalInit <> nil then
    ExternalInit(argc, argv, envp, InitFunc);
  Result := InitFunc(argc, argv, envp);
end;

function __libc_start_main (Main: Pointer; Argc: Integer; Argv: Pointer;
          Init, Fini, rtld_Fini: Pointer; StackEnd: Pointer)
        : Integer;
        cdecl;
        external libc name '__libc_start_main';

{ Program entry point }
procedure _start;
asm
{$IFDEF DEBUG_STARTUP}
        INT 3
{$ENDIF}
        { Mark outermost frame, suggested by ELF i386 ABI.  }
        xor ebp,ebp

        { Get data passed on stack }
        pop eax   { argc }
        mov ecx,esp   { argv }

        { Align stack }
        and esp,0fffffff8h
{$IFDEF PC_MAPPED_EXCEPTIONS}
        { Mark the top of the stack with a signature }
        push  UNWINDFI_TOPOFSTACK
{$ENDIF PC_MAPPED_EXCEPTIONS}
        push  ebp   { padding }
        push  esp   { crt1.o does this, don't know why }
        push  edx   { function to be registered with
                      atexit(), passed by loader }
        push  offset @@ret  { _fini dummy }
        push  offset @@ret  { _init dummy }
        push  ecx   { argv }
        push  eax   { argc }
  { We need a symbol for the Pascal entry point (main unit's
    body).  An external symbol `main' fixed up by the linker
    would be fine.  Alas, external declarations can't do that;
    they must be resolved either in the same file with a $L
    directive, or in a shared object.  Hack: use a bogus,
    distinctive symbol to mark the fixup, find and patch it
    in the linker.  }
{$IFDEF PIC}
        call    GetGOT
        mov     ebx, eax
        add     [esp+12],ebx
        add     [esp+8],ebx
        // Linker will replace _GLOBAL_OFFSET_TABLE_ address with main program block
        mov     eax, offset _GLOBAL_OFFSET_TABLE_
        add     eax, ebx
        mov     [ebx].InitAddr, eax
        mov     eax, offset _main
        add     eax, ebx
        push    eax
{$ELSE !PIC}
        // Linker will replace _GLOBAL_OFFSET_TABLE_ address with main program block
        push  offset _GLOBAL_OFFSET_TABLE_
        pop InitAddr
        push  offset _main
{$ENDIF !PIC}
        call  __libc_start_main
        hlt     { they never come back }

@@ret:
end;
{$ENDIF LINUX}

{$IFDEF LINUX}
{ Procedure body not generated on Windows currently }
procedure OpenEdition;
begin
end;

procedure GPLInfected;
begin
end;

{$IFDEF TRIAL_EDITION}
procedure Evaluation;
begin
end;
{$ENDIF TRIAL_EDITION}

procedure Copyright;
begin
end;

const
  sOpenEdition = 'This application was built with Borland Kylix Open Edition(tm).';                   // do not localize
  sGPLMessage = 'This module must be distributed under the terms of the GNU General '                 // do not localize
	+ 'Public License (GPL), version 2. A copy of this license can be found at:'                        // do not localize
	+ 'http://www.borland.com/kylix/gpl.html.';                                                         // do not localize

exports
{$IF Declared(GPL)}
  OpenEdition name sOpenEdition,
  GPLInfected name sGPLMessage,
{$ENDIF GPL}
{$IFDEF TRIAL_EDITION}
	Evaluation name 'This module was compiled with an evaluation version of Borland Delphi',            // do not localize
{$ENDIF TRIAL_EDITION}

  Copyright name 'Portions Copyright(c) 1995-2012 Embarcadero Technologies, Inc.';                     // do not localize


{$IF Declared(GPL)}
initialization
  if IsConsole and not ModuleIsLib then
  begin
    TTextRec(Output).Mode := fmClosed;
	writeln(sGPLMessage);
  end;
{$ENDIF GPL}
{$ENDIF LINUX}
{$IFDEF MSWINDOWS}
initialization
finalization
  ShutdownDelayHelp2;
{$ENDIF}
end.
