unit alcuAsyncExecutor;

interface

uses l3Base, csProcessTask, l3Types, ddProgressObj, csNotification, CsDataPipe,
  daTypes;

type
  TsatAsyncExecutor = class(Tl3ThreadContainer)
  private
    f_TaskFile: String;
    f_IP: String;
    f_Port: Integer;
    f_Login: String;
    f_Password: String;
    f_Aborted: Integer;
    f_Task: TddProcessTask;
    f_Progress: Long;
    f_Message: AnsiString;
    f_OnceSended: Boolean;
    f_ServerUserID: TdaUserID;
    f_ExitCode: Integer;
    procedure ProcessProgress(aState: Byte; aValue: Long; const aMsg: AnsiString = '');
    procedure ExternalNotify(aNotificationType: TCsNotificationType;
      aNumber: Integer; const aText: AnsiString; var aHandled: Boolean);
    procedure ServerStatusChanged(aOnline: Boolean);
    procedure SendProgress(aValue: Long; const aMsg: AnsiString);
    procedure pipe_AsyncProgress(aPipe: TcsDataPipe);
    procedure pipe_GetServerUser(aPipe: TcsDataPipe);
    procedure pipe_SendTaskResult(aPipe: TcsDataPipe);
    function RunningTask: Boolean;
  protected
    procedure DoExecute; override;
  public
    constructor Create(const aTaskFile, anIP: String; aPort: Integer; const aLogin, aPassword: String);
    procedure RequestAbort;
    function IsAborted: Boolean;
    property ExitCode: Integer read f_ExitCode;
  end;

implementation

uses
  Classes, ddHTInit, alcuExport, l3Stream, daDataProvider, dt_Mail,
  csUserRequestManager, csQueryTypes, ddProcessTaskPrim, ddClientBaseEngine,
  ddIniStorage, SysUtils, l3TempMemoryStream, l3Interlocked, daUtils,
  csTaskTypes, alcuStrings;

{ TsatTaskRunThread }

procedure TsatAsyncExecutor.RequestAbort;
begin
  l3InterlockedExchange(f_Aborted, 1);
  f_ExitCode := cs_arsAborted;
end;

constructor TsatAsyncExecutor.Create(const aTaskFile, anIP: String;
  aPort: Integer; const aLogin, aPassword: String);
begin
  inherited Create;
  f_ExitCode := cs_arsSuccess;
  f_TaskFile := aTaskFile;
  f_IP := anIP;
  f_Port := aPort;
  f_Login := aLogin;
  f_Password := aPassword;
end;

procedure TsatAsyncExecutor.DoExecute;
var
  l_Stream: TStream;
  l_Progressor: TddProgressObject;
  l_OldLogName: String;
  l_NewLogName: String;
