{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                    FireDAC tracer                     }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Stan.Tracer;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Stan.Error, FireDAC.Stan.Util, FireDAC.Stan.Intf;

type
  TFDTracer = class;

  { --------------------------------------------------------------------------- }
  { TFDTracer                                                                   }
  { --------------------------------------------------------------------------- }
  TFDTracer = class(TFDThread)
  private
    FTraceFileName: String;
    FTraceFileHandler: TFDTextFile;
    FTraceFileAppend: Boolean;
    FCounter: Int64;
    FTraceFileColumns: TFDTraceFileColumns;
    FTraceFileEncoding: TFDEncoding;
    procedure CheckInactive;
    procedure SetTraceFileName(const AValue: String);
    procedure SetTraceFileAppend(AValue: Boolean);
    procedure OpenTraceFiles;
    procedure CloseTraceFiles;
    procedure SetTraceFileEncoding(const Value: TFDEncoding);
  protected
    class function GetStartMsgClass: TFDThreadMsgClass; override;
    class function GetStopMsgClass: TFDThreadMsgClass; override;
    class function GetTerminateMsgClass: TFDThreadMsgClass; override;
    function DoAllowTerminate: Boolean; override;
    procedure DoActiveChanged; override;
    procedure DoIdle; override;
  public
    constructor Create;
    procedure TraceMsg(const AObjClassName, AObjName, AMsg: String);
    property TraceFileName: String read FTraceFileName write SetTraceFileName;
    property TraceFileAppend: Boolean read FTraceFileAppend write SetTraceFileAppend;
    property TraceFileColumns: TFDTraceFileColumns read FTraceFileColumns write FTraceFileColumns;
    property TraceFileEncoding: TFDEncoding read FTraceFileEncoding write SetTraceFileEncoding;
  end;

var
  FADShowTraces: Boolean = True;

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  System.SyncObjs, System.Diagnostics,
  FireDAC.Stan.Consts, FireDAC.Stan.ResStrs;

var
  GTracesLock: TCriticalSection;
  GTraces: TFDStringList = nil;

type
  TFDTracerMsgBase = class;
  TFDTracerStartMsg = class;
  TFDTracerStopMsg = class;
  TFDTracerTerminateMsg = class;
  TFDTracerOutputMsg = class;

  { --------------------------------------------------------------------------- }
  { TFDTracerMsgBase                                                            }
  { --------------------------------------------------------------------------- }
  TFDTracerMsgBase = class(TFDThreadMsgBase)
  private
    FCounter: Int64;
    FTime: TDateTime;
    FThreadID: TThreadID;
  public
    constructor Create; override;
    function Perform(AThread: TFDThread): Boolean; override;
    function AsString(AItems: TFDTraceFileColumns): String; virtual;
  end;

  { --------------------------------------------------------------------------- }
  { TFDTracerStartMsg                                                           }
  { --------------------------------------------------------------------------- }
  TFDTracerStartMsg = class(TFDTracerMsgBase)
  public
    constructor Create; override;
    function Perform(AThread: TFDThread): Boolean; override;
    function AsString(AItems: TFDTraceFileColumns): String; override;
  end;

  { --------------------------------------------------------------------------- }
  { TFDTracerStopMsg                                                            }
  { --------------------------------------------------------------------------- }
  TFDTracerStopMsg = class(TFDTracerMsgBase)
  public
    function Perform(AThread: TFDThread): Boolean; override;
    function AsString(AItems: TFDTraceFileColumns): String; override;
  end;

  { --------------------------------------------------------------------------- }
  { TFDTracerTerminateMsg                                                       }
  { --------------------------------------------------------------------------- }
  TFDTracerTerminateMsg = class(TFDTracerMsgBase)
  public
    function Perform(AThread: TFDThread): Boolean; override;
    function AsString(AItems: TFDTraceFileColumns): String; override;
  end;

  { --------------------------------------------------------------------------- }
  { TFDTracerOutputMsg                                                          }
  { --------------------------------------------------------------------------- }
  TFDTracerOutputMsg = class(TFDTracerMsgBase)
  private
    FObjClassName: String;
    FObjID: String;
    FMsgText: String;
  public
    constructor Create(const AObjectClassName, AObjID, AMsgText: String); overload;
    function AsString(AItems: TFDTraceFileColumns): String; override;
  end;

{ --------------------------------------------------------------------------- }
{ TFDTracerMsgBase                                                            }
{ --------------------------------------------------------------------------- }
constructor TFDTracerMsgBase.Create;
begin
  inherited Create;
  FCounter := TStopwatch.GetTimeStamp();
  FTime := Time();
  FThreadID := TThread.CurrentThread.ThreadID;
