{*********************************************************}
{*                  STFORMAT.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$I+} {I/O Checking On}
{$H+} {Huge strings}

unit StFormat;

interface

{$IFNDEF WIN32}
  !! Error: This unit cannot be compiled with Delphi 1
{$ENDIF}

uses
  SysUtils, Windows, Forms, Classes, Controls, StConst,
  StShBase, StBase;

{$Z+}
type
  TStFormatOptions = (fmtSystemOnly, fmtFull);

  TStFormatOptionsSet = set of TStFormatOptions;

  TStDisketteErrorEvent = procedure (Sender : TObject;
                                     var Retry : Boolean) of object;

  TStCustomFormatDrive = class(TStShellComponent)

  protected {private}
    FDrive       : string;
    FOptions     : TStFormatOptionsSet;

    FOnDisketteError : TStDisketteErrorEvent;
    FOnFormatError   : TNotifyEvent;

    function CheckDiskette : Integer;
  protected

    procedure SetDrive(const Value : string);
{$Z-}

    {properties}
    property Drive : string
      read FDrive
      write SetDrive;

    property Options : TStFormatOptionsSet
      read FOptions
      write FOptions
      default [fmtFull];

    {events}
    property OnDisketteError : TStDisketteErrorEvent
      read FOnDisketteError
      write FOnDisketteError;

    property OnFormatError : TNotifyEvent
      read FOnFormatError
      write FOnFormatError;

{$Z+}
  public
    { Public declarations }
    constructor Create(AOwner : TComponent);
      override;
{$Z-}
    function Execute : Boolean;
  published
    { Published declarations }
  end;

  TStFormatDrive = class(TStCustomFormatDrive)
  public
    {properties}
    property Error;
    property ErrorString;

  published
    {properties}
    property Drive;
    property Options;

    {events}
    property OnDisketteError;
    property OnFormatError;
  end;

implementation

{$IFDEF TRIALRUN}
uses
  {$IFDEF Win32} Registry, {$ELSE} Ver, {$ENDIF}
  IniFiles,
  ShellAPI,
  StTrial;
{$I TRIAL00.INC} {FIX}
{$I TRIAL01.INC} {CAB}
{$I TRIAL02.INC} {CC}
{$I TRIAL03.INC} {VC}
{$I TRIAL04.INC} {TCC}
{$I TRIAL05.INC} {TVC}
{$I TRIAL06.INC} {TCCVC}
{$ENDIF}

const
  StNoError = 0;
  StAbort   = 1;
  StRetry   = 2;

  { These constants are not defined in ShellApi.PAS. }
  SHFMT_OPT_FULL     = $0001;
  SHFMT_OPT_SYSONLY  = $0002;
  SHFMT_ID_DEFAULT   = $FFFF;

  SHFMT_NOFORMAT     = $FFFFFFFD; { The drive could not be formatted. }
  SHFMT_CANCEL       = $FFFFFFFE; { The format was cancelled.         }
  SHFMT_ERROR        = $FFFFFFFF; { Other format error.               }

function SHFormatDrive(hWnd : HWND; Drive, FormatID, Options : Integer)
                       : Integer; stdcall; external 'shell32.dll';

function TStCustomFormatDrive.CheckDiskette : Integer;
var
  OldErrMode : Integer;
  OldDir     : array [0..MAX_PATH - 1] of Char;
  TempFile   : array [0..MAX_PATH - 1] of Char;
  Retry      : Boolean;
  Res        : DWORD;
