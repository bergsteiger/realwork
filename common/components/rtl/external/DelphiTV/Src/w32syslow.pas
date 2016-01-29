//---------------------------------------------------------
//-                                                       -
//-      Virtual Pascal Runtime Library.  Version 2.1.    -
//-      System interface layer Win32                     -
//-      --------------------------------------------------
//-      Copyright (C) 1995-2000 vpascal.com              -
//-                                                       -
//---------------------------------------------------------
{$DEFINE RouteConsoleToStdInOut}  // !!.kg
{$H-}
unit W32SysLow;

interface

uses SysUtils, Use32, Windows;

const
  create_FailIfExists     = $0000;
  create_TruncateIfExists = $0001;

  // Flags: If the file does not exist; set only one of these
  open_FailIfNew          = $0000;  // ocFileOpen fails if no file
  open_CreateIfNew        = $0001;  // ocFileOpen creates file if no file
  open_TruncateIfExists   = $0002;  // ocFileOpen truncates existing file
  // semaphores
  SemInfinite = INFINITE;

// TVision and Crt
type
  PSysPoint = ^TSysPoint;
  TSysPoint = packed record
    X,Y: SmallInt;
  end;

  PSysRect = ^TSysRect;
  TSysRect = packed record
    A,B: TSysPoint;
  end;

  PWin32Cell = ^TWin32Cell;
  TWin32Cell = record
    Ch:     SmallWord;
    Attr:   SmallWord;
  end;

type
  TSysMouseEvent = packed record
    smeTime:    Longint;
    smePos:     TSysPoint;
    smeButtons: Byte;
  end;

  TSysKeyEvent = packed record
    skeKeyCode:    SmallWord;
    skeShiftState: Byte;
  end;

  TQuad = comp;
  TDateTimeRec = record
    FTime,FDate: SmallWord;
  end;

  TOSSearchRec = packed record
    Handle: Longint;
    NameLStr: Pointer;
    Attr: Byte;
    Time: Longint;
    Size: Longint;
    Name: String;
    Filler: array[0..3] of Char;
    ExcludeAttr: Longint;
    FindData:    TWin32FindData;
  end;

  { Search record used by FindFirst and FindNext }
  SearchRec = packed record
    Handle: Longint;
    Filler1: Longint;
    Attr: Byte;
    Time: Longint;
    Size: Longint;
    Name: ShortString;
    Filler2: array[0..3] of Char;
    Filler3: array[0..321] of Char;
  end;

  TCharCase = (ccLower, ccUpper, ccAnsiLower, ccAnsiUpper);
  TCtrlBreakHandler = function: Boolean;
  TSemHandle = longint;
  TDriveType = ( dtFloppy, dtHDFAT, dtHDHPFS, dtInvalid,
                 dtNovellNet, dtCDRom, dtLAN, dtHDNTFS, dtUnknown,
                 dtTVFS, dtHDExt2, dtJFS );
  PathStr = ShortString;
  DirStr  = ShortString;
  ExtStr  = ShortString;
  NameStr = ShortString;
  ComStr = ShortString;
{ Textfile record }

  TextBuf = array [0..127] of Char;
  TextRec = record
    Handle:    Longint;                 // File Handle
    Mode:      Longint;                 // Current file mode
    BufSize:   Longint;                 // Text File buffer size
    BufPos:    Longint;                 // Buffer current position
    BufEnd:    Longint;                 // Buffer ending position
    BufPtr:    ^TextBuf;                // Pointer to the buffer
    OpenFunc:  Pointer;                 // Open Text File function @
    InOutFunc: Pointer;                 // In/Out ...
    FlushFunc: Pointer;                 // Flush ...
    CloseFunc: Pointer;                 // Close ...
    UserData:  array [1..32] of Byte;   // User data area
    Name:      array [0..259] of Char;  // File name (ASCIIZ)
    Buffer:    TextBuf;                 // Default I/O buffer
  end;

{ Date and time record used by PackTime and UnpackTime }
  DateTime = record
    Year,Month,Day,Hour,Min,Sec: Word;
  end;

const
  sysmem_Read    = $01;
  sysmem_Write   = $02;
  sysmem_Execute = $04;
  sysmem_Guard   = $08;
  sysmem_Default = $05;
const
{ Flags bit masks }
  fCarry     = $0001;
  fParity    = $0004;
  fAuxiliary = $0010;
  fZero      = $0040;
  fSign      = $0080;
  fOverflow  = $0800;

{ File mode magic numbers }

  fmClosed = $A55AD7B0;
  fmInput  = $A55AD7B1;
  fmOutput = $A55AD7B2;
  fmInOut  = $A55AD7B3;

{ File attribute constants }
  ReadOnly  = $01;
  Hidden    = $02;
  SysFile   = $04;
  VolumeID  = $08;      // N/A under OS/2
  Directory = $10;
  Archive   = $20;
  AnyFile   = $3F;
var
  CtrlBreakHandler: TCtrlBreakHandler = nil;
  TVVioHandle: Word = 0;
  DosError: integer;

function  SysTVDetectMouse: Longint;
procedure SysTVInitMouse(var X,Y: Integer);
procedure SysTVDoneMouse(Close: Boolean);
procedure SysTVShowMouse;
procedure SysTVHideMouse;
procedure SysTVUpdateMouseWhere(var X,Y: Integer);
function SysTVGetMouseEvent(var Event: TSysMouseEvent): Boolean;
procedure SysTVKbdInit;
function SysTVGetKeyEvent(var Event: TSysKeyEvent): Boolean;
function SysTVPeekKeyEvent(var Event: TSysKeyEvent): Boolean;
function SysTVGetShiftState: Byte;
procedure SysTVSetCurPos(X,Y: Integer); pascal;
procedure SysTVSetCurType(Y1,Y2: Integer; Show: Boolean); pascal;
procedure SysTVGetCurType(var Y1,Y2: Integer; var Visible: Boolean); pascal;
procedure SysTVShowBuf(Pos,Size: Integer);
procedure SysTVClrScr;
function SysTVGetScrMode(Size: PSysPoint): Integer;
procedure SysTVSetScrMode(Mode: Integer);
function SysTVGetSrcBuf: Pointer;
procedure SysTVInitCursor;
procedure SysCtrlSleep(Delay: Integer);
function SysGetValidDrives: Longint;
type
  TCursorType = (crHidden, crBlock, crUnderline);
procedure SetCursorType(CursorType: TCursorType);

procedure SysCtrlExitProcess(ExitCode: Longint);
// Required by the System unit
function SysFileStdIn: Longint;
function SysFileStdOut: Longint;
function SysFileStdErr: Longint;
function SysFileOpen(FileName: PChar; Mode: Longint; var Handle: Longint): Longint;
function SysFileCreate(FileName: PChar; Mode,Attr: Longint; var Handle: Longint): Longint;
function SysFileOpen_Create(Open: Boolean;FileName: PChar; Mode,Attr,Action: Longint; var Handle: Longint): Longint;
function SysFileCopy(_Old, _New: PChar; _Overwrite: Boolean): Boolean;
function SysFileSeek(Handle,Distance,Method: Longint; var Actual: Longint): Longint;
function SysFileRead(Handle: Longint; var Buffer; Count: Longint; var Actual: Longint): Longint;
function SysFileWrite(Handle: Longint; const Buffer; Count: Longint; var Actual: Longint): Longint;
function SysFileSetSize(Handle,NewSize: Longint): Longint;
function SysFileClose(Handle: Longint): Longint;
function SysFileFlushBuffers(Handle: Longint): Longint;
function SysFileDelete(FileName: PChar): Longint;
function SysFileMove(OldName,NewName: PChar): Longint;
function SysFileIsDevice(Handle: Longint): Longint;
function SysDirGetCurrent(Drive: Longint; Path: PChar): Longint;
function SysDirSetCurrent(Path: PChar): Longint;
function SysDirCreate(Path: PChar): Longint;
function SysDirDelete(Path: PChar): Longint;
function SysMemAvail: Longint;
function SysMemAlloc(Size,Flags: Longint; var MemPtr: Pointer): Longint;
function SysMemFree(MemPtr: Pointer): Longint;
function SysSysMsCount: Longint;
procedure SysSysWaitSem(var Sem: Longint);
procedure SysSysSelToFlat(var P: Pointer);
procedure SysSysFlatToSel(var P: Pointer);
function SysCtrlCreateThread(Attrs: Pointer; StackSize: Longint; Func,Param: Pointer; Flags: Longint; var Tid: Longint): Longint;
function SysCtrlKillThread(Handle: Longint): Longint;
function SysCtrlSuspendThread(Handle: Longint): Longint;
function SysCtrlResumeThread(Handle: Longint): Longint;
function SysGetThreadId: Longint;
function SysGetProcessId: Longint;
procedure SysCtrlExitThread(ExitCode: Longint);
function SysFileExpand(Dest,Name: PChar): PChar;
procedure SysChangeCase(Source, Dest: PChar; Len: Longint; NewCase: TCharCase);
// Semaphores
function SemCreateEvent(_Name: pChar; _Shared, _State: Boolean): TSemHandle;
function SemAccessEvent(_Name: pChar): TSemHandle;
function SemPostEvent(_Handle: TSemhandle): Boolean;
function SemWaitEvent(_Handle: TSemHandle; _TimeOut: Longint): Boolean;
procedure SemCloseEvent(_Handle: TSemHandle);

function SemCreateMutex(_Name: PChar; _Shared, _State: Boolean): TSemHandle;
function SemAccessMutex(_Name: PChar): TSemHandle;
function SemRequestMutex(_Handle: TSemHandle; _TimeOut: Longint): Boolean;
function SemReleaseMutex(_Handle: TSemHandle): Boolean;
procedure SemCloseMutex(_Handle: TSemHandle);

function SysGetCodePage: Longint;
procedure SysCtrlSetCBreakHandler;
procedure SysGetCurPos(var X,Y: SmallWord);

// DOS Untit support
procedure FindFirst(const Path: PathStr; Attr: Word; var F: SearchRec);
procedure FindNext(var F: SearchRec);
procedure UnpackTime(P: Longint; var T: DateTime);
procedure PackTime(var T: DateTime; var P: Longint);
function FSearch(const Path: PathStr; const DirList: String): PathStr;
function FExpand(const Path: PathStr): PathStr;
function EnvCount: Integer;
function EnvStr(Index: Integer): String;
function GetEnv(const EnvVar: String): String;
procedure FSplit(const Path: PathStr; var Dir: DirStr; var Name: NameStr; var Ext: ExtStr);
procedure Exec(const Path: PathStr; const ComLine: ComStr);
function DosExitCode: Word;
procedure FindClose(var F: SearchRec);
function SysFileAsOS(FileName: PChar): Boolean;

function LocalAddr(Proc :Pointer) :TMethod;

var
  SysConIn:    Longint = -1;
  SysConOut:   Longint = -1;


implementation

uses W32Kbd;

var
  SysBufInfo: TConsoleScreenBufferInfo;
  SysScrBuf: array[0..$13000] of Char;

