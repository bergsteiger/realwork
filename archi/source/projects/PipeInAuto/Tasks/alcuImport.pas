unit alcuImport;

interface

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

uses Classes, csProcessTask, ddImportPipe, DT_types, ddProgressObj, l3Base, csImport,
 l3LongintList,

 ddProcessTaskPrim,
 csTaskResult,
 alcuImportTaskResult
 ;

type
  TalcuImport = class(TcsImportTaskItem)
  private
    f_CommentList: TStrings;
    f_InPipe: TddImportPipe;
    f_SkipMessages: TStrings;
    procedure CommentWrite(TopicNo: lOngint; Comment: Tl3String);
    procedure CreateImportPipe;
    procedure DestroyPipes;
    procedure ReportResult;
    procedure WorkupRelated(aRelatedList: Tl3LongintList);
    function pm_GetTaskResult: TalcuImportTaskResult;
  protected
    procedure Cleanup; override;
    procedure DoAbort; override;
    procedure DoRun(const aContext: TddRunContext); override;
    function GetTaskResultClass: TcsTaskResultClass; override;
  {$If defined(AppServerSide)}
    procedure DoRunSuccessfullyFinished(const aServices: IcsRunTaskServices); override;
  {$IfEnd defined(AppServerSide)}
    function AllowSimultaneousRun: Boolean; override;
  public
    class function CanAsyncRun: Boolean; override;
    constructor Create({aOwner: TObject; }aUserID: TUserID); override;
    procedure TopicSkip(aTopicNo: Longint; const aMessage: String);
    procedure TopicStart(aTopicNo: Longint; const aMessage: String);
  {$If defined(AppServerSide)}
    procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
  {$If defined(AppServerSide)}
    procedure RunEnded(const aServices: IcsRunTaskServices); override;
  {$IfEnd defined(AppServerSide)}
(*    procedure WriteResult(aStream: TStream); override;*)
    property SkipMessages: TStrings read f_SkipMessages;
    property TaskResult: TalcuImportTaskResult read pm_GetTaskResult;
  end;

implementation

uses
 csTaskTypes, DT_Const, DT_IFltr, {$IfDef AppServerSide} ddAppConfig, alcuMailServer, {$EndIf AppServerSide} SysUtils,
 l3FileUtils, ddUtils, daUtils, daTypes, StrUtils, DT_Mail, dt_Utils, DT_Doc, l3Types,
 l3Stream, ddServerTask, ddFileIterator, dtIntf, DT_Sab, DT_Query,
 dt_AttrSchema, l3Chars, dt_LinkServ, alcuStrings;

resourcestring
  rsDocumentNo   = 'Документ №%d %s';
  rsImportPipeCreateError = 'Ошибка создания трубы импорта';
  rsSourceFolderNotFound = 'CRITICAL ERROR: Исходного каталога (%s) не существует';
  rsImportedDocsList = 'Список документов, импортированных в "Архивариус", находится в приложении'+cc_EOL;
  rsImportedOnlyReference = 'Были импортированы только справки.'+cc_EOL;
  rsFoundCommentsList = 'Список комментариев, найденных в импортированных документах'+cc_EOL;
  rsDeleteDocsCheckFailed = 'Часть документов не прошли проверку удаления:'+cc_EOL;
  rsNoAnyDocumentImported = 'Ни один из переданных на импорт документов импортирован не был';
  rsImportResults = 'Импорт из %s от %s';
  rsImportDoneCount = 'Импорт из %s завершен';
  rsSomeDocsHaveErrors = 'Некоторые документы содержали ошибки:'#10;
  rsImportDone = 'Импорт завершен. ';
  rsAllDocsImported = 'Все документы загружены за исключением:'#10;
  rsAllDocsImportedSeeReport = '%sВсе документы загружены за исключением %d. Полный список в отчете.'#10;
  rsErrorAtImport = 'Во время выполнения Вашего задания на импорт произошла ошибка';

{
****************************** TddImportTaskItem *******************************
}
constructor TalcuImport.Create({aOwner: TObject; }aUserID: TUserID);
begin
 inherited;
 f_SkipMessages := TStringList.Create;
 f_CommentList := TStringList.Create;
