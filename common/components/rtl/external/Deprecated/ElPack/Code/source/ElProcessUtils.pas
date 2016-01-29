{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}
{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

{.$DEFINE RUCOMMENTS}
unit ElProcessUtils;

interface

uses ElList, ElTools, Windows, SysUtils, Messages, TlHelp32;

type

  TProcessInfo = class
    ModuleName: string;
    PID: integer;
    ThreadCount: integer;
    PriorityCls: integer;
    function DiffersFrom(Source : TProcessInfo) : boolean;
  end;

  TModuleInformation = class
    ModuleName: string;
    ModulePath: string;
    hModule: THandle;
  end;

procedure FillProcessList(L : TElList);
procedure FillModuleList(PID: DWORD; L : TElList);

function GetProcessHandle(ModuleName : string) : THandle;
function ProcessExists(ModuleName : string) : boolean;
procedure CloseProcess(ModuleName : string; Forced : boolean);

function IsUsePSAPI: Boolean;

implementation

var
  APILoaded : boolean;

(*
{$ifndef BUILDER_USED}
const
  TH32CS_SNAPHEAPLIST = $00000001;
  TH32CS_SNAPPROCESS  = $00000002;
  TH32CS_SNAPTHREAD   = $00000004;
  TH32CS_SNAPMODULE   = $00000008;
  TH32CS_SNAPALL      = TH32CS_SNAPHEAPLIST or TH32CS_SNAPPROCESS or TH32CS_SNAPTHREAD or TH32CS_SNAPMODULE;
  TH32CS_INHERIT      = $80000000;

{$else}

const

{$IFDEF VCL_4_USED}
{$EXTERNALSYM TH32CS_SNAPHEAPLIST}
{$ENDIF}
  TH32CS_SNAPHEAPLIST = $00000001;
{$IFDEF VCL_4_USED}
{$EXTERNALSYM TH32CS_SNAPPROCESS}
{$ENDIF}
  TH32CS_SNAPPROCESS  = $00000002;
{$IFDEF VCL_4_USED}
{$EXTERNALSYM TH32CS_SNAPTHREAD}
{$ENDIF}
  TH32CS_SNAPTHREAD   = $00000004;
{$IFDEF VCL_4_USED}
{$EXTERNALSYM TH32CS_SNAPMODULE}
{$ENDIF}
  TH32CS_SNAPMODULE   = $00000008;
{$IFDEF VCL_4_USED}
{$EXTERNALSYM TH32CS_SNAPALL}
{$ENDIF}
  TH32CS_SNAPALL      = TH32CS_SNAPHEAPLIST or TH32CS_SNAPPROCESS or
    TH32CS_SNAPTHREAD or TH32CS_SNAPMODULE;
{$IFDEF VCL_4_USED}
{$EXTERNALSYM TH32CS_INHERIT}
{$ENDIF}
  TH32CS_INHERIT      = $80000000;

{$endif}
*)

type
{$R-}

    PProcessIDArray = ^TProcessIDArray;
    TProcessIDArray = array[0..0] of Integer;

    PHMODULE = ^HMODULE;

    TProcessMemoryCounters = record
        cb:LongInt;                         // The size of the structure, in bytes
        PageFaultCount:LongInt;             // The number of page faults
        PeakWorkingSetSize:LongInt;         // The peak working set size
        WorkingSetSize:LongInt;             // The current working set size
        QuotaPeakPagedPoolUsage:LongInt;    // The peak paged pool usage
        QuotaPagedPoolUsage:LongInt;        // The current paged pool usage
        QuotaPeakNonPagedPoolUsage:LongInt; // The peak nonpaged pool usage
        QuotaNonPagedPoolUsage:LongInt;     // The current nonpaged pool usage
        PagefileUsage:LongInt;              // The current pagefile usage
        PeakPagefileUsage:LongInt;          // The peak pagefile usage
    end;

    TProcessEntry32 = packed record
        dwSize: DWORD;
        cntUsage: DWORD;
        th32ProcessId: DWORD;       // this process
        th32DefaultHeapId: DWORD;
        th32ModuleId: DWORD;        // associated exe
        cntThreads: DWORD;
        th32ParentProcessId: DWORD; // this process's parent process
        pcPriClassBase: Longint;    // Base priority of process's threads
        dwFlags: DWORD;
        szExeFile: array[0..MAX_PATH - 1] of Char;// Path
    end;


    EnumProcessesProc = function (lpidProcess:PProcessIDArray;                                   cb:LongInt;                                                    var cbNeedee:DWORD                                            ):BOOL; stdcall;

    EnumProcessModulesProc = function(hProcess : THANDLE;
                                      lphModule : PHMODULE;
                                      cb : DWORD;
                                      var cbNeedee: DWORD
                                     ): Bool; stdcall;

    GetModuleFileNameExProc = function (hProcess:THandle;  // handle to the process
                                        hMoe:HMODULE;      // handle to the module
                                        lpBaseName:PChar;  // buffer that receives the base name
                                        nSize: DWORD      // size of the buffer
                                       ):LongInt; stdcall;

    GetProcessMemoryInfoProc = function(hProcess:THandle;                      // handle to the process
                                        ppsmemCounters:TProcessMemoryCounters; // structure that receives information
                                        cb : DWORD                          // size of the structure
                                       ) : BOOL; stdcall;

    CreateToolhelp32SnapshotProc = function (dwFlags, th32ProcessIe: DWORD): THandle; stdcall;

    Process32FirstProc = function (hSnapshot: THandle; var lppe: TProcessEntry32): BOOL; stdcall;
    Process32NextProc = function (hSnapshot: THandle; var lppe: TProcessEntry32): BOOL; stdcall;

const
    EnumProcesses        : EnumProcessesProc = nil;
    EnumProcessModules   : EnumProcessModulesProc = nil;
    GetModuleFileNameEx  : GetModuleFileNameExProc = nil;
    GetProcessMemoryInfo : GetProcessMemoryInfoProc = nil;

    CreateToolHelp32Snapshot : CreateToolhelp32SnapshotProc = nil;
    Process32First           : Process32FirstProc = nil;
    Process32Next            : Process32NextProc = nil;

function IsUsePSAPI: Boolean;
begin
  Result := IsWinNT and (not IsWin2000Up);
end;

function TProcessInfo.DiffersFrom(Source : TProcessInfo) : boolean;
begin
  result := (ModuleName <> Source.ModuleName) or
            (Self.PID <> Source.Pid) or
            (Self.ThreadCount <> Source.ThreadCount) or
            (Self.PriorityCls <> Source.PriorityCls);
end;

function GetProcessHandle(ModuleName : string) : THandle;
var
  L: TElList;
  I: Integer;
  S: String;
begin
  Result := INVALID_HANDLE_VALUE;
  L := TElList.Create;
  try
    L.AutoClearObjects := true;
    FillProcessList(L);
    S := LowerCase(ModuleName);
    for i := 0 to L.Count - 1 do
    begin
      if LowerCase(ExtractFileName(TProcessInfo(L[i]).ModuleName)) = S then
      begin
        result := OpenProcess(STANDARD_RIGHTS_REQUIRED, false, TProcessInfo(L[i]).PID);
        if result = 0 then
          result := INVALID_HANDLE_VALUE;
        exit;
      end;
    end;
  finally
    L.Free;
  end;
end;

function ProcessExists(ModuleName : string) : boolean;
var
  L: TElList;
  I: Integer;
  S: String;
begin
  L := TElList.Create;
  try
    L.AutoClearObjects := true;
    FillProcessList(L);
    S := LowerCase(ModuleName);
    for i := 0 to L.Count - 1 do
    begin
      if LowerCase(ExtractFileName(TProcessInfo(L[i]).ModuleName)) = S then
      begin
        result := true;
        exit;
      end;
    end;
    result := false;
  finally
    L.Free;
  end;
end;

procedure CloseProcess(ModuleName : string; Forced : boolean);
var
  L: TElList;
  S: String;
  I, ID : Integer;
  hProc : THandle;

  function EnumWindowProc(Wnd : HWND; lParam : integer) : boolean; stdcall;
  var IID : DWORD;
  begin
    GetWindowThreadProcessId(Wnd, @IID);
    result := true;
    if Integer(IID) = LParam then
    begin
      PostMessage(Wnd, WM_CLOSE, 0, 0);
      result := false;
    end;
  end;


begin
  L := TElList.Create;
  try
    L.AutoClearObjects := true;
    FillProcessList(L);
    S := LowerCase(ModuleName);
    for i := 0 to L.Count - 1 do
    begin
      if LowerCase(ExtractFileName(TProcessInfo(L[i]).ModuleName)) = S then
      begin
        ID := TProcessInfo(L[i]).PID;
        if Forced then
        begin
          hProc := OpenProcess(PROCESS_TERMINATE, false, ID);
          TerminateProcess(hProc, 0);
        end
        else
          EnumWindows(@EnumWindowProc, ID);
      end;
    end;
  finally
    L.Free;
  end;
end;

procedure FillProcessList(L : TElList);
var pidArray : pProcessIDArray;
    mhArray  : array[0..1000] of HMODULE;
    c        : Cardinal;
    cb       : DWORD;
    i,j      : Integer;
    ph       : THandle;
    buf      : array[0..MAX_PATH] of char;
    Info     : TProcessInfo;
    hSnapshot: THandle;
    pe32     : TProcessEntry32;
begin
  L.Clear;
  if not ApiLoaded then
    exit;
  if IsUsePSAPI then
  begin
    c := 100 * sizeof(Integer);
    GetMem(pidArray, c);
    while true do
    begin
      if not EnumProcesses(pidArray, c, cb) then exit;
      if cb <= c then break;
      FreeMem(pidArray);
      c := cb;
      GetMem(pidArray, c);
    end;
    j := (cb div sizeof(integer)) - 1;
    for i := 0 to j do
    begin
      Info := TProcessInfo.Create;
      Info.PID := pidArray[i];
      Info.PriorityCls := 0;
      ph := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ,False,pidArray[i]);
      if ph <> 0 then
      begin
        if EnumProcessModules(ph, @mhArray, SizeOf(mhArray), CB) then
        begin
          if GetModuleFileNameEx(ph, mhArray[0], Buf, MAX_PATH)>0 then
            Info.ModuleName := StrPas(@Buf[0])
          else
            Info.ModuleName := '';
          Info.PriorityCls := GetPriorityClass(ph);
          Info.ThreadCount := 0;
        end;
        CloseHandle(ph);
      end;
      L.Add(Info);
    end;
    FreeMem(pidArray);
  end
  else
  begin
    hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    pe32.dwSize := sizeof(TProcessEntry32);
    if Process32First(hSnapshot, pe32) then
      repeat
        Info := TProcessInfo.Create;
        Info.PID := pe32.th32ProcessID;
        Info.ModuleName := pe32.szExeFile;
        Info.PriorityCls := pe32.pcPriClassBase;
        Info.ThreadCount := pe32.cntThreads;
        L.Add(Info);
      until not Process32Next(hSnapshot, pe32);
    CloseHandle(hSnapshot);
  end;