type
  TSysMouQUeue = array[0..15] of TSysMouseEvent;
  PSysMouQueue = ^TSysMouQueue;
  TSysKeyQueue = array[0..15] of TSysKeyEvent;
  PSysKeyQueue = ^tSysKeyQueue;

const
  // Pointers to keyboard interface variables located either in the
  // VpKbdW32 unit, or in the VpKbdW32.Dll file, if available
  pSysKeyCount   : pLongint     = nil;
  pSysMouCount   : pLongint     = nil;
  pSysKeyQue     : pSysKeyQueue = nil;
  pSysMouQue     : pSysMouQueue = nil;
  pSysShiftState : pByte        = nil;

  tidCursor:   Longint = -1;  // Thread ID of cursor thread
  semCursor:   Longint = -1;  // Event semaphore, set when cursor pos changes
  CurXPos:     Longint = -1;  // Internally maintained cursor position
  CurYPos:     Longint = -1;
  SysPlatform: Longint = -1;  // Platform ID, from SysPlatformID
  SysSpecialKeys: Set of Byte = [0, $e0];

type
  PStandardCell = ^TStandardCell;
  TStandardCell = packed record
    Ch   : Char;
    Attr : Byte;
  end;

  TKbdInit = procedure(var _pSysKeyCount, _pSysKeyQue, _pSysShiftState, _pSysMouCount, _pSysMouQue);
  TKbdUpdateEventQueues = procedure;

const
  KbdDllName     = 'VpKbdW32.Dll'; // Name of keyboard handler DLL
  hKbdDll        : Longint = -1;   // Handle of keyboard DLL
  name_KbdInit             = 'KbdInit';
  name_KbdUpdateEventQueue = 'KbdUpdateEventQueues';

  pKbdInit : TKbdInit = nil;
  pKbdUpdateEventQueues : TKbdUpdateEventQueues = nil;

function QueryProcAddr(Name: PChar; IsKernel: Boolean): Pointer;
const
  Names: array[Boolean] of PChar = ('user32.dll', 'kernel32.dll');
  Handles: array[Boolean] of THandle = (0, 0);
var
  K: Boolean;
begin
  K := IsKernel;
  if Handles[K] = 0 then
    Handles[K] := LoadLibrary(Names[K]);
  Result := GetProcAddress(Handles[K], Name);
end;

const
  AccessMode: array[0..2] of Integer = (
    generic_Read, generic_Write, generic_Read or generic_Write);
  ShareMode: array[0..4] of Integer = (
    0, 0, file_share_Read, file_share_Write, file_share_Read or file_share_Write);

function SetResult(Success: Boolean): Longint;
begin
  Result := 0;
  if not Success then
    Result := GetLastError;
end;

function SysFileStdIn: Longint;
begin
  Result := GetStdHandle(std_Input_Handle);
end;

function SysFileStdOut: Longint;
begin
  Result := GetStdHandle(std_Output_Handle);
end;

function SysFileStdErr: Longint;
begin
  Result := GetStdHandle(std_Error_Handle);
end;

threadvar
  SysAnsiFn: Array[0..260] of char;
  SysOemFn: Array[0..260] of char;

function AnsiFn(_FileName: PChar): PChar;
begin
  // Convert filename to ANSI character set
  OemToChar(_FileName, SysAnsiFn);
  Result := SysAnsiFn;
end;

function OemFn(_FileName: PChar): PChar;
begin
  // Convert filename to OEM character set
  CharToOem(_FileName, SysOemFn);
  Result := SysOemFn;
end;

function SysFileOpen_Create(Open: Boolean;FileName: PChar; Mode,Attr,Action: Longint; var Handle: Longint): Longint;
var
  SA: TSecurityAttributes;
  APIFlags: Longint;
begin
  if Open then
    if Action and open_CreateIfNew <> 0 then
      APIFlags := open_Always       // Open or create
    else if Action and open_TruncateIfExists <> 0 then
      APIFlags := truncate_existing // Open and truncate
    else
      APIFlags := open_Existing     // Open; fail if no file
  else
    if Action and create_TruncateIfExists <> 0 then
      APIFlags := create_Always     // Create and truncate
    else
      APIFlags := create_New;       // Create; fail if exists

  SA.nLength := SizeOf(SA);
  SA.lpSecurityDescriptor := nil;
  SA.bInheritHandle := True;
  Handle := CreateFile(AnsiFn(FileName), AccessMode[Mode and 3], ShareMode[(Mode and $F0) shr 4],
      @SA, APIFlags, file_attribute_Normal, 0);
  Result := SetResult(Handle <> invalid_Handle_Value);
end;

function SysFileOpen(FileName: PChar; Mode: Longint; var Handle: Longint): Longint;
var
  SA: TSecurityAttributes;
begin
  SA.nLength := SizeOf(SA);
  SA.lpSecurityDescriptor := nil;
  SA.bInheritHandle := True;
  Handle := CreateFile(AnsiFn(FileName), AccessMode[Mode and 3], ShareMode[(Mode and $F0) shr 4],
    @SA, open_Existing, file_attribute_Normal, 0);
  Result := SetResult(Handle <> invalid_Handle_Value);
end;

function SysFileCreate(FileName: PChar; Mode,Attr: Longint; var Handle: Longint): Longint;
var
  SA: TSecurityAttributes;
begin
  SA.nLength := SizeOf(SA);
  SA.lpSecurityDescriptor := nil;
  SA.bInheritHandle := True;
  Handle := CreateFile(AnsiFn(FileName), AccessMode[Mode and 3], ShareMode[(Mode and $F0) shr 4],
    @SA, create_Always, file_attribute_Normal, 0);
  Result := SetResult(Handle <> invalid_Handle_Value);
end;

function SysFileCopy(_Old, _New: PChar; _Overwrite: Boolean): Boolean;
begin
  Result := CopyFile(_Old, _New, not _Overwrite);
end;

function SysFileSeek(Handle,Distance,Method: Longint; var Actual: Longint): Longint;
begin
  Actual := SetFilePointer(Handle, Distance, nil, Method);
  Result := SetResult(Actual <> $FFFFFFFF);
end;

function SysFileRead(Handle: Longint; var Buffer; Count: Longint; var Actual: Longint): Longint;
begin
  Result := SetResult(ReadFile(Handle, Buffer, Count, Cardinal(Actual), nil));
end;

function SysFileWrite(Handle: Longint; const Buffer; Count: Longint; var Actual: Longint): Longint;
var
  sbi: TConsoleScreenBufferInfo;
begin
  Result := SetResult(WriteFile(Handle, Buffer, Count, Cardinal(Actual), nil));
  {$IFDEF RouteConsoleToStdInOut}
  if (tidCursor <> -1) and (Handle = SysConOut) then
  {$ELSE}
  if  (tidCursor <> -1)
  and ((Handle = SysConOut)
  or  ((Handle = SysFileStdOut) and (SysFileIsDevice(SysFileStdOut)=1))
  or  ((Handle = SysFileStdErr) and (SysFileIsDevice(SysFileStdErr)=1))) then
  {$ENDIF}
    begin
      // Writeln without Crt unit: Update cursor position variable
      GetConsoleScreenBufferInfo(SysConOut, sbi);
      CurXPos := sbi.dwCursorPosition.x;
      CurYPos := sbi.dwCursorPosition.y;
    end;
end;

function SysFileSetSize(Handle,NewSize: Longint): Longint;
var
  CurPos: Longint;
begin
  CurPos := SetFilePointer(Handle, 0, nil, file_Current);
  Result := SetResult((CurPos <> $FFFFFFFF) and
    (SetFilePointer(Handle, NewSize, nil, file_Begin) <> $FFFFFFFF) and
    SetEndOfFile(Handle) or
    (SetFilePointer(Handle, CurPos, nil, file_Begin) <> $FFFFFFFF));
end;

function SysFileClose(Handle: Longint): Longint;
begin
  Result := SetResult(CloseHandle(Handle));
end;

function SysFileFlushBuffers(Handle: Longint): Longint;
begin
  Result := SetResult(FlushFileBuffers(Handle));
end;

function SysFileDelete(FileName: PChar): Longint;
begin
  Result := SetResult(DeleteFile(AnsiFn(FileName)));
end;

function SysFileMove(OldName,NewName: PChar): Longint;
begin
  Result := SetResult(MoveFile(OldName, NewName));
end;

function SysFileIsDevice(Handle: Longint): Longint;
var
  HandleType: Longint;
begin
  HandleType := GetFileType(Handle);
  case HandleType of
  0,1 : Result := 0; // File;
    2 : Result := 1; // Device
    3 : Result := 2; // Pipe
  end;
end;

function SysDirGetCurrent(Drive: Longint; Path: PChar): Longint;
var
  DriveName: array[0..3] of Char;
  Buffer: array[0..259] of Char;
begin
  // !! Compiler problem? Result is set by GetCurrentDirectory call!
  Result := 0;
  if Drive <> 0 then
  begin
    DriveName[0] := Chr(Drive + (Ord('A') - 1));
    DriveName[1] := ':';
    DriveName[2] := #0;
    GetCurrentDirectory(SizeOf(Buffer), Buffer);
    SetCurrentDirectory(DriveName);
  end;
  GetCurrentDirectory(260, Path);
  StrCopy( Path, OemFn(Path) );
  if Drive <> 0 then
    SetCurrentDirectory(Buffer);
end;

function SysDirSetCurrent(Path: PChar): Longint;
begin
  if Path^ = #0 then
    Result := 0 // Otherwise returns rc = 161: Bad path name
  else
    Result := SetResult(SetCurrentDirectory(AnsiFn(Path)));
end;

function SysDirCreate(Path: PChar): Longint;
begin
  Result := SetResult(CreateDirectory(AnsiFn(Path), nil));
end;

function SysDirDelete(Path: PChar): Longint;
begin
  Result := SetResult(RemoveDirectory(AnsiFn(Path)));
end;

function SysMemAvail: Longint;
var
  Status: TMemoryStatus;
begin
  Status.dwLength := SizeOf(TMemoryStatus);
  GlobalMemoryStatus(Status);
  with Status do
  begin
    Result := dwAvailPhys + dwAvailPageFile;
    if Result > dwAvailVirtual then
      Result := dwAvailVirtual;
  end;
end;

function SysMemAlloc(Size,Flags: Longint; var MemPtr: Pointer): Longint;
begin
  MemPtr := VirtualAlloc(nil, Size, Flags, page_ReadWrite);
  Result := SetResult(MemPtr <> nil);
end;

function SysMemFree(MemPtr: Pointer): Longint;
begin
  Result := SetResult(VirtualFree(MemPtr, 0, mem_Release));
end;

function SysSysMsCount: Longint;
begin
  Result := GetTickCount;
end;

procedure SysSysSelToFlat(var P: Pointer);
begin
  // Do nothing; n/a for Win32
end;

procedure SysSysFlatToSel(var P: Pointer);
begin
  // Do nothing; n/a for Win32
end;

function SysGetThreadId: Longint;
begin
  Result := GetCurrentThreadId;
end;

