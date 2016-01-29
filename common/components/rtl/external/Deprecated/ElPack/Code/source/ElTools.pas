{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$INCLUDE elpack2.inc}
{$IFDEF ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$ELSE}
{$IFDEF LINUX}
{$I ../ElPack.inc}
{$ELSE}
{$I ..\ElPack.inc}
{$ENDIF}
{$ENDIF}

(*

Version history

12/18/2002

  Fixed DirExists for root folders

04/19/2002

  Fixed GetSystemDir function

<...>

  Fixed GetTempDir function in windows

*)

unit ElTools;

interface

uses
{$IFNDEF KYLIX_USED}
  Windows,
  Messages,
  ShellAPI,
  ActiveX,
  mmSystem,
{$IFDEF VCL_6_USED}
  Types,
{$ENDIF}
{$ELSE}
  Types,
  Libc,
{$ENDIF KYLIX_USED}
  SysUtils,
  Classes,
{$ifndef ELPACK_SINGLECOMP}
  ElCRC32,
{$endif}
  ElStrUtils;

{$IFDEF BUILDER_USED}
{$IFDEF VCL_6_USED}
{.$HPPEMIT '#define TRect Types::TRect'}
//type
//  TRect = Types.TRect;
{$ENDIF}
{$ENDIF}

function Sign(a: integer): integer;
function Max(a, b: integer): integer;
function Min(a, b: integer): integer;
function InRange(L, R, x: integer): boolean;
function InRangeF(L, R, x: double): boolean;

function SwapDouble(d: double): double;
function swapInt32(i: integer): integer;
function swapInt16(w: word): Word;

function RangesIntersect(L1, R1, L2, R2: integer): boolean;
 //vAd: ??? "SubtractTimes" Нигде в "ElPack" не используется:
{$IFNDEF VER90}
{$IFDEF MSWINDOWS}
function SubtractTimes(Time1, Time2: TDateTime): TDateTime;
{$ENDIF}
{$ENDIF}

function GetTime(DateTime: TDateTime): TDateTime;

// the following two functions write and read the string in the following format:
// <string length><text>
function WriteStringToStream(S: TStream; const Str: string): boolean;
function ReadStringFromStream(S: TStream; var Str: string): boolean;
{$IFNDEF BROKEN_UNICODE}
function WriteWideStringToStream(S: TStream; const Str: WideString): boolean;
function ReadWideStringFromStream(S: TStream; var Str: WideString): boolean;
{$ENDIF}
function WriteFStringToStream(S: TStream; const Str: TElFString): boolean;
function ReadFStringFromStream(S: TStream; var Str: TElFString): boolean;

// the following two functions write and read the string in the following format:
// <text>#13#10
procedure WriteTextToStream(S: TStream; Data: string);
function ReadTextFromStream(S: TStream; var Data: string): boolean;

{$IFDEF VCL_4_USED}
function GetFileSize(const FileName: string): Int64;
{$ELSE}
function GetFileSize(const FileName: string): Integer;
{$ENDIF}
function FileDateTime(const FileName: string): TDateTime;
function FileNameValid(const FileName: string): boolean;
function CreateFile(const FileName: string): boolean;
function EnsureDirExists(RootName: string; const DirName: string): Boolean;
{$ifndef ELPACK_SINGLECOMP}
function EnsureValidFileName(const PathName, FileName: string): string;
{$endif}
function ReplaceExt(const FileName, NewExt: string): string;

function DirExists(DirName: string): boolean;
function PurgeDir(DirName: string): boolean;
function GetModulePath: string;

{$IFDEF MSWINDOWS}
function GetComputerName: string;
{$ENDIF}

function IsBIn(index: integer; storage: byte): boolean;

 //vAd: ??? Нигде вообще не используется
function encode_line(const buf; size: integer): string;

{$IFDEF VER90}
function CompareMem(Var1, Var2: pointer; size: integer): boolean; assembler;
{$ENDIF}

procedure ValFloat(Value: string; var Result: Double; var Error: integer);
function StrFloat(Value: double): string;

type
  TDirectMemoryStream = class(TMemoryStream)
  public
    procedure SetPointer(Ptr: Pointer; Size: Longint);
  end;
  TElMemoryStream = TDirectMemoryStream;

  TNamedFileStream = class(TFileStream)
  private
    FFileName: string;
  public
    constructor Create(const FileName: string; Mode: Word);
    property FileName: string read FFileName;
  end;

const
  MAXPATHLEN = 1024;

// Returns a path name after adding
// a backslash character to the end if it is not already there.
function IncludeTrailingBackslash2(Path: string): string;

{$IFDEF MSWINDOWS}
function GetSystemDir: string;
function GetWindowsDir: string;
function GetTempDir: string;
function GetShortPath(const Path: string): string;
{$ENDIF}

function AppendSlash(const PathName: string): string;
{$IFNDEF D_2}
function GetTempFile(SDir: string): string;
{$ENDIF}

{$IFDEF MSWINDOWS}
function GetSpecialFolder(const CSIDL: integer): string;
{$ENDIF}
function GetUserLocalAppDataFolder: string;
function GetUserAppDataFolder: string;
{$IFDEF MSWINDOWS}
function GetCommonAppDataFolder: string;
{$ENDIF}

type
  TReducedDateTime = record
    Year,
      Month,
      DOW,
      Day,
      Hour,
      Min: word;
  end;

function DateTimeToReduced(T: TDateTime): TReducedDateTime;
function ReducedToDateTime(T: TReducedDateTime): TDateTime;
function CompareReducedDT(T1, T2: TReducedDateTime): boolean;
// < -1
// = 0
// > +1
function MakeReducedDT(Year, Month, Day, DOW, Hour, Min: word):
  TReducedDateTime;

function RunProgram(StartName: string; const Params, StartDir: string): THandle;

function ScaleRectToRect(RectSrc, RectDest: TRect): TRect;
procedure CenterRects(WS, WT, HS, HT: integer; var R: TRect);
function RectToString(Rect: TRect): string;
function StringToRect(AString: string): TRect;

function IncDate(ADate: TDateTime; Days, Months, Years: Integer): TDateTime;
function IncTime(ATime: TDateTime; Hours, Minutes, Seconds, MSecs: Integer):
  TDateTime;
function ExtractTime(ATime: TDateTime): TDateTime;
function ExtractDate(ATime: TDateTime): TDateTime;

function DaysPerMonth(AYear, AMonth: Integer): Integer;
function ElDayOfWeek(ADay, AMonth, AYear: Integer): Integer;
function DateToJulianDays(ADay, AMonth, AYear: Integer): integer;
procedure JulianDaysToDate(var ADay, AMonth, AYear: Integer; JulianDate:
  integer);
function ElDateTimeToSeconds(ADay, AMonth, AYear, AHours, AMinute, ASecond:
  integer): Cardinal;
procedure ElSecondsToDateTime(Seconds: Cardinal; var ADay, AMonth, AYear,
  AHours, AMinute, ASecond: integer);

function GetSysStartDayOfWeek: integer;

