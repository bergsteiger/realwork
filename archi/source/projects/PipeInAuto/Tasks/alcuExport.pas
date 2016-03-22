unit alcuExport;

interface

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

uses
 Classes,
 CsDataPipe, csExport, csProcessTask,
 ddProgressObj, ExportPipe,
 dtIntf, DT_Sab, DT_Types,
 L3LongintList,
 csMessageManager,
 k2Base,
 ddProcesstaskPrim
 , l3StringList;

type
  TalcuExport = class(TcsExport)
  private
    f_ErrorList: Tl3StringList;
    f_OutPipe: TExportPipe;
    procedure CorrectSab(aRegionList, aBusyList, aLockedList: Tl3LongintList);
    procedure CreateExportPipe(aProgressor: TddProgressObject);
    procedure DestroyPipes;
    procedure SendRegionMail(aUserID: TUserID; aAlready, aBusy: Tl3LongintList);
    procedure SetAccessGroup(aSAB: ISab; aUserID: TUserID);
    procedure UnLockRegionDocuments(aLocked: Tl3LongintList);
    procedure _CorrectRegionSab(aUserID: TUserID; aLocked: Tl3LongintList);
  protected
    procedure DoRun(const aContext: TddRunContext); override;
    function GetFinalExportDirectory: AnsiString; virtual;
    function GetClearAttributes: TexpClearAttributes; virtual;
    procedure DoAbort; override;
    procedure ReportEmptyDocs(EmptyCount: Integer); virtual;
    procedure SendErrors;
    procedure Cleanup; override;
  public
    class function CanAsyncRun: Boolean; override;
  {$If defined(AppServerSide)}
    procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
    procedure _OnReportEmpty(aSender: TObject; aEmptyCount: Integer);
    property ErrorList: Tl3StringList read f_ErrorList;
  end;//TalcuExport

implementation

uses
 DT_Const, dt_AttrSchema, dt_ImpExpTypes, L3Base, DateUtils, HT_Const, L3Stream,
 L3FileUtils, SysUtils, alcuStrings, alcuUtils, DT_Doc, StrUtils, ddProgressTypes, l3ShellUtils,
 l3String,
 HT_Dll, ddUtils, {$If defined(AppServerSide)} ddAppConfig, {$IfEnd defined(AppServerSide)}
 daUtils,
 daInterfaces,
 daTypes,
 daSchemeConsts,
 {$If defined(AppServerSide)} daDataProvider, {$IfEnd defined(AppServerSide)}
 DT_LinkServ, DT_Link, DT_Lock, Dt_Query, dt_Mail, DT_Utils,
 alcuMailServer, alcuTypes, ddServerTask, CsTaskTypes, DT_DictConst, dt_UserConst,
 l3Types, ddPipeOutInterfaces,

 AutoAnnoExportTask_Const
 , csExportTaskPrim;

procedure TalcuExport.DoAbort;
begin
 inherited DoAbort;
 if f_OutPipe <> nil then
  f_OutPipe.AbortExport;
end;

procedure TalcuExport.CorrectSab(aRegionList, aBusyList, aLockedList:
    Tl3LongintList);
var
 l_WorkSab : ISab;
 l_RegSab, l_ValSab: ISab;
 l_Q     : TdtQuery;
 l_List  : Tl3LongintList;
 l_ID    : TDocID;

 l_RegionID, i: Integer;
 l_MaxMask, l_LockMask: Integer;
 l_Handle: TJLHandle;
