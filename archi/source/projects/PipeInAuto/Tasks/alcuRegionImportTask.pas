unit alcuRegionImportTask;

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
 csTaskResult,
 csProcessTask,
 ddProcessTaskPrim,

 alcuFTPBrowser,
 alcuRegionImportTaskResult,
 alcuRegionImportTaskPrim
 ;

type
 TalcuRegionImportTask = class(TalcuRegionImportTaskPrim)
 private
  f_ArchiveFileName: String;
  procedure GetFileFromFTP;
  procedure EnumFile(const Sender: TalcuFTPBrowser; const aFileName: String; var NeedStop: Boolean);
  procedure DeleteFileFromFTP;
  function UnZipFile: Boolean;
  function TrueFileNameMask: string;
  function FullArchiveFileName: String;
  function pm_GetTaskResult: TalcuRegionImportTaskResult;
 protected
  function GetTaskResultClass: TcsTaskResultClass; override;
  function AllowSimultaneousRun: Boolean; override;
  procedure DoRun(const aContext: TddRunContext); override;
  {$If defined(AppServerSide)}
  procedure DoRunSuccessfullyFinished(const aServices: IcsRunTaskServices); override;
  {$IfEnd defined(AppServerSide)}
 public
  class function CanAsyncRun: Boolean; override;
  function CanSimultaneousRunWith(const aTask: TddProcessTask): Boolean; override;
  {$If defined(AppServerSide)}
  procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
  property TaskResult: TalcuRegionImportTaskResult read pm_GetTaskResult;
 end;//TalcuRegionImportTask

implementation

uses
 SysUtils,

 l3Base,
 l3FileUtils,

 csTaskTypes,

 ddServerTask,
 {$If defined(AppServerSide)}
 ddAppConfig,
 ddAppConfigTypes,
 ddAppConfigDataAdapters,
 {$IfEnd defined(AppServerSide)}

 alcuFTPBrowserParams,
 alcuZipUtils
 ;

{ TalcuRegionImportTask }

function TalcuRegionImportTask.AllowSimultaneousRun: Boolean;
begin
 Result := True;
end;

class function TalcuRegionImportTask.CanAsyncRun: Boolean;
begin
 Result := False;
end;

function TalcuRegionImportTask.CanSimultaneousRunWith(
  const aTask: TddProcessTask): Boolean;
begin
  Result := inherited CanSimultaneousRunWith(aTask);
  if Result and (aTask is TalcuRegionImportTask) then
   Result := (Self = aTask) or (TalcuRegionImportTask(aTask).RegionIndex <> RegionIndex);
end;

procedure TalcuRegionImportTask.DeleteFileFromFTP;
var
 l_Browser: TalcuFTPBrowser;
begin
 l3System.Msg2Log('Удаление архива с FTP...');
 l_Browser := TalcuFTPBrowser.Create;
 try
  l_Browser.SetTaggedData(FTPParams);
  if not l_Browser.DeleteFile(f_ArchiveFileName) then
   raise Exception.CreateFmt('%s - не удалось удалить файл: %s', [Description, f_ArchiveFileName]);
 finally
  FreeAndNil(l_Browser);
 end;
 l3System.Msg2Log('Удаление завершено');
end;

procedure TalcuRegionImportTask.DoRun(const aContext: TddRunContext);
begin
 GetFileFromFTP;
 if FullARchiveFileName = '' then
 begin
  l3System.Msg2Log('%s - файлы дельт на FTP не найдены',[Description]);
  Exit;
 end;
 if UnZipFile then
 begin
  inherited DoRun(aContext);
  if not Aborted then
   DeleteFileFromFTP;
 end
 else
  raise Exception.CreateFmt('%d - не удалось распаковать файл: %s', [Description, f_ArchiveFileName]);
end;

{$If defined(AppServerSide)}
procedure TalcuRegionImportTask.DoRunSuccessfullyFinished(
  const aServices: IcsRunTaskServices);
var
 l_Task: TalcuRegionImportTask;
begin
 inherited;
 if not Aborted and TaskResult.HasMoreFilesToProcess then
 begin
  l_Task := TalcuRegionImportTask.Create(UserID);
  try
   l_Task.RegionIndex := RegionIndex;
   aServices.AddActiveTask(l_Task);
  finally
   FreeAndNil(l_Task);
  end;
 end;