{$IFDEF MSWINDOWS}
procedure ElSystemTimeToTzSpecificLocalTime(lpTimeZoneInformation:
  PTimeZoneInformation;
  var lpUniversalTime: TSystemTime; var lpLocalTime: TSystemTime);
{procedure ElTZSpecificLocalTimeToSystemTime(lpTimeZoneInformation : PTimeZoneInformation;
  var lpUniversalTime : TSystemTime; var lpLocalTime : TSystemTime);{}
procedure UTCToZoneLocal(lpTimeZoneInformation: PTimeZoneInformation;
  lpUniversalTime: TSystemTime; var lpLocalTime: TSystemTime);
procedure ZoneLocalToUTC(lpTimeZoneInformation: PTimeZoneInformation;
  var lpUniversalTime: TSystemTime; lpLocalTime: TSystemTime);
{$ENDIF}

{$IFDEF MSWINDOWS}
function NowToUTC: TDateTime;
function ZoneIDtoBias(ZoneID: string): integer;
{$ENDIF}

{$IFNDEF D_2}
{$IFDEF MSWINDOWS}
function GetFormattedTimeString(ADate: TDateTime; const Format: string): string;
{$ENDIF}
{$ENDIF}
function DayNumber(AYear, AMonth, ADay: integer): integer;
function WeekNumber(AYear, AMonth, ADay: integer): integer;

function TimeInMask(const CronMask: string; T: TReducedDateTime): boolean;

{$IFDEF MSWINDOWS}

function GetSystemErrorMessage(ErrorCode : integer): string;

function GetShiftState: TShiftState;
function GetKeysState: integer;

{$IFNDEF D_2}
function SetPrivilege(const sPrivilegeName: string; bEnabled: boolean): boolean;
{$ENDIF}

type
  TMsgPumpRoutineEvent = procedure of object;
  TElWndMethod = procedure(var Message: TMessage) of object;

var
  OnMessagePump: TMsgPumpRoutineEvent;

function XAllocateHWND(Obj: TObject; WndMethod: TElWndMethod): HWND;
procedure XDeallocateHWND(Wnd: HWND);

 //???
function WindowExists(const ClassName, Caption: string; ExactMatch: boolean):
  HWND;
function TopWindowExists(const ClassName, Caption: string; ExactMatch: boolean):
  HWND;

{$ENDIF MSWINDOWS}

//function ProcessExists(Name : string) : THandle;

procedure PlaySound(Name: PChar; Flags1,
  Flags2: DWORD);

{$ifdef MSWINDOWS}
function DrivePresent(const DrivePath: string): Boolean;
{$endif}

{$IFDEF KYlIX_USED}
var
{$ELSE}
const
{$ENDIF}
  IsLinux: boolean = false;
  IsWin95: boolean = false;
  IsWinNT: boolean = false;
  IsWin2000: boolean = false;
  IsWinNTUp: boolean = false;
  IsWin2000Up: boolean = false;
  IsWinXP: boolean = false;
  IsWinXPUp: boolean = false;
  IsWin95OSR2: boolean = false;
  IsWin98: boolean = false;
  IsWinME: boolean = false;
  IsWin98Up: boolean = false;

{$IFDEF MSWINDOWS}
var
  LastWin: HWND; // the Result of last WindowExists or TopWindowExists call
  LastProcessID: DWORD; // the Result of last ProcessExists call
{$ENDIF}

const
  ElementFormatList: array[1..38] of string
  = ('D', 'DD', 'w', '', 'ww', 'W', 'd', 'dd',
    'm', 'mm', 'mmm', 'mmmm', 'y', 'yy',
    'n', 'nn', 'Y', 'YY', 'x', 'xx', 'h',
    'hh', 'H', 'HH', 'M', 'MM', 'S', 'SS',
    '', '', '', 'tt', '|', '''', '~', '.', ':', 'TT');

implementation

{$IFDEF MSWINDOWS}
 {todo: ??? It is necessary to test in release}
uses ShlObj;
{$ENDIF}


procedure PlaySound(Name: PChar; Flags1,
  Flags2: DWORD);
begin
{$IFDEF MSWINDOWS}
 {todo: ??? It is necessary to test in release}
  mmSystem.PlaySound(Name, Flags1, Flags2);
{$ELSE}

{$ENDIF MSWINDOWS}
end;

function swapInt16(w: word): Word;
begin
  Result := (w shl 8) or (w shr 8);
end;

function swapInt32(i: integer): integer;
begin
  Result := (i shr 24) or (((i and $FF0000) shr 16) shl 8) or
    (((i and $FF00) shr 8) shl 16) or ((i and $FF) shl 24);
end;


{$IFNDEF VCL_4_USED}
type
  Int64Rec = packed record
    Lo, Hi: DWORD;
  end;
{$ENDIF}

type
  PInt64Rec = ^Int64Rec;

 //of: {$ifndef CLR}

function SwapDouble(d: double): double;
var
  pd, pd1: PInt64Rec;
begin
  pd := @d;
  pd1 := @Result;
  pd1.Lo := SwapInt32(pd.hi);
  pd1.hi := SwapInt32(pd.lo);
end;


{$WARNINGS off}

function GetSysStartDayOfWeek: integer;
var
  LS: string;
const
  LOCALE_IFIRSTDAYOFWEEK = $0000100C;
begin
{$IFDEF MSWINDOWS}
  LS := GetLocaleStr(LOCALE_USER_DEFAULT, LOCALE_IFIRSTDAYOFWEEK, '0');
{$ELSE}
  LS := '';
{$ENDIF}
  Result := StrToIntDef(LS, 0) + 1;
  if Result = 7 then
    Result := 0;
end;
{$WARNINGS on}

function GetTime(DateTime: TDateTime): TDateTime;
begin
  Result := DateTime - Trunc(DateTime);
end;

{$IFDEF MSWINDOWS}

function GetCommonAppDataFolder: string;
const
  CSIDL_COMMON_APPDATA = $0023;
  CSIDL_COMMON_DOCUMENTS = $002E;
var
  Buf1, Buf2: array[0..MAX_PATH] of char;
begin
  Result := GetSpecialFolder(CSIDL_COMMON_APPDATA);
  if Length(Result) = 0 then
    Result := GetSpecialFolder(CSIDL_COMMON_DOCUMENTS);
  if Result = '' then
    Result := ExtractFilePath(ParamStr(0));
  StrPCopy(Buf1, Result);
  ExpandEnvironmentStrings(Buf1, Buf2, MAX_PATH);
  Result := IncludeTrailingBackslash2(StrPas(Buf2));
end;
{$ENDIF MSWINDOWS}

{$IFDEF MSWINDOWS}

function GetUserAppDataFolder: string;
const
  CSIDL_LOCAL_APPDATA = $001C;
  CSIDL_PERSONAL = $0005;
  CSIDL_APPDATA = $001A;
var
  Buf1, Buf2: array[0..MAX_PATH] of char;
begin
  Result := GetSpecialFolder(CSIDL_APPDATA);
  if Length(Result) = 0 then
    Result := GetSpecialFolder(CSIDL_PERSONAL);
  if Result = '' then
    Result := ExtractFilePath(ParamStr(0));
  StrPCopy(Buf1, Result);
  ExpandEnvironmentStrings(Buf1, Buf2, MAX_PATH);
  Result := IncludeTrailingBackslash2(StrPas(Buf2));
end;
{$ELSE}

function GetUserAppDataFolder: string;
begin
  Result := IncludeTrailingBackslash2(GetEnv('HOME'));
end;
{$ENDIF}

{$IFDEF MSWINDOWS}

function GetUserLocalAppDataFolder: string;
const
  CSIDL_LOCAL_APPDATA = $001C;
  CSIDL_PERSONAL = $0005;
  CSIDL_APPDATA = $001A;
begin
  Result := GetSpecialFolder(CSIDL_LOCAL_APPDATA);
  if Length(Result) = 0 then
    Result := GetSpecialFolder(CSIDL_APPDATA);
  if Length(Result) = 0 then
    Result := GetSpecialFolder(CSIDL_PERSONAL);
  if Result = '' then
    Result := ExtractFilePath(ParamStr(0));
  Result := IncludeTrailingBackslash2(Result);
end;
{$ELSE}

function GetUserLocalAppDataFolder: string;
begin
  Result := GetEnv('HOME');
end;
{$ENDIF MSWINDOWS}

{$IFDEF MSWINDOWS}

function GetSpecialFolder(const CSIDL: integer): string;
var
  ShellMalloc: IMalloc;
  ItemIDList: PItemIDList;
  Buffer: PChar;
begin
  Result := '';
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then
  begin
    Buffer := ShellMalloc.Alloc(MAXPATHLEN + 1);
    try
      if Succeeded(SHGetSpecialFolderLocation(0, CSIDL, ItemIDList)) then
      begin
        ShGetPathFromIDList(ItemIDList, Buffer);
        ShellMalloc.Free(ItemIDList);
        Result := Buffer;
      end;
    finally
      ShellMalloc.Free(Buffer);
    end;
  end;
end;
{$ENDIF MSWINDOWS}

function IncludeTrailingBackslash2(Path: string): string;
begin
  Result := Path;
{$IFNDEF D_2}
  if (Result <> '') and not (AnsiLastChar(Result)^ in ['\', '/']) then
{$ELSE}
  if (Result <> '') and not (Result[Length(Result)] in ['\', '/']) then
{$ENDIF}
{$IFDEF MSWINDOWS}
    Result := Result + '\';
{$ELSE}
    Result := Result + '/';
{$ENDIF}
end;

{$IFNDEF D_2}

function GetTempFile(SDir: string): string;
var
{$IFDEF MSWINDOWS}
  uuid: TGUID;
  SUuidW: WideString;
  SUuid: string;
{$ELSE}
  i: integer;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  if Length(SDir) = 0 then
  begin
    SetLength(SDir, MAX_PATH + 1);
    GetTempPath(MAX_PATH, PChar(SDir));
    SDir := IncludeTrailingBackslash2(StrPas(PChar(SDir)));
  end;
  CoCreateGuid(uuid);
  SetLength(SUuidW, 39);
  StringFromGUID2(uuid, PWideChar(SUuidW), Length(SUuidW));
  SUuid := SUuidW;
  SUuid := Trim(SUuid);
  SUuid := Copy(SUuid, 2, Length(SUuid) - 2);
  Result := AnsiLowerCaseFileName(SDir + SUuid);
    {
      SetLength(Result, MAX_PATH + 1);
      GetTempFileName(PChar(SDir), 'atp', 0, PChar(Result));
    }
{$ELSE}
  i := 0;
  while i < MaxInt do
  begin
    SDir := '/tmp/' + 'eltmpfl' + IntToStr(i);
    if not FileExists(Sdir) then
    begin
      Result := SDir;
      exit;
    end;
  end;
{$ENDIF}
end;
{$ENDIF}

constructor TNamedFileStream.Create(const FileName: string; Mode: Word);
begin
  inherited;
  FFileName := FileName;
end;

function TimeInMask(const CronMask: string; T: TReducedDateTime): boolean;

  function InPart(const S: string; Value: integer): boolean;
  var
    s1, s2: string;
  begin
    if s = '*' then
      Result := true
    else
    begin
      s1 := s;
      while pos(',', s1) > 0 do
      begin
        s2 := copy(s1, 1, pos(',', s1) - 1);
        delete(s1, 1, pos(',', s1));
        Result := s2 = IntToStr(value);
        if Result then exit;
      end;
      Result := s1 = IntToStr(value);
    end;
  end;

begin
  Result := false;
  if not InPart(ExtractWord(CronMask, 1), T.Min) then exit;
  if not InPart(ExtractWord(CronMask, 2), T.Hour) then exit;
  if not InPart(ExtractWord(CronMask, 3), T.Day) then exit;
  if not InPart(ExtractWord(CronMask, 4), T.DOW) then exit;
  if not InPart(ExtractWord(CronMask, 5), T.Month) then exit;
  Result := true;
end;

{$IFDEF MSWINDOWS}

function GetSystemDir: string;
begin
  SetLength(Result, MAXPATHLEN + 1);
  GetSystemDirectory(PChar(Result), MAXPATHLEN);
  SetLength(Result, StrLen(PChar(Result)));
  Result := IncludeTrailingBackslash2(Result);
end;

function GetShortPath(const Path: string): string;
begin
  SetLength(Result, MAXPATHLEN + 1);
  GetShortPathName(PChar(Path), PChar(Result), MAXPATHLEN);
end;

function GetTempDir: string;
{$IFDEF MSWINDOWS}
var
  SDir: string;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
    // behaviour changed because GetTempFile
    // in previous edition always returns
    // one 'acp0000'-coded name.
    //
    // Now it returns unique name.
  SetLength(SDir, MAX_PATH + 1);
  GetTempPath(MAX_PATH, PChar(SDir));
  Result := IncludeTrailingBackslash2(StrPas(PChar(SDir)));
{$ELSE}
  Result := '/tmp/';
{$ENDIF}
end;

function GetWindowsDir: string;
begin
  SetLength(Result, MAXPATHLEN + 1);
  GetWindowsDirectory(PChar(Result), MAXPATHLEN);
  Result := IncludeTrailingBackslash2(Result);
end;
{$ENDIF}

{$IFNDEF D_2}
{$IFDEF MSWINDOWS}

function GetFormattedTimeString(ADate: TDateTime; const Format: string): string;

  function DefDateSeparator: string;
  {$IFDEF MSWINDOWS}
  var
    S: string;
  {$ENDIF}
  begin
{$IFDEF MSWINDOWS}
    SetLength(S, 255);
    GetLocaleInfo(GetThreadLocale, LOCALE_SDATE, PChar(S), 254);
    SetLength(S, StrLen(PChar(S)));
    Result := S;
{$ELSE}
    Result := '/';
{$ENDIF}
  end;

  function DefTimeSeparator: string;
  {$IFDEF MSWINDOWS}
  var
    S: string;
  {$ENDIF}
  begin
{$IFDEF MSWINDOWS}
    SetLength(S, 255);
    GetLocaleInfo(GetThreadLocale, LOCALE_STIME, PChar(S), 254);
    SetLength(S, StrLen(PChar(S)));
    Result := S;
{$ELSE}
    Result := ':';
{$ENDIF}
  end;

{$IFDEF MSWINDOWS}

  function LongDateToStr(var ST: TSystemTime): string;
{$ELSE}

  function LongDateToStr(ST: TDateTime): string;
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  var
    S: string;
  {$ENDIF MSWINDOWS}
  begin
{$IFDEF MSWINDOWS}
    SetLength(S, 255);
    GetDateFormat(GetThreadLocale, LOCALE_NOUSEROVERRIDE or DATE_LONGDATE, @ST,
      nil, PChar(S), 254);
    SetLength(S, StrLen(PChar(S)));
    Result := S;
{$ELSE}
    Result := FormatDateTime(LongDateFormat, ST);
{$ENDIF MSWINDOWS}
  end;

{$IFDEF MSWINDOWS}

  function LongTimeToStr(var ST: TSystemTime): string;
  var
    S: string;
    F: string;
    s1: string;
    ff: integer;
{$ELSE}

  function LongTimeToStr(ST: TDateTime): string;
  {$ENDIF}
  begin
{$IFDEF MSWINDOWS}
    SetLength(S, 255);
    GetLocaleInfo(GetThreadLocale, LOCALE_ITIME, PChar(S), 254);
    SetLength(S, StrLen(PChar(S)));
    s1 := DefTimeSeparator;
    ff := 0;
    if StrToIntDef(S, 0) = 0 then
      F := 'hh' + s1 + 'mm' + s1 + 'ss tt'
    else
    begin
      F := 'HH' + s1 + 'mm' + s1 + 'ss';
      ff := TIME_FORCE24HOURFORMAT;
    end;
    SetLength(S, 255);
    GetTimeFormat(GetThreadLocale, ff, @ST, PChar(F), PChar(S), 254);
    SetLength(S, StrLen(PChar(S)));
    Result := S;
{$ELSE}
    Result := FormatDateTime(LongTimeFormat, ST);
{$ENDIF MSWINDOWS}
  end;

  function GetAMPMSign(Period: integer): string;
  {$IFDEF MSWINDOWS}
  var
    S: string;
  {$ENDIF}
  begin
{$IFDEF MSWINDOWS}
    SetLength(S, 255);
    if Period = 0 then
      GetLocaleInfo(GetThreadLocale, LOCALE_S1159, PChar(S), 254)
    else
      GetLocaleInfo(GetThreadLocale, LOCALE_S2359, PChar(S), 254);
    SetLength(S, StrLen(PChar(S)));
    Result := S;
{$ELSE}
    if Period = 0 then
      Result := 'am'
    else
      Result := 'pm';
{$ENDIF MSWINDOWS}
  end;

var
  S1, S2, S3, S4: string;
  i: integer;
  Dt: TDateTime;
  ST: TSystemTime;
begin
  S1 := Format;
  S2 := '';
  i := 1;
  S4 := S1;
  DT := ADate;
  DateTimeToSystemTime(DT, ST);
  ST.wDayOfWeek := DayOfWeek(DT) - 1;
  while i <= Length(S1) do
  begin
    if S1[i] = '''' then
    begin
      if (i < Length(S1)) and (S1[i + 1] = '''') then
      begin
        S2 := S2 + '''';
        inc(i);
      end
      else
      begin
        inc(i);
        while (i <= Length(S1)) do
        begin
          if S1[i] = '''' then break;
          S2 := S2 + S1[i];
          inc(i);
        end;
      end;
    end
    else
      if S1[i] = '~' then
      S2 := S2 + #9
    else
      if S1[i] = ':' then
      S2 := S2 + DefTimeSeparator
    else
      if S1[i] = '.' then
      S2 := S2 + DefDateSeparator
    else
      if S1[i] = '|' then
      S2 := S2 + #13#10
    else
      if Pos('nn', S4) = 1 then
    begin
      S3 := IntToStr(DayNumber(ST.wYear, ST.wMonth, ST.wDay));
      while Length(S3) < 3 do
        S3 := '0' + S3;
      S2 := S2 + S3;
      inc(i);
    end
    else
      if S1[i] = 'n' then
      S2 := S2 + IntToStr(DayNumber(ST.wYear, ST.wMonth, ST.wDay))
    else
      if Pos('YY', S4) = 1 then
    begin
      S3 := IntToStr(WeekNumber(ST.wYear, ST.wMonth, ST.wDay));
      if Length(S3) = 1 then S3 := '0' + S3;
      S2 := S2 + S3;
      inc(i);
    end
    else
      if S1[i] = 'Y' then
      S2 := S2 + IntToStr(WeekNumber(ST.wYear, ST.wMonth, ST.wDay))
    else
      if Pos('yy', S4) = 1 then
    begin
      S2 := S2 + IntToStr(ST.wYear);
      inc(i);
    end
    else
      if S1[i] = 'y' then
      S2 := S2 + IntToStr(ST.wYear mod 100)
    else
      if Pos('mmmm', S4) = 1 then
    begin
      S2 := S2 + LongMonthNames[ST.wMonth];
      inc(i, 3);
    end
    else
      if Pos('mmm', S4) = 1 then
    begin
      S2 := S2 + ShortMonthNames[ST.wMonth];
      inc(i, 2);
    end
    else
      if Pos('mm', S4) = 1 then
    begin
      S3 := IntToStr(ST.wMonth);
      if Length(S3) = 1 then S3 := '0' + S3;
      S2 := S2 + S3;
      inc(i);
    end
    else
      if S1[i] = 'm' then
      S2 := S2 + IntToStr(ST.wMonth)
    else
      if Pos('TT', S4) = 1 then
    begin
      S2 := S2 + Uppercase(GetAMPMSign(ST.wHour div 12));
      inc(i);
    end
    else
      if Pos('tt', S4) = 1 then
    begin
      S2 := S2 + Lowercase(GetAMPMSign(ST.wHour div 12));
      inc(i);
    end
    else
      if Pos('ww', S4) = 1 then
    begin
      S2 := S2 + LongDayNames[ST.wDayOfWeek + 1];
      inc(i);
    end
    else
      if S1[i] = 'w' then
      S2 := S2 + ShortDayNames[ST.wDayOfWeek + 1]
    else
      if S1[i] = 'W' then
      S2 := S2 + IntToStr(ST.wDayOfWeek)
    else
      if Pos('hh', S4) = 1 then
    begin
      if (ST.wHour = 0) or (ST.wHour = 12) then
        S3 := '12'
      else
        S3 := IntToStr(ST.wHour mod 12);
      if Length(S3) = 1 then S3 := '0' + S3;
      S2 := S2 + S3;
      inc(i);
    end
    else
      if S1[i] = 'h' then
    begin
      if (ST.wHour = 0) or (ST.wHour = 12) then
        S2 := S2 + '12'
      else
        S2 := S2 + IntToStr(ST.wHour mod 12);
    end
    else
      if Pos('HH', S4) = 1 then
    begin
      S3 := IntToStr(ST.wHour);
      if Length(S3) = 1 then S3 := '0' + S3;
      S2 := S2 + S3;
      inc(i);
    end
    else
      if S1[i] = 'H' then
      S2 := S2 + IntToStr(ST.wHour)
    else
      if Pos('MM', S4) = 1 then
    begin
      S3 := IntToStr(ST.wMinute);
      if Length(S3) = 1 then S3 := '0' + S3;
      S2 := S2 + S3;
      inc(i);
    end
    else
      if S1[i] = 'M' then
      S2 := S2 + IntToStr(ST.wMinute)
    else
      if Pos('SS', S4) = 1 then
    begin
      S3 := IntToStr(ST.wSecond);
      if Length(S3) = 1 then S3 := '0' + S3;
      S2 := S2 + S3;
      inc(i);
    end
    else
      if S1[i] = 'S' then
      S2 := S2 + IntToStr(ST.wSecond)
    else
      if Pos('dd', S4) = 1 then
    begin
      S3 := IntToStr(ST.wDay);
      if Length(S3) = 1 then S3 := '0' + S3;
      S2 := S2 + S3;
      inc(i);
    end
    else
      if S1[i] = 'd' then
      S2 := S2 + IntToStr(ST.wDay)
    else
      if Pos('xx', S4) = 1 then
    begin
      S2 := S2 + LongTimeToStr(ST);
      inc(i);
    end
    else
      if S1[i] = 'x' then
      S2 := S2 + TimeToStr(DT)
    else
      if Pos('DD', S4) = 1 then
    begin
      S2 := S2 + LongDateToStr(ST);
      inc(i);
    end
    else
      if S1[i] = 'D' then
      S2 := S2 + DateToStr(DT)
    else
    begin
      S2 := S2 + S1[i];
    end;
    inc(i);
    S4 := Copy(S1, i, Length(S1));
  end;
  Result := S2;
end;
{$ENDIF MSWINDOWS}
{$ENDIF} //of: {$ifndef D_2}

function DayNumber(AYear, AMonth, ADay: integer): integer;
var
  i: integer;
begin
  Result := 0;
  for i := 1 to AMonth - 1 do
    Inc(Result, DaysPerMonth(AYear, i));
  Inc(Result, ADay);
end;

function WeekNumber(AYear, AMonth, ADay: integer): integer;
var
  FirstDay, FirstMonday, YearOffset: integer;
begin
  YearOffset := DayNumber(AYear, AMonth, ADay);
  FirstDay := ElDayOfWeek(1, 1, AYear);
  Dec(FirstDay);
  if FirstDay = 0 then
    FirstDay := 7;
  if FirstDay = 1 then
    FirstMonday := 1
  else
    FirstMonday := 9 - FirstDay;
  if (AMonth = 1) and (ADay < FirstMonday) then
    if FirstDay <= 4 then
      Result := 1
    else
      Result := WeekNumber(AYear - 1, 12, 31)
  else
  begin
    Result := ((YearOffset - FirstMonday) div 7) + 1;
    if (FirstDay <= 4) and (FirstDay > 1) then Inc(Result);
  end;
end;

function ExtractTime(ATime: TDateTime): TDateTime;
begin
  Result := Frac(ATime);
end;

function ExtractDate(ATime: TDateTime): TDateTime;
begin
  Result := Trunc(ATime);
end;

function IncTime(ATime: TDateTime; Hours, Minutes, Seconds, MSecs: Integer):
  TDateTime;
begin
  Result := ATime + (Hours div 24) + (((Hours mod 24) * 3600000 +
    Minutes * 60000 + Seconds * 1000 + MSecs) / MSecsPerDay);
end;

function ScaleRectToRect(RectSrc, RectDest: TRect): TRect;
var
  DiffH, DiffV: integer;
begin
  DiffH := (RectSrc.Right - RectSrc.Left) - (RectDest.Right - RectDest.Left);
  DiffV := (RectSrc.Bottom - RectSrc.Top) - (RectDest.Bottom - RectDest.Top);
  if DiffH > DiffV then
  begin
    CenterRects(
      RectDest.Right - RectDest.Left,
      RectDest.Right - RectDest.Left,
      MulDiv((RectSrc.Bottom - RectSrc.Top), (RectDest.Right - RectDest.Left),
        (RectSrc.Right - RectSrc.Left)),
      RectDest.Bottom - RectDest.Top,
      Result
      );
    OffsetRect(Result, RectDest.Left, RectDest.Top);
  end
  else
  begin
    CenterRects(
      MulDiv((RectSrc.Right - RectSrc.Left), (RectDest.Bottom - RectDest.Top),
        (RectSrc.Bottom - RectSrc.Top)),
      RectDest.Right - RectDest.Left,
      RectDest.Bottom - RectDest.Top,
      RectDest.Bottom - RectDest.Top,
      Result
      );
    OffsetRect(Result, RectDest.Left, RectDest.Top);
  end;
end;

procedure CenterRects(WS, WT, HS, HT: integer; var R: TRect);
begin
  R.Left := max(WT div 2 - WS div 2, 0);
  R.Right := min(R.Left + WS - 1, WT + R.Left - 1); //changed line
  R.Top := max(HT div 2 - HS div 2, 0);
  R.Bottom := min(R.Top + HS - 1, HT + R.Top - 1); //changed line
end;

const
//bin2b64 : string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  bin2uue: string =
    '`!"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_';



function ReadTextFromStream(S: TStream; var Data: string): boolean;
var
  b: boolean;
  cs, cp, rr: integer;
  p: PChar;
begin
  cs := 256;
  cp := 0;
  Data := '';
  b := false;
  Result := false;
  while not b do
  begin
    SetLength(Data, cp + cs);
    p := PChar(Data);
    inc(p, cp);
    rr := S.Read(p^, cs);
    if rr <> cs then
    begin
      b := true;
      SetLength(Data, cp + rr);
    end;
    if (Pos(#13#10, Data) > 0) then
    begin
      b := true;
      Result := true;
      SetLength(Data, cp + rr);
      rr := rr - Pos(#13#10, StrPas(p)) - 1;
      S.Seek(-rr, soFromCurrent);
      SetLength(Data, Length(Data) - rr - 2);
    end
    else
      inc(cp, cs);
  end;
end;

procedure WriteTextToStream(S: TStream; Data: string);
var
  i: integer;
begin
  i := Length(Data);
  if (i < 2) or (not ((Data[i - 2] = #13) and (Data[i - 1] = #10))) then
    Data := Data + #13#10;
  S.Write(PChar(Data)^, Length(Data));
end;

function encode_line(const buf; size: integer): string;
type
  ta_8u = packed array[0..65530] of byte;
var
  buff: ta_8u absolute buf;
  offset: shortint;
  pos1, pos2: byte;
  i: byte;
  out: string;
begin
  setlength(out, size * 4 div 3 + 4);
  fillchar(out[1], size * 4 div 3 + 2, #0); (* worst case *)
  offset := 2;
  pos1 := 0;
  pos2 := 2;
  out[pos2] := #0;
  while pos1 < size do
  begin
    if offset > 0 then
    begin
      out[pos2] := char(ord(out[pos2]) or ((buff[pos1] and ($3F shl offset)) shr
        offset));
      offset := offset - 6;
      inc(pos2);
      out[pos2] := #0;
    end
    else
      if offset < 0 then
    begin
      offset := abs(offset);
      out[pos2] := char(ord(out[pos2]) or ((buff[pos1] and ($3F shr offset)) shl
        offset));
      offset := 8 - offset;
      inc(pos1);
    end
    else
    begin
      out[pos2] := char(ord(out[pos2]) or ((buff[pos1] and $3F)));
      inc(pos2);
      inc(pos1);
      out[pos2] := #0;
      offset := 2;
    end;
  end;
  if offset = 2 then dec(pos2);
  for i := 2 to pos2 do
    out[i] := bin2uue[ord(out[i]) + 1];
  encode_line := copy(out, 1, pos2);
end;
 //of: {$ifndef CLR}

function FileNameValid(const FileName: string): boolean;
var
  i: integer;
  Ch: Char;
const
  UnsafeChars = ['/', '\', '>', '<', ':', '"', '|', '?', '*'];
begin
  Result := false;
  for i := Length(FileName) downto 1 do // Iterate
  begin
    Ch := FileName[i];
    if (Ord(Ch) < 32) or (AnsiChar(Ch) in UnsafeChars) then
      exit;
  end; // for i
  Result := true;
end;

{$IFDEF VCL_4_USED}

function GetFileSize(const FileName: string): Int64;
var
{$IFDEF MSWINDOWS}
  Handle: THandle;
  FindData: TWin32FindData;
{$ELSE}
  astat: TStatBuf;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  Handle := FindFirstFile(PChar(FileName), FindData);
  if Handle <> INVALID_HANDLE_VALUE then
  begin
    Windows.FindClose(Handle);
    if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
    begin
      Int64Rec(Result).Lo := FindData.nFileSizeLow;
      Int64Rec(Result).Hi := FindData.nFileSizeHigh;
      Exit;
    end;
  end;
  Result := -1;
{$ELSE}
  if (stat(PChar(FileName), astat) = 0) then
    Result := astat.st_size
  else
    Result := -1;
{$ENDIF}
end;
{$ELSE}

function GetFileSize(const FileName: string): Integer;
var
  SearchRec: TSearchRec;
begin
  if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec) = 0 then
    Result := SearchRec.Size
  else
    Result := -1;
  FindClose(SearchRec);
end;
{$ENDIF}

function FileDateTime(const FileName: string): TDateTime;
var
  Age: Integer;
begin
  Age := FileAge(FileName);
  if Age = -1 then
    Result := 0
  else
    Result := FileDateToDateTime(Age);
end;

function CreateFile(const FileName: string): boolean;
var
  S: TFileStream;
begin
  if not FileExists(FileName) then
  begin
    try
      S := TFileStream.Create(FileName, fmCreate or fmShareDenyNone);
      S.Free;
      Result := true;
    except
      Result := false;
    end;
  end
  else
    Result := true;
end;

function EnsureDirExists(RootName: string; const DirName: string): Boolean;
begin
  result := true;

  if (Length(RootName) > 0) and (AnsiChar(RootName[Length(RootName)]) in ['\',
    '/']) then
    Delete(RootName, Length(RootName), 1);

  if RootName <> '' then
    if not DirExists(AppendSlash(RootName)) then
      result := EnsureDirExists(ExtractFilePath(RootName),
        ExtractFileName(RootName));
  if Result then
  begin
    RootName := AppendSlash(RootName);
    if (DirName <> '') and (not DirExists(RootName + DirName)) then
      result := CreateDir(RootName + DirName);
  end;
end;

{$ifndef ELPACK_SINGLECOMP}
function EnsureValidFileName(const PathName, FileName: string): string;
var
  pn: string;
begin
  pn := AppendSlash(PathName);
  Result := pn + FileName;
  if not FileExists(Result) then
  begin
    if not CreateFile(Result) then
      Result := pn + GetTempFile(pn) + IntToStr(CrcStr(FileName)) + ExtractFileExt(FileName)
    else
      DeleteFile(Result);
  end;
end;
{$endif}

function DirExists(DirName: string): boolean;
var
  SRec: TSearchRec;
begin
  Result := false;

  {$IFDEF MSWINDOWS}
  if Length(DirName) = 3 then
  begin
    result := DrivePresent(DirName);
    exit;
  end
  else
  {$ENDIF}
    if (Length(DirName) > 3) and (AnsiChar(DirName[Length(DirName)]) in ['\',
      '/']) then
    Delete(DirName, Length(DirName), 1);

  if FindFirst(DirName, faAnyFile, SRec) = 0 then
  begin
    if (SRec.Attr and faDirectory) > 0 then Result := true;
  end;
  SysUtils.FindClose(SRec);
end;

function ReplaceExt(const FileName, NewExt: string): string;
var
  i, j, l: integer;
begin
  j := length(FileName);
  i := length(ExtractFileExt(FileName));
  if (j = 0) then
  begin
    result := '';
    exit;
  end;
  l := length(NewExt);
  SetLength(Result, j - i + l);
  Move(FileName[1], Result[1], j - i);
  if l > 0 then
    Move(NewExt[1], Result[j - i + 1], l);
end;

{$WARNINGS off}

function PurgeDir(DirName: string): boolean;
var
  SRec: TSearchRec;
begin
  Result := false;
  DirName := AppendSlash(DirName);
  if FindFirst(DirName + '*.*', faAnyFile, SRec) = 0 then
  try
    repeat
      if (SRec.Attr and faDirectory) <> faDirectory then
      begin
        if not DeleteFile(DirName + SRec.FindData.cFileName) then
          exit;
      end
      else
      begin
        if not PurgeDir(DirName + SRec.FindData.cFileName) or
        not RemoveDirectory(PChar(DirName + SRec.FindData.cFileName))
 then
          exit;
      end;
    until FindNext(SRec) <> 0;
  finally
    SysUtils.FindClose(SRec);
  end;
  Result := true;
end;
{$WARNINGS on}

function RunProgram(StartName: string; const Params, StartDir: string): THandle;
{$IFDEF MSWINDOWS}
var
  CrFlags: DWORD;
  CurDir: PChar;
  AppName: PChar;
  FParams: PChar;
  s: string;
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  res: boolean;
{$ENDIF}

begin
{$IFDEF MSWINDOWS}
  if Pos(' ', StartName) > 0 then
    StartName := '"' + StartName + '"';

  s := StartName + #32 + Params;
  AppName := nil;

  GetMem(FParams, Length(S) + 1);
  StrPCopy(FParams, s);
  GetMem(CurDir, Length(StartDir) + 1);
  s := StartDir;
  StrPCopy(CurDir, s);
    // Set process specific flags
  CrFlags := NORMAL_PRIORITY_CLASS + CREATE_DEFAULT_ERROR_MODE;
    // set Startup information
  FillMemory(@StartInfo, SizeOf(TStartupInfo), 0);
  with StartInfo do
  begin
    cb := SizeOf(TStartupInfo);
    lpDesktop := nil;
    lpTitle := nil;
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := SW_SHOW;
  end; // with
  res := CreateProcess(AppName, FParams, nil, nil, false, CrFlags, nil,
    CurDir, StartInfo, ProcInfo);
  FreeMem(FParams, 260);
  FreeMem(CurDir, 260);
  if AppName <> nil then FreeMem(AppName, 260);
  Result := INVALID_HANDLE_VALUE;
  if res then
  begin
    CloseHandle(ProcInfo.hThread);
    Result := ProcInfo.hProcess;
  end;
{$ELSE}
  Result := fork();
  if (Result = LongWord(-1)) then
    exit;
  if (Result = 0) then
  begin
    chdir(StartDir);
    execl('/bin/sh', 'sh', '-c', startname + ' ' + params, 0);
    exit;
  end;
{$ENDIF MSWINDOWS}
end;

procedure TDirectMemoryStream.SetPointer(Ptr: Pointer; Size: Longint);
begin
  inherited;
  Position := 0;
  if Ptr = nil then
    Capacity := 0;
end;

function MakeReducedDT(Year, Month, Day, DOW, Hour, Min: word):
  TReducedDateTime;
begin
  Result.Year := year;
  Result.month := month;
  Result.Day := day;
  Result.DOW := dow;
  Result.Hour := hour;
  Result.Min := min;
end;

{$IFDEF VER90}

function CompareMem(Var1, Var2: pointer; size: integer): boolean; assembler;
asm
  push    esi
  push    edi
  xor     eax,eax
  mov     esi, var1
  mov     edi, var2
  mov     ecx, size
  shr     ecx,2
  mov     edx, size
  and     edx,3
  repe    cmpsd
  jne     @@2
  mov     ecx,edx
  repe    cmpsb
  jne     @@2
@@1:
  inc     eax
@@2:
  pop     edi
  pop     esi
end;

{$ENDIF}

function CompareReducedDT(T1, T2: TReducedDateTime): boolean;
begin
  Result := CompareMem(@T1, @T2, SizeOf(TReducedDateTime));
end;

function DateTimeToReduced(T: TDateTime): TReducedDateTime;
var
  i, j: word;
begin
  DecodeDate(T, Result.Year, Result.Month, Result.Day);
  DecodeTime(T, Result.Hour, Result.Min, i, j);
  Result.DOW := SysUtils.DayOfWeek(T) - 1;
end;

function ReducedToDateTime(T: TReducedDateTime): TDateTime;
begin
  try
    Result := EncodeDate(T.Year, T.Month, T.Day) + EncodeTime(T.Hour, T.Min, 0,
      0);
  except
    on E: EConvertError do
    begin
      Result := Now;
    end;
  end;
end;

procedure DefineOS;
{$IFDEF MSWINDOWS}
var
  VerInfo: TOsVersionInfo;
begin
  VerInfo.dwOsVersionInfoSize := SizeOf(VerInfo);
  GetVersionEx(VerInfo);
  IsWin95 := VerInfo.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS;
  IsWin95OSR2 := (VerInfo.dwPlatformID = VER_PLATFORM_WIN32_WINDOWS) and
    (Loword(VerInfo.dwBuildNumber) >= 1000);
  IsWinNt := VerInfo.dwPlatformId = VER_PLATFORM_WIN32_NT;

  IsWin2000 := (VerInfo.dwPlatformId = VER_PLATFORM_WIN32_NT) and
    (VerInfo.dwMajorVersion >= 5);
  IsWinXP := (VerInfo.dwPlatformId = VER_PLATFORM_WIN32_NT) and
    (VerInfo.dwMajorVersion = 5) and (VerInfo.dwMinorVersion = 1);

  IsWin2000Up := IsWin2000 or IsWinXP;
  IsWinNTUp := IsWinNT or IsWin2000Up;

  IsWinXPUp := (VerInfo.dwPlatformId = VER_PLATFORM_WIN32_NT) and
    (VerInfo.dwMajorVersion >= 5) and (VerInfo.dwMinorVersion >= 1);

  IsWin98 := (VerInfo.dwPlatformID = VER_PLATFORM_WIN32_WINDOWS) and
    (VerInfo.dwMinorVersion > 0);
  IsWin98Up := IsWin98;

  IsWinME := (VerInfo.dwPlatformID = VER_PLATFORM_WIN32_WINDOWS) and
    (VerInfo.dwMinorVersion >= 90);

{$ELSE}
begin
  IsLinux := true;
{$ENDIF}
end;

function IsBIn;
begin
  Result := ((Storage shr (index - 1)) and 1) = 1;
end;

function Sign(a: integer): integer;
begin
  if a < 0 then
    Result := -1
  else
    if a > 0 then
    Result := 1
  else
    Result := 0;
end;

function InRangeF(L, R, x: double): boolean;
begin
  Result := not ((x < L) or (x > R));
end;

function InRange(L, R, x: integer): boolean;
begin
  Result := not ((x < L) or (x > R));
end;

function Max(a, b: integer): integer;
begin
  if a < b then
    Result := b
  else
    Result := a;
end;

function Min(a, b: integer): integer;
begin
  if a > b then
    Result := b
  else
    Result := a;
end;

{$IFNDEF VER90}
{$IFDEF MSWINDOWS}

function SubtractTimes(Time1, Time2: TDateTime): TDateTime;
var
  TT: TSystemTime;
  TFT1, TFT2, TFT3: TFileTime;
  h1, h2, l1, l2: integer;
begin
  begin
    DateTimeToSystemTime(Time1, TT);
    SystemTimeToFileTime(TT, TFT1);
    DateTimeToSystemTime(Time2, TT);
    SystemTimeToFileTime(TT, TFT2);
    h1 := TFT1.dwHighDateTime;
    h2 := TFT2.dwHighDateTime;
    l1 := TFT1.dwLowDateTime;
    l2 := TFT2.dwLowDateTime;
    if (h1 < h2) or
      ((h1 = h2) and (l1 < l2)) then
      Result := 0
    else
    begin
      asm
           push eax
           mov eax, l1
           cmp eax, l2
           jl @1
           mov eax, l1
           sub eax, l2
           sub eax, $FFFFFFFF
           mov TFT3.dwLowDateTime, eax
           jmp @2
          @1:
          mov eax, l1
          sub eax, l2
          mov TFT3.dwLowDateTime, eax
          @2:
           // subtracting high-order dwords
           mov eax, h1
           sub eax, h2
           mov TFT3.dwHighDateTime, eax
           pop eax
      end;
      FileTimeToSystemTime(TFT3, TT);
      TT.wYear := 299 + TT.wYear;
      Result := SystemTimeToDateTime(TT);
    end;
    exit;
  end;
end;
{$ENDIF MSWINDOWS}
{$ENDIF VER90}
 //of: {$ifndef CLR}

function RangesIntersect(L1, R1, L2, R2: integer): boolean;
begin
  Result := not ((Min(L1, R1) > Max(L2, R2)) or (Min(L2, R2) > Max(L1, R1)));
end;

function WriteStringToStream(S: TStream; const Str: string): boolean;
var
  i: integer;
begin
  i := Length(Str);
  try
    S.WriteBuffer(i, sizeof(integer));
    if i > 0 then
      S.WriteBuffer(Str[1], i);
    Result := true;
  except
    Result := false;
  end;
end;

function ReadStringFromStream(S: TStream; var Str: string): boolean;
var
  SS: string;
  i: integer;
begin
  i := Length(Str);
  try
    S.ReadBuffer(i, sizeof(integer));
    if i < 0 then
      raise Exception.Create('Invalid string header read from the stream');
    if i = 0 then
      Str := ''
    else
    begin
      SetLength(SS, i);
      S.ReadBuffer(SS[1], i);
      Str := SS;
    end;
    Result := true;
  except
    Result := false;
  end;
end;

{$IFNDEF BROKEN_UNICODE}

function WriteWideStringToStream(S: TStream; const Str: WideString): boolean;
var
  i: integer;
begin
  i := Length(Str);
  try
    S.WriteBuffer(i, sizeof(integer));
    if i > 0 then
      S.WriteBuffer(Str[1], i * sizeof(WideChar));
    Result := true;
  except
    Result := false;
  end;
end;

function ReadWideStringFromStream(S: TStream; var Str: WideString): boolean;
var
  SS: WideString;
  i: integer;
begin
  try
    S.ReadBuffer(i, sizeof(integer));
    if i < 0 then
      raise Exception.Create('Invalid string header read from the stream');
    if i = 0 then
      Str := ''
    else
    begin
      SetLength(SS, i);
      S.ReadBuffer(SS[1], i * sizeof(WideChar));
      Str := SS;
    end;
    Result := true;
  except
    Result := false;
  end;
end;
{$ENDIF} //of: {$ifndef BROKEN_UNICODE}

function WriteFStringToStream(S: TStream; const Str: TElFString): boolean;
begin
{$IFDEF ELPACK_UNICODE}
  Result := WriteWideStringToStream(S, Str);
{$ELSE}
  Result := WriteStringToStream(S, Str);
{$ENDIF}
end;

function ReadFStringFromStream(S: TStream; var Str: TElFString): boolean;
{$IFDEF ELPACK_UNICODE}
var
  S2: WideString;
begin
  Result := ReadWideStringFromStream(S, S2);
{$ELSE}
var
  S2: string;
begin
  Result := ReadStringFromStream(S, S2);
{$ENDIF}
  Str := S2;
end;

function IsLeapYear(AYear: Integer): Boolean;
begin
  Result := (AYear mod 4 = 0) and ((AYear mod 100 <> 0) or (AYear mod 400 = 0));
end;

const
  aDaysCentury = 15020;

function ElDateTimeToSeconds(ADay, AMonth, AYear, AHours, AMinute, ASecond:
  integer): Cardinal;
begin
  Result := (DateToJulianDays(ADay, AMonth, AYear) - aDaysCentury) * 86400;
  inc(Result, aHours * 3600 + AMinute * 60 + aSecond);
end;

procedure ElSecondsToDateTime(Seconds: Cardinal; var ADay, AMonth, AYear,
  AHours, AMinute, ASecond: integer);
var
  aDays: integer;
  aSecs: integer;
begin
  aDays := Seconds div 86400 + aDaysCentury;
  aSecs := Seconds mod 86400;
  JulianDaysToDate(ADay, AMonth, AYear, aDays);
  AHours := aSecs div 3600;
  AMinute := (aSecs - (AHours * 3600)) div 60;
  ASecond := aSecs mod 60;
end;

function DateToJulianDays(ADay, AMonth, AYear: Integer): integer;
var
  A, B: integer;
begin
  a := 10000 * Ayear + 100 * AMonth + ADay;
  if AMonth <= 2 then
  begin
    AMonth := AMonth + 12;
    AYear := AYear - 1;
  end;
  if a <= 15821004 then
    b := -2 + trunc((AYear + 4716) / 4) - 1179
  else
    b := trunc(AYear / 400) - trunc(AYear / 100) + trunc(AYear / 4);
  a := 365 * AYear - 679004;
  Result := a + b + trunc(30.6001 * (AMonth + 1)) + ADay;
end;

procedure JulianDaysToDate(var ADay, AMonth, AYear: Integer; JulianDate:
  integer);
var
  JD, b, c, d, e, f: integer;
begin
  JD := JulianDate + 2400001;
  if JD < 2299161 then
  begin
    c := JD + 1524;
  end
  else
  begin
    b := trunc((JD - 1867216.25) / 36524.25);
    c := JD + (b - trunc(b / 4)) + 1525;
  end;
  d := trunc((c - 122.1) / 365.25);
  e := 365 * d + trunc(d / 4);
  f := trunc((c - e) / 30.6001);
  ADay := trunc(c - e + 0.5) - trunc(f * 30.6001);
  AMonth := f - 1 - 12 * trunc(f / 14);
  AYear := D - 4715 - trunc((7 + AMonth) / 10);
end;

function ElDayOfWeek(ADay, AMonth, AYear: Integer): Integer;
begin
  if AMonth > 2 then
    inc(AMonth)
  else
  begin
    Inc(AMonth, 13);
    Dec(AYear);
  end;
  Result := trunc(365.25 * AYear) + trunc(30.6 * AMonth) + ADay - 621050;
  Result := Result - trunc(Result / 7) * 7 + 1;
  if Result = 7 then Result := 0;
  inc(Result);
end;

function DaysPerMonth(AYear, AMonth: Integer): Integer;
const
  DaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30,
    31, 30, 31);
begin
  Result := DaysInMonth[AMonth];
  if (AMonth = 2) and IsLeapYear(AYear) then
    Inc(Result); { leap-year Feb is special }
end;

function IncDate(ADate: TDateTime; Days, Months, Years: Integer): TDateTime;
var
  D, M, Y: Word;
  Day, Month, Year: Longint;
begin
  DecodeDate(ADate, Y, M, D);
  Year := Y;
  Month := M;
  Day := D;
  Inc(Year, Years);
  Inc(Year, Months div 12);
  Inc(Month, Months mod 12);
  if Month < 1 then
  begin
    Inc(Month, 12);
    Dec(Year);
  end
  else
    if Month > 12 then
  begin
    Dec(Month, 12);
    Inc(Year);
  end;
  if Day > DaysPerMonth(Year, Month) then Day := DaysPerMonth(Year, Month);
  Result := EncodeDate(Year, Month, Day) + Days + Frac(ADate);
end;

{$IFDEF VER90}

type
  PDayTable = ^TDayTable;
  TDayTable = array[1..12] of Word;

const
  MonthDays: array[Boolean] of TDayTable =
  ((31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31),
    (31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31));

function DoEncodeDate(Year, Month, Day: Word; var Date: TDateTime): Boolean;
var
  I: Integer;
  DayTable: PDayTable;
begin
  Result := False;
  DayTable := @MonthDays[IsLeapYear(Year)];
  if (Year >= 1) and (Year <= 9999) and (Month >= 1) and (Month <= 12) and
    (Day >= 1) and (Day <= DayTable^[Month]) then
  begin
    for I := 1 to Month - 1 do
      Inc(Day, DayTable^[I]);
    I := Year - 1;
    Date := I * 365 + I div 4 - I div 100 + I div 400 + Day - DateDelta;
    Result := True;
  end;
end;

function EncodeDate(Year, Month, Day: Word): TDateTime;
begin
  if not DoEncodeDate(Year, Month, Day, Result) then
    raise exception.Create('Invalid argument for date encode.');
end;

procedure DivMod(Dividend: Integer; Divisor: Word;
  var Result, Remainder: Word);
asm
        PUSH    EBX
        MOV     EBX,EDX
        MOV     EDX,EAX
        SHR     EDX,16
        DIV     BX
        MOV     EBX,Remainder
        MOV     [ECX],AX
        MOV     [EBX],DX
        POP     EBX
end;

procedure DecodeDate(Date: TDateTime; var Year, Month, Day: Word);
const
  D1 = 365;
  D4 = D1 * 4 + 1;
  D100 = D4 * 25 - 1;
  D400 = D100 * 4 + 1;
var
  Y, M, D, I: Word;
  T: Integer;
  DayTable: PDayTable;
begin
  T := DateTimeToTimeStamp(Date).Date;
  if T <= 0 then
  begin
    Year := 0;
    Month := 0;
    Day := 0;
  end
  else
  begin
    Dec(T);
    Y := 1;
    while T >= D400 do
    begin
      Dec(T, D400);
      Inc(Y, 400);
    end;
    DivMod(T, D100, I, D);
    if I = 4 then
    begin
      Dec(I);
      Inc(D, D100);
    end;
    Inc(Y, I * 100);
    DivMod(D, D4, I, D);
    Inc(Y, I * 4);
    DivMod(D, D1, I, D);
    if I = 4 then
    begin
      Dec(I);
      Inc(D, D1);
    end;
    Inc(Y, I);
    DayTable := @MonthDays[IsLeapYear(Y)];
    M := 1;
    while True do
    begin
      I := DayTable^[M];
      if D < I then Break;
      Dec(D, I);
      Inc(M);
    end;
    Year := Y;
    Month := M;
    Day := D + 1;
  end;
end;

procedure DateTimeToSystemTime(DateTime: TDateTime; var SystemTime:
  TSystemTime);
begin
  with SystemTime do
  begin
    DecodeDate(DateTime, wYear, wMonth, wDay);
    DecodeTime(DateTime, wHour, wMinute, wSecond, wMilliseconds);
  end;
end;

function SystemTimeToDateTime(const SystemTime: TSystemTime): TDateTime;
begin
  with SystemTime do
    Result := EncodeDate(wYear, wMonth, wDay) +
      EncodeTime(wHour, wMinute, wSecond, wMilliSeconds);
end;

{$ENDIF}

{$IFDEF MSWINDOWS}

function NowToUTC: TDateTime;
var
  ST: TSystemTime;
begin
  GetSystemTime(ST);
  Result := SystemTimeToDateTime(ST);
end;
{$ENDIF}

{$IFDEF MSWINDOWS}

procedure ToAbsoluteDate(aYear: integer; var ATime: TSystemTime);
var
  DayNum: integer;
  DIM: Integer;
begin
  ATime.wYear := aYear;
  if (ATime.wDay >= 1) and (ATime.wDay <= 4) then
  begin
    // get first day in month
    DayNum := SysUtils.DayOfWeek(EncodeDate(aTime.wYear, aTime.wMonth, 1));
    DayNum := aTime.wDayOfWeek - DayNum + 1; // get first dayInWeek in month
    if DayNum <= 0 then
      Inc(DayNum, 7);
    DayNum := DayNum + (ATime.wDay - 1) * 7;
      // get weekInMonth-th dayInWeek in month
    ATime.wDay := DayNum;
  end
  else
    if ATime.wDay = 5 then
  begin // last week, calculate from end of month
    DIM := DaysPerMonth(aTime.wYear, aTime.wMonth);
    // get last day in month
    dayNum := SysUtils.DayOfWeek(EncodeDate(aTime.wYear, aTime.wMonth, DIM));
    dayNum := DIM + (aTime.wDayOfWeek - dayNum);
    if dayNum > DIM then Dec(dayNum, 7); // get last dayInWeek in month
    ATime.wDay := DayNum;
  end;

(*  ATime.wYear := aYear;
  FirstDate := EncodeDate(ATime.wYear, ATime.wMonth, 1);
  FMonthOffset := 2 - ((DateTimeToTimeStamp(FirstDate).Date mod 7 + 8) mod 7); { day of week for 1st of month }
  if FMonthOffset = 2 then FMonthOffset := -5;
  DayNum := FMonthOffset + ATime.wDayOfWeek + (ATime.wDay) * 7;
  if (DayNum < 1) then inc(DayNum, 7);
  Dim := DaysPerMonth(ATime.wYear, ATime.wMonth);
  while (DayNum > Dim) do dec(DayNum, 7);
  ATime.wDay := DayNum;
  aTime.DayOfWeek := DayOfWeek(SystemTimetoDateTime(aTime));*)
end;

function IsInDaylightTime(lpTimeZoneInformation: TTimeZoneInformation;
  lpLocalTime: TSystemTime): boolean;
var
  TempTime1, TempTime2, TempTime3: TDateTime;
begin
  Result := false;
  if lpTimeZoneInformation.StandardDate.wMonth <> 0 then
  begin
    if lpTimeZoneInformation.StandardDate.wYear = 0 then
      ToAbsoluteDate(lpLocalTime.wYear, lpTimeZoneInformation.StandardDate);
    TempTime1 := SystemTimeToDateTime(lpTimeZoneInformation.StandardDate);

    if lpTimeZoneInformation.DaylightDate.wYear = 0 then
      ToAbsoluteDate(lpLocalTime.wYear, lpTimeZoneInformation.DaylightDate);
    TempTime2 := SystemTimeToDateTime(lpTimeZoneInformation.DaylightDate);

    TempTime3 := SystemTimeToDateTime(lpLocalTime);

    if TempTime2 < TempTime1 {Northern semisphere} then
      Result := (TempTime3 >= TempTime2) and (TempTime3 < TempTime1)
    else
      Result := not ((TempTime3 >= TempTime1) and (TempTime3 < TempTime2));
  end;
end;

procedure UTCToZoneLocal(lpTimeZoneInformation: PTimeZoneInformation;
  lpUniversalTime: TSystemTime; var lpLocalTime: TSystemTime);
var
  DTF: TDateTime;
begin
  MoveMemory(@lpLocalTime, @lpUniversalTime, sizeof(TSystemTime));

  DTF := IncTime(SystemTimeToDateTime(lpLocalTime), 0,
    -lpTimeZoneInformation.Bias, 0, 0);
  DateTimeToSystemTime(DTF, lpLocalTime);

  if not IsInDaylightTime(lpTimeZoneInformation^, lpLocalTime) then
    DTF := IncTime(DTF, 0, -lpTimeZoneInformation.StandardBias, 0, 0)
  else
    DTF := IncTime(DTF, 0, -lpTimeZoneInformation.DaylightBias, 0, 0);

  DateTimeToSystemTime(DTF, lpLocalTime);
end;

procedure ZoneLocalToUTC(lpTimeZoneInformation: PTimeZoneInformation;
  var lpUniversalTime: TSystemTime; lpLocalTime: TSystemTime);
var
  DTF: TDateTime;
begin
  MoveMemory(@lpUniversalTime, @lpLocalTime, sizeof(TSystemTime));
  DTF := IncTime(SystemTimeToDateTime(lpUniversalTime), 0,
    lpTimeZoneInformation.Bias, 0, 0);
  if not IsInDaylightTime(lpTimeZoneInformation^, lpLocalTime) then
    DTF := IncTime(DTF, 0, lpTimeZoneInformation.StandardBias, 0, 0)
  else
    DTF := IncTime(DTF, 0, lpTimeZoneInformation.DaylightBias, 0, 0);

  DateTimeToSystemTime(DTF, lpUniversalTime);
end;

procedure ElSystemTimeToTzSpecificLocalTime(lpTimeZoneInformation:
  PTimeZoneInformation;
  var lpUniversalTime: TSystemTime;
  var lpLocalTime: TSystemTime);
begin
  UTCToZoneLocal(lpTimeZoneInformation, lpUniversalTime, lpLocalTime);
end;
{$ENDIF}

function ZoneIDtoBias(ZoneID: string): integer;
const
  IDs: array[0..17] of string = ('NST', 'AST', 'ADT', 'EST', 'EDT',
    'CST', 'CDT', 'MST', 'MDT', 'PST',
    'PDT', 'YST', 'YDT', 'HST', 'HDT',
    'BST', 'BDT', 'GMT');

  biases: array[0..17] of integer = (210, 240, 180, 300, 240, 360, 300, 420,
    360,
    480, 420, 540, 480, 600, 540, 660, 600, 0);
var
  i: integer;
  aID: char;
begin
  ZoneID := Uppercase(ZoneID);
  Result := 0;
  if Length(ZoneID) = 0 then
  begin
    Result := 0;
    exit;
  end;
  if Length(ZoneID) = 1 then
  begin
    aID := ZoneID[1];
    case aID of
      'J', 'Z': Result := 0;
      'A'..'I',
        'K'..'M': Result := -(Ord(aID) - 64);
      'N'..'Y': Result := Ord(aID) - Ord('M');
    end;
  end
  else
    if AnsiChar(ZoneID[1]) in ['0'..'9'] then
  begin
    Result := StrToIntDef(Copy(ZoneID, 1, 2), 0) + StrToIntDef(Copy(ZoneID, 3,
      2), 0);
  end
  else
    if AnsiChar(ZoneID[1]) in ['+', '-'] then
  begin
    Result := StrToIntDef(Copy(ZoneID, 2, 2), 0) + StrToIntDef(Copy(ZoneID, 4,
      2), 0);
    if ZoneID[1] = '-' then Result := -Result;
  end
  else
  begin
    Result := 0;
    for i := 0 to 17 do
      if ZoneID = IDs[i] then
      begin
        Result := Biases[i];
        exit;
      end;
  end;
end;

{$IFDEF MSWINDOWS}
{$IFNDEF D_2}

function SetPrivilege(const sPrivilegeName: string; bEnabled: boolean): boolean;
var
  TPPrev,
    TP: TTokenPrivileges;
  Token: THandle;
  dwRetLen: DWord;
begin
  Result := False;
  OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
    Token);
  TP.PrivilegeCount := 1;
  if (LookupPrivilegeValue(nil, PChar(sPrivilegeName), TP.Privileges[0].LUID))
    then
  begin
    if (bEnabled) then
    begin
      TP.Privileges[0].Attributes :=
        SE_PRIVILEGE_ENABLED;
    end
    else
    begin
      TP.Privileges[0].Attributes :=
        0;
    end;
    dwRetLen := 0;
    Result := AdjustTokenPrivileges(
      Token,
      False,
      TP,
      SizeOf(TPPrev),
      TPPrev,
      dwRetLen);
  end;
  CloseHandle(Token);
end;
{$ENDIF} //of: {$ifndef D_2}

type
  PEnumWinRec = ^TEnumWinRec;
  TEnumWinRec = record
    WinFound: boolean;
    Count: integer;
    WinHandle: HWND;
    Caption: string;
    ClassName: string;
    Exact: boolean;
    TopWin: boolean;
  end;

  PEnumProcRec = ^TEnumProcRec;
  TEnumProcRec = record
    ModuleName: string;
    ModuleFound: boolean;
    ModuleID: integer;
  end;

function FindWinCallBack(WinHandle: HWND; Param: integer): boolean; stdcall;
var
  P: PChar;
  s: string;
  s1,
  s2: string;
  pr :DWORD;
begin
  GetMem(P, 256);
  SetLength(s, 256);
  if PEnumWinRec(Param)^.ClassName <> '' then
  begin
    GetClassName(WinHandle, P, 255);
    s1 := UpperCase(PEnumWinRec(Param)^.ClassName);
    s2 := UpperCase(P);
    if PEnumWinRec(Param)^.Exact then
      PEnumWinRec(Param)^.WinFound := s1 = s2
    else
    begin
      Result := true;
      PEnumWinRec(Param)^.WinFound := false;
      exit;
    end;
  end;

  if SendMessageTimeout(WinHandle, WM_GETTEXT, 255, Integer(P), SMTO_ABORTIFHUNG
    or SMTO_BLOCK, 100, pr) <> 0 then
  begin
    s := StrPas(P);

    s1 := UpperCase(PEnumWinRec(Param)^.Caption);
    s2 := UpperCase(P);
    if PEnumWinRec(Param)^.Exact then
      PEnumWinRec(Param)^.WinFound := s1 = s2
    else
      PEnumWinRec(Param)^.WinFound := Pos(s1, s2) > 0;
  end
  else
    PEnumWinRec(Param)^.WinFound := false;

  if PEnumWinRec(Param)^.WinFound then
    PEnumWinRec(Param)^.WinHandle := WinHandle;

  Result := not (PEnumWinRec(Param)^.WinFound);
  if Result and not PEnumWinRec(Param)^.TopWin then
  begin
    EnumChildWindows(WinHandle, @FindWinCallBack, Param);
    Result := not PEnumWinRec(Param).WinFound;
  end;

  inc(PEnumWinRec(Param)^.Count);
  FreeMem(P, 256);
end;

function WindowExists(const ClassName, Caption: string; ExactMatch: boolean):
  HWND;
var
  SRec: TEnumWinRec;
begin
  SRec.WinFound := false;
  SRec.Caption := Caption;
  SRec.ClassName := ClassName;
  SRec.Count := 0;
  SRec.WinHandle := 0;
  SRec.TopWin := false;
  SRec.Exact := ExactMatch;
  EnumWindows(@FindWinCallback, integer(@SRec));
  if SRec.WinFound then
  begin
    Result := SRec.WinHandle;
    LastWin := Result;
  end
  else
    Result := 0;
end;

function TopWindowExists(const ClassName, Caption: string; ExactMatch: boolean):
  HWND;
var
  SRec: TEnumWinRec;
  P: PChar;
begin
  if ExactMatch then
  begin
    if ClassName <> '' then
      P := nil
    else
      P := PChar(ClassName);
    LastWin := FindWindow(P, PChar(Caption));
    Result := LastWin;
  end
  else
  begin
    SRec.WinFound := false;
    SRec.Caption := Caption;
    SRec.ClassName := ClassName;
    SRec.Count := 0;
    SRec.WinHandle := 0;
    SRec.TopWin := true;
    EnumWindows(@FindWinCallback, integer(@SRec));
    if SRec.WinFound then
    begin
      Result := SRec.WinHandle;
      LastWin := Result;
    end
    else
      Result := 0;
  end;
end;
(*
function ProcessExists(Name : string) : THandle;
{$IFNDEF NT}
var
   hSnapshot: THandle;
   pe32: TProcessEntry32;
{$ELSE}
  var pidArray:array[0..1000] of Integer;
      mhArray:array[0..1000] of HMODULE;
      b:BOOL;
      i,j,pc,mc:Integer;
      ph:THandle;
      mn:array[0..1000] of char;
      SRec : TEnumProcRec;

      function EnumProc(dwThreadId:LongInt; hMod16,hTask16:Word;
               pszModName,pszFileName:PChar; lpUserDefined:LongInt):BOOL; stdcall;
      begin
        if UpperCase(ExtractFileName(StrPas(pszFileName)))=UpperCase(PEnumProcRec(lpUserDefined)^.ModuleName) then
        begin
          PEnumProcRec(lpUserDefined)^.ModuleFound:=true;
          PEnumProcRec(lpUserDefined)^.ModuleID := 0;
        end;
        Result:=True;
      end;
{$ENDIF}
begin
    LastProcessID := 0;
{$IFNDEF NT}
    hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    pe32.dwSize := sizeof(TProcessEntry32);
     // Walk the snapshot of the processes
    if Process32First(hSnapshot, pe32) then
      repeat
         if CompareText(ExtractFileName(pe32.szExeFile), PChar(Name)) = 0 then
         begin
           Result:=pe32.th32ProcessID;
           CloseHandle(hSnapshot);
           exit;
         end;
      until not Process32Next(hSnapshot, pe32);
      CloseHandle(hSnapshot);
    Result := 0;
{$ELSE}
  b:=EnumProcesses(PProcessIDArray(@pidArray),SizeOf(pidArray),pc);
  if not b then
  begin
    Result := 0;
    exit;
  end;
  pc:=pc div SizeOf(LongInt);
  if (pc>1001) then pc:=1001;
  for i:=1 to pc do
  begin
    ph:=OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ,False,pidArray[i-1]);
    if (ph<>0) then
    begin
      FillChar(mhArray,SIzeOf(mhArray),0);
      b:=EnumProcessModules(ph,PModuleHandleArray(@mhArray),SizeOf(mhArray),mc);
      if b then
      begin
        mc:=mc div SizeOf(LongInt);
        if (mc>1001) then mc:=1001;
        for j:=1 to mc do begin
          FillChar(mn,SizeOf(mn),0);
          if (GetModuleFileNameEx(ph,mhArray[j-1],mn,SizeOf(mn))<>0) then
          begin
            if (Pos('\SYSTEM32\NTVDM.EXE',UpperCase(StrPas(mn)))>0) then
            begin
              SRec.ModuleFound:=false;
              SRec.ModuleName:=Name;
              VDMEnumTaskWOWEx(pidArray[i-1],@EnumProc,integer(@SRec));
              if SRec.ModuleFound then
              begin
                Result := -1;
                if ph<>0 then CloseHandle(ph);
                exit;
              end;
            end else
            begin
              if (GetModuleBaseName(ph, mhArray[j-1], mn, SizeOf(mn))<>0)
                 and (UpperCase(StrPas(mn))=UpperCase(Name)) then
              begin
                Result := pidArray[i-1];
                if ph<>0 then CloseHandle(ph);
                exit;
              end;
            end;
          end;
        end;
      end;
    end;
    if (ph<>0) then CloseHandle(ph);
  end;
  Result:=0;
{$ENDIF}
end;
*)

 //of: {$ifndef CLR}

{$ENDIF MSWINDOWS}


function AppendSlash(const PathName: string): string;
begin
  Result := IncludeTrailingBackslash2(PathName);
end;

function GetModulePath: string;
begin
  SetLength(Result, MAXPATHLEN + 1);
  GetModuleFileName(HInstance, PChar(Result), MAXPATHLEN);
  Result := IncludeTrailingBackslash2(ExtractFilePath(Result));
end;

{$IFNDEF KYLIX_USED}

function GetComputerName: string;
var
  Size: DWORD;
begin
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  SetLength(Result, Size);
  Windows.GetComputerName(PChar(Result), Size);
  SetLength(Result, size);
end;
{$ENDIF}

function RectToString(Rect: TRect): string;
begin
  Result := IntToStr(Rect.Left) + ',' + IntToStr(Rect.Top) + ',' +
    IntToStr(Rect.Right) + ',' + IntToStr(Rect.Bottom);
end;

function StringToRect(AString: string): TRect;
var
  S: string;
begin
  try
    S := Copy(AString, 1, Pos(',', AString) - 1);
    if S = '' then exit;
    Delete(AString, 1, Pos(',', AString));
    Result.Left := StrToInt(S);

    S := Copy(AString, 1, Pos(',', AString) - 1);
    if S = '' then exit;
    Delete(AString, 1, Pos(',', AString));
    Result.Top := StrToInt(S);

    S := Copy(AString, 1, Pos(',', AString) - 1);
    if S = '' then exit;
    Delete(AString, 1, Pos(',', AString));
    Result.Right := StrToInt(S);

    S := AString;
    if S = '' then exit;
    Result.Bottom := StrToInt(S);
  except
{$IFDEF MSWINDOWS}
    SetRectEmpty(Result);
{$ELSE}
    FillChar(Result, sizeof(Result), 0);
{$ENDIF}
  end;
end;

procedure ValFloat(Value: string; var Result: Double; var Error: integer);
(*
var p : integer;
    iPart,
    dPart : integer;
    PC: PChar;
begin
  p := Pos('.', Value);
  if (p > 1) and (p < Length(Value)) then
  begin
    Val(Copy(Value, 1, P - 1), iPart, Error);
    if Error <> 0 then
      exit;
    Val(Copy(Value, P + 1, Length(Value)), dPart, Error);
    if Error <> 0 then
    begin
      Inc(Error, P);
      exit;
    end;
    PC := @Result;
    Move(iPart, PC^, sizeof(ipart));
    Inc(PC, sizeof(ipart));
    Move(dPart, PC^, sizeof(dpart));
    Error := 0;
  end
  else
    if p <> 0 then
      Error := p
    else
      Error := -1;
end;
*)
begin
  Replace(Value, '.', DecimalSeparator);
  if not TextToFloat(PChar(Value), Result, fvExtended) then
    Error := 1
  else
    Error := 0;
end;

function StrFloat(Value: double): string;
(*
var p : pinteger;
begin
  p := @Value;
  Result := IntToStr(P^) + '.';
  inc(p);
  Result := Result + IntToStr(P^);
end;
*)
begin
  Result := FloatToStr(Value);
  Replace(Result, DecimalSeparator, '.');
end;

{$IFNDEF KYLIX_USED}

type
  TElMessagePump = class
  protected
    function DoPump: boolean;
    procedure ThreadedMessagePump;
  end;

function TElMessagePump.DoPump: boolean;
var
  Msg: TMsg;
begin
  Result := FALSE;
  if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
  begin
    Result := TRUE;
    if Msg.Message = WM_QUIT then
    else
    begin
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end;
  end;
end;

procedure TElMessagePump.ThreadedMessagePump;
begin
  while DoPump do
    ;
end;

type
  TWndObjInstance = record
    Obj: TObject;
    WndMethod: TElWndMethod;
  end;
  PWndObjInstance = ^TWndObjInstance;

function XDefWindowProc(aWnd: HWND; aMsg: Integer; wParam: WPARAM; lParam:
  LPARAM): Integer; stdcall;
var
  Msg: TMessage;
  ObjInst: PWndObjInstance;
begin
  ObjInst := PWndObjInstance(GetWindowLong(aWnd, GWL_USERDATA));
  if Assigned(ObjInst) and Assigned(ObjInst.WndMethod) then
  begin
    Msg.Msg := aMsg;
    Msg.wParam := wParam;
    Msg.lParam := lParam;
    ObjInst.WndMethod(Msg);
    Result := Msg.Result;
  end
  else
    Result := DefWindowProc(aWnd, aMsg, wParam, lParam)
end;

var
  XElWindowClass: TWndClass = (
    style: 0;
    lpfnWndProc: @XDefWindowProc;
    cbClsExtra: 0;
    cbWndExtra: 0;
    hInstance: 0;
    hIcon: 0;
    hCursor: 0;
    hbrBackground: 0;
    lpszMenuName: nil;
    lpszClassName: 'XElUtilWindow');

function XAllocateHWND(Obj: TObject; WndMethod: TElWndMethod): HWND;
var
  TempClass: TWndClass;
  ClassRegistered: Boolean;
  ObjInst: PWndObjInstance;
begin
  XelWindowClass.hInstance := HInstance;
  ClassRegistered := GetClassInfo(HInstance, XelWindowClass.lpszClassName,
    TempClass);
  if not ClassRegistered or (TempClass.lpfnWndProc <> @DefWindowProc) then
  begin
    if ClassRegistered then
      Windows.UnregisterClass(XelWindowClass.lpszClassName, HInstance);
    Windows.RegisterClass(XelWindowClass);
  end;
  Result := CreateWindowEx(WS_EX_TOOLWINDOW, XelWindowClass.lpszClassName,
    '', WS_POPUP, 0, 0, 0, 0, 0, 0, HInstance, nil);
  GetMem(ObjInst, sizeof(TWndObjInstance));
  ObjInst.Obj := Obj;
  ObjInst.WndMethod := WndMethod;
  SetWindowLong(Result, GWL_USERDATA, Integer(ObjInst));
end;

procedure XDeallocateHWND(Wnd: HWND);
var
  ObjInst: PWndObjInstance;
begin
  ObjInst := PWndObjInstance(GetWindowLong(Wnd, GWL_USERDATA));
  DestroyWindow(Wnd);
  FreeMem(ObjInst);
end;


var
  MessagePump: TElMessagePump;

{$ENDIF KYLIX_USED}

{$IFDEF MSWINDOWS}

function GetSystemErrorMessage(ErrorCode : integer): string;
  var
    buf : PChar;
begin
  FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_ALLOCATE_BUFFER, nil, ErrorCode, 0, PChar(@buf), 0, nil);
  SetLength(Result, StrLen(buf));
  Move(buf^, result[1], StrLen(buf) + 1);
  localfree(Cardinal(buf));
end;

function GetKeysState: integer;
begin
  Result := 0;
  if GetKeyState(VK_CONTROL) < 0 then
    Result := Result or MK_CONTROL;
  if GetKeyState(VK_Shift) < 0 then
    Result := Result or MK_SHIFT;
end;

function GetShiftState: TShiftState;
begin
  Result := [];
  if GetKeyState(VK_MENU) < 0 then
    Include(Result, ssAlt);
  if GetKeyState(VK_CONTROL) < 0 then
    Include(Result, ssCtrl);
  if GetKeyState(VK_Shift) < 0 then
    Include(Result, ssShift);
end;

function DrivePresent(const DrivePath: string): Boolean;
var
  i: UINT;
begin
  i := GetDriveType(PChar(DrivePath));
  Result := (i <> DRIVE_NO_ROOT_DIR) and (i <> DRIVE_UNKNOWN);
end;

{$ENDIF}

initialization
  DefineOS;

{$IFNDEF KYLIX_USED}
  MessagePump := TElMessagePump.Create;
  OnMessagePump := MessagePump.ThreadedMessagePump;

finalization
  MessagePump.Free;
{$ENDIF}

end.