end;

procedure FillModuleList(PID: DWORD; L : TElList);
var
    Info: TModuleInformation;
    // PSAPI.DLL
    PH: THandle;
    MODList: array[0..1000] of HMODULE;
    MODName: array [0..MAX_PATH - 1] of Char;
    i: Integer;
    modNeeded : DWORD;
    // CreateToolhelp32Snapshot
    me: TModuleEntry32;
    bOk: Boolean;
    m_hSnapshot: THandle;
begin
  if L=nil then
    exit;
  L.Clear;
  if not ApiLoaded then
    exit;
  if PID=0 then
    PID := GetCurrentProcessId();
  if IsUsePSAPI then
  begin
    PH := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, PID);
    if PH <> 0 then
    try
      if EnumProcessModules(PH, @MODList,1000, modNeeded) then
      begin
        for i := 0 to (modNeeded div SizeOf (HMODULE) - 1) do
        begin
          if GetModuleFileNameEx(PH, MODList[i], MODName, SizeOf(MODName)) > 0 then
          begin
            Info := TModuleInformation.Create;
            Info.hModule := MODList[i];
            Info.ModuleName := ExtractFileName(MODName);
            Info.ModulePath := ExtractFilePath(MODName);
            L.Add(Info);
          end;
        end;
      end;
    finally
      CloseHandle(PH);
    end;
  end
  else
  begin
    m_hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, PID);
    if (m_hSnapshot = INVALID_HANDLE_VALUE) then
      exit;
    try
      FillChar(me, sizeof(me), 0);
      me.dwSize := sizeof(me);
      bOK := Module32First(m_hSnapshot, me);
      while bOk do
      begin
        Info := TModuleInformation.Create;
        Info.hModule := me.hModule;
        Info.ModuleName := StrPas(PChar(@me.szModule));
        Info.ModulePath := ExtractFilePath(StrPas(PChar(@me.szExePath)));
        L.Add(Info);
        bOK := Module32Next(m_hSnapshot, me);
      end;
    finally
      CloseHandle(m_hSnapshot);
    end;
  end;