begin
 // Их может быть несколько!
 if RegionIDList.Count = 0 then
  l3System.Msg2Log('Не задан параметр "Группа доступа Переданные в регионы"')
 else
 begin
  l_RegSab := MakeSabCopy(DocSAB);
  l_RegSab.RecordsByKey(fID_Fld);
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

  // переливаем найденное в aRegionList
  l_ValSab := MakeSabCopy(l_RegSab);
  try
   l_ValSab.ValuesOfKey(fId_Fld);
   dtCopyValuesSabToList(l_ValSab, aRegionList);
  finally
   l_ValSab := nil;
  end;

  // теперь получим список документов, которые можно пытаться обработать
  l_WorkSab := MakeSabCopy(DocSAB); // исходный...
  l_WorkSab.RecordsByKey(fID_Fld);
  l_RegSab.InvertSab;
  l_WorkSab.AndSab(l_RegSab);     // минус УЖЕ переданные в регионы


  l_List := Tl3LongintList.Make;
  try
   // перельем все полученные документы в список для обработки
   l_WorkSab.ValuesOfKey(fId_Fld);
   dtCopyValuesSabToList(l_WorkSab, l_List);

   // а теперь будем последовательно захватывать документы,
   // а какие не получится -  переносить в список занятых
   for I := Pred(l_List.Count) downto 0 do
   begin
    l_ID := TDocID(l_List[I]);
    l_Handle := LockServer.LockDoc(CurrentFamily, l_ID, l_MaxMask, l_LockMask);
    try
     if (l_LockMask and acgNameAttr) = 0 then
     begin // Нам этот документ не подходит
      aBusyList.Add(l_ID);
      l_List.Delete(I);
      LockServer.UnlockDoc(CurrentFamily, l_Handle);
     end
     else
      aLockedList.Add(l_Handle);
    finally
     //LockServer.UnlockDoc(CurrentFamily, l_Handle);
    end;
   end;

   // Теперь сформируем саб из обрабатываемых документов (тех, кто остался в l_List)
   DocSab := MakeValueSet(DocumentServer.FileTbl, fId_Fld, l_List);
  finally
   l3Free(l_List);
  end;
 end;
end;

procedure TalcuExport.CreateExportPipe(aProgressor: TddProgressObject);
begin
  f_OutPipe:= TExportPipe.Create{(nil)};
   f_OutPipe.Family:= CurrentFamily;
   f_OutPipe.InternalFormat:= False;
   f_OutPipe.AllPartsDivideBy([edbTopic]);
   f_OutPipe.UpdateFiles:= False;
   f_OutPipe.ExportDocument:= True;
   f_OutPipe.Progressor:= aProgressor;
   f_OutPipe.OnReportEmpty := _OnReportEmpty;
end;

procedure TalcuExport.DestroyPipes;
begin
  l3Free(f_OutPipe);
end;

procedure TalcuExport.DoRun(const aContext: TddRunContext);
var
  l_IniFileName: string;
  tmpSab: Sab;
  //l_Sab: ISab;
  l_Booms: Boolean;
  l_Stream: Tl3FileStream;
  l_ExportCount, i: Integer;
  l_ExportRec: TExpResultRec;
  l_Busy: Tl3LongintList;
  l_Locked : Tl3LongintList;
 l_ExecResult: Cardinal;