end;

procedure TalcuImport.DoAbort;
begin
 inherited;
 if f_InPipe <> nil then
  f_InPipe.AbortProcess;
end;

procedure TalcuImport.Cleanup;
begin
 l3Free(f_InPipe);
 l3Free(f_CommentList);
 l3Free(f_SkipMessages);
 inherited;
end;

procedure TalcuImport.CommentWrite(TopicNo: lOngint; Comment: Tl3String);
begin
  f_CommentList.Add(SysUtils.Format(rsDocumentNo, [TOpicNo, Comment.AsString]));
end;

procedure TalcuImport.CreateImportPipe;
begin
  f_InPipe:= TddImportPipe.Create(CurrentFamily);
  try
   f_InPipe.CleanFiles:= True;
   f_InPipe.UserDepend:= True;
   f_InPipe.CheckDocuments:= True;
   f_InPipe.CheckNullDocs:= False;
   f_InPipe.SameDocuments:= sdrDelete; { исправлено по указанию Нашего П 16.01.2001. Раньше было sdrDeleteIfNotModify }
   f_InPipe.DeleteConditions:= [dcIfNotVIncluded, dcIfNotHasAnno];
    //f_InPipe.DeleteConditions:= [dcIfNotModify,dcIfNotVIncluded]; Исправлено по указанию Большого Вождя 08.02.2001
   f_InPipe.MoveFiles:= False;
   f_InPipe.NotUpdatableDicts:= ddAllDicts;
   f_InPipe.FinalUpdate:= False;
   f_InPipe.SafeCleanDir:= SafeDir;
   f_InPipe.OnCommentWrite:= CommentWrite;
  except
   {$IfDef nsTest}
   raise;
   {$Else  nsTest}
   l3System.Msg2Log(rsImportPipeCreateError);
   {$EndIf nsTest}
  end;
end;

procedure TalcuImport.DestroyPipes;
begin
 l3Free(f_InPipe);
end;

procedure TalcuImport.DoRun(const aContext: TddRunContext);
begin
 if f_InPipe = nil then
  CreateImportPipe;
 try
  f_InPipe.Progressor:= aContext.rProgressor;
   f_CommentList.Clear;
   if (TaskFolder <> '') and DirectoryExists(TaskFolder) then
   begin
    f_InPipe.OnTopicStart:= TopicStart;
    f_InPipe.OnTopicSkip:= TopicSkip;
    //f_InPipe.Aborted := False;
     f_InPipe.UserID:= UserID;
     f_InPipe.WorkDir:= TaskFolder;
     f_InPipe.PictureDir:= TaskFolder;
     f_InPipe.InputFileType:= CheckFileType(f_InPipe.WorkDir, IsAnnotation);
     f_InPipe.CheckRegion:= IsRegion;
     f_InPipe.SafeCleanDirSuffix := TaskID;
     if DeleteIncluded then
      f_InPipe.DeleteConditions:= [dcIfNotHasAnno]
     else
      f_InPipe.DeleteConditions:= [dcIfNotVIncluded, dcIfNotHasAnno];
     try
      f_InPipe.Execute;
      ReportResult;
      f_InPipe.OnTopicStart:= nil;
      f_InPipe.OnTopicSkip:= nil;
     except
      on E: Exception do
      begin
       l3System.Exception2Log(E);
       Self.Error;
       raise;
      end;
     end; { try..except Execute }
   end
   else
   begin { Облом }
    {$IfDef nsTest}
    raise Exception.CreateFmt(rsSourceFolderNotFound, [TaskFolder]);
    {$Else  nsTest}
    l3System.Msg2Log(rsSourceFolderNotFound, [TaskFolder]);
    {$EndIf nsTest}
   end;
  finally
   DestroyPipes;
  end;
end;

procedure TalcuImport.TopicSkip(aTopicNo: Longint; const aMessage: String);
begin
  DocumentIDList.Remove(aTopicNo);
  f_SkipMessages.Add(aMessage);
end;

