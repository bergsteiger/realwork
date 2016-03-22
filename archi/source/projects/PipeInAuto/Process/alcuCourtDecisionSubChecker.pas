unit alcuCourtDecisionSubChecker;

interface

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

uses
 l3Base,

 csCourtDecisionSabCheckerParams
 ;

type
 TalcuCourtDecisionSubChecker = class(Tl3Base)
 public
  class procedure CheckInList(const aParams: TcsCourtDecisionSabCheckerParams; const aDocListFileName: string);
 {$If defined(AppServerSide)}
  class procedure CheckByDate(const aParams: TcsCourtDecisionSabCheckerParams);
 {$IfEnd defined(AppServerSide)}
 end;

implementation

uses
 Classes,
 SysUtils,
 IniFiles,

 l3LongintList,

 daTypes,
 daSchemeConsts,

 dt_Const,
 dt_Dict,
 dt_LinkServ,
 dt_AttrSchema,

 csCourtsListHelper,
 csCourtDescription,

 {$If defined(AppServerSide)}
 alcuTypes,
 alcuServer,
 {$IfEnd defined(AppServerSide)}
 alcuMailServer,
 alcuUtils,
 alcuCourtDecision
 ;


{ TalcuCourtDecisionSubChecker }

 {$If defined(AppServerSide)}