begin
  Result := StNoError;
  if Assigned(FOnDisketteError) then begin
    { Catch diskette errors here. }
    OldErrMode := SetErrorMode(SEM_FAILCRITICALERRORS);
    GetCurrentDirectory(SizeOf(OldDir), OldDir);
    SetLastError(0);
    { First try to switch to FDrive. }
    SetCurrentDirectory(PChar(FDrive));
    { See if there was an error. }
    CheckSystemError(0);
    { No? Then try to create a file on the diskette. }
    if Error = 0 then begin
      GetTempFileName(PChar(FDrive), '~ST', 0, TempFile);
      Res := CreateFile(TempFile, GENERIC_WRITE, 0,
        nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
      if Res = INVALID_HANDLE_VALUE then
        CheckSystemError(0)
      else begin
        CloseHandle(Res);
        DeleteFile(TempFile);
      end;
    end;
    { Reset the current directory. }
    SetCurrentDirectory(OldDir);
    { Reset the error mode. }
    SetErrorMode(OldErrMode);
    { Fire the event. }
    Retry := False;
    if FError <> 0 then begin
      FOnDisketteError(Self, Retry);
      if Retry then begin
        Result := StRetry;
        if FError = 0 then
          Result := StNoError;
      end else
        Result := StAbort;
    end;
  end;
end;

constructor TStCustomFormatDrive.Create(AOwner : TComponent);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create(AOwner);
  FOptions := [fmtFull];
end;

function TStCustomFormatDrive.Execute : Boolean;
var
  Flags        : Word;
  ParentHandle : HWND;
  Err          : Integer;
  Res          : Integer;
  DriveNo      : Integer;
  OSVInfo      : TOsVersionInfo;
begin

  Result := False;

  { Check to see if the drive is valid and if it is a removeable drive. }
  Res := GetDriveType(PChar(FDrive));
  if Res <> DRIVE_REMOVABLE then
    raise EStShellFormatError.CreateResTP(stscShellFormatBadDrive, 0);

  { Check to see if the drive is ready. }
  Res := CheckDiskette;
  case Res of
    { Problem but user wants to retry so recurse. }
    StRetry :
      begin
        Result := Execute;
        Exit;
      end;
    { Problem and user wants to bail out. }
    StAbort : Exit;
  end;

  { Get a handle to the owning window. }
  if Owner is TWinControl then
    ParentHandle := (Owner as TWinControl).Handle
  else if Owner is TApplication then
    ParentHandle := (Owner as TApplication).Handle
  else
    ParentHandle := 0;

  Flags := 0;

  { If the OS is NT then don't add the SHFMT_OPT_SYSONLY flag. }
  OsVInfo.dwOSVersionInfoSize := SizeOf(TOsVersionInfo);
  GetVersionEx(OSVInfo);
  if OsVInfo.dwPlatformId <> VER_PLATFORM_WIN32_NT then begin
    if fmtSystemOnly in FOptions then
      Flags := Flags or SHFMT_OPT_SYSONLY;
    if fmtFull in FOptions then
      Flags := Flags or SHFMT_OPT_FULL;
  end else
    { For some odd reason this is backwards in NT. }
    if not (fmtFull in FOptions) then
      Flags := Flags or SHFMT_OPT_FULL;
  { Convert drive letter to a drive number. }
  DriveNo := Ord(UpperCase(FDrive)[1]) - Ord('A');                     
  { Execute the Format dialog. }
  Err := SHFormatDrive(ParentHandle, DriveNo, SHFMT_ID_DEFAULT, Flags);
  if (Err < 0) then begin
    FError := Err;
    case FError of
      Integer(SHFMT_ERROR)    : Err := stscShellFormatError;           
      Integer(SHFMT_CANCEL)   : Err := stscShellFormatCancel;          
      Integer(SHFMT_NOFORMAT) : Err := stscShellFormatNoFormat;        
    end;
    FErrorString := SysToolStr[Err];
    if Assigned(FOnFormatError) then
      FOnFormatError(Self);
  end else begin
    FError := 0;
    FErrorString := '';
    Result := True;
  end;
end;

procedure TStCustomFormatDrive.SetDrive(const Value : string);
var
  P : Integer;
begin
  if Value <> '' then begin
    FDrive := UpperCase(Value);
    { Fix-up drive letter if necessary. Won't catch every }
    { user error but will catch the most common ones.    }
    P := Pos('\', FDrive);
    if P <> 0 then
      Delete(FDrive, P, Length(FDrive) - P + 1);
    if (Length(FDrive) = 1) and (Pos(':', FDrive) = 0) then
      FDrive := FDrive + ':';
  end else
    FDrive := '';
end;


end.