procedure TalcuImport.TopicStart(aTopicNo: Longint; const aMessage: String);
begin
  DocumentIDList.Add(aTopicNo);
end;

procedure TalcuImport.WorkupRelated(aRelatedList: Tl3LongintList);
var
 //l_RelSab: ISab;
 l_RegSab: ISab;
 l_List: Tl3LongintList;
 l_Q     : TdtQuery;
begin
 if RegionIDList.Count = 0 then
  {$IfDef nsTest}
  raise Exception.Create('Не задан параметр "Группа доступа Переданные в регионы"')
  {$Else  nsTest}
  l3System.Msg2Log('Не задан параметр "Группа доступа Переданные в регионы"')
  {$EndIf nsTest}
 else
 begin
 // Нужно проанализировать список справок на предмет их принадлежности к запрещенным ГД
 // В списке внешние номера

  l_RegSab := MakeValueSet(DocumentServer.FileTbl, fRelated_Fld, DocumentIDList);
  try
   LinkServer(CurrentFamily).ReNum.ConvertToInternalNumbers(l_RegSab);
   l_RegSab.TransferToPhoto(fRelated_Fld, DocumentServer.FileTbl);
   l_RegSab.RecordsByKey;

   l_List := Tl3LongintList.Make;
   try
    // переданные на обработку в регионы  [MagicNumbers].RegionID
    RegionIDList.ToList(l_List);
    l_Q := TdtDictQuery.Create(da_dlAccGroups, l_List);
   finally
    l3Free(l_List);
   end;

   try
    l_RegSab.AndSab(l_Q.FoundList); // находим во входных данных все уже переданные на обработку в регионы
   finally
    l3Free(l_Q);
   end;

   l_RegSab.ValuesOfKey(fRelated_Fld);
   // переливаем найденное в aRegionList
   LinkServer(CurrentFamily).ReNum.ConvertToExternalNumbers(l_RegSab);
   dtCopyValuesSabToList(l_RegSab, aRelatedList);
  finally
   l_RegSab:= nil;
  end;
 end;
end;

  {$If defined(AppServerSide)}
procedure TalcuImport.SetupServerSideConfigParams;
begin
 inherited;
 RegionIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['utRegionID']));
 SafeDir := ddAppConfiguration.AsString[SalcuAutoPipeServer_SafeDirName];
end;
  {$IfEnd defined(AppServerSide)}

function TalcuImport.GetTaskResultClass: TcsTaskResultClass;
begin
  Result := TalcuImportTaskResult;
end;

function TalcuImport.pm_GetTaskResult: TalcuImportTaskResult;
begin
  Result := TalcuImportTaskResult(inherited TaskResult);
end;

procedure TalcuImport.ReportResult;
var
 l_MailBody   : String;
 St           : Tl3String;
 l_RelList    : Tl3LongintList;
 i            : Integer;
 l_DocList: Tl3LongIntList;