end;

{ --------------------------------------------------------------------------- }
function TFDTracerMsgBase.AsString(AItems: TFDTraceFileColumns): String;
var
  s: String;
begin
  if tiRefNo in AItems then
    Result := Format('%8d ', [FCounter])
  else
    Result := '';
  if tiTime in AItems then begin
    DateTimeToString(s, 'hh:nn:ss.zzz ', FTime);
    Result := Result + s;
  end;
  if tiThreadID in AItems then
    Result := Result + Format('%8d ', [FThreadID]);
end;

{ --------------------------------------------------------------------------- }
function TFDTracerMsgBase.Perform(AThread: TFDThread): Boolean;
var
  oTracer: TFDTracer;
begin
  oTracer := AThread as TFDTracer;
  Inc(FCounter);
  Self.FCounter := FCounter;
  if oTracer.FTraceFileHandler <> nil then
    oTracer.FTraceFileHandler.WriteLine(AsString(oTracer.FTraceFileColumns));
  Result := True;
end;

{ --------------------------------------------------------------------------- }
{ TFDTracerStartMsg                                                           }
{ --------------------------------------------------------------------------- }
constructor TFDTracerStartMsg.Create;
begin
  inherited Create;
end;

{ --------------------------------------------------------------------------- }
function TFDTracerStartMsg.Perform(AThread: TFDThread): Boolean;
var
  oMsg: TFDThreadStartMsg;
begin
  (AThread as TFDTracer).OpenTraceFiles;
  inherited Perform(AThread);
  oMsg := TFDThreadStartMsg.Create;
  try
    Result := oMsg.Perform(AThread);
  finally
    FDFree(oMsg);
  end;
end;

{ --------------------------------------------------------------------------- }
function TFDTracerStartMsg.AsString(AItems: TFDTraceFileColumns): String;
begin
  Result := inherited AsString(AItems) + '-=#!!! FireDAC Tracer started !!!#=-';
end;

{ --------------------------------------------------------------------------- }
{ TFDTracerStopMsg                                                            }
{ --------------------------------------------------------------------------- }
function TFDTracerStopMsg.Perform(AThread: TFDThread): Boolean;
var
  oMsg: TFDThreadStopMsg;
begin
  inherited Perform(AThread);
  (AThread as TFDTracer).CloseTraceFiles;
  oMsg := TFDThreadStopMsg.Create;
  try
    Result := oMsg.Perform(AThread);
  finally
    FDFree(oMsg);
  end;
end;

{ --------------------------------------------------------------------------- }
function TFDTracerStopMsg.AsString(AItems: TFDTraceFileColumns): String;
begin
  Result := inherited AsString(AItems) + '-=#!!! FireDAC Tracer stopped !!!#=-';
end;

{ --------------------------------------------------------------------------- }
{ TFDTracerTerminateMsg                                                       }
{ --------------------------------------------------------------------------- }
function TFDTracerTerminateMsg.Perform(AThread: TFDThread): Boolean;
var
  oMsg: TFDThreadTerminateMsg;
begin
  inherited Perform(AThread);
  oMsg := TFDThreadTerminateMsg.Create;
  try
    Result := oMsg.Perform(AThread);
  finally
    FDFree(oMsg);
  end;
end;

{ --------------------------------------------------------------------------- }
function TFDTracerTerminateMsg.AsString(AItems: TFDTraceFileColumns): String;
begin
  Result := inherited AsString(AItems) + '-=#!!! FireDAC Tracer terminated !!!#=-';
end;

{ --------------------------------------------------------------------------- }
{ TFDTracerOutputMsg                                                          }
{ --------------------------------------------------------------------------- }
constructor TFDTracerOutputMsg.Create(const AObjectClassName, AObjID, AMsgText: String);
begin
  inherited Create;
  FObjClassName := AObjectClassName;
  FObjID := AObjID;
  FMsgText := AMsgText;
end;

{ --------------------------------------------------------------------------- }
function TFDTracerOutputMsg.AsString(AItems: TFDTraceFileColumns): String;
begin
  Result := inherited AsString(AItems);
  if tiClassName in AItems then
    Result := Result + FDPadR(FObjClassName, 32) + ' ';
  if tiObjID in AItems then
    Result := Result + FDPadR(FObjID, 20) + ' ';
  if tiMsgText in AItems then
    Result := Result + FMsgText;
end;

{ --------------------------------------------------------------------------- }
{ TFDTracer                                                                   }
{ --------------------------------------------------------------------------- }
constructor TFDTracer.Create;
begin
  inherited Create;
  FreeOnTerminate := False;
  FTraceFileAppend := C_FD_MonitorAppend;
  FTraceFileColumns := C_FD_MonitorColumns;
