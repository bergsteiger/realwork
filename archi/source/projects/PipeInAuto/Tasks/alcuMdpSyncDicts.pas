unit alcuMdpSyncDicts;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/NOT_FINISHED_alcuMdpSyncDicts.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::Lists::TalcuMdpSyncDicts
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
  Classes,

  IdHTTP,
  IdComponent,

  ddProcessTaskPrim,
  ddProgressObj,

  csProcessTask,
  csMdpSyncDicts
  ;

type
 TalcuMdpSyncDicts = class(TcsMdpSyncDicts)
 private
  f_HTTP: TIdHTTP;
  f_Progressor: TddProgressObject;
  f_TotalFileSize: Int64;
  f_SendedSize: Int64;
  f_SendingSize: Int64;
  function DoSendFiles(const aFileName: AnsiString): Boolean;
  function DoCalcSizes(const aFileName: AnsiString): Boolean;
  function SendFile(const aFileName: AnsiString): Boolean;
  procedure HTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
  procedure HTTPEndWork(ASender: TObject; AWorkMode: TWorkMode);
 protected
  procedure DoRun(const aContext: TddRunContext); override;
 public
  class function CanAsyncRun: Boolean; override;
  function CanSimultaneousRunWith(const aTask: TddProcessTask): Boolean; override;
  {$If defined(AppServerSide)}
  procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
  function IsHiddenFromUser: Boolean; override;
 end;

implementation

uses
 SysUtils,
 TypInfo,

 l3Types,
 l3Base,
 l3Mutex,
 l3Stream,
 l3FileUtils,

 csTaskTypes,

 {$If defined(AppServerSide)} alcuMdpSyncParamUtils, {$IfEnd defined(AppServerSide)}
 ddServerTask,
 ddFileIterator
 ;

{ TalcuMdpSyncDicts }

class function TalcuMdpSyncDicts.CanAsyncRun: Boolean;
begin
 Result := True;
end;

function TalcuMdpSyncDicts.CanSimultaneousRunWith(
  const aTask: TddProcessTask): Boolean;
begin
 Result := (aTask = Self) or (ClassName <> aTask.ClassName);
end;

procedure TalcuMdpSyncDicts.DoRun(const aContext: TddRunContext);
var
 l_Iterator: TddFileIterator;
 l_Mutex: Tl3Mutex;
begin
{$If defined(AppServerSide)}
 Error(Format('Задача %s должна работать в асинхронном режиме.', [Description]));
 Exit;
{$Else defined(AppServerSide)}
 if SyncURL = '' then
 begin
  Error('Не задан URL для синхронизации словарей в Гардок');
  Exit;
 end;
 l_Mutex := Tl3Mutex.Create(GuardName);
 try
  l_Mutex.Enter;
  try
   l_Iterator := TddFileIterator.Make(ExtractFilePath(SyncFolderMask), ExtractFileName(SyncFolderMask));
  finally
   l_Mutex.Leave;
  end;
 finally
  FreeAndNil(l_Mutex);
 end;
 try
  if l_Iterator.Count > 0 then
  begin
   aContext.rProgressor.SetRefTo(f_Progressor);
   try
    f_HTTP := TIdHTTP.Create;
    try
     //f_HTTP.Request.CharSet := 'windows-1251';
     if UseProxy then
     begin
      // настраиваем тут прокси
      with f_HTTP.ProxyParams do
      begin
       ProxyServer := Self.ProxyServer;
       ProxyPort   := Self.ProxyPort;
       ProxyUsername := Self.ProxyLogin;
       ProxyPassword := Self.ProxyPassword;
       BasicAuthentication := True;
      end;
     end;
     f_TotalFileSize := 0;
     l_Iterator.IterateFiles(DoCalcSizes);
     if f_Progressor <> nil then
      f_Progressor.Start(f_TotalFileSize, Description);
     try
      f_SendedSize := 0;
      f_SendingSize := 0;
      l_Iterator.IterateFiles(DoSendFiles);
     finally
      if f_Progressor <> nil then
       f_Progressor.Stop;
     end;
    finally
     FreeAndNil(f_HTTP);
    end;
   finally
    FreeAndNil(f_Progressor);
   end;
  end;
 finally
  FreeAndNil(l_Iterator);
 end;
{$IfEnd defined(AppServerSide)}
end;

procedure TalcuMdpSyncDicts.HTTPEndWork(ASender: TObject;
  AWorkMode: TWorkMode);
begin
 if (aWorkMode = wmWrite) and (f_Progressor <> nil) then
  f_Progressor.ProcessUpdate(f_SendedSize + f_SendingSize);
end;

procedure TalcuMdpSyncDicts.HTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
 if Aborted then
  SysUtils.Abort;
 if (aWorkMode = wmWrite) and (f_Progressor <> nil) then
  f_Progressor.ProcessUpdate(f_SendedSize + aWorkCount);
end;

function TalcuMdpSyncDicts.IsHiddenFromUser: Boolean;
begin
 Result := True;
end;

function TalcuMdpSyncDicts.DoSendFiles(
  const aFileName: AnsiString): Boolean;
begin
 Result := not Aborted;
 if Result and FileExists(aFileName) then
 begin
  if SendFile(aFileName) then
   DeleteFile(aFileName);
 end;
end;

function TalcuMdpSyncDicts.SendFile(const aFileName: AnsiString): Boolean;
var
 l_Data: TStream;
begin
 l3System.Msg2Log('Синхронизация словарей в Гардок');
 Result := False;
 try
  l_Data := Tl3FileStream.Create(aFileName, l3_fmRead);
  try
   f_SendingSize := l_Data.Size;
   f_HTTP.OnWork := HTTPWork;
   f_HTTP.OnWorkEnd := HTTPEndWork;
   try
    f_HTTP.Post(SyncURL, l_Data);
   finally
    f_HTTP.OnWork := nil;
    f_HTTP.OnWorkEnd := nil;
   end;
   f_SendedSize := f_SendedSize + l_Data.Size;
  finally
   FreeAndNil(l_Data);
  end;
  l3System.Msg2Log('Словари в Гардоке синхронизированы успешно');
  Result := True;
 except
  on E: Exception do
   l3System.Msg2Log('ОШИБКА синхронизации словарей в Гардок: %s', [E.Message]);
 end;
end;

{$If defined(AppServerSide)}
procedure TalcuMdpSyncDicts.SetupServerSideConfigParams;
begin
 inherited;
 SetupMdpSyncParams(Self);
end;
{$IfEnd defined(AppServerSide)}

function TalcuMdpSyncDicts.DoCalcSizes(
  const aFileName: AnsiString): Boolean;
begin
 Result := not Aborted;
 if Result and FileExists(aFileName) then
  f_TotalFileSize := f_TotalFileSize + SizeOfFile(aFileName);
end;

initialization
 RegisterTaskClass(cs_ttMdpSyncDicts, TalcuMdpSyncDicts, 'Синхронизация словарей в Гардок');

end.