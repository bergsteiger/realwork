unit alcuSpellCorrectTask;

interface
{$I alcuDefine.inc}

uses
 csSpellCorrectTask, Classes, ddProgressObj, DT_Types, l3LongintList,

 csMessageManager,
 ddProcessTaskPrim
 ;

type
 TalcuSpellCorrectTask = class(TcsSpellCorrectTask)
 private
  f_CurDocID: Integer;
  f_DocList: Tl3LongintList;
  f_ErrorList: TStrings;
  f_IsRelated: Boolean;
  procedure SendReport;
 protected
  procedure Cleanup; override;
  procedure DoRun(const aContext: TddRunContext); override;
  procedure MarkCorrectedDocs;
  procedure SpellError(const aDescript: String; aCategory: Integer);
 public
  constructor Create({aOwner: TObject; }aUserID: TUserID); override;
(*  procedure WriteResult(aStream: TStream); overload; override;*)
  property CurDocID: Integer read f_CurDocID write f_CurDocID;
 end;

implementation

uses
 cstasktypes,
 ddServerTask, ddMisspellCorrect,
 m3DB,
 m3DBActions,
 m3StorageInterfaces,
 m3StorageElementIDList,
 evdReader,
 evdWriter,
 evEvdRd,
 daUtils,
 dt_Serv,
 DT_Doc,
 SysUtils,
 l3FileUtils, L3Filer, m3DBInterfaces, L3Base, l3Interfaces, L3Types, DT_Const,
 DT_LinkServ,
 DT_Mail, csProcessTask, l3LongintListPrim, l3Date,
 daInterfaces, Dt_TblCacheDef, Dt_TblCache,

 m3DBFiler
 ;

{
******************************** TddProcessTask ********************************
}
constructor TalcuSpellCorrectTask.Create({aOwner: TObject; }aUserID: TUserID);
begin
 inherited;
 f_ErrorList:= TStringList.Create;
 f_DocList:= Tl3LongintList.Make;
 //TaskType:= cs_ttSpellCheck;
 Self.StatusW := cs_tsDelayed;
end;

procedure TalcuSpellCorrectTask.Cleanup;
begin
 inherited;
 FreeAndNil(f_ErrorList);
 FreeAndNil(f_DocList);
end;


procedure TalcuSpellCorrectTask.DoRun(const aContext: TddRunContext);
var
 l_TopicListFiler: Tl3DOSFiler;
 l_Name     : string;
 l_Reader   : TevCustomEvdReader;
 l_Writer   : TevdCustomNativeWriter;
 l_Filter   : TddMisspellCorrectFilter;
 l_OutFiler : Tm3DBFiler;
 l_InFiler  : Tl3CustomFiler;
 l_DocID    : TDocID;
 l_RelID    : TDocID;
 l_SRString : Tl3WString;
 l_DB       : Im3DB;
 l_Tmp      : Boolean;

  procedure CheckOneDocument(const aDocID: TDocID);
  var
   l_Doc: Im3DBDocument;
  begin
   l_Doc := l_DB.GetDocument(aDocID);
   l_InFiler.Handle := aDocID;
   l_InFiler.COMStream := l_Doc.Open(m3_saRead, m3_dsMain);
   l_OutFiler.Handle := aDocID;
   l_OutFiler.PartSelector := m3_dsMain;
   l_OutFiler.ObjectIndex := 0;
   l_OutFiler.Open;
   try
    l_Reader.Execute;
   finally
    l_InFiler.COMStream := nil;
    l_OutFiler.Close;
   end;
  end;