end;

const PsApiDll = 'psapi.dll';
const PsApiDllHandle: THandle = 0;
      KernelHandle  : THandle = 0;

Type
  TProcessBasicInformation = packed record
    ExitStatus: DWORD;
    PebBaseAddress: Pointer;
    AffinityMask: DWORD;
    BasePriority: DWORD;
    UniqueProcessId: LongInt;
    InheritedFromUniqueProcessId: DWORD;
  end;
  PProcessBasicInformation = ^TProcessBasicInformation;

  TNtQueryInformationProcess =
    function(hProcess: THandle; ProcessInformationClass: Integer;
      var ProcessInformation; ProcessInformationLength: Integer;
      var ReturnLength: Integer): Integer; stdcall;
  TRtlNtStatusToDosError = function (p1: DWORD):DWORD; stdcall;
  TNtQuerySystemInformation = function (p1, p2, p3, p4:  DWORD):DWORD; stdcall;

var
  NtQueryInformationProcess: TNtQueryInformationProcess;
  RtlNtStatusToDosError: TRtlNtStatusToDosError;
  NtQuerySystemInformation: TNtQuerySystemInformation;

function GetProcessModuleQueryInfoNT4( hProcess: THandle; hModule :HMODULE; lpBuffer: Pointer ): BOOL; stdcall;
type
  TLocalVars = packed record
    PBI: TProcessBasicInformation;
    DW1, DW2: DWORD;
  end;
