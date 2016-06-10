unit alcuMdpImportSyncronizer;
 {* Синхронизация в Гардок журнала импорта документов в Архивариус }

// Модуль: "w:\archi\source\projects\PipeInAuto\Process\alcuMdpImportSyncronizer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMdpImportSyncronizer" MUID: (574C0FA701BB)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
 l3IntfUses
 , alcuMdpDatedSyncronizer
 , Classes
;

type
 TalcuMdpImportSyncronizer = class(TalcuMdpDatedSyncronizer)
  {* Синхронизация в Гардок журнала импорта документов в Архивариус }
  protected
   function PrepareData(aStream: TStream): Boolean; override;
   function GetTitle: AnsiString; override;
   function GetIniParamName: AnsiString; override;
 end;//TalcuMdpImportSyncronizer

implementation

uses
 l3ImplUses
 , SysUtils
 , l3XMLWriter
 , l3Interfaces
 , l3Date
 , l3DateSt
 , l3Stream
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 ,daSchemeConsts,
 daDataProvider,
 dt_Types,
 dt_DictConst,
 dt_Sab,
 dt_Query,
 dt_User,
 dt_LinkServ,
 dt_AttrSchema,
 dt_Log,
 dt_Renum
 {$IfEnd} // NOT Defined(Nemesis)
 , alcuMdpSyncIntf
;

function TalcuMdpImportSyncronizer.PrepareData(aStream: TStream): Boolean;
//#UC START# *574C359C0010_574C0FA701BB_var*
var
 l_XML   : Il3XMLWriter;
 l_Query : TdtQuery;
 l_Docs  : ISab;
type
 PImportLogRec = ^TImportLogRec;
 TImportLogRec = packed record
              rDocID  : TDocID;
              rDate   : TStDate;
              rAuthor : TUserID;
             end;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 var
  lUserName : String;
  ltmpLoginName : String;
  ltmpActFlag   : Byte;
 begin
  Result := True;
  with PImportLogRec(aItemPtr)^ do
  begin
   GlobalDataProvider.UserManager.GetUserInfo(rAuthor, lUserName, ltmpLoginName, ltmpActFlag);
   l_XML.OpenLevel('item');
   try
    l_XML.PutSimpleField('topic', '', Format('%d', [rDocID]));
    l_XML.PutSimpleField('date', '', l3DateToStr(rDate, 'DD.MM.YYYY'));
    l_XML.PutSimpleField('user', '', lUserName);
   finally
    l_XML.CloseLevel;
   end;
  end; // with
 end; // function lRecAccessProc

var
 lRAProcStub : TdtRecAccessProc;
 l_LogSab    : ISab;
 lUserSab    : ISab;
 lRenumSab   : ISab;
 lJoinSab    : IJoinSab;
 l_MinDate, l_MaxDate: TStDate;
 l_IStream   : IStream;
 l_Action    : Byte;
//#UC END# *574C359C0010_574C0FA701BB_var*
begin
//#UC START# *574C359C0010_574C0FA701BB_impl*
 Result := False;
 l_MinDate := StDateToDemon(DateTimeToStDate(f_From));
 l_MaxDate := StDateToDemon(DateTimeToStDate(f_To));
 l_LogSab := MakeSab(LinkServer(CurrentFamily).LogBook);
 l_LogSab.Select(lgDate_Key, l_MinDate, l_MaxDate); // за период
 l_Action := Ord(acWasImported);
 l_LogSab.SubSelect(lgAction_Key, l_Action); // только импорты
 
 if l_LogSab.Count <> 0 then
 begin
  lUserSab := MakeAllRecords(UserManager.xxxUserTbl);
  lUserSab.ValuesOfKey(dtIDFld);
  lUserSab.RecordsByKey(lgAuthor_Key, l_LogSab);
  l_LogSab.AndSab(lUserSab);

  if l_LogSab.Count > 0 then
  begin
   lRenumSab := MakeAllRecords(LinkServer(CurrentFamily)[atRenum]);

   lJoinSab := MakeJoinSab(l_LogSab, lgDocID_Key,
                           lRenumSab, rnRealID_fld);

   l_XML := Tl3XMLWriter.Make(l3Stream2IStream(aStream));
   try
    l_XML.OpenLevel('data', Format('version="%d" region="%d" dict="%s" operation="%s"', [cMdpSyncVersion,
    GlobalDataProvider.RegionID, 'importlog', c_mssOperationStr[ssoUpd]]));
    try
     lRAProcStub := L2RecAccessProc(@lRecAccessProc);
     try
      lJoinSab.IterateJoinRecords(lRAProcStub, [JFRec(lRenumSab.Table, rnImportID_fld),
                                                JFRec(l_LogSab.Table,  lgDate_Key),
                                                JFRec(l_LogSab.Table,  lgAuthor_Key)]);
     finally
      FreeRecAccessProc(lRAProcStub);
     end;
    finally
     l_XML.CloseLevel;
    end;
   finally
    l_XML := nil;
   end;
   Result := True;
  end;
 end;
//#UC END# *574C359C0010_574C0FA701BB_impl*
end;//TalcuMdpImportSyncronizer.PrepareData

function TalcuMdpImportSyncronizer.GetTitle: AnsiString;
//#UC START# *574C395100E9_574C0FA701BB_var*
//#UC END# *574C395100E9_574C0FA701BB_var*
begin
//#UC START# *574C395100E9_574C0FA701BB_impl*
 Result := 'синхронизации импортов в Гардок';
//#UC END# *574C395100E9_574C0FA701BB_impl*
end;//TalcuMdpImportSyncronizer.GetTitle

function TalcuMdpImportSyncronizer.GetIniParamName: AnsiString;
//#UC START# *574E9F28031C_574C0FA701BB_var*
//#UC END# *574E9F28031C_574C0FA701BB_var*
begin
//#UC START# *574E9F28031C_574C0FA701BB_impl*
 Result := 'LastImportsSync';
//#UC END# *574E9F28031C_574C0FA701BB_impl*
end;//TalcuMdpImportSyncronizer.GetIniParamName

end.
