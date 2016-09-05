unit alcuMdpStagesSyncronizer;
 {* Синхронизация этапов в Гардок }

// Модуль: "w:\archi\source\projects\PipeInAuto\Process\alcuMdpStagesSyncronizer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TalcuMdpStagesSyncronizer" MUID: (574C0F390376)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

uses
 l3IntfUses
 , alcuMdpDatedSyncronizer
 , Classes,
 dt_Types
;

type
 TalcuMdpStagesSyncronizer = class(TalcuMdpDatedSyncronizer)
  {* Синхронизация этапов в Гардок }
  private
   function GetGardocStageCode(aStageType: TStageType): Integer;
  protected
   function PrepareData(aStream: TStream): Boolean; override;
   function GetTitle: AnsiString; override;
   function GetIniParamName: AnsiString; override;
 end;//TalcuMdpStagesSyncronizer

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
 daTypes,
 dt_DictConst,
 dt_Sab,
 dt_Query,
 dt_User,
 dt_LinkServ,
 dt_AttrSchema,
 dt_Stage,
 dt_Renum
 {$IfEnd} // NOT Defined(Nemesis)
 , alcuMdpSyncIntf
;

function TalcuMdpStagesSyncronizer.GetGardocStageCode(aStageType: TStageType): Integer;
//#UC START# *574EC035002D_574C0F390376_var*
//#UC END# *574EC035002D_574C0F390376_var*
begin
//#UC START# *574EC035002D_574C0F390376_impl*
 case aStageType of
  stInput    : Result := 1001;
  stRead     : Result := 1002;
  stORead    : Result := 1102;
  stEdit     : Result := 1003;
  stOEdit    : Result := 1103;
  stClass    : Result := 503;
  stKW       : Result := 502;
  stUrObr    : Result := 501;
  stFinUrObr : Result := 1
  else         Result := 0;
 end;
//#UC END# *574EC035002D_574C0F390376_impl*
end;//TalcuMdpStagesSyncronizer.GetGardocStageCode


function TalcuMdpStagesSyncronizer.PrepareData(aStream: TStream): Boolean;
//#UC START# *574C359C0010_574C0F390376_var*
var
 l_XML   : Il3XMLWriter;
 lStage  : TStageType;
 l_Query : TdtQuery;
 l_Docs  : ISab;
type
 PStageRec = ^TStageRec;
 TStageRec = packed record
              rDocID  : TdaDocID;
              rStType : Byte;
              rEDate  : TStDate;
              rAuthor : TdaUserID;
             end;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 var
  lUserName : String;
  lGardocStageCode : Integer;
  ltmpLoginName : String;
  ltmpActFlag   : Byte;
 begin
  Result := True;
  with PStageRec(aItemPtr)^ do
  begin
   lGardocStageCode := GetGardocStageCode(TStageType(rStType));
   if lGardocStageCode > 0 then
   begin
    GlobalDataProvider.UserManager.GetUserInfo(rAuthor, lUserName, ltmpLoginName, ltmpActFlag);
    l_XML.OpenLevel('item');
    try
     l_XML.PutSimpleField('topic', '', Format('%d', [rDocID]));
     l_XML.PutSimpleField('code', '', Format('%d', [lGardocStageCode]));
     l_XML.PutSimpleField('date', '', l3DateToStr(rEDate, 'DD.MM.YYYY'));
     l_XML.PutSimpleField('user', '', lUserName);
    finally
     l_XML.CloseLevel;
    end;
   end; // if lGardocStageCode > 0 then
  end;
 end; // function lRecAccessProc

var
 lRAProcStub : TdtRecAccessProc;
 l_StagesSab : ISab;
 lUserSab    : ISab;
 lRenumSab   : ISab;
 lJoinSab    : IJoinSab;
 l_MinDate, l_MaxDate: TStDate;
 l_IStream   : IStream;
//#UC END# *574C359C0010_574C0F390376_var*
begin
//#UC START# *574C359C0010_574C0F390376_impl*
 Result := False;
 // выводим все новые этапы за период
 l_MinDate := StDateToDemon(DateTimeToStDate(f_From));
 l_MaxDate := StDateToDemon(DateTimeToStDate(f_To));
 l_StagesSab := MakeSab(LinkServer(CurrentFamily).Attribute[atStages]);
 l_StagesSab.Select(stEDate_Key, l_MinDate, l_MaxDate); // закрытые за период

 if l_StagesSab.Count <> 0 then
 begin
//!! !!! заменить xxxUserManager
  lUserSab := MakeAllRecords(xxxUserManager.xxxUserTbl);
  lUserSab.ValuesOfKey(dtIDFld);
  lUserSab.RecordsByKey(stAuthor_Key, l_StagesSab);
  l_StagesSab.AndSab(lUserSab);

  if l_StagesSab.Count > 0 then
  begin
   lRenumSab := MakeAllRecords(LinkServer(CurrentFamily)[atRenum]);

   lJoinSab := MakeJoinSab(l_StagesSab, stDocID_Key,
                           lRenumSab, rnRealID_fld);

   l_XML := Tl3XMLWriter.Make(l3Stream2IStream(aStream));
   try
    l_XML.OpenLevel('data', Format('version="%d" region="%d" dict="%s" operation="%s"', [cMdpSyncVersion,
    GlobalDataProvider.RegionID, 'stages', c_mssOperationStr[ssoUpd]]));
    try
     lRAProcStub := L2RecAccessProc(@lRecAccessProc);
     try
      lJoinSab.IterateJoinRecords(lRAProcStub, [JFRec(lRenumSab.Table,   rnImportID_fld),
                                                JFRec(l_StagesSab.Table, stType_Key),
                                                JFRec(l_StagesSab.Table, stEDate_Key),
                                                JFRec(l_StagesSab.Table, stAuthor_Key)]);
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
//#UC END# *574C359C0010_574C0F390376_impl*
end;//TalcuMdpStagesSyncronizer.PrepareData

function TalcuMdpStagesSyncronizer.GetTitle: AnsiString;
//#UC START# *574C395100E9_574C0F390376_var*
//#UC END# *574C395100E9_574C0F390376_var*
begin
//#UC START# *574C395100E9_574C0F390376_impl*
 Result := 'синхронизации этапов в Гардок';
//#UC END# *574C395100E9_574C0F390376_impl*
end;//TalcuMdpStagesSyncronizer.GetTitle

function TalcuMdpStagesSyncronizer.GetIniParamName: AnsiString;
//#UC START# *574E9F28031C_574C0F390376_var*
//#UC END# *574E9F28031C_574C0F390376_var*
begin
//#UC START# *574E9F28031C_574C0F390376_impl*
 Result := 'LastStagesSync';
//#UC END# *574E9F28031C_574C0F390376_impl*
end;//TalcuMdpStagesSyncronizer.GetIniParamName

end.