function SysCtrlKillThread(Handle: Longint): Longint;
begin
  Result := SetResult(TerminateThread(Handle, 0));
end;

function SysCtrlSuspendThread(Handle: Longint): Longint;
begin
  Result := SetResult(SuspendThread(Handle) <> $FFFFFFFF);
end;

function SysCtrlResumeThread(Handle: Longint): Longint;
begin
  Result := SetResult(ResumeThread(Handle) <> $FFFFFFFF);
end;

procedure SysCtrlExitThread(ExitCode: Longint);
var
  P: Pointer;
type
  TExitThread = procedure(ExitCode: Longint) stdcall;
begin
  P := QueryProcAddr('ExitThread', True);
  if P <> nil then
    TExitThread(P)(ExitCode)
  else
    SysCtrlExitProcess(ExitCode);
end;

procedure SysCtrlExitProcess(ExitCode: Longint);
begin
  ExitProcess(ExitCode);
end;

function SysCtrlCreateThread(Attrs: Pointer; StackSize: Longint; Func,Param: Pointer; Flags: Longint; var Tid: Longint): Longint;
begin
  Result := SetResult(CreateThread(Attrs, Cardinal(StackSize), Func, Param, Cardinal(Flags), Cardinal(Tid)) <> 0);
end;

function SysCtrlGetModuleName(Handle: Longint; Buffer: PChar): Longint;
begin
  SetResult(GetModuleFileName(0, Buffer, 260) <> 0);
end;

var
  SysCritSec: TRTLCriticalSection;
  InitCritSec: Boolean;

procedure SysCtrlEnterCritSec;
var
  P: Pointer;
type
  TInitializeCriticalSectionAndSpinCount =
    procedure(CriticalSection: TRTLCriticalSection; SpinCount: DWord) stdcall;
begin
  if not InitCritSec then
    begin
      P := QueryProcAddr('InitializeCriticalSectionAndSpinCount', True);
      if assigned(P) then
        TInitializeCriticalSectionAndSpinCount(P)(SysCritSec, 4000)
      else
       InitializeCriticalSection(SysCritSec);
      InitCritSec := True;
    end;
  EnterCriticalSection(SysCritSec);
end;

procedure SysCtrlLeaveCritSec;
begin
  LeaveCriticalSection(SysCritSec);
end;

function GetParamStr(P: PChar; var Param: ShortString): PChar;
var
  Len: Longint;