begin
// Нужно отделить обычный экспорт от серверного и т.п.
 CreateExportPipe(aContext.rProgressor);
 try
  l_Locked := Tl3LongintList.make;
  try
    // Вывод в лог информации о выполняемом задании
     l3System.Msg2Log('%s: %s', [UserNameByID(UserID), Description]);
     if ExportKW then
      l3System.Msg2Log(rsklevyeslovav, [DocumentFileNameMask]);
    // конец вывода
     f_OutPipe.ExportDirectory := GetFinalExportDirectory;

     // Либо мы уже имеем готовый список в DocSab, либо у нас диапазон, который либо список, либо единичный документ
     Assert((DocSab <> nil) or (DiapasonType in [tdSingle, tdNumList]), 'Такое не умеем экспортировать!');

     if (DiapasonType = tdNumList) or (DocSab <> nil) then
     begin
      if (DocSab = nil) and (DiapasonType = tdNumList) then
       MakeSab;
      Assert(DocSab <> nil, 'Список документов неопределён!');
      if ToRegion <> cUndefDictID then
       _CorrectRegionSab(UserID, l_Locked); { TODO -oДмитрий Дудко -cРазвитие : На самом деле нельзя отправлять письма из процедуры проверки саба }
      f_OutPipe.DocSab:= DocSab;
     end
     else
      f_OutPipe.MakeSingleDocSab(DocID, False);

     f_OutPipe.ExportEditions        := ExportEditions;
     f_OutPipe.ExportEmpty           := ExportEmptyKW;
     f_OutPipe.ExportDocument        := ExportDocument;
     f_OutPipe.ExportReferences      := ExportReferences;
     f_OutPipe.ExportRTFBody         := ExportRTFBody;
     f_OutPipe.ExportKW              := ExportKW;
     f_OutPipe.ExportDocImage        := ExportDocImage;
     f_OutPipe.MultiUser             := MultiUser;
     //f_OutPipe.Family                := Family;
     f_OutPipe.InternalFormat        := InternalFormat;
     f_OutPipe.OutFileType           := TepSupportFileType(OutFileType);

     // Пока сделано так, чтобы сохранить текущее поведение. Если будет необходимость в
     // более тонкой настройке, то можно будет переделать...
     case SeparateFiles of
      divNone     : f_OutPipe.AllPartsDivideBy([]);
      divTopic    : f_OutPipe.AllPartsDivideBy([edbTopic]);
      divAccRight : f_OutPipe.AllPartsDivideBy([edbAccGroup]);
      divSize     : f_OutPipe.AllPartsDivideBy([edbSize]);
     end;

     f_OutPipe.FileMask[edpDocument]  := l3CStr(DocumentFileNameMask);
     f_OutPipe.FileMask[edpReference] := l3CStr(ReferenceFileNameMask);
     f_OutPipe.FileMask[edpAnnotation]:= l3CStr(AnnoTopicFileName);
     f_OutPipe.ObjTopicFileName      := ObjTopicFileName;
     f_OutPipe.KWFileName            := KWFileName;
     f_OutPipe.OutputFileSize        := OutputFileSize;
     f_OutPipe.ExportAnnotation      := ExportAnnoTopics;
     f_OutPipe.OnlyStructure         := OnlyStructure;
     f_OutPipe.ClearAttributes       := GetClearAttributes;
     f_OutPipe.FormulaAsPicture      := FormulaAsPicture;
     try
       FreeAndNil(f_ErrorList);
       f_OutPipe.Execute;
       f_ErrorList := f_OutPipe.ErrorList.Use;
       SendErrors;
       if FileExists(AdditionalProcess) then
        l_ExecResult:= FileExecuteWait(AdditionalProcess,
                                       f_OutPipe.ExportDirectory,
                                       ExtractFileDir(AdditionalProcess),
                                       esMinimized);

       // Нужно окончательно перейти на DocSab
       if (ToRegion <> cUndefDictID) and (DiapasonType = tdNumList) then
       begin
        SetAccessGroup(DocSab, UserID);
        UnLockRegionDocuments(l_Locked);
       end; // if (ToRegion <> cUndefDictID) and (D.Typ = tdNumList)
     except
      on E: Exception do
      begin
       l3System.Exception2Log(E);
       Error;
       Exit;
      end;
     end; // try..except

     if (UserID > 0) then
     begin
      { TODO -oДмитрий Дудко -cРазвитие : Переделать на общий механизм - все сделано-отдай результат }
 //     if IsUserRequireReports(aTask.UserID) then // Для того, чтобы можно было забрать задания
 //      MessageManager.SendNotify(aTask.UserID, ntExportDone, aTask.Index, aTask.TaskID);

           l3System.Msg2Log(rsEksportpolzovatelyazavershen, [UserNameByID(UserID)]);
     end; // (aTask.UserID > 0)
  finally
   l3Free(l_Locked);
  end;
 finally
  DestroyPipes;
 end;
end;

function TalcuExport.GetFinalExportDirectory: AnsiString;
begin
 {$IFDef ServerAssistantSide}
 Result := IfThen((UserID <> usServerService), TaskFolder, ExportDirectory);
 {$Else ServerAssistantSide}
 Result := IfThen(IsUserRequireReports(UserID), TaskFolder, ExportDirectory);
 {$EndIF ServerAssistantSide}
end;

procedure TalcuExport.SendErrors;
begin
 if (ErrorList.Count > 0) and (UserID <> usServerService) then
 begin
  dt_mail.MailServer.SendMail(mlNone, UserID, DateTimeToStr(Now) + ' - Ошибки экспорта',
  PAnsiChar(l3StringListToStr(ErrorList)),
  nil);
 end;
end;

procedure TalcuExport.SendRegionMail(aUserID: TUserID; aAlready, aBusy: Tl3LongintList);
var
 i: Integer;
 l_MailAttach: TDocumentSabList;
 l_MailType: TMailType;
 l_MailBody: String;