const
  arg_hProcess  =  $08;
  arg_hModule   =  $0C;
  arg_lpBuffer  =  $10;

  cLocalVarsSize = SizeOf(TLocalVars);
  cProcessBasicInformationSize = sizeOf(TProcessBasicInformation);
asm
            add   esp, -cLocalVarsSize
            push  ebx
            lea   eax, [ebp-cLocalVarsSize].TLocalVars.PBI // = PProcessBasicInformation
            push  esi
            push  edi

            // NtQueryInformationProcess(hProcess, 0{Class}, var_20{Buff}, $18{BufSize}, 0{ReturnLen})
            push  0   // ReturnLength
            mov   esi, [ebp+arg_hProcess] // hProcess
            push  cProcessBasicInformationSize
            push  eax // PProcessBasicInformation
            push  0   // ProcessInformationClass
            push  esi // hProcess
            call  dword ptr [NtQueryInformationProcess]

            test  eax, eax
            jge   @@NTQIP@TRUE
            push  eax
            call  dword ptr [RtlNtStatusToDosError]
            push  eax
            jmp   @@RET@FALSE@ERROR
@@NTQIP@TRUE:
            cmp   dword ptr [ebp+arg_hModule], 0
            mov   edi, [ebp-cLocalVarsSize].TLocalVars.PBI.TProcessBasicInformation.PebBaseAddress

            jnz   @@NZMEM
            // ReadProcessMemory
            push  0   // lpNumberOfBytesRead = nil
            lea   eax, [ebp+arg_hModule]
            push  4   // Size
            lea   ecx, [edi+arg_hProcess]
            push  eax // Buffer
            push  ecx // lpBaseAddress
            push  esi // hProcess
            call  Windows.ReadProcessMemory
            test  eax, eax
            jz    @@RET@FALSE
