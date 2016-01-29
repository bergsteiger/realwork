unit alcuRegionAutoExportTask;

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
 Classes,
 
 ddProcessTaskPrim,
 ddProgressObj,

 csProcessTask,

 alcuRegionAutoExportTaskPrim
 ;

type
 TalcuRegionAutoExportTask = class(TalcuRegionAutoExportTaskPrim)
 private
  procedure PackDocuments(aProgressor: TddProgressObject);
  function MakeZipFileName: string;
  procedure PutToFTP;
 protected
  procedure DoRun(const aContext: TddRunContext); override;
  {$If defined(AppServerSide)}
  procedure DoRunSuccessfullyFinished(const aServices: IcsRunTaskServices); override;
  {$IfEnd defined(AppServerSide)}
  function NeedNotifySender: Boolean; override;
  function NeedCorrectLastDate: Boolean; override;
  {$If defined(AppServerSide)}
  function GetPrevCompilation: TDateTime;
  procedure CalcDates; override;
  {$IfEnd defined(AppServerSide)}
  procedure DoLoadFrom(aStream: TStream; aIsPipe: Boolean); override;
  function AllowSimultaneousRun: Boolean; override;
  function NeedSendCheckReport: Boolean; override;
 public
  class function CanAsyncRun: Boolean; override;
  function CanSimultaneousRunWith(const aTask: TddProcessTask): Boolean; override;
  {$If defined(AppServerSide)}
  procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
  procedure DoSaveTo(aStream: TStream; aIsPipe: Boolean); override;
 end;//TalcuRegionAutoExportTask

implementation

uses
 SysUtils,

 l3Base,
 l3LongintList,
 l3FileUtils,

 evdDTTypes,

 {$If defined(AppServerSide)}
 ddAppConfig,
 ddAppConfigTypes,
 ddAppConfigDataAdapters,
 ddScheduler,
 ddCalendarEvents,
 {$IfEnd defined(AppServerSide)}
 ddServerTask,
 csTaskTypes,

 {$If defined(AppServerSide)}
 alcuFTPBrowserParams,
 {$IfEnd defined(AppServerSide)}
 alcuFTPBrowser,
 alcuZipUtils
 ;

{ TalcuRegionAutoExportTask }

function TalcuRegionAutoExportTask.AllowSimultaneousRun: Boolean;
begin
 Result := True;
end;

  {$If defined(AppServerSide)}
procedure TalcuRegionAutoExportTask.CalcDates;
var
 l_TaskVer, l_TaskCom: TddSchedulerTask;
 l_Compilation, l_Version: TDateTime;
begin
 if Today = 0 then
  Today := Now;
 // Задачи Версия и Компиляция
 with TddScheduler(ddAppConfiguration.AsObject['Scheduler']) do
 begin
  l_TaskVer:= GetTaskByTaskType(ctVersion);
  l_TaskCom:= GetTaskByTaskType(ctCompilation);
 end; // with TddScheduler(ddAppConfiguration.AsObject['Scheduler'])
 // Собственно вычисление
 if (l_TaskVer <> nil) and (l_TaskCom <> nil) then
 begin
  l_Compilation:= l_TaskCom.PrevFullDateTime[Today];
  l_Version:= l_TaskVer.FullDateTime[l_Compilation];
  l_Compilation:= l_TaskCom.PrevFullDateTime[l_Compilation];
 end; // (l_TaskVer <> nil) and (l_TaskCom <> nil)
 if VersionDate = 0 then
  VersionDate := l_Version;
 if CompileDate = 0 then
  CompileDate := l_Compilation;
 if Today = 0 then
  Today:= GetPrevCompilation;
 l3System.Msg2Log('Подключенные в версию от %s', [DateToStr(VersionDate)]);
 l3System.Msg2Log('Измененные и аннотации с %s по %s', [DateToStr(CompileDate), DateToStr(Today)]);
end;
  {$IfEnd defined(AppServerSide)}

class function TalcuRegionAutoExportTask.CanAsyncRun: Boolean;
begin
 Result := True;
