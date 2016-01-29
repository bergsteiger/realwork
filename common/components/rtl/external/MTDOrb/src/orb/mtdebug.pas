// **********************************************************************
//
// Copyright (c) 2000 - 2003 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit mtdebug;

interface

{$I dorb.inc}

uses {$IFDEF MSWINDOWS}Windows{$ENDIF}{$IFDEF LINUX}Libc{$ENDIF},SysUtils, Classes,
  mtdebug_int, osthread, orbtypes;

{$IFNDEF USELIB}

type
  TLogger = class(TInterfacedObject, ILogger)
  private
    FMutex: TMutex;
    FInfo: THandle;
    FError: THandle;
    FMsgTypes: TMessageTypes;
    procedure InternalMessage(const AHandle: THandle; const Msg: AnsiString);
  protected
    { ILogger }
    function IsLogged(const MsgType: mtdebug_int.TMessageType): boolean;
    procedure Info(const Msg: AnsiString);
    procedure Error(const Msg: AnsiString);
    procedure Warning(const Msg: AnsiString);
    procedure Trace(const Category, Msg: AnsiString);
  public
    constructor Create(const MsgTypes: TMessageTypes = []; const InfoFile: string = ''; const ErrorFile: string = '');
    destructor Destroy; override;
  end;

procedure CreateLogger(const MsgTypes: TMessageTypes; const InfoFile: string; const ErrorFile: string);
procedure DestroyLogger;
function MTDORBLogger: ILogger;

procedure Debug(const Msg: AnsiString);
function CallStackTextualRepresentation(): string;
{$ELSE}
procedure CreateLogger(const MsgTypes: TMessageTypes; const InfoFile: string; const ErrorFile: string); external MTDORB_Library_Name;
function MTDORBLogger: ILogger; external MTDORB_Library_Name;

procedure Debug(const Msg: AnsiString); external MTDORB_Library_Name;
function CallStackTextualRepresentation(): string; external MTDORB_Library_Name;
{$ENDIF}

{$IFNDEF USELIB}

implementation

{$IFDEF USE_JCL}uses JclDebug;{$ENDIF}

var
  loggerVar: ILogger;

function CallStackTextualRepresentation(): string;
{$IFDEF USE_JCL}
var
  strs: TStrings;
{$ENDIF}
begin
{$IFDEF USE_JCL}
  strs := TStringList.Create;
  try
    JclCreateStackList(true, 6, nil).AddToStrings(strs, true);
    result := strs.Text;
  finally
    strs.Free;
  end; { try/finally }
{$ENDIF}
end;

procedure CreateLogger(const MsgTypes: TMessageTypes; const InfoFile: string; const ErrorFile: string);
begin
  loggerVar := TLogger.Create(MsgTypes, InfoFile, ErrorFile);
end;
//WJ: logger should be cleared after orb shutdown
procedure DestroyLogger;
begin
  loggerVar := nil;
end;

function MTDORBLogger: ILogger;
begin
  result := loggerVar;
end;

{$IFDEF MSWINDOWS}
var
  x: Integer;
{$ENDIF}

procedure Debug(const Msg: AnsiString);
begin
{$IFDEF MSWINDOWS}
  OutputDebugString(PChar(Format('%d %s Thread=%x%s',
    [InterlockedIncrement(x), Msg, GetCurrentThreadID, #10 + #13])));
{$ENDIF}
end;

{ TLogger }

constructor TLogger.Create(const MsgTypes: TMessageTypes; const InfoFile,
  ErrorFile: string);
begin
  inherited Create;
  FMsgTypes := MsgTypes;
  FMutex := TMutex.Create;
  if InfoFile <> '' then begin
    if FileExists(InfoFile) then
      FInfo := FileOpen(InfoFile, fmOpenWrite or fmShareDenyNone)
    else
      FInfo := FileCreate(InfoFile);
    FileSeek(FInfo, 0, 2);
  end
  else
{$IFDEF MSWINDOWS}
    FInfo := GetStdHandle(STD_OUTPUT_HANDLE);
{$ENDIF}
{$IFDEF LINUX}
    FInfo := STDOUT_FILENO;
{$ENDIF}
  if ErrorFile <> '' then begin
    //WJ: if user wants all log in one file - open it only once
    if UpperCase(ErrorFile) = UpperCase(InfoFile)  then
      FError := FInfo
    else if FileExists(ErrorFile) then
      FError := FileOpen(ErrorFile, fmOpenWrite or fmShareDenyNone)
    else
      FError := FileCreate(ErrorFile);
    FileSeek(FError, 0, 2);
  end
  else
{$IFDEF MSWINDOWS}
    FError := GetStdHandle(STD_ERROR_HANDLE);
{$ENDIF}
{$IFDEF LINUX}
    FError := STDERR_FILENO;
{$ENDIF}
end;

destructor TLogger.Destroy;
begin
//WJ: set message on closing log
  Info('Info logger is closed');
  Error('Error logger is closed');
{$IFDEF MSWINDOWS}
  CloseHandle(FError);
{$ENDIF}
{$IFDEF LINUX}
  __close(FError);
{$ENDIF}
  if FError <> FInfo then
  begin
{$IFDEF MSWINDOWS}
    CloseHandle(FInfo);
{$ENDIF}
{$IFDEF LINUX}
    __close(FInfo);
{$ENDIF}
  end;
  FreeAndNil(FMutex);
  inherited;
end;

procedure TLogger.Error(const Msg: AnsiString);
begin
  if mtError in FMsgTypes then
    InternalMessage(FError, Msg);
end;

procedure TLogger.Info(const Msg: AnsiString);
begin
  if mtInfo in FMsgTypes then
    InternalMessage(FInfo, Msg);
end;

procedure TLogger.InternalMessage(const AHandle: THandle; const Msg: AnsiString);
var
  sync: ISynchronized;
  intMsg: string;
begin
  intMsg := Format('[%s] %s%s', [FormatDateTime('ddd mmm dd hh:nn:ss.zzz yyyy', Now),
    Msg, #13{$IFDEF MSWINDOWS} + #10{$ENDIF}]);
  sync := TSynchronized.Create(FMutex);
  FileWrite(AHandle, intMsg, Length(intMsg));
  sync := nil;
end;

function TLogger.IsLogged(const MsgType: mtdebug_int.TMessageType): boolean;
begin
  result := MsgType in FMsgTypes;
end;

procedure TLogger.Trace(const Category, Msg: AnsiString);
begin
  if mtTrace in FMsgTypes then
    InternalMessage(FInfo, AnsiString(Format('%s: %s', [Category, Msg])));
end;

procedure TLogger.Warning(const Msg: AnsiString);
begin
  if mtWarning in FMsgTypes then
    InternalMessage(FInfo, Msg);
end;

{$IFDEF LIBRARY}
exports
  Debug,
  CreateLogger,
  MTDORBLogger,
  CallStackTextualRepresentation;
{$ENDIF}
{$ELSE}
implementation
{$ENDIF}
end.