@@NZMEM:
            // ReadProcessMemory
            push  0   // lpNumberOfBytesRead = nil
            lea   eax, [ebp-cLocalVarsSize].TLocalVars.DW1
            push  4   // Size
            add   edi, $0C // + 14
            push  eax // Buffer
            push  edi // lpBaseAddress
            push  esi // hProcess
            call  Windows.ReadProcessMemory
            test  eax, eax
            jz    @@RET@FALSE
            mov   edi, [ebp-cLocalVarsSize].TLocalVars.DW1

            // ReadProcessMemory
            push  0   // lpNumberOfBytesRead = nil
            add   edi, $14 // + 20
            push  4   // Size
            lea   eax, [ebp-cLocalVarsSize].TLocalVars.DW2
            push  eax // Buffer
            push  edi // lpBaseAddress
            push  esi // hProcess
            call  Windows.ReadProcessMemory
            test  eax, eax
            jz    @@RET@FALSE
            cmp   [ebp-cLocalVarsSize].TLocalVars.DW2, edi
            jz    @@RET@FALSE@ERROR6
            mov   ebx, [ebp+arg_lpBuffer]
@@LOOP:
            // ReadProcessMemory
            mov   eax, [ebp-cLocalVarsSize].TLocalVars.DW2
            push  0   // lpNumberOfBytesRead = nil
            sub   eax, $08
            push  $48 // Size = 72
            push  ebx // Buffer
            push  eax // lpBaseAddress
            push  esi // hProcess
            call  Windows.ReadProcessMemory
            test  eax, eax
            jz    @@RET@FALSE
            mov   eax, [ebp+arg_hModule]
            cmp   [ebx+18h], eax
            jz    @@RET@TRUE
            mov   eax, [ebx+arg_hProcess]
            mov   [ebp-cLocalVarsSize].TLocalVars.DW2, eax
            cmp   eax, edi
            jnz   @@LOOP
@@RET@FALSE@ERROR6:
            push  $06
@@RET@FALSE@ERROR:
            call  Windows.SetLastError
@@RET@FALSE:
            xor   eax, eax
@@RET@00:
            pop   edi
            pop   esi
            pop   ebx
            mov   esp, ebp
            jmp   @@RET
@@RET@TRUE:
            mov   eax, 1
            jmp   @@RET@00
@@RET:
end;

function GetModuleFileNameExWNT4(hProcess: THandle; hModule: HMODULE;
    lpFilename: PWideChar; nSize: DWORD): DWORD stdcall;
assembler;
const
  arg_hProcess    =  $08;
  arg_hModule     =  $0C;
  arg_lpFilename  =  $10;
  arg_nSize       =  $14;

  var_Buffer        = -$4C;
  var_28            = -$28;
  var_lpBaseAddress = -$24;