end;

function TalcuRegionAutoExportTask.CanSimultaneousRunWith(
  const aTask: TddProcessTask): Boolean;
begin
  Result := inherited CanSimultaneousRunWith(aTask);
  if Result and (aTask is TalcuRegionAutoExportTask) then
   Result := (Self = aTask) or (TalcuRegionAutoExportTask(aTask).RegionIndex <> RegionIndex);
end;

procedure TalcuRegionAutoExportTask.DoLoadFrom(aStream: TStream;
  aIsPipe: Boolean);
begin
 inherited;
 RegionIndex := ReadInteger(aStream);
end;

procedure TalcuRegionAutoExportTask.DoRun(const aContext: TddRunContext);
begin
 l3System.Msg2Log(Description);
 PureDir(ExportFolder);
 inherited DoRun(aContext);
 if TaskResult.IsSuccess and not Aborted then
 begin
  try
   PackDocuments(aContext.rProgressor);
   if Aborted then
    Exit;
   PutToFTP;
   l3System.Msg2Log('%s завершено', [Description]);
  except
   on E:Exception do
    l3System.Msg2Log('%s не удалось: %s', [Description, E.Message]);
  end;
 end
 else
  l3System.Msg2Log('%s не удалось', [Description]);
end;

  {$If defined(AppServerSide)}
procedure TalcuRegionAutoExportTask.DoRunSuccessfullyFinished(
  const aServices: IcsRunTaskServices);
begin
 inherited;
 PureDir(ExportFolder);
 DelDir(ExportFolder);
end;
  {$IfEnd defined(AppServerSide)}

procedure TalcuRegionAutoExportTask.DoSaveTo(aStream: TStream;
  aIsPipe: Boolean);
begin
 inherited;
 WriteInteger(aStream, RegionIndex);
end;

  {$If defined(AppServerSide)}
function TalcuRegionAutoExportTask.GetPrevCompilation: TDateTime;
var
 l_Task: TddSchedulerTask;
begin
 l_Task:= TddScheduler(ddAppConfiguration.AsObject['Scheduler']).GetTaskByTaskType(ctCompilation);
 if l_Task <> nil then
  Result:= l_Task.PrevFullDateTime[Now]
 else
  Result := Now;
end;
  {$IfEnd defined(AppServerSide)}

function TalcuRegionAutoExportTask.MakeZipFileName: string;
var
 l_Mask, l_Mask2, l_Folder: String;
 i: Integer;
begin
 // Нужно вытащить из маски все, кроме D, M, Y, сформировать дату и вернуть все обратно
 l_Mask:= FileNameMask;
 l_Mask2:= l_Mask;
 for i:= 1 to Length(l_Mask2) do
  if not (l_Mask2[i] in ['D', 'Y', 'M']) then
   l_Mask2[i]:= 'x';
 Result:= FormatDateTime(l_Mask2, Date);
 for i:= 1 to Length(l_mask2) do
  if l_Mask2[i] = 'x' then
   Result[i]:= l_Mask[i];
 // Чтобы не копились в папке с программой
 l_Folder:= ResultWarehouse;
 if ForceDirectories(l_Folder) then
  Result:= ConcatDirName(l_Folder, Result);
end;

function TalcuRegionAutoExportTask.NeedCorrectLastDate: Boolean;
begin
  Result := False;
end;

function TalcuRegionAutoExportTask.NeedNotifySender: Boolean;
begin
  Result := False;
end;

function TalcuRegionAutoExportTask.NeedSendCheckReport: Boolean;
begin
 Result := False;
end;

procedure TalcuRegionAutoExportTask.PackDocuments(
  aProgressor: TddProgressObject);
begin
 l3System.Msg2Log('Упаковка результатов экспорта...');
 if ZipFiles(MakeZipFileName, ExportFolder, '*.evd', False, aProgressor) then
  l3System.Msg2Log('Упаковка завершена')
 else
  l3System.Msg2Log('Упаковка результатов экспорта не выполнена!');