begin
  Result := P;
  repeat
    while Result^ in [#1..' '] do
      Inc(Result);
    if PSmallWord(Result)^ = (Ord('"') shl 8 + Ord('"')) then
      Inc(Result, 2)
    else
      Break;
  until False;
  Len := 0;
  while Result^ > ' ' do
    if Result^ = '"' then
      begin
        Inc(Result);
        while not (Result^ in [#0,'"']) do
        begin
          Inc(Len);
          Param[Len] := Result^;
          Inc(Result);
        end;
        if Result^ <> #0 then
          Inc(Result);
      end
    else
      begin
        Inc(Len);
        Param[Len] := Result^;
        Inc(Result);
      end;
  Param[0] := Chr(Len);
end;

function SysCmdln: PChar;
begin
  Result := GetCommandLine;
end;

function SysCmdlnCount: Longint;
var
  P: PChar;
  S: ShortString;
begin
  P := SysCmdln;
  Result := -1;
  repeat
    P := GetParamStr(P, S);
    if S = '' then
      Exit;
    Inc(Result);
  until False;
end;

procedure SysCmdlnParam(Index: Longint; var Param: ShortString);
var
  I: Longint;
  P: PChar;
  Buffer: array[0..260] of Char;
begin
  I := Index;
  if I = 0 then
    begin
      SysCtrlGetModuleName(0, Buffer);
      P := Buffer;
      Param := '';
      while (P^ <> #0) and (I < 255) do
      begin
        Inc(I);
        Param[I] := P^;
        Inc(P);
      end;
      SetLength(Param, I);
    end
  else
    begin
      // Skip ParamStr(0)
      P := SysCmdln;// + Length(ParamStr(0));
      repeat
        P := GetParamStr(P, Param);
        if (I = 0) or (Param = '') then
          Exit;
        Dec(I);
      until False;
    end;
end;

function SysGetProcessId: Longint;
begin
  Result := GetCurrentProcessID;
end;

function SysGetEnvironment: PChar;
begin
  Result := GetEnvironmentStrings;
end;

function SysOsVersion: Longint;
begin
  Result := SmallWord(GetVersion);
end;

function SysPlatformID: Longint;
var
  OSVersionInfo: TOSVersionInfo;
begin
  OSVersionInfo.dwOSVersionInfoSize := SizeOf(OSVersionInfo);
  GetVersionEx(OSVersionInfo);
  Result := OSVersionInfo.dwPlatformId;
end;

procedure SysGetDateTime(Year,Month,Day,DayOfWeek,Hour,Minute,Second,MSec: PLongint);
var
  DT: TSystemTime;
begin
  GetLocalTime(DT);
  if Year <> nil then Year^ := DT.wYear;
  if Month <> nil then Month^ := DT.wMonth;
  if Day <> nil then Day^ := DT.wDay;
  if DayOfWeek <> nil then DayOfWeek^ := DT.wDayOfWeek;
  if Hour <> nil then Hour^ := DT.wHour;
  if Minute <> nil then Minute^ := DT.wMinute;
  if Second <> nil then Second^ := DT.wSecond;
  if MSec <> nil then MSec^ := DT.wMilliseconds;
end;

procedure SysSetDateTime(Year,Month,Day,Hour,Minute,Second,MSec: PLongint);
var
  DT: TSystemTime;
begin
  GetLocalTime(DT);
  if Year <> nil then DT.wYear := Year^;
  if Month <> nil then DT.wMonth := Month^;
  if Day <> nil then DT.wDay := Day^;
  if Hour <> nil then DT.wHour := Hour^;
  if Minute <> nil then DT.wMinute := Minute^;
  if Second <> nil then DT.wSecond := Second^;
  if MSec <> nil then DT.wMilliseconds := MSec^;
  SetLocalTime(DT);
end;

function SysVerify(SetValue: Boolean; Value: Boolean): Boolean;
begin
  Result := False;
end;

function SysDiskFreeLong(Drive: Byte): TQuad;
var
  RootPath: array[0..3] of Char;
  RootPtr: PChar;
  SectorsPerCluster,BytesPerSector,FreeClusters,TotalClusters: Cardinal;
begin
  RootPtr := nil;
  if Drive > 0 then
  begin
    RootPath[0] := Char(Drive + (Ord('A') - 1));
    RootPath[1] := ':';
    RootPath[2] := '\';
    RootPath[3] := #0;
    RootPtr := RootPath;
  end;
  if GetDiskFreeSpace(RootPtr, SectorsPerCluster, BytesPerSector, FreeClusters, TotalClusters) then
    Result := 1.0 * SectorsPerCluster * BytesPerSector * FreeClusters
  else
    Result := -1;
end;

function SysDiskSizeLong(Drive: Byte): TQuad;
var
  RootPath: array[0..3] of Char;
  RootPtr: PChar;
  SectorsPerCluster,BytesPerSector,FreeClusters,TotalClusters: DWord;
begin
  RootPtr := nil;
  if Drive > 0 then
  begin
    RootPath[0] := Char(Drive + (Ord('A') - 1));
    RootPath[1] := ':';
    RootPath[2] := '\';
    RootPath[3] := #0;
    RootPtr := RootPath;
  end;
  if GetDiskFreeSpace(RootPtr, SectorsPerCluster, BytesPerSector, FreeClusters, TotalClusters) then
    Result := 1.0 *SectorsPerCluster * BytesPerSector * TotalClusters
  else
    Result := -1;
end;

function SysGetFileAttr(FileName: PChar; var Attr: Longint): Longint;
begin
  Attr := GetFileAttributes(AnsiFn(FileName));
  Result := SetResult(Attr <> -1);
  if Attr = -1 then
    Inc(Attr);
end;

function SysSetFileAttr(FileName: PChar; Attr: Longint): Longint;
begin
  Result := SetResult(SetFileAttributes(AnsiFn(FileName), Attr));
end;

function SysGetFileTime(Handle: Longint; var Time: Longint): Longint;
var
  FileTime, LocalFileTime: TFileTime;
begin
  Result := SetResult(GetFileTime(Handle, nil, nil, @FileTime) and
    FileTimeToLocalFileTime(FileTime, LocalFileTime) and
    FileTimeToDosDateTime(LocalFileTime, TDateTimeRec(Time).FDate, TDateTimeRec(Time).FTime));
end;

function SysSetFileTime(Handle: Longint; Time: Longint): Longint;
var
  LocalFileTime, FileTime: TFileTime;
begin
  Result := SetResult(DosDateTimeToFileTime(TDateTimeRec(Time).FDate, TDateTimeRec(Time).FTime, LocalFileTime) and
    LocalFileTimeToFileTime(LocalFileTime, FileTime) and
    SetFileTime(Handle, nil, nil, @FileTime));
end;

function DoFindFile(var F: TOSSearchRec; IsPChar: Boolean): Longint;
var
  LocalFileTime: TFileTime;
  ExclAttr: Longint;
  InclAttr: Longint;
begin
  // Extract Include/Exclude attributes from F.ExcludeAttr field
  ExclAttr := not F.ExcludeAttr and (file_Attribute_Hidden or file_Attribute_System or $8 or file_Attribute_Directory or file_Attribute_Archive);
  InclAttr := (F.ExcludeAttr and $FF00) shr 8;
  // Make sure attributes are not both excluded and included
  ExclAttr := ExclAttr and not InclAttr;
  with F do
  begin
    // Reject entries where
    // - Attributes that are excluded are present.
    // - Attributes that must be present are not all there
    while (FindData.dwFileAttributes and ExclAttr <> 0) or
      (FindData.dwFileAttributes and InclAttr <> InclAttr) do
      if not FindNextFile(Handle, FindData) then
      begin
        Result := GetLastError;
        Exit;
      end;
    FileTimeToLocalFileTime(FindData.ftLastWriteTime, LocalFileTime);
    FileTimeToDosDateTime(LocalFileTime, TDateTimeRec(Time).FDate, TDateTimeRec(Time).FTime);
    Size := FindData.nFileSizeLow;
    Attr := FindData.dwFileAttributes;
    // Convert filename to OEM character set
    CharToOem(FindData.cFileName, FindData.cFileName);
    if IsPChar then
      StrCopy(PChar(@Name), FindData.cFileName)
    else
      Name := StrPas(FindData.cFileName);
  end;
  Result := 0;
end;

function SysFindFirst(Path: PChar; Attr: Longint; var F: TOSSearchRec; IsPChar: Boolean): Longint;
begin
  F.ExcludeAttr := Attr;
  F.Handle := FindFirstFile(Path, F.FindData);
  if F.Handle <> invalid_Handle_Value then
    begin
      Result := DoFindFile(F, IsPChar);
      if Result <> 0 then
        begin
          Windows.FindClose(F.Handle);
          F.Handle := invalid_Handle_Value;
        end;
    end
  else
    Result := GetLastError;
end;

function SysFindNext(var F: TOSSearchRec; IsPChar: Boolean): Longint;
begin
  if FindNextFile(F.Handle, F.FindData) then
    Result := DoFindFile(F, IsPChar)
  else
    Result := GetLastError;
end;

function SysFindClose(var F: TOSSearchRec): Longint;
begin
  if F.Handle = invalid_Handle_Value then
    Result := 0
  else
    Result := SetResult(Windows.FindClose(F.Handle));
  F.Handle := invalid_Handle_Value;
end;

// Check if file exists; if it does, update FileName parameter
// to include correct case of existing file
function SysFileAsOS(FileName: PChar): Boolean;
var
  Handle: THandle;
  FindData: TWin32FindData;
  LocalFileTime: TFileTime;
  P: PChar;
begin
  Handle := FindFirstFile(AnsiFn(FileName), FindData);
  if Handle <> invalid_Handle_Value then
    begin
      if FindData.cFileName[0] <> #0 then
        begin
          // Replace filename part with data returned by Windows
          P := StrRScan(FileName, '\');
          if P = nil then
            P := FileName
          else
            inc(P); // Point to first character of file name
          strcopy(P, FindData.cFileName);
        end;
      Windows.FindClose(Handle);
      Result := True;
    end
  else
    Result := False;
end;

function SysFileSearch(Dest,Name,List: PChar): PChar;
var
  I, P, L: Integer;
  Buffer: array[0..259] of Char;
begin
  Result := Dest;
  StrCopy(Buffer, Name);
  P := 0;
  L := StrLen(List);
  while True do
  begin
    if SysFileAsOS(Buffer) then
    begin
      SysFileExpand(Dest, Buffer);
      Exit;
    end;
    while (P < L) and (List[P] = ';') do
      Inc(P);
    if P >= L then
      Break;
    I := P;
    while (P < L) and (List[P] <> ';') do
      Inc(P);
    StrLCopy(Buffer, List + I, P - I);
    if not (List[P-1] in [':', '\']) then
      StrLCat(Buffer, '\', 259);
    StrLCat(Buffer, Name, 259);
  end;
  Dest^ := #0;
end;

function SysFileExpand(Dest,Name: PChar): PChar;
var
  L: Longint;
  NameOnly: PChar;
begin
  if strlen(Name) = 0 then
    SysDirGetCurrent(0, Dest)
  else
    if GetFullPathName(Name, 260, Dest, NameOnly) = 0 then
      StrCopy(Dest, Name) // API failed; copy name to dest
    else
      if (StrComp(Name, '.') <> 0) and (StrComp(Name, '..') <> 0) then
        begin
          L := StrLen(Name);
          if (L > 0) and (Name[L-1] = '.') then
          begin
            L := StrLen(Dest);
            if (L > 0) and (Dest[L-1] <> '.') then
            begin
              Dest[L] := '.';
              Dest[L+1] := #0;
            end;
          end;
        end;
  Result := Dest;
end;

threadvar
  ProcessInfo: TProcessInformation;
  LastAsync: Boolean;

function SysExecute(Path,CmdLine,Env: PChar; Async: Boolean; PID: PLongint; StdIn,StdOut,StdErr: Longint): Longint;
var
  P: PChar;
  Flags: Longint;
  StartupInfo: TStartupInfo;
  CmdLineBuf: array [0..8191] of Char;
begin
  P := CmdLineBuf;
  P^ := '"';                   // Quotes to support spaces
  inc(P);
  P := StrECopy(P, Path);      // 'Path'#0
  P^ := '"';
  inc(P);
  P^ := ' ';
  StrCopy(P+1, CmdLine);                // 'Path CommandLine'#0
  FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
  with StartupInfo do
  begin
    cb := SizeOf(TStartupInfo);
    dwFlags := startf_UseShowWindow;
    wShowWindow := sw_ShowNormal;
    if StdIn = -1 then
      hStdInput := SysFileStdIn
    else
      hStdInput := StdIn;
    if StdOut = -1 then
      hStdOutput := SysFileStdOut
    else
      hStdOutput := StdOut;
    if StdErr = -1 then
      hStdError := SysFileStdErr
    else
      hStdError := StdErr;
    if (StdIn <> - 1) or (StdOut <> -1) or (StdErr <> -1) then
      Inc(dwFlags, startf_UseStdHandles);
  end;
  Flags := normal_Priority_Class;
  LastAsync := Async;
  Result := SetResult(CreateProcess(Path, CmdLineBuf, nil, nil, True, Flags, Env, nil, StartupInfo, ProcessInfo));
  if Result = 0 then
    if Async then
      begin
        if PID <> nil then
          PID^ := ProcessInfo.hProcess;
      end
    else
      WaitForSingleObject(ProcessInfo.hProcess, Infinite);
end;

function SysExitCode: Longint;
begin
  if LastAsync then
    WaitForSingleObject(ProcessInfo.hProcess, Infinite);
  GetExitCodeProcess(ProcessInfo.hProcess, Cardinal(Result));
end;

procedure SysGetCaseMap(TblLen: Longint; Tbl: PChar );
begin
  CharUpperBuff(Tbl, TblLen);
end;

procedure SysGetWeightTable(TblLen: Longint; WeightTable: PChar);
var
  I: Longint;

begin
  // !!! Must use Win32 function
  for I := 0 to pred(TblLen) do
    begin
      WeightTable^ := Chr(i);
      inc(WeightTable);
    end;
end;

function SysGetCodePage: Longint;
var
  P: Pointer;
type
  TGetKBCodePage = function: Longint;
begin
  P := QueryProcAddr('GetKBCodePage', False);
  if P = nil then
    Result := 0
  else
    Result := TGetKBCodePage(P);
end;

function SysCompareStrings(s1, s2: PChar; l1, l2: Longint; IgnoreCase: Boolean): Longint;
begin
  if IgnoreCase then
    Result := CompareString(Locale_User_Default, norm_ignorecase,S1, l1, s2, l2)-2
  else
    Result := CompareString(Locale_User_Default, 0, S1, l1, s2, l2)-2;
end;

procedure SysChangeCase(Source, Dest: PChar; Len: Longint; NewCase: TCharCase);
var
  I: Longint;
begin
  if NewCase in [ccLower, ccUpper] then
    begin
      i := 0;
      while i < Len do
        begin
          if NewCase = ccLower then
            if Source^ in ['A'..'Z'] then
              Dest^ := chr(ord(Source^)+32)
            else
              Dest^ := Source^
          else
            if Source^ in ['a'..'z'] then
              Dest^ := chr(ord(Source^)-32)
            else
              Dest^ := Source^;
          inc(i);
          inc(Source);
          inc(Dest);
        end;
    end
  else
    begin
      // AnsiUpper and AnsiLower
      StrLCopy(Dest, Source, Len);
      if NewCase = ccAnsiLower then
        CharLowerBuff(Dest, Len)
      else
        CharUpperBuff(Dest, Len);
    end;
end;

function SysLowerCase(s: PChar): PChar;
begin
  Result := CharLower(s);
end;

function SysUpperCase(s: PChar): PChar;
begin
  Result := CharUpper(s);
end;

var
  PrevXcptProc: Pointer;

function CtrlHandler(CtrlType: DWord): Bool; stdcall;
begin
  if Assigned(CtrlBreakHandler) and CtrlBreakHandler then
    Result := True
  else
    Result := False;
end;

procedure SysCtrlSetCBreakHandler;
begin
  SetConsoleCtrlHandler(@CtrlHandler, True);
end;

function SysFileIncHandleCount(Count: Longint): Longint;
begin
  // Return 0, indicating success.  In Win95/NT, the number of file handles
  // is limited by available physical memory only.
  Result := 0;
end;

procedure DoSetCursorPosition;
var
  CurPos: TCoord;
begin
  CurPos.x := CurXPos;
  CurPos.y := CurYPos;
  SetConsoleCursorPosition(SysConOut, CurPos);
end;

function CursorThreadFunc(P: Pointer): Longint;
var
  LastX, LastY: Longint;
begin
  LastX := -1;
  LastY := -1;
  repeat
    SemWaitEvent(semCursor, 300);
    if (CurXPos <> LastX) or (CurYPos <> LastY) then
      begin
        DoSetCursorPosition;
        LastX := CurXPos;
        LastY := CurYPos;
      end;
  until tidCursor = -2;
  tidCursor := -1;
end;

procedure CursorThreadExitProc;
begin
  // Force cursor thread to terminate
  tidCursor := -2;
  SemPostEvent(semCursor);
  // Update cursor position
  DoSetCursorPosition;
end;

procedure InitialiseKeyboardHandler;
begin
  if hKbdDll = -1 then // First try - attempt load
    begin
      hKbdDll := LoadLibrary(KbdDllName);
      if hKbdDll <> 0 then
        begin
          @pKbdInit := GetProcAddress(hKbdDll, name_KbdInit);
          @pKbdUpdateEventQueues := GetProcAddress(hKbdDll, name_KbdUpdateEventQueue);
        end;
      // If any of the entry points were not found in the DLL, point them
      // to statically linked default handlers
      if not assigned(pKbdInit) or not assigned(pKbdUpdateEventQueues) then
        begin
          @pKbdInit := @W32kbd.KbdInit;
          @pKbdUpdateEventQueues := @W32kbd.KbdUpdateEventQueues;
        end;
      pKbdInit(pSysKeyCount, pSysKeyQue, pSysShiftState, pSysMouCount, pSysMouQue);

      // Check if we're in Russia, cp 866.  If we are, allow key $E0 to be
      // interpreted as a character
      if SysGetCodePage = 866 then
        SysSpecialKeys := [0]
      else
        SysSpecialKeys := [0, $E0];
    end;
end;

procedure InitialiseConsole;
begin
  {$IFDEF RouteConsoleToStdInOut}
  SysConIn  := SysFileStdIn;
  SysConOut := SysFileStdOut;
  {$ELSE}
  SysConIn  := CreateFile('CONIN$' , generic_Read or generic_Write, file_share_Read, nil, open_Existing, file_attribute_Normal, 0);
  SysConOut := CreateFile('CONOUT$', generic_Read or generic_Write, file_share_Read or file_share_Write, nil, open_Existing, file_attribute_Normal, 0);
  {$ENDIF}
  InitialiseKeyboardHandler;
end;


const
  CrtScanCode: Byte = 0;

function SysKeyPressed: Boolean;
begin
  if CrtScanCode <> 0 then
    Result := True
  else
    begin
      InitialiseKeyboardHandler;
      pKbdUpdateEventQueues;
      Result := pSysKeyCount^ <> 0;
    end;
end;

function SysPeekKey(Var Ch: Char): Boolean;
begin
  pKbdUpdateEventQueues;
  if pSysKeyCount^ > 0 then
    Result := False
  else
    begin
      Result := True;
      if Lo(pSysKeyQue^[0].skeKeyCode) in [0,$E0] then
        Ch := #0
      else
        Ch := Chr(Lo(pSysKeyQue^[0].skeKeyCode));
    end;
end;

function SysReadKey: Char;
var
  EventCount: DWord;
  InRec: TInputRecord;
begin
  if CrtScanCode <> 0 then
    begin
      Result := Chr(CrtScanCode);
      CrtScanCode := 0;
    end
  else
    begin
      InitialiseKeyboardHandler;
      repeat
        pKbdUpdateEventQueues;
        if pSysKeyCount^ = 0 then
          WaitForSingleObject(SysConIn, infinite);
      until pSysKeyCount^ <> 0;
      Dec(pSysKeyCount^);
      if Lo(pSysKeyQue^[0].skeKeyCode) in [0,$E0] then
        begin
          CrtScanCode := Hi(pSysKeyQue^[0].skeKeyCode);
          Result := #0;
        end
      else
        Result := Chr(Lo(pSysKeyQue^[0].skeKeyCode));
      Move(pSysKeyQue^[1], pSysKeyQue^[0], pSysKeyCount^ * SizeOf(TSysKeyEvent));
    end;
end;

procedure SysFlushKeyBuf;
begin
  InitialiseKeyboardHandler;
  CrtScanCode := 0;
  pSysKeyCount^ := 0;
  FlushConsoleInputBuffer(SysConIn);
end;

procedure InitialiseCursorThread;
var
  sbi: TConsoleScreenBufferInfo;
begin
  if tidCursor = -1 then
    begin
      // Get initial cursor position
      GetConsoleScreenBufferInfo(SysConOut, sbi);
      CurXPos := sbi.dwCursorPosition.x;
      CurYPos := sbi.dwCursorPosition.y;

      semCursor := SemCreateEvent(nil, false, false);
      BeginThread(nil, 16384, CursorThreadFunc, nil, 0, Cardinal(tidCursor) );
      SemPostEvent(semCursor);
      AddExitProc(CursorThreadExitProc);
    end;
end;

procedure SysWrtCharStrAtt(CharStr: Pointer; Len, X, Y: SmallWord; var Attr: Byte);
var
  Buffer: Array[0..255] of TWin32Cell;
  BufferSize,
  BufferCoord: TCoord;
  WriteRegion: TSmallRect;
  BufNext: ^TWin32Cell;
  I: Longint;
begin
  InitialiseCursorThread;
  BufNext := @Buffer;
  for i := 0 to Len-1 do
    begin
      BufNext^.Attr := Attr;
      BufNext^.Ch := Ord( PChar(CharStr)^ );
      inc(PChar(CharStr));
      inc(BufNext);
    end;
  with BufferSize do
    begin
      x := Len;
      y := 1;
    end;
  with BufferCoord do
    begin
      x := 0;
      y := 0;
    end;
  with WriteRegion do
    begin
      Left := x;
      Top := y;
      Right := x+Len-1;
      Bottom := y;
    end;
  WriteConsoleOutput( SysConOut, @Buffer, BufferSize, BufferCoord, WriteRegion );
end;

function SysReadAttributesAt(x,y: SmallWord): Byte;
var
  WasRead: Cardinal;
  Coor: TCoord;
  Temp: SmallWord;
begin
  SysTVInitCursor;
  Coor.x := x;
  Coor.y := y;
  ReadConsoleOutputAttribute(SysConOut, @Temp, 1, Coor, WasRead);
  Result := Temp;
end;

function SysReadCharAt(x,y: SmallWord): Char;
var
  WasRead: Cardinal;
  Coor: TCoord;
begin
  SysTVInitCursor;
  Coor.x := x;
  Coor.y := y;
  ReadConsoleOutputCharacter(SysConOut, @Result, 1, Coor, WasRead);
  if WasRead = 0 then
    Result := #0;
end;

procedure SysScrollUp(X1,Y1,X2,Y2,Lines,Cell: SmallWord);
var
  Cliprect,
  ScrollRect: TSmallRect;
  DestCoord: TCoord;
  Fill: TWin32Cell;
  i: Integer;
begin
  if SysPlatform = -1 then
    SysPlatform := SysPlatformID;
  Fill.ch := Lo(Cell);
  Fill.Attr := Hi( Cell );
  ScrollRect.Left := X1;
  ScrollRect.Top := Y1;
  ScrollRect.Right := X2;
  ScrollRect.Bottom := Y2;
  ClipRect := ScrollRect;
  if SysPlatform = VER_PLATFORM_WIN32_NT then
    begin
      DestCoord.x := X1;       // This API works in Windows NT
      DestCoord.y := Y1-Lines;
      ScrollConsoleScreenBuffer(SysConOut, ScrollRect, @ClipRect, DestCoord, PCharInfo(@Fill)^);
    end
  else
    begin
      if Lines > 1 then
        for i := 1 to 2 do // Half a screen at a time; bug in Win95
          begin
            DestCoord.x := X1;
            DestCoord.y := Y1-Lines div 2;
            ScrollConsoleScreenBuffer(SysConOut, ScrollRect, @ClipRect, DestCoord, PCharInfo(@Fill)^);
          end;
      if odd(Lines) then // Also do last line, if odd number
        begin
          DestCoord.x := X1;
          DestCoord.y := Y1-1;
          ScrollConsoleScreenBuffer(SysConOut, ScrollRect, @ClipRect, DestCoord, PCharInfo(@Fill)^);
        end;
    end;
end;

procedure SysScrollDn(X1,Y1,X2,Y2,Lines,Cell: SmallWord);
var
  ScrollRect: TSmallRect;
  DestCoord: TCoord;
  Fill: TWin32Cell;
begin
  Fill.ch := Lo(Cell);
  Fill.Attr := Hi(Cell);
  ScrollRect.Left := X1;
  ScrollRect.Top := Y1;
  ScrollRect.Right := X2;
  ScrollRect.Bottom := Y2-Lines;
  DestCoord.x := X1;
  DestCoord.y := Y1+Lines;
  ScrollConsoleScreenBuffer(SysConOut, ScrollRect, nil, DestCoord, PCharInfo(@Fill)^);
end;

procedure SysGetCurPos(var X,Y: SmallWord);
begin
  if CurXPos = -1 then
    InitialiseCursorThread;
  X := CurXPos;
  Y := CurYPos;
end;

function SysTVDetectMouse: Longint;
begin
  Result := 2;
end;

procedure SysTVInitMouse(var X,Y: Integer);
begin
  X := 0;
  Y := 0;
end;

procedure SysTVDoneMouse(Close: Boolean);
begin
end;

procedure SysTVShowMouse; // No control over mouse pointer in Win32
begin
end;

procedure SysTVHideMouse; // No control over mouse pointer in Win32
begin
end;

procedure SysTVUpdateMouseWhere(var X,Y: Integer);
begin
end;

function SysTVGetMouseEvent(var Event: TSysMouseEvent): Boolean;
begin
  InitialiseKeyboardHandler;
  pKbdUpdateEventQueues;
  if pSysMouCount^ = 0 then
    Result := False
  else
    begin
      Dec(pSysMouCount^);
      Event := pSysMouQue^[0];
      Move(pSysMouQue^[1], pSysMouQue^[0], pSysMouCount^ * SizeOf(TSysMouseEvent));
      Result := True;
    end;
end;

procedure SysTVKbdInit;
begin
  SetConsoleMode(SysConIn, ENABLE_MOUSE_INPUT);
end;

function SysTVGetKeyEvent(var Event: TSysKeyEvent): Boolean;
begin
  InitialiseKeyboardHandler;
  pKbdUpdateEventQueues;
  if pSysKeyCount^ = 0 then
    Result := False
  else
    begin
      Dec(pSysKeyCount^);
      Event := pSysKeyQue^[0];
      Move(pSysKeyQue^[1], pSysKeyQue^[0], pSysKeyCount^ * SizeOf(TSysKeyEvent));
      Result := True;
    end;
end;

function SysTVPeekKeyEvent(var Event: TSysKeyEvent): Boolean;
begin
  InitialiseKeyboardHandler;
  pKbdUpdateEventQueues;
  if pSysKeyCount^ = 0 then
    Result := False
  else
    begin
      Event := pSysKeyQue^[0];
      Result := True;
    end;
end;

function SysTVGetShiftState: Byte;
begin
  InitialiseKeyboardHandler;
  Result := pSysShiftState^;
end;

procedure SysTVSetCurPos(X,Y: Integer);
var
  CurPos: TCoord;
begin
  CurXPos := X;
  CurYPos := Y;
  {$IFDEF RouteConsoleToStdInOut}
  if tidCursor = -1 then
  {$ENDIF}
    // Set cursor position without using cursor thread
    DoSetCursorPosition
  {$IFDEF RouteConsoleToStdInOut}
  else
    // Record cursor position; tell cursor thread to update
    SemPostEvent(semCursor);
  {$ENDIF}
end;

procedure SysTVSetCurType(Y1,Y2: Integer; Show: Boolean);
var
  Info: TConsoleCursorInfo;
begin
  Info.bVisible := Show;
  if Abs(Y1 - Y2) <= 1 then
    Info.dwSize := 15
  else
    Info.dwSize := 99;
  SetConsoleCursorInfo(SysConOut, Info);
end;

procedure SetCursorType(CursorType: TCursorType);
const
  CursorTypes: array[TCursorType] of integer   = (0, 100, 15);
  CursorVisible: array[TCursorType] of boolean = (false, true, true);
var
  Info: TConsoleCursorInfo;
begin
  Info.dwSize   := CursorTypes[CursorType];
  Info.bVisible := CursorVisible[CursorType];
  SetConsoleCursorInfo(SysConOut, Info);
end;


procedure SysTVGetCurType(var Y1,Y2: Integer; var Visible: Boolean);
var
  Info: TConsoleCursorInfo;
begin
  GetConsoleCursorInfo(SysConOut, Info);
  Visible := Info.bVisible;
  if Info.dwSize <= 25 then
    begin
      Y1 := 6;
      Y2 := 7;
    end
  else
    begin
      Y1 := 1;
      Y2 := 7;
    end;
end;

procedure WriteConsoleLine(X,Y: Integer; Len: Integer);
var
  P: PChar;
  Q: PWin32Cell;
  LineBuf: array[0..255] of TWin32Cell;
  R: TSmallRect;
  BufPos: TCoord;
  LineSize: TCoord;
begin
  InitialiseCursorThread;
  { Prepared parameters }
  LineSize.X := SysBufInfo.dwSize.X;
  LineSize.Y := 1;
  BufPos.X := 0;
  BufPos.Y := 0;
  R.Left := X;
  R.Top  := Y;
  R.Right := X + Len - 1;
  R.Bottom := Y;
  { Translate the buffer from DOS-OS/2 format to Win32 }
  P := SysScrBuf + ((Y * SysBufInfo.dwSize.X) + X) * 2;
  Q := @LineBuf;
  while Len > 0 do
  begin
    Q^.Ch := Ord(P^);
    Inc(P);
    Q^.Attr := Ord(P^);
    Inc(P);
    Inc(Q);
    Dec(Len);
  end;
  WriteConsoleOutput(SysConOut, @LineBuf, LineSize, BufPos, R);
end;

function Min(X,Y: Integer): Integer;
begin
  Result := Y;
  if X < Y then
    Result := X;
end;

procedure SysTVShowBuf(Pos,Size: Integer);
var
  I,X,Y: Integer;
begin
  Pos := Pos div 2;
  X := Pos mod SysBufInfo.dwSize.X;
  Y := Pos div SysBufInfo.dwSize.X;
  while Size > 0 do
  begin
    I := Min(SysBufInfo.dwSize.X - X, Size div 2);
    WriteConsoleLine(X, Y, I);
    Dec(Size, I * 2);
    X := 0;
    Inc(Y);
  end;
end;

procedure SysTVClrScr;
var
  I,BufSize: Integer;
begin
  BufSize := SysBufInfo.dwSize.X * SysBufInfo.dwSize.Y * 2;
  I := 0;
  while I < BufSize do
  begin
    SysScrBuf[I] := ' ';
    Inc(I);
    SysScrBuf[I] := #7;
    Inc(I);
  end;
  SysTVShowBuf(0, BufSize);
  SysTVSetCurPos(0, 0);
end;

function SysTVGetScrMode(Size: PSysPoint): Integer;
begin
  GetConsoleScreenBufferInfo(SysConOut, SysBufInfo);
  case SysBufInfo.dwSize.Y of
    25:    Result := $0003;
    43,50: Result := $0103;
    else   Result := $00FF;
  end;
  if Size <> nil then
    with Size^ do
    begin
      X := SysBufInfo.dwSize.X;
      Y := SysBufInfo.dwSize.Y;
      if Size.Y > 234 then
        Size.Y := 234;
    end;
end;

procedure SysTVSetScrMode(Mode: Integer);
var
  R: TSmallRect;
  Size: TCoord;
begin
  Size.X := 80;
  Size.Y := 25;
  if Mode and $0100 <> 0 then
    Size.Y := 50;
  SetConsoleScreenBufferSize(SysConOut, Size);
  R.Left   := 0;
  R.Top    := 0;
  R.Right  := Size.X - 1;
  R.Bottom := Size.Y - 1;
  SetConsoleWindowInfo(SysConOut, True, R);
end;

function SysTVGetSrcBuf: Pointer;
const
  First: Boolean = True;
  UpLeft: TCoord= (X:0; Y:0);
  ReadFrom: TSmallRect = (Left:0; Top:0; Right:0; Bottom:0);
var
  Size: TSysPoint;
  Coord: TCoord;
  Buffer: PWin32Cell;
  PDest: PStandardCell;
  PSrc: PWin32Cell;
  X,Y: Longint;
begin
  Result := @SysScrBuf;
  if First then
    begin
      First := False;
      SysTVGetScrMode(@Size);
      Coord.X := Size.X;
      Coord.Y := Size.Y;
      ReadFrom.Right := Size.X;
      ReadFrom.Bottom := Size.Y;
      // Read existing content of screen into buffer
      GetMem(Buffer, (Size.X+1)*(Size.Y+1)*SizeOf(TWin32Cell));
      if not ReadConsoleOutput(SysConOut, Buffer, Coord, UpLeft, ReadFrom) then
        X := GetLastError;
      // Move the data to the screen buffer in standard format
      PSrc := Buffer;
      PDest := Result;
      for Y := 0 to Size.Y-1 do
        for X := 0 to Size.X-1 do
          begin
            PDest^.Ch := chr(PSrc^.Ch);
            PDest^.Attr := byte(PSrc^.Attr);
            inc(PSrc);
            inc(PDest);
          end;
      FreeMem(Buffer);
    end;
end;

procedure SysTVInitCursor;
begin
  if SysConIn = -1 then
    InitialiseConsole;
end;

procedure SysCtrlSleep(Delay: Integer);
begin
  Sleep(Delay);
end;

function SysGetValidDrives: Longint;
begin
  Result := GetLogicalDrives;
end;

procedure SysDisableHardErrors;
begin
  SetErrorMode(sem_FailCriticalErrors);
end;

function SysKillProcess(Process: Longint): Longint;
begin
  Result := SetResult(TerminateProcess(Process, 1));
end;

function SysAllocSharedMem(Size: Longint; var MemPtr: Pointer): Longint;
begin
  Result := -1;
end;

function SysGiveSharedMem(MemPtr: Pointer): Longint;
begin
  Result := -1;
end;

function SysPipeCreate(var ReadHandle,WriteHandle: THandle; Size: Longint): Longint;
var
  SA: TSecurityAttributes;
begin
  SA.nLength := SizeOf(SA);
  SA.lpSecurityDescriptor := nil;
  SA.bInheritHandle := True;
  Result := SetResult(CreatePipe(ReadHandle, WriteHandle, @SA, Size));
end;

function SysPipePeek(Pipe: Longint; Buffer: Pointer; BufSize: Longint; var BytesRead: Longint; var IsClosing: Boolean): Longint;
var
  State: Longint;
begin
  Result := SetResult(PeekNamedPipe(Pipe, Buffer, BufSize, @BytesRead, nil, nil));
  IsClosing := WaitForSingleObject(ProcessInfo.hProcess, 0) = wait_Object_0;
end;

function SysPipeClose(Pipe: Longint): Longint;
begin
  Result := SysFileClose(Pipe);
end;

function SysLoadResourceString(ID: Longint; Buffer: PChar; BufSize: Longint): PChar;
begin
  Buffer[0] := #0;
  LoadString(HInstance, ID, Buffer, BufSize);
  Result := Buffer;
end;

function SysFileUNCExpand(Dest,Name: PChar): PChar;

  procedure GetUNCPath(FileName: PChar);
  type
    PNetResourceArray = ^TNetResourceArray;
    TNetResourceArray = array[0..MaxInt div SizeOf(TNetResource) - 1] of TNetResource;
  var
    Done: Boolean;
    I,Size: Cardinal;
    Count: integer;
    NetHandle: THandle;
    P,NetResources: PNetResource;
    RemoteNameInfo: array[0..1023] of Byte;
    Drive: char;
  begin
    if SysPlatform <> VER_PLATFORM_WIN32_WINDOWS then
      begin
        Size := SizeOf(RemoteNameInfo);
        if WNetGetUniversalName(FileName, UNIVERSAL_NAME_INFO_LEVEL,
          @RemoteNameInfo, Size) <> NO_ERROR then
          Exit;
        StrCopy(FileName, PRemoteNameInfo(@RemoteNameInfo).lpUniversalName);
      end
    else
      begin
      { The following works around a bug in WNetGetUniversalName under Windows 95 }
        Drive := UpCase(FileName[1]);
        if (Drive < 'A') or (Drive > 'Z') or (StrLen(FileName) < 3) or
          (FileName[1] <> ':') or (FileName[2] <> '\') then
          Exit;
        if WNetOpenEnum(RESOURCE_CONNECTED, RESOURCETYPE_DISK, 0, nil, NetHandle) <> NO_ERROR then
          Exit;
        Count := -1;
        if WNetEnumResource(NetHandle, Cardinal(Count), nil, Size) = ERROR_MORE_DATA then
        begin
          GetMem(NetResources, Size);
          Done := False;
          P := NetResources;
          repeat
            if WNetEnumResource(NetHandle, Cardinal(Count), P, Size) <> NO_ERROR then
              Break;
            I := 0;
            while I < Count do
            begin
              with P^ do
                if (lpLocalName <> nil) and (UpCase(FileName[0]) = UpCase(lpLocalName[0])) then
                begin
                  I := StrLen(lpRemoteName);
                  StrMove(@FileName[I], @FileName[2], MaxInt);
                  Move(lpRemoteName^, FileName^, I);
                  Done := True;
                  Break;
                end;
              Inc(I);
              Inc(P);
            end;
          until Done;
          FreeMem(NetResources);
        end;
        WNetCloseEnum(NetHandle);
      end;
  end;

begin
  if SysPlatform = -1 then
    SysPlatform := SysPlatformID;
  SysFileExpand(Dest, Name);
  if (UpCase(Dest[0]) in ['A'..'Z']) and (Dest[1] = ':') and (Dest[2] = '\') then
    GetUNCPath(Dest);
  Result := Dest;
end;

function SysGetSystemError(Code: Longint; Buffer: PChar; BufSize: Longint;var MsgLen: Longint): PChar;
begin
  MsgLen := FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM or
    FORMAT_MESSAGE_ARGUMENT_ARRAY, nil, Code, 0, Buffer, BufSize, nil);
  Result := Buffer;
end;

function GetLocaleStr(Locale,LocaleType: Integer; Default,Dest: PChar): PChar;
begin
  if GetLocaleInfo(Locale, LocaleType, Dest, 260) <= 0 then
    StrCopy(Dest, Default);
  Result := Dest;
end;

function GetLocaleChar(Locale, LocaleType: Integer; Default: Char): Char;
var
  Buffer: array[0..1] of Char;
begin
  if GetLocaleInfo(Locale, LocaleType, @Buffer, 2) > 0 then
    Result := Buffer[0] else
    Result := Default;
end;

function SysStrToIntDef(S: PChar; Default: Integer): Integer;
var
  E: Integer;
begin
  Val(S, Result, E);
  if E <> 0 then
    Result := Default;
end;

procedure SysGetCurrencyFormat(CString: PChar; var CFormat, CNegFormat, CDecimals: Byte; var CThousandSep, CDecimalSep: Char);
var
  DefaultLCID: LCID;
  Buffer: array[0..259] of Char;
begin
  DefaultLCID := GetThreadLocale;
  GetLocaleStr(DefaultLCID, LOCALE_SCURRENCY, '', CString);
  CFormat := SysStrToIntDef(GetLocaleStr(DefaultLCID, LOCALE_ICURRENCY, '0', Buffer), 0);
  CNegFormat := SysStrToIntDef(GetLocaleStr(DefaultLCID, LOCALE_INEGCURR, '0', Buffer), 0);
  CThousandSep := GetLocaleChar(DefaultLCID, LOCALE_STHOUSAND, ',');
  CDecimalSep := GetLocaleChar(DefaultLCID, LOCALE_SDECIMAL, '.');
  CDecimals := SysStrToIntDef(GetLocaleStr(DefaultLCID, LOCALE_ICURRDIGITS, '0', Buffer), 0);
end;

procedure SysGetDateFormat(var DateSeparator: Char; ShortDateFormat, LongDateFormat: PChar);
var
  DefaultLCID: LCID;
begin
  DefaultLCID := GetThreadLocale;
  DateSeparator := GetLocaleChar(DefaultLCID, LOCALE_SDATE, '/');
  GetLocaleStr(DefaultLCID, LOCALE_SSHORTDATE, 'm/d/yy', ShortDateFormat);
  GetLocaleStr(DefaultLCID, LOCALE_SLONGDATE, 'mmmm d, yyyy', LongDateFormat);
end;

procedure SysGetTimeFormat(var TimeSeparator: Char; TimeAMString,TimePMString,ShortTimeFormat,LongTimeFormat: PChar);
var
  TimePostfix: PChar;
  DefaultLCID: LCID;
  Buffer: array[0..259] of Char;
begin
  DefaultLCID := GetThreadLocale;
  TimeSeparator := GetLocaleChar(DefaultLCID, LOCALE_STIME, ':');
  GetLocaleStr(DefaultLCID, LOCALE_S1159, 'am', TimeAMString);
  GetLocaleStr(DefaultLCID, LOCALE_S2359, 'pm', TimePMString);
  TimePostfix := '';
  if SysStrToIntDef(GetLocaleStr(DefaultLCID, LOCALE_ITLZERO, '0', Buffer), 0) = 0 then
    begin
      StrCopy(ShortTimeFormat, 'h:mm');
      StrCopy(LongTimeFormat, 'h:mm:ss');
    end
  else
    begin
      StrCopy(ShortTimeFormat, 'hh:mm');
      StrCopy(LongTimeFormat, 'hh:mm:ss');
    end;
  if SysStrToIntDef(GetLocaleStr(DefaultLCID, LOCALE_ITIME, '0', Buffer), 0) = 0 then
    TimePostfix := ' AMPM';
  StrCat(ShortTimeFormat, TimePostfix);
  StrCat(LongTimeFormat, TimePostfix);
end;

function SysGetModuleName(var Address: Pointer; Buffer: PChar; BufSize: Longint): PChar;
var
  MemInfo: TMemoryBasicInformation;
  ModName: array[0..Max_Path] of Char;
begin
  VirtualQuery(Address, MemInfo, SizeOf(MemInfo));
  if (MemInfo.State <> mem_Commit) or
     (GetModuleFilename(THandle(MemInfo.AllocationBase), ModName, SizeOf(ModName)) = 0) then
    begin
      GetModuleFileName(HInstance, ModName, SizeOf(ModName));
      if Assigned(Address) then
        Dec(PChar(Address), $1000);
    end
  else
    Dec(PChar(Address), Longint(MemInfo.AllocationBase));
  StrLCopy(Buffer, StrRScan(ModName, '\') + 1, BufSize - 1);
  Result := Buffer;
end;

procedure SysDisplayConsoleError(PopupErrors: Boolean; Title, Msg: PChar);
var
  Count: Longint;
begin
  SysFileWrite(SysFileStdOut, Msg^, StrLen(Msg), Count);
end;

procedure SysDisplayGUIError(Title, Msg: PChar);
begin
  MessageBox(0, Msg, Title, MB_OK or MB_IconStop or MB_TaskModal);
end;

procedure SysBeep;
begin
  MessageBeep(0);
end;

procedure SysBeepEx(Freq,Dur: Longint);
begin
  Windows.Beep(Freq, Dur);
end;

function SysGetVolumeLabel(Drive: Char): ShortString;
const
  Root: Array[0..4] of char = 'C:\'#0;
var
  VolLabel: Array[0..256] of char;
  MaxLength, FSFlags: Cardinal;
begin
  Root[0] := Drive;
  if GetVolumeInformation(Root, VolLabel, Sizeof(VolLabel),
    nil, MaxLength, FSFlags, nil, 0) then
    Result := StrPas(VolLabel)
  else
    Result := '';
end;

function SysSetVolumeLabel(Drive: Char; _Label: ShortString): Boolean;
const
  Root: Array[0..4] of char = 'C:\'#0;
begin
  Root[0] := Drive;
  _Label[Length(_Label)+1] := #0;
  Result := SetVolumeLabel(Root, PChar(@_Label[1]));
end;

function SysGetForegroundProcessId: Longint;
var
  WHandle: Longint;
  ThreadID: Longint;
begin
  WHandle := GetForegroundWindow;
  Result := GetWindowThreadProcessId(WHandle, @ThreadID);
end;

function SysGetBootDrive: Char;
begin
  Result := 'C';
end;

function SysGetDriveType(Drive: Char): TDriveType;
const
  Root: Array[0..4] of char = 'C:\'#0;
var
  FSName: Array[0..255] of char;
  MaxLength: Cardinal;
  FSFlags: Cardinal;
begin
  Root[0] := Drive;
  Result := dtInvalid;
  if GetVolumeInformation(Root, nil, 0, nil, MaxLength, FSFlags, FSName, sizeof(FSName)) then
    begin
      if StrLComp(FSName, 'FAT', 3) = 0 then
        Result := dtHDFAT
      else if StrComp(FSName, 'HPFS') = 0 then
        Result := dtHDHPFS
      else if StrComp(FSName, 'NTFS') = 0 then
        Result := dtHDNTFS
      else if StrLComp(FSName, 'CD', 2) = 0 then
        Result := dtCDROM
      else if StrComp(FSName, 'LAN') = 0 then
        Result := dtLan
      else if StrComp(FSName, 'NOVELL') = 0 then
        Result := dtNovellNet;
    end;

  if Result = dtInvalid then
    case GetDriveType(Root) of
      Drive_Fixed     : Result := dtHDFAT;
      Drive_Removable : Result := dtFloppy;
      Drive_CDRom     : Result := dtCDROM;
      Drive_Remote    : Result := dtLAN;
      0, 1            : Result := dtInvalid;
    else                Result := dtUnknown;
    end;
end;

function SysGetVideoModeInfo( Var Cols, Rows, Colours : Word ): Boolean;
var
  Buffer: TConsoleScreenBufferInfo;
begin
  SysTVInitCursor;
  GetConsoleScreenBufferInfo(SysConOut, Buffer);

  Cols := Buffer.dwSize.x;
  Rows := Buffer.dwSize.y;
  Colours := 16; //Buffer.wAttributes;
end;

function SysGetVisibleLines( var Top, Bottom: Longint ): Boolean;
var
  Buffer: TConsoleScreenBufferInfo;
begin
  SysTVInitCursor;
  GetConsoleScreenBufferInfo(SysConOut, Buffer);
  Top := Buffer.srwindow.top+1;
  Bottom := Buffer.srwindow.bottom+1;
  Result := True;
end;

function SysSetVideoMode( Cols, Rows: Word ): Boolean;
var
  Size: TCoord;
  R: TSmallRect;
begin
  SysTVInitCursor;
  Size.X := Cols;
  Size.Y := Rows;
  Result := SetConsoleScreenBufferSize(SysConOut, Size);
  R.Left   := 0;
  R.Top    := 0;
  R.Right  := Size.X - 1;
  R.Bottom := Size.Y - 1;
  Result := SetConsoleWindowInfo(SysConOut, True, R);
end;

function SemCreateEvent(_Name: pChar; _Shared, _State: Boolean): TSemHandle;
var
  Security: TSecurityAttributes;
begin
  if _Shared then
    begin
      with Security do
        begin
          nLength := Sizeof(Security);
          lpSecurityDescriptor := nil;
          bInheritHandle := True;
        end;
      Result := CreateEvent(@Security, False, _State, _Name);
    end
  else
    Result := CreateEvent(nil, False, _State, _Name);
end;

function SemAccessEvent(_Name: PChar): TSemHandle;
begin
  Result := OpenEvent( Event_all_access, False, _Name);
  if Result = 0 then
    Result := -1;
end;

function SemPostEvent(_Handle: TSemhandle): Boolean;
begin
  Result := SetEvent(_Handle);
end;

function SemWaitEvent(_Handle: TSemHandle; _TimeOut: Longint): Boolean;
begin
  Result := WaitForSingleObject(_Handle, _TimeOut) = WAIT_OBJECT_0;
end;

function SemCreateMutex(_Name: PChar; _Shared, _State: Boolean): TSemHandle;
var
  Security: TSecurityAttributes;
begin
  if _Shared then
    begin
      with Security do
        begin
          nLength := Sizeof(Security);
          lpSecurityDescriptor := nil;
          bInheritHandle := True;
        end;
      Result := CreateMutex(@Security, _State, _Name);
    end
  else
    // Non-shared mutex does not require security descriptor
    Result := CreateMutex(nil, _State, _Name);
end;

function SemRequestMutex(_Handle: TSemHandle; _TimeOut: Longint): Boolean;
begin
  Result := WaitForSingleObject(_Handle, _TimeOut) = WAIT_OBJECT_0;
  if Result = False then
    _Handle := GetLastError;
end;

function SemAccessMutex(_Name: PChar): TSemHandle;
begin
  Result := OpenMutex( mutex_all_access, False, _Name);
  if Result = 0 then
    Result := -1;
end;

function SemReleaseMutex(_Handle: TSemHandle): Boolean;
begin
  Result := ReleaseMutex( _Handle );
  if Result = False then
    _Handle := GetLastError;
end;

procedure SemCloseEvent(_Handle: TSemHandle);
begin
  CloseHandle(_Handle);
end;

procedure SemCloseMutex(_Handle: TSemHandle);
begin
  CloseHandle(_Handle);
end;

function SysMemInfo(_Base: Pointer; _Size: Longint; var _Flags: Longint): Boolean;
var
  Buffer: TMemoryBasicInformation;
begin
  Result := VirtualQuery(_Base, Buffer, Sizeof(Buffer)) = Sizeof(Buffer);
  if Result then
    with Buffer do
     begin
       _Flags := 0;
       if Protect and (Page_ReadOnly or Page_ReadWrite or Page_Execute_Read) <> 0 then
         _Flags := _Flags or sysmem_Read or sysmem_Execute;
       if Protect and (Page_WriteCopy or Page_ReadWrite) <> 0 then
         _Flags := _Flags or sysmem_Write;
       if Protect and (Page_Execute or Page_Execute_Read or Page_Execute_ReadWrite) <> 0 then
         _Flags := _Flags or sysmem_Execute;
       if Protect and Page_Guard <> 0 then
         _Flags := _Flags or sysmem_Guard;
     end;
end;

function SysSetMemProtection(_Base: Pointer; _Size: Longint; _Flags: Longint): Boolean;
var
  Flags: Longint;
  Buffer: TMemoryBasicInformation;
begin
  VirtualQuery(_Base, Buffer, Sizeof(Buffer));
  if _Flags and sysmem_Execute <> 0 then
    if _Flags and sysmem_Read <> 0 then
      if _Flags and sysmem_Write <> 0 then
        Flags := page_Execute_ReadWrite
      else
        Flags := page_Execute_Read
    else
      if _Flags and sysmem_Write <> 0 then
        Flags := page_Execute_WriteCopy
      else
        Flags := page_Execute
  else
    if _Flags and sysmem_Read <> 0 then
      if _Flags and sysmem_Write <> 0 then
        Flags := page_ReadWrite
      else
        Flags := page_ReadOnly
    else
      if _Flags and sysmem_Write <> 0 then
        Flags := page_WriteCopy
      else
        Flags := page_NoAccess;
  Result := VirtualProtect(_Base, _Size, Flags, @Buffer);
end;

procedure SysMessageBox(_Msg, _Title: PChar; _Error: Boolean);
var
  Flag: Longint;
begin
  if _Error then
    Flag := mb_IconError
  else
    Flag := mb_IconInformation;
  MessageBox( 0, _Msg, _Title, Flag or mb_ApplModal);
end;

function SysClipCanPaste: Boolean;
var
  IsClipboardFormatAvailable: function(Format: UInt): Bool stdcall;
begin
  @IsClipboardFormatAvailable := QueryProcAddr('IsClipboardFormatAvailable', False);
  if Assigned(IsClipboardFormatAvailable) then
    Result := IsClipboardFormatAvailable(cf_Text)
  else
    Result := False;
end;

function SysClipCopy(P: PChar; Size: Longint): Boolean;
var
  Q: pChar;
  MemHandle: HGlobal;
  OpenClipboard: function(Wnd: hWnd): Bool stdcall;
  EmptyClipboard: function: Bool stdcall;
  CloseClipboard: function: Bool stdcall;
  SetClipboardData: function(Format: UInt; Mem: THandle): THandle stdcall;
begin
  Result := False;
  @OpenClipboard := QueryProcAddr('OpenClipboard', False);
  @EmptyClipboard := QueryProcAddr('EmptyClipboard', False);
  @CloseClipboard := QueryProcAddr('CloseClipboard', False);
  @SetClipboardData := QueryProcAddr('SetClipboardData', False);
  if Assigned(OpenClipboard) and Assigned(EmptyClipboard) and
    Assigned(CloseClipboard) and Assigned(SetClipboardData) then
  begin
    // Open clipboard
    if OpenClipboard(0) then
    begin
      EmptyClipboard;
      // Allocate a shared block of memory
      MemHandle := GlobalAlloc(gmem_Moveable or gmem_DDEShare, Size+1);
      Q := GlobalLock(MemHandle);
      // Copy clipboard data across and translate to ANSI charset
      Result := OemToCharBuff(P, Q, Size);
      Q[Size]:=#0;
      GlobalUnlock(MemHandle);
      // Insert data into clipboard
      if Result then
        Result := SetClipboardData(cf_Text, MemHandle) <> 0;
      // Do not free memory: Windows does this!
      // GlobalFree(MemHandle);
    end;
    CloseClipboard;
  end;
end;

function SysClipPaste(var Size: Integer): Pointer;
var
  P: Pointer;
  MemHandle: HGlobal;
  OpenClipboard: function(Wnd: hWnd): Bool stdcall;
  CloseClipboard: function: Bool stdcall;
  GetClipboardData: function(Format: UInt): THandle stdcall;
begin
  Result := nil;
  @OpenClipboard := QueryProcAddr('OpenClipboard', False);
  @CloseClipboard := QueryProcAddr('CloseClipboard', False);
  @GetClipboardData := QueryProcAddr('GetClipboardData', False);
  if Assigned(OpenClipboard) and Assigned(CloseClipboard)
    and Assigned(GetClipboardData) then
  begin
    if OpenClipboard(0) then
    begin
      MemHandle := GetClipboardData(cf_Text);
      P := GlobalLock(MemHandle);
      if Assigned(P) then
      begin
        Size := StrLen(P) + 1;
        GetMem(Result, Size);
        // Copy clipboard data across and translate to OEM charset
        CharToOemBuff(P, Result, Size);
      end;
      GlobalUnlock(MemHandle);
      CloseClipBoard;
    end;
  end;
end;

// Retrieve various system settings, bitmapped:
// 0: Enhanced keyboard installed

function SysGetSystemSettings: Longint;
var
  KbdFlag: Longint;
begin
  Result := 0;
  KbdFlag := GetKeyboardType(0);
  if KbdFlag in [2, 4] then
    Result := Result OR 1;
end;

procedure SysSysWaitSem(var Sem: Longint);
asm
      @@1:
        mov     eax,Sem
   lock bts     [eax].Longint,0
        jnc     @@RET
        push    31              // Wait for at least one timer slice
        Call    SysCtrlSleep    // and try to check again
        jmp     @@1
      @@RET:
end;


function SetDosError(ErrCode: Integer): Integer;
begin
  DosError := ErrCode;
  Result := ErrCode;
end;

// Converts a 4-byte packed date/time returned by FindFirst, FindNext or
// GetFTime into a DateTime record.

procedure UnpackTime(P: Longint; var T: DateTime);
var
  FDateTime: TDateTimeRec absolute P;
begin
  with T,FDateTime do
  begin
    Year  := (FDate and $FE00) shr 9 + 1980;
    Month := (FDate and $01E0) shr 5;
    Day   := (FDate and $001F);
    Hour  := (FTime and $F800) shr 11;
    Min   := (FTime and $07E0) shr 5;
    Sec   := (FTime and $001F) * 2;
  end;
end;

// Converts a DateTime record into a 4-byte packed date/time used by
// SetFTime.

procedure PackTime(var T: DateTime; var P: Longint);
var
  FDateTime: TDateTimeRec absolute P;
begin
  with T,FDateTime do
  begin
    FDate := (Year - 1980) shl 9 + Month shl 5 + Day;
    FTime := Hour shl 11 + Min shl 5 + (Sec div 2);
  end;
end;

// Splits the file name specified by Path into its three components. Dir
// is set to the drive and directory path with any leading and trailing
// backslashes, Name is set to the file name, and Ext is set to the
// extension with a preceding dot. Each of the component strings may
// possibly be empty, if Path contains no such component.

procedure FSplit(const Path: PathStr; var Dir: DirStr; var Name: NameStr; var Ext: ExtStr);
var
  I,NamePos,ExtPos: Integer;
begin
  NamePos := 0;
  ExtPos  := 256;
  for I := 1 to Length(Path) do
  case Path[I] of
    ':', {$IFDEF LINUX} '/' {$ELSE} '\' {$ENDIF} :
      begin
        NamePos := I;
        ExtPos  := 256;
      end;
    '.': ExtPos := I;
  end;
  Dir  := Copy(Path, 1, NamePos);
  Name := Copy(Path, NamePos+1, ExtPos-NamePos-1);
  Ext  := Copy(Path, ExtPos, 255);
end;

// EnvCount returns the number of strings contained in the OS environment.

function EnvCount: Integer;
var
  P: PChar;
  Count: Integer;
begin
  P := SysGetEnvironment;
  Count := 0;
  while P^ <> #0 do
  begin
    repeat Inc(P) until (P-1)^ = #0;
    Inc(Count);
  end;
  Result := Count;
end;

// Returns a specified environment string. The returned string is of the
// form "VAR=VALUE". The index of the first string is one. If Index is
// less than one or greater than EnvCount,EnvStr returns an empty string.

function EnvStr(Index: Integer): String;
var
  P: PChar;
  Count: Integer;
begin
  Result := '';
  if Index > 0 then
  begin
    P := SysGetEnvironment;
    Count := 1;
    while (Count < Index) and (P^ <> #0) do
    begin
      repeat Inc(P) until (P-1)^ = #0;
      Inc(Count);
    end;
    Result := StrPas(P);
  end;
end;

// Returns the value of a specified environment variable. The variable
// name can be in upper or lower case, but it must not include the '='
// character. If the specified environment variable does not exist,
// GetEnv returns an empty string.

function GetEnv(const EnvVar: String): String;
var
  P: PChar;
  L: Word;
  EnvVarBuf: array [0..255] of Char;
begin
  StrPCopy(EnvVarBuf, EnvVar);
  L := Length(EnvVar);
  P := SysGetEnvironment;
  while P^ <> #0 do
  begin
    if (StrLIComp(P, EnvVarBuf, L) = 0) and (P[L] = '=') then
    begin
      Result := StrPas(P + L + 1);
      Exit;
    end;
    Inc(P, StrLen(P) + 1);
  end;
  Result := '';
end;

// Searches the specified (or current) directory for the first entry
// that matches the specified filename and attributes. The result is
// returned in the specified search record. Errors (and no files found)
// are reported in DosError.

procedure FindFirst(const Path: PathStr; Attr: Word; var F: SearchRec);
var
  PathBuf: array [0..SizeOf(PathStr)-1] of Char;
  sr: TOSSearchRec absolute F;
begin
  SetDosError(SysFindFirst(StrPCopy(PathBuf, Path), Attr, sr, false));
end;

// Returns the next entry that matches the name and attributes specified
// in a previous call to FindFirst. The search record must be one passed
// to FindFirst. Errors (and no more files) are reported in DosError.

procedure FindNext(var F: SearchRec);
var
  sr: TOSSearchRec absolute F;
begin
  SetDosError(SysFindNext(sr, False));
end;

// Ends the search, closes the search record. FindClose should be issued
// whenever search record is no longer needed. Errors are reported in DosError.

procedure FindClose(var F: SearchRec);
var
  sr: TOSSearchRec absolute F;
begin
  SetDosError(SysFindClose(sr));
end;

// Searches for the file given by Path in the list of directories given
// by DirList. The directory paths in DirList must be separated by
// semicolons. The search always starts with the current directory of
// the current drive. The returned value is a fully qualified file name
// or an empty string if the file could not be located.

function FSearch(const Path: PathStr; const DirList: String): PathStr;
var
  PathBuf:    array[0..259] of Char;
  DirListBuf: array[0..259] of Char;
  ResBuf:     array[0..259] of Char;
begin
  Result := StrPas(SysFileSearch(ResBuf, StrPCopy(PathBuf, Path), StrPCopy(DirListBuf, DirList)));
end;

// FExpand expands the file name in Path into a fully qualified file
// name. The resulting name consists of a drive letter, a colon, a root
// relative directory path, and a file name. Embedded '.' and '..'
// directory references are removed.

function FExpand(const Path: PathStr): PathStr;
var
  I: Integer;
  PathBuf: array[0..259] of Char;
  ResBuf:  array[0..259] of Char;
begin
  Result := StrPas(SysFileExpand(ResBuf, StrPCopy(PathBuf, Path)));
{$IFDEF UpperCase}
  for I := 1 to Length(Result) do
    Result[I] := UpCase(Result[I]);
{$ENDIF}
end;

// Executes another program. The program is specified by the Path
// parameter, and the command line is specified by the CmdLine parameter.
// ExecFlags specifies Exec type (synchronous or asynchronous). To
// execute an OS/2 internal command, run CMD.EXE, e.g.
// "Exec(GetEnv('COMSPEC'),'/C DIR *.PAS');". Note the /C in front of
// the command. Errors are reported in DosError.

procedure Exec(const Path: PathStr; const ComLine: ComStr);
var
  PathBuf:    array [0..255] of Char;
  CmdLineBuf: array [0..255] of Char;
begin
//  SetDosError(SysExecute(StrPCopy(PathBuf, Path), StrPCopy(CmdLineBuf, ComLine), nil, ExecFlags = efAsync, nil, -1, -1, -1));
end;

// DosExitCode returns the exit code of a sub-process. To obtain the
// correct exit code make sure that ExecFlags variable has not been
// changed between calls to Exec and DosExitCode.

function DosExitCode: Word;
begin
  Result := SysExitCode;
end;

function LocalAddr(Proc :Pointer) :TMethod;
asm
  mov Result.Data, EBP
  mov Result.Code, Proc
end;

end.
