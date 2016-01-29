{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

type
  DWORD = LongWord;

const
  advapi32 = 'advapi32.dll';
  kernel   = 'kernel32.dll';
  user     = 'user32.dll';
  oleaut   = 'oleaut32.dll';

  GENERIC_READ             = DWORD($80000000);
  GENERIC_WRITE            = $40000000;
  FILE_SHARE_READ          = $00000001;
  FILE_SHARE_WRITE         = $00000002;
  FILE_ATTRIBUTE_NORMAL    = $00000080;

  CREATE_NEW               = 1;
  CREATE_ALWAYS            = 2;
  OPEN_EXISTING            = 3;

  FILE_BEGIN               = 0;
  FILE_CURRENT             = 1;
  FILE_END                 = 2;

  STD_INPUT_HANDLE         = DWORD(-10);
  STD_OUTPUT_HANDLE        = DWORD(-11);
  STD_ERROR_HANDLE         = DWORD(-12);

  CSTR_EQUAL               = 2;
  LOCALE_SYSTEM_DEFAULT    = 2048;
  LOCALE_USER_DEFAULT      = 1024;
  LOCALE_INVARIANT         = 127;
  NORM_IGNORECASE          = 1;
  MAX_PATH                 = 260;

  ERROR_INSUFFICIENT_BUFFER = 122;   { dderror }

type
  HWND = THandle;               { from windef.h }
  HKEY = THandle;               { from windef.h }
  DWORD_PTR = ^DWORD;
  PDWORD = ^DWORD;
  BOOL = LongBool;
  PBOOL = ^BOOL;
  ULONG_PTR = NativeUInt;
  SIZE_T = ULONG_PTR;
  UINT = LongWord;
  LANGID = WORD;
  LCID = DWORD;
  LCTYPE = DWORD;   { Locale type constant. }
  LPSTR = _PAnsiChr;
  LPCSTR = _PAnsiChr;
  LPWSTR = PWideChar;
  FARPROC = Pointer;
  ACCESS_MASK = DWORD;
  REGSAM = ACCESS_MASK;  { Requested Key access mask type. }
  ULONGLONG = UInt64;

  PSecurityAttributes = Pointer;
  POverlapped = Pointer;

  PFileTime = ^TFileTime;
  TFileTime = record
    dwLowDateTime: DWORD;
    dwHighDateTime: DWORD;
  end;

  PSystemTime = ^TSystemTime;
  TSystemTime = record
    wYear: Word;
    wMonth: Word;
    wDayOfWeek: Word;
    wDay: Word;
    wHour: Word;
    wMinute: Word;
    wSecond: Word;
    wMilliseconds: Word;
  end;

  PSystemInfo = ^TSystemInfo;
  TSystemInfo = record
    case Integer of
      0: (
        dwOemId: DWORD);
      1: (
        wProcessorArchitecture: Word;
        wReserved: Word;
        dwPageSize: DWORD;
        lpMinimumApplicationAddress: Pointer;
        lpMaximumApplicationAddress: Pointer;
        dwActiveProcessorMask: DWORD_PTR;
        dwNumberOfProcessors: DWORD;
        dwProcessorType: DWORD;
        dwAllocationGranularity: DWORD;
        wProcessorLevel: Word;
        wProcessorRevision: Word);
  end;

  PMemInfo = ^TMemoryBasicInformation;
  TMemoryBasicInformation = record
    BaseAddress : Pointer;
    AllocationBase : Pointer;
    AllocationProtect : DWORD;
    RegionSize : SIZE_T;
    State : DWORD;
    Protect : DWORD;
    Type_9 : DWORD;
  end;

  PStartupInfo = ^TStartupInfo;
  TStartupInfo = record
    cb: DWORD;
    lpReserved: PWideChar;
    lpDesktop: PWideChar;
    lpTitle: PWideChar;
    dwX: DWORD;
    dwY: DWORD;
    dwXSize: DWORD;
    dwYSize: DWORD;
    dwXCountChars: DWORD;
    dwYCountChars: DWORD;
    dwFillAttribute: DWORD;
    dwFlags: DWORD;
    wShowWindow: Word;
    cbReserved2: Word;
    lpReserved2: PByte;
    hStdInput: THandle;
    hStdOutput: THandle;
    hStdError: THandle;
  end;

  TWin32FindData = packed record
    dwFileAttributes: DWORD;
    ftCreationTime: TFileTime;
    ftLastAccessTime: TFileTime;
    ftLastWriteTime: TFileTime;
    nFileSizeHigh: DWORD;
    nFileSizeLow: DWORD;
    dwReserved0: DWORD;
    dwReserved1: DWORD;
    cFileName: array[0..MAX_PATH - 1] of WideChar;
    cAlternateFileName: array[0..13] of WideChar;
  end;

  PRTLCriticalSectionDebug = Pointer;

  TRTLCriticalSection = record
    DebugInfo: PRTLCriticalSectionDebug;
    LockCount: Longint;
    RecursionCount: Longint;
    OwningThread: THandle;
    LockSemaphore: THandle;
    Reserved: ULONG_PTR;
  end;

{$IF defined(CPUX64)}
type
  M128A = record
    Low: UInt64;
    High: Int64;
  end align 16;
  XMM_SAVE_AREA32 = record
    ControlWord: UInt16;
    StatusWord: UInt16;
    TagWord: UInt8;
    Reserved1: UInt8;
    ErrorOpcode: UInt16;
    ErrorOffset: UInt32;
    ErrorSelector: UInt16;
    Reserved2: UInt16;
    DataOffset: UInt32;
    DataSelector: UInt16;
    Reserved3: UInt16;
    MxCsr: UInt32;
    MxCsr_Mask: UInt32;
    FloatRegisters: array[0..7] of M128A;
    XmmRegisters: array[0..15] of M128A;
    Reserved4: array[0..95] of Byte;
  end align 16;
  XMM_SAVE_AREA = record
    case Integer of
      0: (
        FltSave: XMM_SAVE_AREA32);
      1: (
        Header: array[0..1] of M128A;
        Legacy: array[0..7] of M128A;
        Xmm0, Xmm1, Xmm2, Xmm3, Xmm4, Xmm5, Xmm6, Xmm7: M128A;
        Xmm8, Xmm9, Xmm10, Xmm11, Xmm12, Xmm13, Xmm14, Xmm15: M128A);
  end;
  PContext = ^TContext;
  TContext = record
    P1Home: UInt64;
    P2Home: UInt64;
    P3Home: UInt64;
    P4Home: UInt64;
    P5Home: UInt64;
    P6Home: UInt64;
    ContextFlags: UInt32;
    MxCsr: UInt32;
    SegCs, SegDs, SegEs, SegFs, SegGs, SegSs: UInt16;
    EFlags: UInt32;
    Dr0, Dr1, Dr2, Dr3, Dr6, Dr7: UInt64;
    Rax, Rcx, Rdx, Rbx, Rsp, Rbp, Rsi, Rdi: UInt64;
    R8, R9, R10, R11, R12, R13, R14, R15: UInt64;
    Rip: UInt64;
    case Integer of
      0: (
        FltSave: XMM_SAVE_AREA32);
      1: (
        Header: array[0..1] of M128A;
        Legacy: array[0..7] of M128A;
        Xmm0, Xmm1, Xmm2, Xmm3, Xmm4, Xmm5, Xmm6, Xmm7: M128A;
        Xmm8, Xmm9, Xmm10, Xmm11, Xmm12, Xmm13, Xmm14, Xmm15: M128A);
      2: (
        XmmSaveArea: XMM_SAVE_AREA;

        VectorRegister: array[0..25] of M128A;
        VectorControl: UInt64;
        DebugControl: UInt64;
        LastBranchToRip: UInt64;
        LastBranchFromRip: UInt64;
        LastExceptionToRip: UInt64;
        LastExceptionFromRip: UInt64);
  end align 16;
{$ENDIF !CPUX64}
{$IF defined(CPU386)}
type
  PContext = Pointer{^TContext};
{$ENDIF}

{$IF not defined(CPU386)}
const // for TExceptionDisposition / EXCEPTION_DISPOSITION
  DISPOSITION_DISMISS          = 0;
  DISPOSITION_CONTINUE_SEARCH  = 1;
  DISPOSITION_NESTED_EXCEPTION = 2;
  DISPOSITION_COLLIDED_UNWIND  = 3;

type
  TExceptionDisposition = Integer;
  PRuntimeFunction = ^TRuntimeFunction;
  TRuntimeFunction = record
    FunctionStart: LongWord;
    FunctionEnd: LongWord;
    UnwindInfo: LongWord;
  end;
  PUnwindHistoryTable = Pointer{^TUnwindHistoryTable};
  PExecptionRoutine = Pointer{^TExecptionRoutine};
  PDispatcherContext = ^TDispatcherContext;
  TDispatcherContext = record
    ControlPc:        NativeUInt;           //  0 $00
    ImageBase:        NativeUInt;           //  8 $08
    FunctionEntry:    PRuntimeFunction;     // 16 $10
    EstablisherFrame: NativeUInt;           // 24 $18
    TargetIp:         NativeUInt;           // 32 $20
    ContextRecord:    PContext;             // 40 $28
    LanguageHandler:  PExecptionRoutine;    // 48 $30
    HandlerData:      Pointer;              // 56 $38
    HistoryTable:     PUnwindHistoryTable;  // 64 $40
    ScopeIndex:       UInt32;               // 72 $48
    _Fill0:           UInt32;               // 76 $4c
  end;                                      // 80 $50
  TTopLevelExceptionFilter = function(ExceptionInfo: PExceptionPointers):
    LongWord;
{$ENDIF !CPU386}


type
  _LOGICAL_PROCESSOR_RELATIONSHIP = (RelationProcessorCore{ = 0}, RelationNumaNode{ = 1}, RelationCache{ = 2}, RelationProcessorPackage{ = 3}, RelationGroup{ = 4}, RelationAll = $FFFF);
  {$EXTERNALSYM _LOGICAL_PROCESSOR_RELATIONSHIP}
  LOGICAL_PROCESSOR_RELATIONSHIP = _LOGICAL_PROCESSOR_RELATIONSHIP;
  {$EXTERNALSYM LOGICAL_PROCESSOR_RELATIONSHIP}
  TLogicalProcessorRelationship = LOGICAL_PROCESSOR_RELATIONSHIP;

type
  _PROCESSOR_CACHE_TYPE = (CacheUnified{ = 0}, CacheInstruction{ = 1}, CacheData{ = 2}, CacheTrace{ = 3});
  {$EXTERNALSYM _PROCESSOR_CACHE_TYPE}
  PROCESSOR_CACHE_TYPE = _PROCESSOR_CACHE_TYPE;
  {$EXTERNALSYM PROCESSOR_CACHE_TYPE}
  TProcessorCacheType = PROCESSOR_CACHE_TYPE;

  _CACHE_DESCRIPTOR = record
    Level: Byte;
    Associativity: Byte;
    LineSize: Word;
    Size: DWORD;
    _Type: PROCESSOR_CACHE_TYPE;
  end;
  {$EXTERNALSYM _CACHE_DESCRIPTOR}
  CACHE_DESCRIPTOR = _CACHE_DESCRIPTOR;
  {$EXTERNALSYM CACHE_DESCRIPTOR}
  PCACHE_DESCRIPTOR = ^_CACHE_DESCRIPTOR;
  {$EXTERNALSYM PCACHE_DESCRIPTOR}
  TCacheDescriptor = _CACHE_DESCRIPTOR;
  PCacheDescriptor = PCACHE_DESCRIPTOR;

const
  CACHE_FULLY_ASSOCIATIVE = $FF;
  {$EXTERNALSYM CACHE_FULLY_ASSOCIATIVE}

type
  _SYSTEM_LOGICAL_PROCESSOR_INFORMATION = record
    ProcessorMask: ULONG_PTR;
    Relationship: LOGICAL_PROCESSOR_RELATIONSHIP;
    case Integer of
      0: (Flags: Byte); // ProcessorCore
      1: (NodeNumber: DWORD); // NumaNode
      2: (Cache: CACHE_DESCRIPTOR); //Cache
      3: (Reserved: array [0..1] of ULONGLONG);
  end;
  {$EXTERNALSYM _SYSTEM_LOGICAL_PROCESSOR_INFORMATION}
  SYSTEM_LOGICAL_PROCESSOR_INFORMATION = _SYSTEM_LOGICAL_PROCESSOR_INFORMATION;
  {$EXTERNALSYM SYSTEM_LOGICAL_PROCESSOR_INFORMATION}
  PSYSTEM_LOGICAL_PROCESSOR_INFORMATION = ^SYSTEM_LOGICAL_PROCESSOR_INFORMATION;
  {$EXTERNALSYM PSYSTEM_LOGICAL_PROCESSOR_INFORMATION}
  TSystemLogicalProcessorInformation = SYSTEM_LOGICAL_PROCESSOR_INFORMATION;
  PSystemLogicalProcessorInformation = PSYSTEM_LOGICAL_PROCESSOR_INFORMATION;

function CloseHandle(Handle: THandle): BOOL; stdcall;
  external kernel name 'CloseHandle';

function GetStdHandle(nStdHandle: DWORD): THandle; stdcall;
  external kernel name 'GetStdHandle';

function CreateFile(lpFileName: PWideChar; dwDesiredAccess, dwShareMode: DWORD;
  lpSecurityAttributes: PSecurityAttributes; dwCreationDisposition, dwFlagsAndAttributes: DWORD;
  hTemplateFile: THandle): THandle; stdcall;
  external kernel name 'CreateFileW';

function DeleteFile(lpFileName: PWideChar): BOOL; stdcall;
  external kernel name 'DeleteFileW';

function GetFileSize(hFile: THandle; lpFileSizeHigh: Pointer): DWORD; stdcall;
  external kernel name 'GetFileSize';

function GetFileType(hFile: THandle): DWORD; stdcall;
  external kernel name 'GetFileType';

function MoveFile(lpExistingFileName, lpNewFileName: PWideChar): BOOL; stdcall;
  external kernel name 'MoveFileW';
  
function ReadFile(hFile: THandle; Buffer: Pointer; nNumberOfBytesToRead: DWORD;
  var lpNumberOfBytesRead: DWORD; lpOverlapped: POverlapped): BOOL; stdcall;
  external kernel name 'ReadFile';

function SetEndOfFile(hFile: THandle): BOOL; stdcall;
  external kernel name 'SetEndOfFile';

function SetFilePointer(hFile: THandle; lDistanceToMove: Longint;
  lpDistanceToMoveHigh: Pointer; dwMoveMethod: DWORD): DWORD; stdcall;
  external kernel name 'SetFilePointer';

function WriteFile(hFile: THandle; Buffer: Pointer; nNumberOfBytesToWrite: DWORD;
  var lpNumberOfBytesWritten: DWORD; lpOverlapped: POverlapped): BOOL; stdcall;
  external kernel name 'WriteFile';


function CreateDirectory(lpPathName: PWideChar;
  lpSecurityAttributes: PSecurityAttributes): BOOL; stdcall;
  external kernel name 'CreateDirectoryW';

function RemoveDirectory(lpPathName: PWideChar): BOOL; stdcall;
  external kernel name 'RemoveDirectoryW';

function GetCurrentDirectoryA(nBufferLength: DWORD; lpBuffer: _PAnsiChr): DWORD; stdcall;
  external kernel name 'GetCurrentDirectoryA';
function GetCurrentDirectoryW(nBufferLength: DWORD; lpBuffer: PWideChar): DWORD; stdcall;
  external kernel name 'GetCurrentDirectoryW';
function GetCurrentDirectory(nBufferLength: DWORD; lpBuffer: PWideChar): DWORD; stdcall;
  external kernel name 'GetCurrentDirectoryW';

function SetCurrentDirectoryA(lpPathName: _PAnsiChr): BOOL; stdcall;
  external kernel name 'SetCurrentDirectoryA';
function SetCurrentDirectoryW(lpPathName: PWideChar): BOOL; stdcall;
  external kernel name 'SetCurrentDirectoryW';
function SetCurrentDirectory(lpPathName: PWideChar): BOOL; stdcall;
  external kernel name 'SetCurrentDirectoryW';


function FindClose(FindFile: THandle): BOOL; stdcall;
  external kernel name 'FindClose';

function FindFirstFile(lpFileName: PWideChar; var lpFindFileData: TWIN32FindData): THandle; stdcall;
  external kernel name 'FindFirstFileW';


procedure InitializeCriticalSection(var lpCriticalSection: TRTLCriticalSection); stdcall;
  external kernel name 'InitializeCriticalSection';
procedure EnterCriticalSection(var lpCriticalSection: TRTLCriticalSection); stdcall;
  external kernel name 'EnterCriticalSection';
procedure LeaveCriticalSection(var lpCriticalSection: TRTLCriticalSection); stdcall;
  external kernel name 'LeaveCriticalSection';
procedure DeleteCriticalSection(var lpCriticalSection: TRTLCriticalSection); stdcall;
  external kernel name 'DeleteCriticalSection';

//TODO: TThreadFunc vs TFNThreadStartRoutine
function CreateThread(SecurityAttributes: Pointer; StackSize: SIZE_T;
                     ThreadFunc: TThreadFunc; Parameter: Pointer;
                     CreationFlags: DWORD; var ThreadId: DWORD): THandle; stdcall;
  external kernel name 'CreateThread';

function GetCurrentThreadId: DWORD; stdcall;
  external kernel name 'GetCurrentThreadId';

procedure SwitchToThread; stdcall;
  external kernel name 'SwitchToThread';

procedure Yield; inline;
begin
  SwitchToThread;
end;

procedure ExitThread(ExitCode: DWORD); stdcall;
  external kernel name 'ExitThread';

procedure ExitProcess(ExitCode: UINT); stdcall;
  external kernel name 'ExitProcess';
    

procedure RaiseException(dwExceptionCode, dwExceptionFlags, nNumberOfArguments: DWORD;
  lpArguments: PDWORD); stdcall;
  external kernel name 'RaiseException';

//TODO: RTLUnwind, RTLUnwindEx
{$IF defined(CPU386)}
procedure RtlUnwind; stdcall;             external kernel name 'RtlUnwind';
{$ELSE}
procedure RtlUnwind(TargetFrame, TargetIp: NativeUInt;
  ExceptionRecord: PExceptionRecord; ReturnValue: NativeUInt); stdcall;
  external kernel name 'RtlUnwind';
procedure RtlUnwindEx(TargetFrame, TargetIp: NativeUInt;
  ExceptionRecord: PExceptionRecord; ReturnValue: NativeUInt;
  OriginalContext: PContext; HistoryTable: PUnwindHistoryTable); stdcall;
  external kernel name 'RtlUnwindEx';
{$ENDIF}

//TODO: UnhandledExceptionFilter
{$IF defined(CPU386)}
procedure UnhandledExceptionFilter; stdcall;
  external kernel name 'UnhandledExceptionFilter';
{$ELSE}
function UnhandledExceptionFilter(ExceptionInfo: PExceptionPointers): LongInt; stdcall;
  external kernel name 'UnhandledExceptionFilter';
{$ENDIF}

  //todo: getlasterror
function GetLastError: Integer; stdcall;
  external kernel name 'GetLastError';

  //todo: setlasterror
procedure SetLastError(ErrorCode: Integer); stdcall;
  external kernel name 'SetLastError';


function FreeLibrary(hLibModule: HMODULE): BOOL; stdcall;
  external kernel name 'FreeLibrary';

function FindResource(ModuleHandle: HMODULE; ResourceName, ResourceType: PChar): TResourceHandle; stdcall;
  external kernel name 'FindResourceW';

function LoadResource(ModuleHandle: HMODULE; ResHandle: TResourceHandle): HGLOBAL; stdcall;
  external kernel name 'LoadResource';

function LoadString(hInstance: HINST; uID: UINT; lpBuffer: PWideChar; nBufferMax: Integer): Integer; stdcall;
  external user name 'LoadStringW';

function LockResource(ResData: HGLOBAL): Pointer; stdcall;
  external kernel name 'LockResource';

function UnlockResource(ResData: HGLOBAL): LongBool;
begin
  Result := False;
end;

function SizeofResource(ModuleHandle: HMODULE; ResHandle: TResourceHandle): Integer; stdcall;
  external kernel name 'SizeofResource';

function FreeResource(ResData: HGLOBAL): LongBool; stdcall;
  external kernel name 'FreeResource';

function GetCommandLine: PWideChar; stdcall;
  external kernel name 'GetCommandLineW';

function GetModuleFileName(hModule: HINST; lpFilename: PWideChar; nSize: DWORD): DWORD; stdcall;
  external kernel name 'GetModuleFileNameW';

function GetModuleHandle(lpModuleName: PWideChar): HMODULE; stdcall;
  external kernel name 'GetModuleHandleW';

function GetProcAddress(hModule: HMODULE; lpProcName: LPCSTR): FARPROC; stdcall;
  external kernel name 'GetProcAddress';

procedure GetStartupInfo(out lpStartupInfo: TStartupInfo); stdcall;
  external kernel name 'GetStartupInfoW';

function LoadLibraryEx(lpLibFileName: PWideChar; hFile: THandle; dwFlags: DWORD): HMODULE; stdcall;
  external kernel name 'LoadLibraryExW';


function GetACP: UINT; stdcall;
  external kernel name 'GetACP';

function GetConsoleCP: UINT; stdcall;
  external kernel name 'GetConsoleCP';

function GetConsoleOutputCP: UINT; stdcall;
  external kernel name 'GetConsoleOutputCP';

function MultiByteToWideChar(CodePage: UINT; dwFlags: DWORD;
  const lpMultiByteStr: LPCSTR; cchMultiByte: Integer;
  lpWideCharStr: LPWSTR; cchWideChar: Integer): Integer; stdcall;
  external kernel name 'MultiByteToWideChar';

function WideCharToMultiByte(CodePage: UINT; dwFlags: DWORD;
  lpWideCharStr: LPWSTR; cchWideChar: Integer; lpMultiByteStr: LPSTR;
  cchMultiByte: Integer; lpDefaultChar: LPCSTR; lpUsedDefaultChar: PBOOL): Integer; stdcall;
  external kernel name 'WideCharToMultiByte';

function GetLocaleInfo(Locale: LCID; LCType: LCTYPE; lpLCData: PWideChar; cchData: Integer): Integer; stdcall;
  external kernel name 'GetLocaleInfoW';

function GetUserDefaultUILanguage: LANGID; stdcall;
  external kernel name 'GetUserDefaultUILanguage';

function GetSystemDefaultUILanguage: LANGID; stdcall;
  external kernel name 'GetSystemDefaultUILanguage';

function GetThreadLocale: LCID; stdcall;
  external kernel name 'GetThreadLocale';

function SetThreadLocale(Locale: LCID): BOOL; stdcall;
  external kernel name 'SetThreadLocale';

function IsValidLocale(Locale: LCID; dwFlags: DWORD): BOOL; stdcall;
  external kernel name 'IsValidLocale';

function IsDBCSLeadByteEx(CodePage: UINT; TestChar: Byte): BOOL; stdcall;
  external kernel name 'IsDBCSLeadByteEx';

function CharNext(lpwsz: PWideChar): PWideChar; stdcall;
  external user name 'CharNextW';

function CompareString(Locale: LCID; dwCmpFlags: DWORD; lpString1: PWideChar;
  cchCount1: Integer; lpString2: PWideChar; cchCount2: Integer): Integer; stdcall;
  external kernel name 'CompareStringW';

function MessageBoxA(hWnd: HWND; lpText, lpCaption: _PAnsiChr; uType: UINT): Integer; stdcall;
  external user   name 'MessageBoxA';
function MessageBoxW(hWnd: HWND; lpText, lpCaption: PWideChar; uType: UINT): Integer; stdcall;
  external user   name 'MessageBoxW';
function MessageBox(hWnd: HWND; lpText, lpCaption: PWideChar; uType: UINT): Integer; stdcall;
  external user   name 'MessageBoxW';


function RegCloseKey(hKey: HKEY): Longint; stdcall;
  external advapi32 name 'RegCloseKey';

function RegOpenKeyEx(hKey: HKEY; lpSubKey: PWideChar;
  ulOptions: DWORD; samDesired: REGSAM; var phkResult: HKEY): Longint; stdcall;
  external advapi32 name 'RegOpenKeyExW';

function RegQueryValueEx(hKey: HKEY; lpValueName: PWideChar;
  lpReserved: Pointer; lpType: PDWORD; lpData: PByte; lpcbData: PDWORD): Longint; stdcall;
  external advapi32 name 'RegQueryValueExW';


function GetVersion: DWORD; stdcall;
  external kernel name 'GetVersion';

procedure GetSystemInfo(var SystemInfo: TSystemInfo); stdcall;
  external kernel name 'GetSystemInfo';


//procedure GetSystemTime; stdcall;
procedure GetSystemTime(var lpSystemTime: TSystemTime); stdcall;
  external kernel name 'GetSystemTime';

procedure GetLocalTime(var lpSystemTime: TSystemTime); stdcall; 
  external kernel name 'GetLocalTime';

procedure SystemTimeToFileTime(const lpSystemTime: TSystemTime; var Dest: TFileTime); stdcall;
  external kernel name 'SystemTimeToFileTime';


function GetTickCount: DWORD; stdcall;
  external kernel name 'GetTickCount';

function QueryPerformanceCounter(var lpPerformanceCount: Int64): LongBool; stdcall;
  external kernel name 'QueryPerformanceCounter';

function VirtualQuery(lpAddress: Pointer;
  var lpBuffer: TMemoryBasicInformation; dwLength: NativeUInt): NativeUInt; stdcall;
  external kernel name 'VirtualQuery';


function SysAllocStringLen(P: PWideChar; Len: Integer): PWideChar; stdcall;
  external oleaut name 'SysAllocStringLen';

function SysReAllocStringLen(var S: _WideStr; P: PWideChar;
  Len: Integer): LongBool; stdcall;
  external oleaut name 'SysReAllocStringLen';

procedure SysFreeString(const S: _WideStr); stdcall;
  external oleaut name 'SysFreeString';

function SysStringLen(const S: _WideStr): Integer; stdcall;
  external oleaut name 'SysStringLen';

function _strlen(lpString: PWideChar): Integer; stdcall;
  external kernel name 'lstrlenW';

function GetLogicalProcessorInformation(Buffer: PSYSTEM_LOGICAL_PROCESSOR_INFORMATION; var ReturnedLength: DWORD): BOOL; stdcall;
  external kernel name 'GetLogicalProcessorInformation' delayed;

function GetProcessHeap: THandle; stdcall;
  external 'kernel32.dll' name 'GetProcessHeap';
function HeapAlloc(Heap: THandle; Flags: LongWord; Size: NativeUInt): Pointer; stdcall;
  external 'kernel32.dll' name 'HeapAlloc';
function HeapReAlloc(Heap: THandle; Flags: LongWord; Ptr: Pointer; Size: NativeUInt): Pointer; stdcall;
  external 'kernel32.dll' name 'HeapReAlloc';
function HeapFree(Heap: THandle; Flags: LongWord; Ptr: Pointer): LongBool; stdcall;
  external 'kernel32.dll' name 'HeapFree';

