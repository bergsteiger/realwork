program alcuTaskExecutor;

// WerAddExcludedApplication

{%File 'ProjectDefine.inc'}

{.$Define DebugAssistant}

{$Include ..\alcuDefine.inc}

uses
  Windows,
  {$IFDEF DebugAssistant}
  dialogs,
  {$ENDIF DebugAssistant}
  Messages,
  l3Base,
  SysUtils,
  Classes,
  l3base64,
  csTaskTypes,
  csUserRequestManager,
  Everest_Schema,
  k2Base,
{$IFDEF AAC}
{$IFDEF Courts}
  alcuDocument in '..\alcuDocument.pas',
  arFiltersUtils in '..\..\Common\Utils\arFiltersUtils.pas',
  arDocObjectMixer in '..\..\Common\Utils\arDocObjectMixer.pas',
  arDocAttributesMixer in '..\..\Common\Utils\arDocAttributesMixer.pas',
  arFoundSelectionFilter in '..\..\Common\Utils\arFoundSelectionFilter.pas',
  alcuCourtDecision in '..\Process\alcuCourtDecision.pas',
  alcuCourtDecisionSubChecker in '..\Process\alcuCourtDecisionSubChecker.pas',
{$ENDIF Courts}
  alcuSourceFilter in '..\alcuSourceFilter.pas',
  alcuCourtDecisionListMaker in '..\alcuCourtDecisionListMaker.pas',
  alcuAACImportTaskResult in '..\Tasks\alcuAACImportTaskResult.pas',
  alcuAACImport in '..\Tasks\alcuAACImport.pas',
{$ENDIF AAC}
  alcuAutoExport in '..\Process\alcuAutoExport.pas',
  alcuAutoExportTaskResult in '..\Tasks\alcuAutoExportTaskResult.pas',
  alcuAutoExportTaskPrim in '..\Tasks\alcuAutoExportTaskPrim.pas',
  alcuAutoExportTask in '..\Tasks\alcuAutoExportTask.pas',
  alcuFTPBrowserParams in '..\Process\alcuFTPBrowserParams.pas',
  alcuFTPBrowser in '..\Process\alcuFTPBrowser.pas',
  alcuRegionAutoExportTaskPrim in '..\Tasks\alcuRegionAutoExportTaskPrim.pas',
  alcuRegionAutoExportTask in '..\Tasks\alcuRegionAutoExportTask.pas',
  alcuSpellChecker in '..\Process\alcuSpellChecker.pas',
  alcuAutoSpellTaskResult in '..\Tasks\alcuAutoSpellTaskResult.pas',
  alcuAutoSpell in '..\Tasks\alcuAutoSpell.pas',
  alcuPrime in '..\Process\alcuPrime.pas',
  alcuAnnotationTaskResult in '..\Tasks\alcuAnnotationTaskResult.pas',
  alcuAnnotationTask in '..\Tasks\alcuAnnotationTask.pas',
  alcuAutoClassReader in '..\alcuAutoClassReader.pas',
  alcuAutoClassTaskResult in '..\Tasks\alcuAutoClassTaskResult.pas',
  alcuAutoClassifier in '..\Tasks\alcuAutoClassifier.pas',
  alcuExport in '..\Tasks\alcuExport.pas',
  alcuAnoncedExportPrim in '..\Tasks\alcuAnoncedExportPrim.pas',
  alcuAnoncedExport in '..\Tasks\alcuAnoncedExport.pas',
  alcuAutoAnnoExportTaskPrim in '..\Tasks\alcuAutoAnnoExportTaskPrim.pas',
  alcuAutoAnnoExportTask in '..\Tasks\alcuAutoAnnoExportTask.pas',
{$IFDEF HavanskyExport}
  alcuHavanskyExportTaskPrim in '..\Tasks\alcuHavanskyExportTaskPrim.pas',
  alcuHavanskyExportTask in '..\Tasks\alcuHavanskyExportTask.pas',
{$ENDIF HavanskyExport}
  alcuImportTaskResult in '..\Tasks\alcuImportTaskResult.pas',
  alcuImport in '..\Tasks\alcuImport.pas',
  alcuRegionImportTaskResult in '..\Tasks\alcuRegionImportTaskResult.pas',
  alcuRegionImportTaskPrim in '..\Tasks\alcuRegionImportTaskPrim.pas',
  alcuRegionImportTask in '..\Tasks\alcuRegionImportTask.pas',
  ddCaseCodeMaker in '..\Tasks\ddCaseCodeMaker.pas',
  alcuRelPublishTaskResult in '..\Tasks\alcuRelPublishTaskResult.pas',
  alcuRelCorrector in '..\Tasks\alcuRelCorrector.pas',
{$IFDEF MDPSyncIntegrated}
  alcuMDP in '..\Process\alcuMDP.pas',
  IOUnit in 'W:\shared\GCI\IOUnit.pas',
  GarDocsUnit in 'W:\MDProcess\ArchiAdapterLib\GarDocsUnit.pas',
  ArchiAdapter in 'W:\MDProcess\ArchiAdapter\ArchiAdapter.pas',
  alcuMdpSyncDicts in '..\Tasks\alcuMdpSyncDicts.pas',
  alcuMdpImportDocs in '..\Tasks\alcuMdpImportDocs.pas',
  alcuMdpSyncStages in '..\Tasks\alcuMdpSyncStages.pas',
  alcuMdpSyncImport in '..\Tasks\alcuMdpSyncImport.pas',
  alcuMdpSyncIntf in '..\Process\alcuMdpSyncIntf.pas',
  alcuMdpProtoSyncronizer in '..\Process\alcuMdpProtoSyncronizer.pas',
  alcuMdpDatedSyncronizer in '..\Process\alcuMdpDatedSyncronizer.pas',
  alcuMdpStagesSyncronizer in '..\Process\alcuMdpStagesSyncronizer.pas',
  alcuMdpImportSyncronizer in '..\Process\alcuMdpImportSyncronizer.pas',
{$ENDIF MDPSyncIntegrated}
  alcuStrings in '..\Core\alcuStrings.pas',
  alcuUtils in '..\Server\alcuUtils.pas',
  alcuTypes in '..\Core\alcuTypes.pas',
  alcuMailServer in '..\Server\alcuMailServer.pas',
  alcuZipUtils in '..\Process\alcuZipUtils.pas',
  alcuCommands in '..\alcuCommands.pas',
  alcuAsyncExecutor in '..\Tasks\alcuAsyncExecutor.pas',
  JwaWinBase in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas',
  JwaNtStatus in 'W:\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas',
  JwaWinNT in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas',
  JwaWinType in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas'
  ;