class procedure TalcuCourtDecisionSubChecker.CheckByDate(const aParams: TcsCourtDecisionSabCheckerParams);
{$IFDEF Courts}
var
 l_Report: TStrings;
 l_Text: String;
 i: Integer;
 l_WorkedDocs: Integer;
 l_Court: TalcuCourtDecisionSubMaker;
 l_CourtsList: CourtsListHelper;
 l_FromDate: TDateTime;
 l_CourtDescription: TcsCourtDescription;
 l_PhrasesList: TStringList;
{$ENDIF}
begin
{$IFDEF Courts}
 TalcuServer.Instance.Status:= dd_apsSetAutoSub;
 TalcuServer.Instance.LockTaskExecution;
 try
  l_Report:= TStringList.Create;
  try
   AddReportLog('Автоматическая простановка меток в судебных постановлениях', l_Report);
   {$IFNDEF Region}
   l_FromDate := aParams.LastUpdateDate;
   AddReportLog('Диапазон дат: с %s по %s', [DateToStr(l_FromDate), DateToStr(SysUtils.Date)], l_Report);
   {$ENDIF}
   l_WorkedDocs:= 0;
   l_Court:= TalcuCourtDecisionSubMaker.Create;
   try
    l_Court.Progressor:= TalcuServer.Instance.Progressor;
    with l_Court do
    begin
     if aParams.IsParamsValid then
     begin
      DocType := aParams.DocTypeID;
      {$IFNDEF Region}
      FromDate := l_FromDate;
      {$ENDIF}
      l_CourtsList := aParams.CourtsList;
      Progressor.Start(l_CourtsList.Count, 'Расстановка меток 20005 и 30005', False);
      l_CourtDescription := TcsCourtDescription.Create;
      try
       l_PhrasesList := TStringList.Create;
       try
        for i:= 0 to Pred(l_CourtsList.Count) do
        begin
         l_CourtDescription.SetTaggedData(l_CourtsList.Courts[i]);
         if l_CourtDescription.NeedProcess then
         begin
          AddReportLog(l_CourtDescription.Name, l_Report);
          l_CourtDescription.DecisionPhrases.CopyTo(l_PhrasesList);
          Execute(l_CourtDescription.SourceID, l_PhrasesList, l_Report);
          Inc(l_WorkedDocs, WorkedDocs);
         end; // l_CourtDescription.NeedProcess
         Progressor.ProcessUpdate(i);
        end; // for i
       finally
        FreeAndNil(l_PhrasesList);
       end;
      finally
       FreeAndNil(l_CourtDescription);
      end;
      Progressor.Stop;
     end; // aParams.IsParamsValid
    end; // with l_Court
   finally
    l_Court.Free;
   end; // with TalcuCourtDecisionSubMaker.Create(nil)
   {$IFNDEF Region}
   aParams.LastUpdateDate := SysUtils.Date;
   {$ENDIF}
   l3System.Msg2Log('Автоматическая простановка меток завершена');
   l_Report.Insert(2, Format('Всего обработано документов: %d'#13#10, [l_WorkedDocs]));
   alcuMail.SendEmail(aParams.NotifyList, l_Report.Text, 'Простановка меток в ФАСах');
  finally
   l3Free(l_Report);
  end;
 finally
  TalcuServer.Instance.UnLockTaskExecution;
 end;
 TalcuServer.Instance.Status:= dd_apsIdle;
{$ENDIF}
end;
 {$IfEnd defined(AppServerSide)}

class procedure TalcuCourtDecisionSubChecker.CheckInList(const aParams: TcsCourtDecisionSabCheckerParams; 
  const aDocListFileName: string);
{$IFDEF Courts}
var
 l_Report: TStrings;
 l_Numbers: Tl3LongintList;
 l_Text: String;
 i: Integer;
 l_WorkedDocs: Integer;
 l_Court: TalcuCourtDecisionSubMaker;
 l_CourtsList: CourtsListHelper;
 l_DocList: TIniFile;
 l_CourtDescription: TcsCourtDescription;
 l_PhrasesList: TStringList;

 procedure lp_FillNumbers(aNumbers: Tl3LongintList; aDocList: TIniFile; aSourceID: Integer);
 var
  l_Section: String;
  i, l_Count, l_Number: Integer;
 begin
  aNumbers.Clear;
  l_Section:= DictServer(CurrentFamily).Dict[da_dlSources].GetFullDictItemName(aSourceID, False);
  if l_Section <> '' then
  begin
   l_Count:= aDocList.ReadInteger(l_Section, 'Count', 0);
   for i:= 1 to l_Count do
   begin
    l_Number:= aDocList.ReadInteger(l_Section, 'Doc'+IntToStr(i), 0);
    if l_Number <> 0 then
     aNumbers.Add(LinkServer(CurrentFamily).Renum.ConvertExternalDocNumberToInternal(l_Number));
   end; // for i
  end; // l_Section <> ''
 end;

{$ENDIF}
begin
{$IFDEF Courts}
 l_Report:= TStringList.Create;
 try
  AddReportLog('Автоматическая простановка меток в судебных постановлениях по заданному списку документов', l_Report);
  l_Numbers:= Tl3LongintList.MakeSorted;
  try
   l_DocList:= TIniFile.Create(aDocListFileName);
   try
    l_WorkedDocs:= 0;
    l_Court:= TalcuCourtDecisionSubMaker.Create;   
    try
     with l_Court do
     begin
      if aParams.IsParamsValid then
      begin
       DocType := aParams.DocTypeID;
       l_CourtsList := aParams.CourtsList;
       l_CourtDescription := TcsCourtDescription.Create;
       try
        l_PhrasesList := TStringList.Create;
        try
         for i:= 0 to Pred(l_CourtsList.Count) do
         begin
          l_CourtDescription.SetTaggedData(l_CourtsList.Courts[i]);
          if l_CourtDescription.NeedProcess then
          begin
           AddReportLog(l_CourtDescription.Name, l_Report);
           //Нужно считать из файла список документов текущего суда
           lp_FillNumbers(l_Numbers, l_DocList, l_CourtDescription.SourceID);
           try
            l_CourtDescription.DecisionPhrases.CopyTo(l_PhrasesList);
            Execute(l_Numbers, l_PhrasesList, l_Report);
            Inc(l_WorkedDocs, WorkedDocs);
           except
            on E: Exception do
            begin
             l3System.Exception2Log(E);
             l3System.Msg2Log('Ошибка расстановки меток в %s', [l_CourtDescription.Name]);
             break;
            end;
           end;
          end; // if l_CourtDescription.NeedProcess
         end; // for i
        finally
         FreeAndNil(l_PhrasesList);
        end;
       finally
        FreeAndNil(l_CourtDescription);
       end;
      end; // if aParams.IsParamsValid
     end; // with l_Court
    finally
     l_Court.Free;
    end; // with TalcuCourtDecisionSubMaker.Create(nil)
   finally
    FreeAndNil(l_DocList);
   end;
  finally
   FreeAndNil(l_Numbers);
  end;
  DeleteFile(aDocListFileName);
  l3System.Msg2Log('Автоматическая простановка меток завершена');
  if l_WorkedDocs > 0 then
  begin
   l_Report.Insert(2, Format('Всего обработано документов: %d'#13#10, [l_WorkedDocs]));
   alcuMail.SendEmail(aParams.NotifyList, l_Report.Text, 'Простановка меток в ФАСах');
  end; // l_WorkedDocs > 0
 finally
  l3Free(l_Report);
 end;
{$ENDIF}
end;

end.