asm
            sub   esp, 4Ch

            // GetProcessModuleQueryInfoNT4
            lea   eax, [ebp+var_Buffer]
            push  eax  // Buffer address
            push  dword ptr [ebp+arg_hModule]
            push  dword ptr [ebp+arg_hProcess] // hProcess
            call  GetProcessModuleQueryInfoNT4

            test  eax, eax
            jz    @@RET@02
            mov   eax, dword ptr [ebp+arg_nSize]
            push  esi
            db    $0F,$B7,$75,$D8 // movzx   esi, [ebp+var_28]
            add   eax, eax
            inc   esi
            inc   esi
            cmp   eax, esi
            jb    @@RET@01
@@LOOP:
            // ReadProcessMemory
            push  0 // lpNumberOfBytesRead = nil
            push  esi // ??? ProcesInformationSize ???
            push  dword ptr [ebp+arg_lpFilename] // lpBuffer
            push  dword ptr [ebp+var_lpBaseAddress] // lpBaseAddress
            push  dword ptr [ebp+arg_hProcess] // hProcess
            call  Windows.ReadProcessMemory
            test  eax, eax
            jz    @@RET@03
            db    $0F,$B7,$45,$D8 // movzx   eax, [ebp+var_28]
            inc   eax
            inc   eax
            cmp   esi, eax
            jnz   @@RET@04
            dec   esi
            dec   esi
@@RET@04:
            mov   eax, esi
            shr   eax, 1
@@RET@03:
            pop   esi
@@RET@02:
            leave
            ret   10h
@@RET@01:
            mov   esi, eax
            jmp   @@LOOP
end;

function GetModuleFileNameExANT4(hProcess: THandle; hModule: HMODULE;
    lpFilename: PAnsiChar; nSize: DWORD): DWORD stdcall;
var
  Buff: String;
begin
  Result := 0;
  if (hProcess=0)or(lpFilename=nil)or(nSize<=0) then
    exit;
  SetLength(Buff, nSize*2);
  Result := GetModuleFileNameExWNT4(hProcess, hModule, PWideChar(PChar(Buff)), nSize*2-2);
  if Result >0 then
  begin
    Result := Windows.WideCharToMultiByte(0,0, PWideChar(PChar(Buff)), Result, lpFilename, Result*2, nil, nil);
    if Result>0 then
      PChar(dword(lpFilename)+Result)^:=#0
    else
      lpFilename^ := #0;
  end
  else
    lpFilename^ := #0;
  if Result > 0 then
    dec(Result);
end;

function EnumProcessesNT4(lpidProcess: LPDWORD; cb: DWORD; var cbNeeded: DWORD): BOOL stdcall;
begin
  Result := False;
  if @NtQueryInformationProcess<>nil then
asm
            mov   eax, fs:0
            push  $0FFFFFFFF
            push  $731B3448
            push  $731B2E38
            push  eax
            mov   fs:0, esp
            add   esp, -$14
            push  ebx
            push  esi
            push  edi
            mov   esi, $8000
            xor   edi, edi
            mov   [ebp-$18], esp
@@LOOP@NTQSI:
            push  esi
            push  edi
            call  Windows.LocalAlloc
            mov   [ebp-$1C], eax
            cmp   eax, edi
            jz    @@RET@FALSE
            push  edi
            push  esi
            push  eax
            push  5
            call  dword ptr [NtQuerySystemInformation]
            cmp   eax, $0C0000004
            jnz   @@NTQSI@FINISH
            push  dword ptr [ebp-$1C]
            call  dword ptr LocalFree
            add   esi, $8000
            jmp   @@LOOP@NTQSI
@@NTQSI@FINISH:
            test  eax, eax
            jge   @@NTQSI@TRUE
            push  eax
            call  dword ptr [RtlNtStatusToDosError]
            push  eax
            call  Windows.SetLastError
            jmp   @@RET@FALSE
@@NTQSI@TRUE:
            xor   esi, esi
            mov   edx, [ebp+$0C]
            shr   edx, 2
            xor   edi, edi
            mov   ecx, [ebp+$08]