var
  l_Executor: TsatAsyncExecutor;
  l_Wnd: THandle;

function satProcessMessage: Boolean;
var
  Msg: TMsg;
begin
  Result := False;
  if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
  begin
    Result := True;
    if Msg.Message <> WM_QUIT then
    begin
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end
    else
      l_Executor.RequestAbort;
  end;
end;

procedure satProcessMessages;
begin
  while satProcessMessage do ;
end;

procedure satHandleMessage;
begin
  if not satProcessMessage then
  begin
    UserRequestManager.ProcessNotifyList;
    Sleep(10);
  end;
end;

begin
{$IFDEF DebugAssistant}
showmessage('attach');
{$ENDIF DebugAssistant}

  SetErrorMode(SEM_FAILCRITICALERRORS or SEM_NOALIGNMENTFAULTEXCEPT or SEM_NOGPFAULTERRORBOX or SEM_NOOPENFILEERRORBOX);

  l3System.ShowObjectsWindow := False;
  ExitCode := cs_arsAborted;
  try
    if not (ParamCount in [4..5]) then
      raise Exception.Create('Неверные параметры вызова');
    if not FileExists(ParamStr(1)) then
      raise Exception.Create('Файл настроек не найден');

    // Такое грязное создание для исключения гонок..
    if Tk2TypeTable.GetInstance = nil then
     Assert(False, 'Нет схемы EVD');

    l_Wnd := AllocateHWnd(nil);
    try
      l_Executor := TsatAsyncExecutor.Create(ParamStr(1), ParamStr(2), StrToInt(ParamStr(3)), l3DecodeBase64(ParamStr(4)), l3DecodeBase64(ParamStr(5)));
      try
        l_Executor.Suspended := False;
        repeat
          satHandleMessage;
        until l_Executor.Suspended;
        ExitCode := l_Executor.ExitCode;
      finally
        l3Free(l_Executor);
      end;
    finally
      DeAllocateHWnd(l_Wnd);
    end;
  except
    on E: Exception do
    begin
      l3System.Msg2Log(E.Message);
      ExitCode := cs_arsGeneralError;
    end;
  end;
end.