begin
 if f_CommentList.Count > 0 then
 begin
  l_MailBody:= rsFoundCommentsList+
               f_CommentList.Text;
 end; // f_CommentList.Count > 0
 if DocumentIDList.Count > 0 then
 begin
  if IsUserRequireReports(UserID) then
  begin
   l_DocList := Tl3LongIntList.Make;
   try
     DocumentIDList.ToList(l_DocList);
     TaskResult.ImportedDocList.FromList(l_DocList);
   finally
     FreeANdNil(l_DocList);
   end;
   if TaskResult.ImportedDocList.Count > 0 then
   begin
    l_MailBody:= l_MailBody + cc_EOL + rsImportedDocsList;
   end
   else
   begin
    // только справки
    l_MailBody:= l_MailBody + cc_EOL + rsImportedOnlyReference;
    l_RelList:= Tl3LongintList.Make;
    try
     WorkupRelated(l_relList);
     // Вывалить список в тело письма
     if not l_RelList.Empty then
     begin
      l_MailBody:= l_MailBody  + cc_EOL + 'Список справок к заблокированным документам' + cc_EOL;
      for i:= 0 to l_RelList.Hi do
       l_MailBody:= l_MailBody  + cc_EOL + IntToStr(l_RelList[i]);
     end; // not l_RelList.Empty
    finally
     FreeAndNil(l_RelList);
    end;
   end;
  end
  else
  begin
   // Преобразовываем список номеров в пары "номер-название"
   ConvertList2Text(DocumentIDList, l_MailBody, True);
  end;
 end // f_TopicList.Count > 0
 else
 begin
  l_MailBody:= l_MailBody + cc_EOL + rsNoAnyDocumentImported;
 end;
 if (SkipMessages.Count > 0) then
  l_MailBody:= l_MailBody+cc_EOL+rsDeleteDocsCheckFailed+
               SkipMessages.Text;
 if f_InPipe.ErrorLog.Count > 0 then
  l_MailBody:= l_MailBody+cc_EOL+rsSomeDocsHaveErrors+
               f_InPipe.ErrorLog.Text;

 TaskResult.MailBody := l_MailBody;

 St:= Tl3String.Create;
 try
  St.AsString:= rsImportDone;
  if SkipMessages.Count > 0 then
  begin
   if SkipMessages.Count <= 10 then
    St.AsString:= St.AsString + rsAllDocsImported+ SkipMessages.Text
   else
    St.AsString:= SysUtils.Format(rsAllDocsImportedSeeReport,
                            [St.AsString, SkipMessages.Count]);
  end; // f_SkipMessages.Count > 0
  if f_InPipe.ErrorLog.Count > 0 then
  begin
   St.AsString:= St.AsString + rsSomeDocsHaveErrors +f_InPipe.ErrorLog.Text;
   St.Shrink(4096);
  end; // f_InPipe.ErrorLog.Count > 0
  TaskResult.UserNotification := St.St;
 finally
  l3Free(St);
 end;

 TaskResult.MailSubject := Format(rsImportResults, [SourceDir, DateToStr(SysUtils.Date)]);
 TaskResult.EMailSubject := Format(rsImportDoneCount, [Description]);
end;

  {$If defined(AppServerSide)}
procedure TalcuImport.DoRunSuccessfullyFinished(const aServices: IcsRunTaskServices);
var
 l_MailType   : TMailType;
 l_MailAttach : TDocumentSabList;
begin
  inherited;
  if IsUserRequireReports(UserID) then
  begin
    if (aServices <> nil) then
      aServices.SendTextMessage(UserID, TaskResult.UserNotification);
    if TaskResult.ImportedDocList.Count > 0 then
    begin
      l_MailType := mlDocList;
      l_MailAttach:= TDocumentSabList.CreateEmpty(CurrentFamily);
      ConvertList2Storage(TaskResult.ImportedDocList, l_MailAttach, True, True);
    end
    else
    begin
      l_MailType := mlNone;
      l_MailAttach := nil;
    end;
    try
      MailServer.SendMail(l_MailType,         // тип сообщения
                          UserID,            // номер адресата
                          TaskResult.MailSubject,// Тема сообщения
                          PChar(TaskResult.MailBody),    // текст сообщения
                          l_MailAttach);       // выборка номеров

    finally
      FreeAndNil(l_MailAttach);
    end;
  end 
  else
   if NeedSendMailReport then
    alcuMail.SendEMail(ReplyAddress, TaskResult.MailBody, TaskResult.EMailSubject, False, nil);
end;
  {$IfEnd defined(AppServerSide)}

class function TalcuImport.CanAsyncRun: Boolean;
begin
  Result := True;
end;

function TalcuImport.AllowSimultaneousRun: Boolean;
begin
  Result := False;
end;

  {$If defined(AppServerSide)}
procedure TalcuImport.RunEnded(const aServices: IcsRunTaskServices);
begin
 inherited;
 if IsUserRequireReports(UserID) and (aServices <> nil) and (Status in cs_tsErrorStatuses) then
  aServices.SendTextMessage(UserID, rsErrorAtImport);
end;
  {$IfEnd defined(AppServerSide)}

initialization
 RegisterTaskClass(cs_ttImport, TalcuImport, 'Импорт документов');

end.