begin
 l_MailBody:= 'Не будут экспортированы:'#13#10;
 l_mailType := mlNone;
 l_MailAttach := nil;
 if aBusy.Count > 0 then
 begin
  { TODO : Нужно перевести во внешние номера }

  l_MailBody:= l_MailBody + '  - документы, находящиеся на редактировании:'#13#10;
  for i:= 0 to aBusy.Hi do
   l_MailBody:= l_MailBody + IntToStr(LinkServer(CurrentFamily).Renum.GetExtDocID(aBusy.Items[i])) + #13#10;
 end; // aBusy.Count > 0

 if aAlready.Count > 0 then
 begin
  l_MailAttach:= TDocumentSabList.CreateEmpty(CurrentFamily);
  try
   { TODO : Нужно перевести во внешние номера }
   ConvertList2Storage(aAlready, l_MailAttach, False);
   l_MailBody:= l_MailBody + '  - документы, уже переданные в регионы (список во вложении)';
   l_MailType:= mlDocList;
   try
    Mailserver.SendMail(l_MailType,         // тип сообщения
                        aUserID,            // номер адресата
                        'Предупреждение - '+DateToStr(SysUtils.Date),// Тема сообщения
                        PChar(l_MailBody),    // текст сообщения
                        l_MailAttach);       // выборка номеров
   except
    on E: Exception do
    begin
     l3System.Msg2Log(SysUtils.Format(rsOshibkaotpravkipismapolzovatelID, [UserNameByID(aUserID), aUserID]));
     Exception2Log(E);
    end;
   end; // try except
  finally
   l3Free(l_MailAttach);
  end; // try..finally
 end // if aTask.DcumentIDList.Count > 0
 else
  MailServer.SendMail(l_MailType,         // тип сообщения
                        aUserID,            // номер адресата
                        'Предупреждение - '+DateToStr(SysUtils.Date),// Тема сообщения
                        PChar(l_MailBody),    // текст сообщения
                        l_MailAttach);       // выборка номеров;
end;

procedure TalcuExport.SetAccessGroup(aSAB: ISab; aUserID: TUserID);
var
 l_AccGroup: Cardinal;
begin
 l_AccGroup:= ToRegion;
 if l_AccGroup <> cUndefDictID then
 begin
  LinkServer(CurrentFamily).LogBook.PutLogRecToDocs(aSab, acAttrWork, aUserID);
  aSab.TransferToPhoto(lnkDocIDFld, LinkServer(CurrentFamily)[atAccGroups]);
  aSAB.RecordsByKey;
  aSab.ModifyRecs(lnkDictIDFld, l_AccGroup);
 end;
end;

procedure TalcuExport.UnLockRegionDocuments(aLocked: Tl3LongintList);
var
 i: Integer;
begin
 for i:= 0 to aLocked.Hi do
  LockServer.UnlockDoc(CurrentFamily, aLocked.Items[i]);
end;

procedure TalcuExport._CorrectRegionSab(aUserID: TUserID; aLocked:
    Tl3LongintList);
var
 l_Busy: Tl3LongintList;
 l_Already: Tl3LongintList;
begin
 l_Busy:= Tl3LongintList.Make;
 try
  l_Already:= Tl3LongintList.Make;
  try
   CorrectSab(l_Already, l_Busy, aLocked);
   if (l_Already.Count > 0) or (l_Busy.Count > 0) then
    SendRegionMail(aUserID, l_Already, l_Busy);
  finally
   l3Free(l_Already);
  end;
 finally
  l3Free(l_Busy);
 end;
end;

procedure TalcuExport._OnReportEmpty(aSender: TObject; aEmptyCount: Integer);
begin
 ReportEmptyDocs(aEmptyCount);
end;

function TalcuExport.GetClearAttributes: TexpClearAttributes;
begin
  Result := attrNone;
end;

procedure TalcuExport.ReportEmptyDocs(EmptyCount: Integer);
begin
 alcuMail.SendEmailNotify(eventEmptyDocuments, True,
                          Format('Обнаружены пустые документы в количестве %d штук', [EmptyCount]),
                          dd_apsExport);
end;

  {$If defined(AppServerSide)}
procedure TalcuExport.SetupServerSideConfigParams;
begin
 inherited;
 TaskFolder := GlobalDataProvider.GetHomePath(UserID);
 RegionIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['utRegionID']));
end;
  {$IfEnd defined(AppServerSide)}

class function TalcuExport.CanAsyncRun: Boolean;
begin
  Result := True;
end;

procedure TalcuExport.Cleanup;
begin
 FreeAndNil(f_ErrorList);
 inherited;
end;

initialization
 RegisterTaskClass(cs_ttExport, TalcuExport, 'экспорт');

end.