end;
{$IfEnd defined(AppServerSide)}

procedure TalcuRegionImportTask.EnumFile(const Sender: TalcuFTPBrowser;
  const aFileName: String; var NeedStop: Boolean);
begin
 if f_ArchiveFileName = '' then
 begin
  f_ArchiveFileName := aFileName;
  ForceDirectories(SourceWarehouse);
  if not Sender.GetFile(f_ArchiveFileName, SourceWarehouse) then
   raise Exception.CreateFmt('%d - не удалось скачать файл: %s', [Description, aFileName])
  else
   l3System.Msg2Log('Получен файл %s', [f_ArchiveFileName]);
 end
 else
 begin
  NeedStop := True;
  TaskResult.HasMoreFilesToProcess := True;
 end;
end;

procedure TalcuRegionImportTask.GetFileFromFTP;
var
 l_Browser: TalcuFTPBrowser;
begin
 l3System.Msg2Log('Получение архива с FTP...');
 l_Browser := TalcuFTPBrowser.Create;
 try
  l_Browser.SetTaggedData(FTPParams);
  f_ArchiveFileName := '';
  l_Browser.EnumFiles(TrueFileNameMask, EnumFile);
 finally
  FreeAndNil(l_Browser);
 end;
 l3System.Msg2Log('Получение завершено');
end;

function TalcuRegionImportTask.GetTaskResultClass: TcsTaskResultClass;
begin
 Result := TalcuRegionImportTaskResult;
end;

function TalcuRegionImportTask.pm_GetTaskResult: TalcuRegionImportTaskResult;
begin
 Result := TalcuRegionImportTaskResult(inherited TaskResult);
end;

function TalcuRegionImportTask.UnZipFile: Boolean;
begin
 if FileExists(FullArchiveFileName) then
 begin
  ForceDirectories(TaskFolder);
  Result:= UnzipFiles(FullArchiveFileName, TaskFolder);
 end 
 else
  Result := False; 
end;

  {$If defined(AppServerSide)}
procedure TalcuRegionImportTask.SetupServerSideConfigParams;
var
 l_Index: Integer;
 l_Config: TddAppConfigNode;
 l_FTPParams: TalcuFTPBrowserParams;
begin
 inherited;
 l_Index:= RegionIndex;
 l_Config := TddAppConfigNode(TddSimpleListDataAdapter(ddAppConfiguration.AsObject['regSources']).Objects[l_Index]);
 Description := Format('Импорт дельты от %s', [l_Config.AsString['Caption']]);
 SourceWarehouse := ConcatDirName(ddAppConfiguration.AsString['regSourcesArchive'], l_Config.AsString['Caption']);

 NeedSendMailReport := True;
 TaskFolder := ddAppConfiguration.AsString['RootTaskFolder'];
 ReplyAddress := l_Config.AsString['NotifyAddress'];
 DeleteIncluded := True;

 FileNameMask := l_Config.AsString['FilenameMask'];

 l_FTPParams := TalcuFTPBrowserParams.Create;
 try
  l_FTPParams.RemoteFolder:= l_Config.AsString['FTPFolder'];
  //l_FTPParams.Port := l_Config.AsInteger['FTPPort'];
  l_FTPParams.ServerName := l_Config.AsString['FTPServer'];
  l_FTPParams.Login := l_Config.AsString['FTPLogin'];
  l_FTPParams.Password := l_Config.AsString['FTPPassword'];
  l_FTPParams.PassiveMode := l_Config.AsBoolean['FTPPassive'];
  FTPParams := l_FTPParams.TaggedData;
 finally
  FreeAndNil(l_FTPParams);
 end;
end;
  {$IfEnd defined(AppServerSide)}

function TalcuRegionImportTask.TrueFileNameMask: string;
var
 i: Integer;
begin
 Result:= FileNameMask;
 for i:= 1 to Length(Result) do
  if Result[i] in ['D', 'M', 'Y'] then
   Result[i]:= '?';
end;

function TalcuRegionImportTask.FullArchiveFileName: String;
begin
 if f_ArchiveFileName <> '' then
  Result := ConcatDirName(SourceWarehouse, f_ArchiveFileName)
 else
  Result := '';
end;

initialization
 RegisterTaskClass(cs_ttRegionImport, TalcuRegionImportTask, 'Импорт внешних дельт');

end.