begin
 try
  if InitBaseEngine(f_IP, f_Port, f_Login, f_Password, True{QuietMode}) then
  begin
   try
    l3System.LogMachineName := GetHomePathCode(GlobalDataProvider.UserID);
    MailServer.UseProxySender := True;
    UserRequestManager.CSClient.Exec(qtalcuGetServerUser, pipe_GetServerUser);
    MailServer.ProxySender := f_ServerUserID;
    l_Stream := Tl3FileStream.Create(f_TaskFile, l3_fmRead);
    try
     f_Task := TddProcessTask.MakeFromEVD(l_Stream, '', False) as TddProcessTask;
    finally
     l3Free(l_Stream);
    end;
    if f_Task = nil then
      f_ExitCode := cs_arsTaskUnregistered;
    try
     UserRequestManager.ShowTextMessages:= False;
     UserRequestManager.OnExternalNotify := ExternalNotify;
     UserRequestManager.OnServerStatusChanged := ServerStatusChanged;
     l_Progressor := TddProgressObject.Create(nil);
     try
      l_Progressor.OnProgressProc := ProcessProgress;
      l3System.Msg2Log('Начали задачу %s (%s)', [f_Task.TaskID, f_Task.Description]);
      l_OldLogName := l3System.LogFileName;
      l_NewLogName := Format('%s%s', [ExtractFilePath(l_OldLogName), Format(cExecutorLogName, [f_Task.TaggedData.TagType.AsString])]);
      l3System.Msg2Log('Далее лог см. %s', [l_NewLogName]);
      l3System.LogFileName := l_NewLogName;
      l3System.Msg2Log('Начали задачу %s (%s)', [f_Task.TaskID, f_Task.Description]);
      f_Task.Run(TddRunContext_C(l_Progressor));
      l3System.Msg2Log('Закончили задачу %s', [f_Task.TaskID]);
      l3System.LogFileName := l_OldLogName;
      l3System.Msg2Log('Закончили задачу %s', [f_Task.TaskID]);
     finally
      l3Free(l_Progressor);
     end;
     if f_Task.Aborted then
      RequestAbort;
     if f_Task.Status in cs_tsErrorStatuses then
      f_ExitCode := cs_arsGeneralError;
     if f_ExitCode = cs_arsSuccess then
      UserRequestManager.CSClient.Exec(qtalcuSendTaskResult, pipe_SendTaskResult);
    finally
     l3Free(f_Task);
    end;
   finally
    DoneClientBaseEngine;
   end;
  end
  else
   RequestAbort;
 except
  f_ExitCode := cs_arsGeneralError;
  raise;
 end;
end;

procedure TsatAsyncExecutor.ProcessProgress(aState: Byte; aValue: Long;
  const aMsg: AnsiString);
begin
  if (f_Aborted = 1) and not f_Task.Aborted then
  begin
    f_Task.Abort;
  end;
  if not f_Task.Aborted then
    SendProgress(aValue, aMsg);
end;

function TsatAsyncExecutor.IsAborted: Boolean;
begin
  Result := f_Aborted = 1;
end;

procedure TsatAsyncExecutor.ExternalNotify(
  aNotificationType: TCsNotificationType; aNumber: Integer;
  const aText: AnsiString; var aHandled: Boolean);
begin
  aHandled := True;
  case aNotificationType of
    ntAutoLogoff,
    ntAbortAsyncRun:
      RequestAbort;
  else
    aHandled := True;
  end;
end;

procedure TsatAsyncExecutor.ServerStatusChanged(aOnline: Boolean);
begin
  if RunningTask and not aOnline then
    RequestAbort;
end;

procedure TsatAsyncExecutor.SendProgress(aValue: Long;
  const aMsg: AnsiString);
begin
  if (f_Progress <> aValue) or (f_Message <> aMsg) or not f_OnceSended then
  begin
    f_Progress := aValue;
    f_Message := aMsg;
    f_OnceSended := True;
    UserRequestManager.CSClient.Exec(qtAsyncProgress, pipe_AsyncProgress);
  end;
end;

procedure TsatAsyncExecutor.pipe_AsyncProgress(aPipe: TcsDataPipe);
begin
  aPipe.WriteLn(f_Task.TaskID);
  aPipe.WriteCardinal(f_Progress);
  aPipe.WriteLn(f_Message);
end;

function TsatAsyncExecutor.RunningTask: Boolean;
begin
  Result := Assigned(f_Task);
end;

procedure TsatAsyncExecutor.pipe_GetServerUser(aPipe: TcsDataPipe);
begin
  f_ServerUserID := aPipe.ReadCardinal;
end;

procedure TsatAsyncExecutor.pipe_SendTaskResult(aPipe: TcsDataPipe);
var
  l_Stream: TStream;
begin
  l_Stream := Tl3TempMemoryStream.Create;
  try
    f_Task.TaskResult.SaveToEVD(l_Stream, nil);
    l_Stream.Seek(0, soFromBeginning);
    aPipe.WriteStream(l_Stream, l_Stream.Size);
  finally
    FreeAndNil(l_Stream);
  end;
end;

end.