end;

{ --------------------------------------------------------------------------- }
class function TFDTracer.GetStartMsgClass: TFDThreadMsgClass;
begin
  Result := TFDTracerStartMsg;
end;

{ --------------------------------------------------------------------------- }
class function TFDTracer.GetStopMsgClass: TFDThreadMsgClass;
begin
  Result := TFDTracerStopMsg;
end;

{ --------------------------------------------------------------------------- }
class function TFDTracer.GetTerminateMsgClass: TFDThreadMsgClass;
begin
  Result := TFDTracerTerminateMsg;
end;

{ --------------------------------------------------------------------------- }
function TFDTracer.DoAllowTerminate: Boolean;
begin
  if Messages = nil then
    Result := True
  else begin
    Result := Messages.LockList.Count = 0;
    Messages.UnlockList;
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TFDTracer.DoActiveChanged;
begin
  if not Active then
    while not DoAllowTerminate do
      Sleep(1);
end;

{ --------------------------------------------------------------------------- }
procedure TFDTracer.DoIdle;
begin
  if (FTraceFileHandler <> nil) and (FTraceFileHandler.Stream <> nil) and
     (FTraceFileHandler.Stream is TBufferedFileStream) then
    TBufferedFileStream(FTraceFileHandler.Stream).FlushBuffer;
end;

{ --------------------------------------------------------------------------- }
procedure TFDTracer.CheckInactive;
begin
  if Active then
    raise EFDException.Create(sMb_TracerPropertyChangeOnlyActiveFalse);
end;

{ --------------------------------------------------------------------------- }
procedure TFDTracer.SetTraceFileName(const AValue: String);
begin
  CheckInactive;
  FTraceFileName := FDExpandStr(AValue);
end;

{ --------------------------------------------------------------------------- }
procedure TFDTracer.SetTraceFileAppend(AValue: Boolean);
begin
  CheckInactive;
  FTraceFileAppend := AValue;
end;

{ --------------------------------------------------------------------------- }
procedure TFDTracer.SetTraceFileEncoding(const Value: TFDEncoding);
begin
  CheckInactive;
  FTraceFileEncoding := Value;
end;

{ --------------------------------------------------------------------------- }
procedure TFDTracer.OpenTraceFiles;
begin
  FCounter := 0;
  if FTraceFileHandler <> nil then
    raise EFDException.Create(sMb_TracerTraceFileHasToBeClosed);
  if FTraceFileName = '' then
    raise EFDException.Create(sMb_TracerTraceFileNameNotAssigned);
  FTraceFileHandler := TFDTextFile.Create(FTraceFileName,
    False, FTraceFileAppend, FTraceFileEncoding, elWindows);
  FTraceFileHandler.WriteLine('--- new start of FireDAC Trace ---');
  if GTraces <> nil then begin
    GTracesLock.Enter;
    try
      if GTraces.IndexOf(FTraceFileName) = -1 then
        GTraces.Add(FTraceFileName);
    finally
      GTracesLock.Leave;
    end;
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TFDTracer.CloseTraceFiles;
begin
  if FTraceFileHandler = nil then
    raise EFDException.Create(sMb_TracerTraceFileHasToBeOpen);
  FDFreeAndNil(FTraceFileHandler);
end;

{ --------------------------------------------------------------------------- }
procedure TFDTracer.TraceMsg(const AObjClassName, AObjName, AMsg: String);
begin
  if (Self <> nil) and Active then
    EnqueueMsg(TFDTracerOutputMsg.Create(AObjClassName, AObjName, AMsg));
end;

{ --------------------------------------------------------------------------- }
procedure ShowTraces;
var
  sMsg: String;
begin
  sMsg := C_FD_Product + ' produced following application trace files:' +
    C_FD_EOL + GTraces.Text;
{$IFDEF MSWINDOWS}
  sMsg := sMsg + C_FD_EOL + 'Press OK to close application.';
{$ENDIF}
  FDSystemMessage(C_FD_Product + ' MonitorBy=FlatFile', sMsg, False);
end;

{ --------------------------------------------------------------------------- }
initialization
  GTracesLock := TCriticalSection.Create;
  GTraces := TFDStringList.Create;

finalization
  GTracesLock.Enter;
  try
    if FADShowTraces and (GTraces.Count > 0) and not FDIsDesignTime then
      ShowTraces;
    FDFreeAndNil(GTraces);
  finally
    GTracesLock.Leave;
    FDFreeAndNil(GTracesLock);
  end;

end.