begin
 l3System.Msg2Log('Обработка файла замен %s', [ExtractFileName(ReplacementFile.Name)]);
 f_DocList.Clear;
 l_TopicListFiler := Tl3DOSFiler.Make(ReplacementFile.Name, l3_fmRead, False);
 try
  l_TopicListFiler.Open;
  try
  l_Name := ConcatDirName(ExcludeTrailingBackslash(GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily)), 'bserv001');
  l_DB := Tm3DB.Make(l_Name, nil, aContext.rProgressor.ProcessUpdate);
  try
   l_InFiler := Tl3CustomFiler.Create;
   try
    l_InFiler.Mode := l3_fmRead;
    l_Reader := TevCustomEvdReader.Create;
    try
     l_Reader.Filer := l_InFiler;
     l_Filter := TddMisspellCorrectFilter.Create;
     try
      l_Filter.OnError:= SpellError;
      l_Reader.Generator := l_Filter;
      l_Writer := TevdCustomNativeWriter.Create;
      try
       l_Filter.Generator := l_Writer;
       l_Writer.Binary := True;
       l_OutFiler := Tm3DBFiler.Create(l_DB);
       try
        l_OutFiler.Mode := l3_fmWrite;
        l_Writer.Filer := l_OutFiler;

        DocumentServer.Family := CurrentFamily;
        while not (l_TopicListFiler.EOF) do
        begin
         l_SRString := l_TopicListFiler.Readln;
         CurDocID := ddParsePairsString(l_SRString, l_Filter);
         if CurDocID > 0 then
         begin
          l_DocID:= Linkserver(CurrentFamily).Renum.ConvertToRealNumber(CurDocID);
          f_IsRelated := False;
          if l_DocID > 0 then
          begin
           f_DocList.Add(CurDocID);
           CheckOneDocument(l_DocID);
           l_RelID := DocumentServer.FileTbl.GetRelated(l_DocID, l_Tmp);
           if l_RelID > 0 then
           begin
            f_IsRelated := True;
            CheckOneDocument(l_RelID);
           end;
          end
          else
           SpellError(' документа нет в базе', 0);
         end; // CurDocID > 0
        end; // while not EOF
       finally
        FreeAndNil(l_OutFiler);
       end;
      finally
       FreeAndNil(l_Writer);
      end;
     finally
      FreeAndNil(l_Filter);
     end;
    finally
     FreeAndNil(l_Reader);
    end;
   finally
    FreeAndNil(l_InFiler);
   end;
  finally
   l_DB := nil;
  end;//try..finally
   finally
    l_TopicListFiler.Close;
   end;
  finally
    FreeAndNil(l_TopicListFiler);
  end;
 MarkCorrectedDocs;
 l3System.Msg2Log('Обработка завершена');
 SendReport;
end;

procedure TalcuSpellCorrectTask.MarkCorrectedDocs;
var
 i: Integer;
 l_ID: Integer;
 l_Date: TstDate;
 l_Time: TstTime;
 l_User: TUserID;
 l_Value: TLogActionType;
begin
 l_Value:= acTextWork;
 l_Date:= CurrentDate; l_User:= usServerService; l_Time:= CurrentTime;
 with TCacheDirectAddAttrData.Create(CurrentFamily, ctLog_Doc) do
 try
  for i:= 0 to f_DocList.Hi do
  begin
    l_ID:= f_DocList[i];
    l_ID:= LinkServer(CurrentFamily).Renum.ConvertToRealNumber(l_ID);
    if l_ID <> cUndefDocID then
    begin
      AddRecord([l_ID,           // DocID
                 Ord(l_Value),   // Action
                 l_Date,         // Date
                 l_Time,         // Time
                 Ord(acfOrdinal),// ActionFlag
                 'ALCU'#0,       // Station
                 l_User]);       // Author
    end; // l_ID <> cUndefDocID
  end; // for i
 finally
  Free;
 end; // TCacheDirectAddAttrData.Create(CurrentFamily, ctStage)
end;

procedure TalcuSpellCorrectTask.SendReport;
var
 l_MailType   : TMailType;
 l_MailSubject: String;
 l_MailBody   : String;
begin
{ TODO -oДмитрий Дудко -cнедоделка : Все это будет приезжать вместе с результатами задачи }
 if (UserID > 0)  then
 begin
   if f_ErrorList.Count > 0 then
    l_MailBody:= 'Не исправлены следующие опечатки: '^M + f_ErrorList.Text
   else
    l_MailBody:= 'Все опечатки исправлены.';
   l_MailType:= mlNone;
   if IsUserRequireReports(UserID) then
   try
     MailServer.SendMail(l_MailType,         // тип сообщения
                        UserID,            // номер адресата
                        Format('Результат обработки файла "%s" %s', [ExtractFileName(ReplacementFile.Name), DateToStr(SysUtils.Date)]),// Тема сообщения
                        PChar(l_MailBody),    // текст сообщения
                        nil);       // выборка номеров
   except
    on E: Exception do
     l3System.Exception2Log(E);
   end // IsUserRequireReports(UserID) then
 end; { aID > 0 }
end;

procedure TalcuSpellCorrectTask.SpellError(const aDescript: String; aCategory: Integer);
begin
 f_DocList.Remove(CurDocID);
 if not f_IsRelated then
  f_ErrorList.Add(Format('%d: %s', [CurDocID, aDescript]))
 else
  f_ErrorList.Add(Format('Справка документа %d: %s', [CurDocID, aDescript]))
end;

(*procedure TalcuSpellCorrectTask.WriteResult(aStream: TStream);
begin
 WriteStrings(aStream, f_ErrorList);
end;*)


initialization
 RegisterTaskClass(cs_ttSpellCheck, TalcuSpellCorrectTask, 'Проверка опечаток');
end.