end;

procedure TalcuRegionAutoExportTask.PutToFTP;
var
 l_Browser: TalcuFTPBrowser;
begin
 l3System.Msg2Log('Копирование архива на FTP...');
 l_Browser := TalcuFTPBrowser.Create;
 try
  l_Browser.SetTaggedData(FTPParams);
  if not l_Browser.PutFile(MakeZipFileName) then
   l3System.Msg2Log('Архив не скопирован. Неверные параметры подключения к FTP');
 finally
  FreeAndNil(l_Browser);
 end;
 l3System.Msg2Log('Копирование завершено');
end;

  {$If defined(AppServerSide)}
procedure TalcuRegionAutoExportTask.SetupServerSideConfigParams;
var
 l_Config: TddAppConfigNode;
 l_Stages: TaeStagesSet;
 l_Index: Integer;
 l_FTPParams: TalcuFTPBrowserParams;
begin
 inherited;
 l_Index:= RegionIndex;
 l_Config := TddAppConfigNode(TddSimpleListDataAdapter(ddAppConfiguration.AsObject['regDestinations']).Objects[l_Index]);
 Description := Format('Создание дельты для получателя %s', [l_Config.AsString['Caption']]);
 OutFormat := outEVD;
 l_Stages:= [aeAnnotations, aeIncluded, aeChanged, aeNotIncluded];
 if not l_Config.AsBoolean['WithAnnoDest'] then
  Exclude(l_Stages, aeAnnotations);
 if not l_Config.AsBoolean['WithNotIncDest'] then
  Exclude(l_Stages, aeNotIncluded);
 Stages := l_Stages;

 if l_Config.AsInteger['DataTypeDest'] = 0 then
 begin
  DocumentsSource:= ae_dsAccGroups;
  AnnoUseAccGroups:= True;
 end
 else
  DocumentsSource:= ae_dsQuery;
 WithEditions:= l_Config.AsBoolean['WithEditionDest'];

 ResultWarehouse := ConcatDirName(ddAppConfiguration.AsString['regDestinationsArchive'], l_Config.AsString['Caption']);
 AccGroupsIDList.FromList(Tl3LongintList(l_Config.AsObject['AccGroupsDest']));
{$If not defined(LUK) AND not defined(SGC)}
 BasesIDList.FromList(nil);
{$IfEnd not defined(LUK) AND not defined(SGC)}
 DocQueryFileName := l_Config.AsString['QueryDest'];
{$If not defined(LUK) AND not defined(SGC)}
 DoneFileName := '';
{$IfEnd not defined(LUK) AND not defined(SGC)}
 ExportFolder := ConcatDirName(ddAppConfiguration.AsString['RootTaskFolder'], 'RegionExport\' + TaskID);
 InfoIDList.FromList(nil);
 NeedTopicList := False;
 eMailNotifyList := l_Config.AsString['NotifyAddressDest'];
 PartSize := 100000;
 SMSNotifyList := '';
 FileNameMask:= l_Config.AsString['FilenameMaskDest'];
 l_FTPParams := TalcuFTPBrowserParams.Create;
 try
  l_FTPParams.RemoteFolder:= l_Config.AsString['FTPFolderDest'];
  //l_FTPParams.Port := l_Config.AsInteger['FTPPortDest'];
  l_FTPParams.ServerName := l_Config.AsString['FTPServerDest'];
  l_FTPParams.Login := l_Config.AsString['FTPLoginDest'];
  l_FTPParams.Password := l_Config.AsString['FTPPasswordDest'];
  l_FTPParams.PassiveMode := l_Config.AsBoolean['FTPPassiveDest'];
  FTPParams := l_FTPParams.TaggedData;
 finally
  FreeAndNil(l_FTPParams);
 end;
end;
  {$IfEnd defined(AppServerSide)}

initialization
 RegisterTaskClass(cs_ttRegionAutoExport, TalcuRegionAutoExportTask, 'Экспорт внешних дельт');

end.