@@LOOP:
            mov   eax, [ebp-$1C]
            add   eax, esi
            cmp   edi, edx
            jnb   @@CHECK2
            mov   dword ptr [ebp-4], 0
            mov   ebx, [eax+$44]
            mov   [ecx+edi*4], ebx
            inc   edi
            mov   dword ptr [ebp-4], $0FFFFFFFF
@@CHECK2:
            mov   eax, [eax]
            add   esi, eax
            test  eax, eax
            jnz   @@LOOP
            mov   esi, 1
            mov   [ebp-4], esi
            lea   ecx, ds:0[edi*4]
            mov   eax, [ebp+$10]
            mov   [eax], ecx
            mov   dword ptr [ebp-4], $0FFFFFFFF
            push  dword ptr [ebp-$1C]
            call  Windows.LocalFree
            mov   eax, esi
            jmp   @@RET
@@RET@FALSE:
            xor   eax, eax
@@RET:
            mov   Result, eax
            mov   ecx, [ebp-$10]
            pop   edi
            mov   fs:0, ecx
            pop   esi
            pop   ebx
            mov   esp, ebp
            push  ecx
end;
end;

function EnumProcessModulesNT4(hProcess: THandle; lphModule: LPDWORD; cb: DWORD;
    var lpcbNeeded: DWORD): BOOL stdcall;
begin
  Result := False;
  if @NtQueryInformationProcess<>nil then
asm
            mov   eax, fs:0
            push  $0FFFFFFFF
            push  $731B3178
            push  $731B2E38
            push  eax
            mov   fs:0, esp
            add   esp, -$78
            lea   eax, [ebp-$40]
            push  ebx
            push  esi
            push  edi
            mov   [ebp-$18], esp
            push  0
            push  18h
            push  eax
            push  0
            push  dword ptr [ebp+$08]
            call  dword ptr [NtQueryInformationProcess]
            test  eax, eax
            jge   @@NTQIP@END
            push  eax
            call  dword ptr [RtlNtStatusToDosError]
            push  eax
            call  Windows.SetLastError
            jmp   @@RET@FALSE
@@NTQIP@END:
            push  0
            lea   eax, [ebp-$28]
            push  4
            push  eax
            mov   eax, [ebp-$3C]
            add   eax, 0Ch
            push  eax
            push  dword ptr [ebp+$08]
            call  Windows.ReadProcessMemory
            test  eax, eax
            jz    @@RET@FALSE
            mov   esi, [ebp-$28]
            push  0
            add   esi, 14h
            push  4
            lea   eax, [ebp-$1C]
            push  eax
            push  esi
            push  dword ptr [ebp+$08]
            call  Windows.ReadProcessMemory
            test  eax, eax
            jz    @@RET@FALSE
            mov   eax, [ebp+$10]
            xor   edi, edi
            shr   eax, 2
            cmp   esi, [ebp-$1C]
            mov   [ebp-$24], eax
            jz    @@RPM@END
            mov   ebx, [ebp+$0C]
@@LOOP:
            mov   eax, [ebp-$1C]
            push  0
            sub   eax, 8
            push  48h
            lea   ecx, [ebp-$88]
            push  ecx
            push  eax
            push  dword ptr [ebp+$08]
            call  Windows.ReadProcessMemory
            test  eax, eax
            jz    @@RET@FALSE
            cmp   edi, [ebp-$24]
            jnb   @@CHECK
            mov   dword ptr [ebp-4], 0
            mov   eax, [ebp-$70]
            mov   [ebx], eax
            mov   dword ptr [ebp-4], $0FFFFFFFF
@@CHECK:
            add   ebx, 4
            inc   edi
            mov   eax, [ebp-$80]
            mov   [ebp-$1C], eax
            cmp   esi, eax
            jnz   @@LOOP
@@RPM@END:
            mov   eax, 1
            mov   [ebp-4], eax
            lea   edx, ds:0[edi*4]
            mov   ecx, [ebp+$14]
            mov   [ecx], edx
            mov   dword ptr [ebp-4], $0FFFFFFFF
            jmp   @@RET
@@RET@FALSE:
            xor   eax, eax
@@RET:
            mov   Result, eax
            mov   ecx, [ebp-$10]
            pop   edi
            mov   fs:0, ecx
            pop   esi
            pop   ebx
            mov   esp, ebp
            push  ecx
end;
end;

function _LoadNTAPI:Boolean;
var
  hNTDLL: HMODULE;
begin
  Result := False;
  hNTDLL := LoadLibrary('NTDLL.DLL');
  if hNTDLL=0 then
    exit;
  try
    NtQueryInformationProcess := GetProcAddress(hNTDLL, 'NtQueryInformationProcess');
    if @NtQueryInformationProcess=nil then
      exit;
    RtlNtStatusToDosError := GetProcAddress(hNTDLL, 'RtlNtStatusToDosError');
    if @RtlNtStatusToDosError=nil then
      exit;
    NtQuerySystemInformation := GetProcAddress(hNTDLL, 'NtQuerySystemInformation');
    if @NtQuerySystemInformation=nil then
      exit;
    Result := True;
  finally
    FreeLibrary(hNTDLL);
    if not Result then
    begin
      NtQueryInformationProcess := nil;
      RtlNtStatusToDosError := nil;
      NtQuerySystemInformation := nil;
    end;
  end;
end;

function GetProcessMemoryInfoNT4(hProcess:THandle; ppsmemCounters:TProcessMemoryCounters;
  cb : DWORD ) : BOOL; stdcall;
begin
  Result := False;
end;

initialization

  if IsUsePSAPI then
  begin
    PsApiDllHandle := LoadLibrary(PsAPIDll);
    if PsApiDllHandle <> 0 then
    begin
      EnumProcesses        := EnumProcessesProc(GetProcAddress(PsApiDllHandle, 'EnumProcesses'));
      EnumProcessModules   := EnumProcessModulesProc(GetProcAddress(PsApiDllHandle, 'EnumProcessModules'));
      GetModuleFileNameEx  := GetModuleFileNameExProc(GetProcAddress(PsApiDllHandle, 'GetModuleFileNameExA'));
      GetProcessMemoryInfo := GetProcessMemoryInfoProc(GetProcAddress(PsApiDllHandle, 'GetProcessMemoryInfo'));
      if (@EnumProcesses <> nil) and (@EnumProcessModules <> nil) and
         (@GetModuleFileNameEx <> nil) and (@GetProcessMemoryInfo <> nil) then
        ApiLoaded := true;
    end
    else
    if _LoadNTAPI() then
    begin
      EnumProcesses        := @EnumProcessesNT4;
      EnumProcessModules   := @EnumProcessModulesNT4;
      GetModuleFileNameEx  := @GetModuleFileNameExANT4;
      GetProcessMemoryInfo := @GetProcessMemoryInfoNT4;
      ApiLoaded := true;
    end;
  end else
  begin
    KernelHandle := GetModuleHandle('kernel32.dll');
    if KernelHandle <> 0 then
    begin
      CreateToolHelp32Snapshot := CreateToolhelp32SnapshotProc(GetProcAddress(KernelHandle, 'CreateToolhelp32Snapshot'));
      Process32First           := Process32FirstProc(GetProcAddress(KernelHandle, 'Process32First'));
      Process32Next            := Process32NextProc(GetProcAddress(KernelHandle, 'Process32Next'));
      if (@Process32First <> nil) and (@Process32Next <> nil) and (@CreateToolhelp32Snapshot <> nil) then
         APILoaded := true;
    end;
  end;

finalization

  if PsApiDllHandle <> 0 then
    FreeLibrary(PsApiDllHandle);

end.
