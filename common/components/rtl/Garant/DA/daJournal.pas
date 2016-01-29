unit daJournal;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DA"
// ������: "w:/common/components/rtl/Garant/DA/daJournal.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DA::Provider::TdaJournal
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\DA\daDefine.inc}

interface

uses
  l3Date,
  l3Tree,
  l3ProtoObject,
  daTypes,
  daInterfaces,
  l3Tree_TLB
  ;

type
 TdaJournal = class(Tl3ProtoObject, IdaJournal)
 private
 // private fields
   f_CurUser : TdaUserID;
   f_CurStatTree : Tl3Tree;
    {* ���� ��� �������� CurStatTree}
   f_Factory : IdaTableQueryFactory;
    {* ���� ��� �������� Factory}
   f_CurSessionID : TdaSessionID;
    {* ���� ��� �������� CurSessionID}
 private
 // private methods
   function GetNewSessionID: TdaSessionID;
 protected
 // realized methods
   function Get_CurStatisticTreeRoot: Il3RootNode;
   procedure CalcStatistics(FromDate: TStDate;
    ToDate: TStDate;
    aDocID: TdaDocID;
    UserOrGroupID: TdaUserID;
    UserGr: Boolean);
   procedure LogExport(aFamilyID: TdaFamilyID;
    aCount: LongInt);
   procedure LogImport(aFamilyID: TdaFamilyID);
   procedure LogPause(aLength: LongInt);
   procedure LogPrintDoc(aFamilyID: TdaFamilyID;
    aDocID: TdaDocID);
   procedure LogSaveDoc(aFamilyID: TdaFamilyID;
    aDocID: TdaDocID);
   procedure LogEditDoc(aFamilyID: TdaFamilyID;
    aDocID: TdaDocID;
    aEditType: TdaDocEditType;
    anOperation: TdaEditOperation = da_eoNone); overload; 
   procedure LogEditDoc(aFamilyID: TdaFamilyID;
    aDocID: TdaDocID;
    aEditType: TdaDocEditType;
    aDictType: TdaDictionaryType); overload; 
   procedure LogDeleteDoc(aFamilyID: TdaFamilyID;
    aDocID: TdaDocID);
   procedure LogEditDict(aFamilyID: TdaFamilyID;
    aDictType: TdaDictionaryType;
    anOperation: TdaEditOperation = da_eoNone);
   procedure LogCreateDoc(aFamilyID: TdaFamilyID;
    aDocID: TdaDocID);
   procedure LogAutoClass(aFamilyID: TdaFamilyID;
    aCount: LongInt);
   procedure LogOpenDoc(aFamilyID: TdaFamilyID;
    aDocID: TdaDocID);
   function Get_UserID: TdaUserID;
   procedure Set_UserID(aValue: TdaUserID);
   procedure StartCaching;
   procedure StopCaching;
   procedure SessionDone;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 protected
 // protected methods
   procedure LogEvent(aOperation: TdaJournalOperation;
     aFamilyID: TdaFamilyID;
     aExtID: LongInt;
     aData: LongInt); virtual; abstract;
   procedure CheckUser(anUserID: TdaUserID); virtual; abstract;
   procedure UserChanged(anUserID: TdaUserID); virtual; abstract;
   procedure SessionChanged; virtual; abstract;
     {* ��������� ������ SessionChanged }
   procedure DoStartCaching; virtual; abstract;
     {* ��������� ������ DoStartCaching }
   procedure DoStopCaching; virtual; abstract;
     {* ��������� ������ DoStopCaching }
   procedure AnalyseLog(const aLog: IdaResultSet);
   function MakeResultSet(FromDate: TStDate;
     ToDate: TStDate;
     aDocID: TdaDocID;
     UserOrGroupID: TdaUserID;
     UserGr: Boolean): IdaResultSet; virtual; abstract;
   procedure CorrectDates(var FromDate: TStDate;
     ToDate: TStDate);
 public
 // public methods
   constructor Create(const aFactory: IdaTableQueryFactory); reintroduce;
 protected
 // protected properties
   property CurStatTree: Tl3Tree
     read f_CurStatTree;
   property Factory: IdaTableQueryFactory
     read f_Factory;
   property CurSessionID: TdaSessionID
     read f_CurSessionID;
 end;//TdaJournal

implementation

uses
  l3Nodes,
  l3TreeInterfaces,
  l3Base,
  daScheme,
  SysUtils,
  TypInfo
  ;

const
   { SessionConst }
  BlankSession : TdaSessionID = -1;

// start class TdaJournal

function TdaJournal.GetNewSessionID: TdaSessionID;
//#UC START# *5549F9E70184_559A3BD901CC_var*
var
 l_Query: IdaQuery;
 Uniq    : Boolean;
 TmpDate : TStDate;
 l_ResultSet: IdaResultSet;
//#UC END# *5549F9E70184_559A3BD901CC_var*
begin
//#UC START# *5549F9E70184_559A3BD901CC_impl*
 l_Query := f_Factory.MakeTabledQuery(TdaScheme.Instance.Table(da_mtJournal));
 try
  Result:=BlankSession;
  TmpDate:=(CurrentDate - DMYtoStDate(1,1,1998)) mod 24855;
  Result:=TmpDate * 24 * 60 * 60 + CurrentTime;
  l_Query.AddSelectField(f_Factory.MakeSelectField('', TdaScheme.Instance.Table(da_mtJournal)['ID_Session']));
  l_Query.WhereCondition := f_Factory.MakeParamsCondition('', TdaScheme.Instance.Table(da_mtJournal)['ID_Session'], da_copEqual, 'p_SessionID');
  l_Query.Prepare;
  try
   Repeat
    l_Query.Param['p_SessionID'].AsLargeInt := Result;
    l_ResultSet := l_Query.OpenResultSet;
    try
     Uniq := l_ResultSet.IsEmpty;
     if Not Uniq then
      Inc(Result);
    finally
     l_ResultSet := nil;
    end;
   until Uniq;
  finally
   l_Query.UnPrepare;
  end;
 finally
  l_Query := nil;
 end;
//#UC END# *5549F9E70184_559A3BD901CC_impl*
end;//TdaJournal.GetNewSessionID

constructor TdaJournal.Create(const aFactory: IdaTableQueryFactory);
//#UC START# *559A424301EE_559A3BD901CC_var*
//#UC END# *559A424301EE_559A3BD901CC_var*
begin
//#UC START# *559A424301EE_559A3BD901CC_impl*
 inherited Create;
 f_CurSessionID := BlankSession;
 f_CurUser := 0;
 f_Factory := aFactory;
 f_CurStatTree := Tl3Tree.Create;
 Randomize;
//#UC END# *559A424301EE_559A3BD901CC_impl*
end;//TdaJournal.Create

procedure TdaJournal.AnalyseLog(const aLog: IdaResultSet);
//#UC START# *5563292201CF_559A3BD901CC_var*
Var
 I          : LongInt;

 CurS_ID    : LargeInt; 
 TmpNode,
 CurS_Node  : Il3Node;

 DT1,DT2    : TStDateTimeRec;
 Days,Secnds: LongInt;
 Hours,Mins,
 Secs       : Word;
 l_Hours, l_Minutes, l_Seconds: Integer;
 Day,
 Month,
 Year       : Integer;
 PauseTime  : TStTime;
 TmpStr     : ShortString;

 //Iter       : TSearchParameters;

 FullTime,
 FullPause,
 FullOpenDocs,
 FullModifDocs,
 FullModifications : LongInt;
 l_SessionField: IdaField;
 l_DateField: IdaField;
 l_TimeField: IdaField;
 l_OperationField: IdaField;
 l_AdditionalInfoField: IdaField;
 l_ExtIDField: IdaField;
 l_Additional: Integer;

 function FindLastNodeByParam(Parent: Il3Node; Param : Integer) : Il3Node;
 Var
  ResNode : Il3Node;

  function IterHandler(CurNode : Il3Node) : Boolean;far;
   begin
    if Param = (CurNode as Il3HandleNode).Handle then
     ResNode:=CurNode;
    Result:=False;
   end;

 begin
  ResNode:=nil;
  CurStatTree.IterateF(l3L2NA(@IterHandler),imOneLevel,Parent);
  Result:=ResNode;
 end;

 Procedure GetTimeFromLongInt(aSecnds : LongInt;Var Hours,Minutes,Seconds : Word);
 Const
  cSIH = 60*60;
  cSIM = 60;
 begin
  Hours:=aSecnds div cSIH;
  aSecnds:=aSecnds mod cSIH;
  Minutes:=aSecnds div cSIM;
  Seconds:=aSecnds mod cSIM;
 end;

 procedure SetSessionTime;
 begin
  DateTimeDiff(DT1,DT2,Days,Secnds);
  FullTime:=FullTime+Days*(24*60*60)+Secnds;
  GetTimeFromLongInt(Secnds,Hours,Mins,Secs);
  Hours:=Hours+Days*24;
  CurStatTree.InsertNode(CurS_Node,
      MakeNode(Format('����������������� ������: %0.2d:%0.2d:%0.2d', [Hours,Mins,Secs])));

  if PauseTime<>0
   then
    begin
     GetTimeFromLongInt(PauseTime,Hours,Mins,Secs);
     CurStatTree.InsertNode(CurS_Node,
         MakeNode(Format('��������� ����� (�����): %0.2d:%0.2d:%0.2d', [Hours,Mins,Secs])));
     FullPause:=FullPause+PauseTime;
    end;
 end;

 procedure SetFooterParams;
 begin
  GetTimeFromLongInt(FullTime,Hours,Mins,Secs);
  CurStatTree.InsertNode(CurStatTree.RootNode,
      MakeNode(Format('����� ����� ������: %0.2d:%0.2d:%0.2d', [Hours,Mins,Secs])));

  GetTimeFromLongInt(FullPause,Hours,Mins,Secs);
  CurStatTree.InsertNode(CurStatTree.RootNode,
      MakeNode(Format('����� ����� ������� (�����): %0.2d:%0.2d:%0.2d', [Hours,Mins,Secs])));

  CurStatTree.InsertNode(CurStatTree.RootNode,
        MakeNode(Format('���������� �������� ����������: %d',[FullOpenDocs])));
  CurStatTree.InsertNode(CurStatTree.RootNode,
        MakeNode(Format('���������� ����������������� ����������: %d',[FullModifDocs])));
  CurStatTree.InsertNode(CurStatTree.RootNode,
        MakeNode(Format('����� ���������� ��������� � ����������: %d',[FullModifications])));
 end;

//#UC END# *5563292201CF_559A3BD901CC_var*
begin
//#UC START# *5563292201CF_559A3BD901CC_impl*
 CurStatTree.Clear;
 FullTime:=0;
 FullPause:=0;
 FullOpenDocs:=0;
 FullModifDocs:=0;
 FullModifications:=0;
 PauseTime:=0;
 DT1.D:=0;
 DT1.T:=0;
 DT2.D:=0;
 DT2.T:=0;

 CurS_ID:=0;
 CurS_Node:=nil;

 l_SessionField := aLog.Field['ID_Session'];
 l_DateField := aLog.Field['Date'];
 l_TimeField := aLog.Field['Time'];
 l_OperationField := aLog.Field['ID_Operat'];
 l_AdditionalInfoField := aLog.Field['Additional'];
 l_ExtIDField := aLog.Field['ID_Ext'];

 while not aLog.EOF do
 begin
   if l_SessionField.AsLargeInt <> CurS_ID then
   begin
    if CurS_Node<>nil
     then
      SetSessionTime;

    DT1.D := l_DateField.AsStDate;
    DT1.T := l_TimeField.AsStTime;
    CurS_ID := l_SessionField.AsLargeInt;
    PauseTime:=0;
   end;

   Case TdaJournalOperation(l_OperationField.AsInteger) of
    da_oobPause : PauseTime:=PauseTime + l_AdditionalInfoField.AsInteger;
    da_oobSessionBegin:
     begin
      TmpNode := CurStatTree.FindNodeByParam(CurStatTree.RootNode, l_ExtIDField.AsLargeInt, imOneLevel);
      if TmpNode=nil
       then
        begin
         TmpNode:=CurStatTree.InsertNode(CurStatTree.RootNode,
                                 MakeNode(PChar(f_Factory.GetUserNameStr(l_ExtIDField.AsLargeInt))));
         (TmpNode as Il3HandleNode).Handle:=l_ExtIDField.AsLargeInt;
        end;
      StDateToDMY(l_DateField.AsStDate,Day,Month,Year);
      StTimeToHMS(l_TimeField.AsStTime, l_Hours, l_Minutes, l_Seconds);
      CurS_Node:=CurStatTree.InsertNode(TmpNode,
                                         MakeNode(Format('������� ������ (%d/%d/%d %.2d:%.2d:%.2d)',
                                                                       [Day, Month, Year, l_Hours, l_Minutes, l_Seconds])));
     end;
    da_oobSessionEnd : CurStatTree.InsertNode(CurS_Node,
                                            MakeNode('C����� ����������� ���������'));
    da_oobOpenDoc    :
     begin
      Inc(FullOpenDocs);
      TmpNode:=CurStatTree.InsertNode(CurS_Node,MakeNode(Format('������ �������� N %d',[l_ExtIDField.AsLargeInt])));
      (TmpNode as Il3HandleNode).Handle:=l_ExtIDField.AsLargeInt;
     end;
    da_oobCreateDoc :
     begin
      Inc(FullOpenDocs);
      TmpNode:=CurStatTree.InsertNode(CurS_Node,MakeNode(Format('������ �������� N %d',[l_ExtIDField.AsLargeInt])));
      (TmpNode as Il3HandleNode).Handle:=l_ExtIDField.AsLargeInt;
     end;
    da_oobDeleteDoc : CurStatTree.InsertNode(CurS_Node,MakeNode(Format('������ �������� N %d',[l_ExtIDField.AsLargeInt])));
    da_oobEditDoc:
     begin
      Inc(FullModifications);
      TmpNode:=FindLastNodeByParam(CurS_Node,l_ExtIDField.AsLargeInt);
      if TmpNode=nil
       then
        begin
         TmpNode:=CurStatTree.InsertNode(CurS_Node,
                                          MakeNode(Format('�������������� �������� N %d',[l_ExtIDField.AsLargeInt])));
         Inc(FullModifDocs);
        end
       else
        if Not TmpNode.HasChild then
         Inc(FullModifDocs);
      l_Additional := l_AdditionalInfoField.AsInteger;
      Case PdaDocEditRec(@l_Additional).EditType of
       da_detText      : CurStatTree.InsertNode(TmpNode,MakeNode('������� �����'));
       da_detAttribute : CurStatTree.InsertNode(TmpNode,MakeNode('�������� ���������'));
       da_detHyperLink : CurStatTree.InsertNode(TmpNode,MakeNode('�������� ����������'));
       da_detSub       : CurStatTree.InsertNode(TmpNode,MakeNode('�������� Sub�'));
       da_detDiction:
        Case PdaDocEditRec(@l_Additional).Details.DictType of
         da_dlSources    : CurStatTree.InsertNode(TmpNode,MakeNode('�������� ������'));
         da_dlTypes      : CurStatTree.InsertNode(TmpNode,MakeNode('�������� ����'));
         da_dlClasses    : CurStatTree.InsertNode(TmpNode,MakeNode('�������� ������'));
         da_dlKeyWords   : CurStatTree.InsertNode(TmpNode,MakeNode('�������� KW'));
         da_dlBases      : CurStatTree.InsertNode(TmpNode,MakeNode('�������� ������'));
         da_dlDateNums   : CurStatTree.InsertNode(TmpNode,MakeNode('�������� ���� ��� �����'));
         da_dlWarnings   : CurStatTree.InsertNode(TmpNode,MakeNode('�������� ��������������'));
         da_dlCorrects   : CurStatTree.InsertNode(TmpNode,MakeNode('������� �������'));
        end;
      end;
     end;
    da_oobPrintDoc : CurStatTree.InsertNode(CurS_Node,MakeNode(Format('�������� N %d ���������',[l_ExtIDField.AsLargeInt])));
    da_oobSaveDoc  : CurStatTree.InsertNode(CurS_Node,MakeNode(Format('�������� N %d �������� �� ����',[l_ExtIDField.AsLargeInt])));
    da_oobEditDictionary :
     begin
      l_Additional := l_AdditionalInfoField.AsInteger;
      Case PdaDictEditRec(@l_Additional).Operation of
       da_eoNone   : TmpStr:='';
       da_eoAdd    : TmpStr:='(�������� �������)';
       da_eoEdit   : TmpStr:='(��������� �������)';
       da_eoDelete : TmpStr:='(������ �������)';
      end;
      Case PdaDictEditRec(@l_Additional).DictType of
       da_dlSources    : CurStatTree.InsertNode(CurS_Node,MakeNode(Format('������� ������� ������ %s',[TmpStr])));
       da_dlTypes      : CurStatTree.InsertNode(CurS_Node,MakeNode(Format('������� ������� ���� %s',[TmpStr])));
       da_dlClasses    : CurStatTree.InsertNode(CurS_Node,MakeNode(Format('������� ������� ������ %s',[TmpStr])));
       da_dlKeyWords   : CurStatTree.InsertNode(CurS_Node,MakeNode(Format('������� ������� KW %s',[TmpStr])));
       da_dlBases      : CurStatTree.InsertNode(CurS_Node,MakeNode(Format('������� ������� ������ %s',[TmpStr])));
       da_dlWarnings   : CurStatTree.InsertNode(CurS_Node,MakeNode(Format('������� ������� �������������� %s',[TmpStr])));
       da_dlCorSources : CurStatTree.InsertNode(CurS_Node,
                                              MakeNode(Format('������� ������� ��������� ���������� %s',[TmpStr])));
      end;
     end;
    da_oobExport : CurStatTree.InsertNode(CurS_Node,MakeNode(Format('�������� ������� %d ����������',
                                                                                [l_AdditionalInfoField.AsInteger])));
    da_oobImport : CurStatTree.InsertNode(CurS_Node,MakeNode('�������� ������'));
    da_oobSearch_Deprecated : ;
    da_oobAutoClass: CurStatTree.InsertNode(CurS_Node,MakeNode(Format('��������� ����������������� %d ����������',
                                                                                [l_AdditionalInfoField.AsInteger])));
   else
    CurStatTree.InsertNode(CurS_Node,MakeNode(Format('�������������� �������� (%s)', [GetEnumName(TypeInfo(TdaJournalOperation), l_OperationField.AsInteger)])));
   end;

   DT2.D := l_DateField.AsStDate;
   DT2.T := l_TimeField.AsStTime;
   aLog.Next;
  end;
  SetSessionTime;
  SetFooterParams;
//#UC END# *5563292201CF_559A3BD901CC_impl*
end;//TdaJournal.AnalyseLog

procedure TdaJournal.CorrectDates(var FromDate: TStDate;
  ToDate: TStDate);
//#UC START# *55657CD20360_559A3BD901CC_var*
//#UC END# *55657CD20360_559A3BD901CC_var*
begin
//#UC START# *55657CD20360_559A3BD901CC_impl*
 if FromDate = 0 then
  FromDate := 1{CurrentDate};
 if ToDate = 0 then
  ToDate := CurrentDate + 5;
//#UC END# *55657CD20360_559A3BD901CC_impl*
end;//TdaJournal.CorrectDates

function TdaJournal.Get_CurStatisticTreeRoot: Il3RootNode;
//#UC START# *554092F701E2_559A3BD901CCget_var*
//#UC END# *554092F701E2_559A3BD901CCget_var*
begin
//#UC START# *554092F701E2_559A3BD901CCget_impl*
 Result := CurStatTree.RootNode;
//#UC END# *554092F701E2_559A3BD901CCget_impl*
end;//TdaJournal.Get_CurStatisticTreeRoot

procedure TdaJournal.CalcStatistics(FromDate: TStDate;
  ToDate: TStDate;
  aDocID: TdaDocID;
  UserOrGroupID: TdaUserID;
  UserGr: Boolean);
//#UC START# *554093EC02FE_559A3BD901CC_var*
//#UC END# *554093EC02FE_559A3BD901CC_var*
begin
//#UC START# *554093EC02FE_559A3BD901CC_impl*
 AnalyseLog(MakeResultSet(FromDate, ToDate, aDocID, UserOrGroupID, UserGr));
//#UC END# *554093EC02FE_559A3BD901CC_impl*
end;//TdaJournal.CalcStatistics

procedure TdaJournal.LogExport(aFamilyID: TdaFamilyID;
  aCount: LongInt);
//#UC START# *55409430035F_559A3BD901CC_var*
//#UC END# *55409430035F_559A3BD901CC_var*
begin
//#UC START# *55409430035F_559A3BD901CC_impl*
 LogEvent(da_oobExport, aFamilyID, 0, aCount);
//#UC END# *55409430035F_559A3BD901CC_impl*
end;//TdaJournal.LogExport

procedure TdaJournal.LogImport(aFamilyID: TdaFamilyID);
//#UC START# *5540943F02DB_559A3BD901CC_var*
//#UC END# *5540943F02DB_559A3BD901CC_var*
begin
//#UC START# *5540943F02DB_559A3BD901CC_impl*
 LogEvent(da_oobImport, aFamilyID, 0, 0);
//#UC END# *5540943F02DB_559A3BD901CC_impl*
end;//TdaJournal.LogImport

procedure TdaJournal.LogPause(aLength: LongInt);
//#UC START# *5540945201E3_559A3BD901CC_var*
//#UC END# *5540945201E3_559A3BD901CC_var*
begin
//#UC START# *5540945201E3_559A3BD901CC_impl*
 LogEvent(da_oobPause, 0, 0, aLength);
//#UC END# *5540945201E3_559A3BD901CC_impl*
end;//TdaJournal.LogPause

procedure TdaJournal.LogPrintDoc(aFamilyID: TdaFamilyID;
  aDocID: TdaDocID);
//#UC START# *55409462014D_559A3BD901CC_var*
//#UC END# *55409462014D_559A3BD901CC_var*
begin
//#UC START# *55409462014D_559A3BD901CC_impl*
 LogEvent(da_oobPrintDoc, aFamilyID, aDocID, 0);
//#UC END# *55409462014D_559A3BD901CC_impl*
end;//TdaJournal.LogPrintDoc

procedure TdaJournal.LogSaveDoc(aFamilyID: TdaFamilyID;
  aDocID: TdaDocID);
//#UC START# *554094740288_559A3BD901CC_var*
//#UC END# *554094740288_559A3BD901CC_var*
begin
//#UC START# *554094740288_559A3BD901CC_impl*
 LogEvent(da_oobSaveDoc, aFamilyID, aDocID, 0);
//#UC END# *554094740288_559A3BD901CC_impl*
end;//TdaJournal.LogSaveDoc

procedure TdaJournal.LogEditDoc(aFamilyID: TdaFamilyID;
  aDocID: TdaDocID;
  aEditType: TdaDocEditType;
  anOperation: TdaEditOperation = da_eoNone);
//#UC START# *554096B30178_559A3BD901CC_var*
var
// l_EditInfo2: TDocEditRec;
 l_EditInfo: TdaDocEditRec;
 Tmp: Longint;
//#UC END# *554096B30178_559A3BD901CC_var*
begin
//#UC START# *554096B30178_559A3BD901CC_impl*
 l_EditInfo.EditType := aEditType;
 l_EditInfo.Details.Operation := anOperation;
 Tmp := 0;
 l3Move(l_EditInfo, Tmp, SizeOf(l_EditInfo));
 LogEvent(da_oobEditDoc, aFamilyID, aDocID, Tmp);
//#UC END# *554096B30178_559A3BD901CC_impl*
end;//TdaJournal.LogEditDoc

procedure TdaJournal.LogEditDoc(aFamilyID: TdaFamilyID;
  aDocID: TdaDocID;
  aEditType: TdaDocEditType;
  aDictType: TdaDictionaryType);
//#UC START# *5540970E00EA_559A3BD901CC_var*
var
 l_EditInfo: TdaDocEditRec;
 Tmp: Longint;
//#UC END# *5540970E00EA_559A3BD901CC_var*
begin
//#UC START# *5540970E00EA_559A3BD901CC_impl*
 l_EditInfo.EditType := aEditType;
 l_EditInfo.Details.DictType := aDictType;
 Tmp := 0;
 l3Move(aEditType, Tmp, SizeOf(l_EditInfo));
 LogEvent(da_oobEditDoc, aFamilyID, aDocID, Tmp);
//#UC END# *5540970E00EA_559A3BD901CC_impl*
end;//TdaJournal.LogEditDoc

procedure TdaJournal.LogDeleteDoc(aFamilyID: TdaFamilyID;
  aDocID: TdaDocID);
//#UC START# *554097C303BF_559A3BD901CC_var*
//#UC END# *554097C303BF_559A3BD901CC_var*
begin
//#UC START# *554097C303BF_559A3BD901CC_impl*
 LogEvent(da_oobDeleteDoc, aFamilyID, aDocID, 0);
//#UC END# *554097C303BF_559A3BD901CC_impl*
end;//TdaJournal.LogDeleteDoc

procedure TdaJournal.LogEditDict(aFamilyID: TdaFamilyID;
  aDictType: TdaDictionaryType;
  anOperation: TdaEditOperation = da_eoNone);
//#UC START# *554097DC02FC_559A3BD901CC_var*
var
// l_Rec2: TDictEditRec;
 l_Rec: TdaDictEditRec;
 Tmp: Longint;
//#UC END# *554097DC02FC_559A3BD901CC_var*
begin
//#UC START# *554097DC02FC_559A3BD901CC_impl*
 l_Rec.DictType := aDictType;
 l_Rec.Operation := anOperation;
 Tmp := 0;
 l3Move(l_Rec, Tmp, SizeOf(l_Rec));
 LogEvent(da_oobEditDictionary, aFamilyID, 0, Tmp);
//#UC END# *554097DC02FC_559A3BD901CC_impl*
end;//TdaJournal.LogEditDict

procedure TdaJournal.LogCreateDoc(aFamilyID: TdaFamilyID;
  aDocID: TdaDocID);
//#UC START# *554098710243_559A3BD901CC_var*
//#UC END# *554098710243_559A3BD901CC_var*
begin
//#UC START# *554098710243_559A3BD901CC_impl*
 LogEvent(da_oobCreateDoc, aFamilyID, aDocID, 0);
//#UC END# *554098710243_559A3BD901CC_impl*
end;//TdaJournal.LogCreateDoc

procedure TdaJournal.LogAutoClass(aFamilyID: TdaFamilyID;
  aCount: LongInt);
//#UC START# *554098930337_559A3BD901CC_var*
//#UC END# *554098930337_559A3BD901CC_var*
begin
//#UC START# *554098930337_559A3BD901CC_impl*
 LogEvent(da_oobAutoClass, aFamilyID, 0, aCount);
//#UC END# *554098930337_559A3BD901CC_impl*
end;//TdaJournal.LogAutoClass

procedure TdaJournal.LogOpenDoc(aFamilyID: TdaFamilyID;
  aDocID: TdaDocID);
//#UC START# *554098A40242_559A3BD901CC_var*
//#UC END# *554098A40242_559A3BD901CC_var*
begin
//#UC START# *554098A40242_559A3BD901CC_impl*
 LogEvent(da_oobOpenDoc, aFamilyID, aDocID, 0);
//#UC END# *554098A40242_559A3BD901CC_impl*
end;//TdaJournal.LogOpenDoc

function TdaJournal.Get_UserID: TdaUserID;
//#UC START# *5541F3E6031F_559A3BD901CCget_var*
//#UC END# *5541F3E6031F_559A3BD901CCget_var*
begin
//#UC START# *5541F3E6031F_559A3BD901CCget_impl*
 CheckUser(f_CurUser);
 Result := f_CurUser;
//#UC END# *5541F3E6031F_559A3BD901CCget_impl*
end;//TdaJournal.Get_UserID

procedure TdaJournal.Set_UserID(aValue: TdaUserID);
//#UC START# *5541F3E6031F_559A3BD901CCset_var*
//#UC END# *5541F3E6031F_559A3BD901CCset_var*
begin
//#UC START# *5541F3E6031F_559A3BD901CCset_impl*
 if f_CurUser <> aValue then
 begin
  if f_CurSessionID <> BlankSession then
  begin
   LogEvent(da_oobSessionEnd, 0, 0, 0);
   f_CurSessionID := BlankSession
  end;
  f_CurUser := aValue;
  UserChanged(f_CurUser);
  if f_CurUser<>0 then
  begin
    f_CurSessionID := GetNewSessionID;
    SessionChanged;
    LogEvent(da_oobSessionBegin, 0, LongInt(f_CurUser), 0);
  end;
 end;
//#UC END# *5541F3E6031F_559A3BD901CCset_impl*
end;//TdaJournal.Set_UserID

procedure TdaJournal.StartCaching;
//#UC START# *5541F6EC00DE_559A3BD901CC_var*
//#UC END# *5541F6EC00DE_559A3BD901CC_var*
begin
//#UC START# *5541F6EC00DE_559A3BD901CC_impl*
 DoStartCaching;
//#UC END# *5541F6EC00DE_559A3BD901CC_impl*
end;//TdaJournal.StartCaching

procedure TdaJournal.StopCaching;
//#UC START# *5541F6FB0124_559A3BD901CC_var*
//#UC END# *5541F6FB0124_559A3BD901CC_var*
begin
//#UC START# *5541F6FB0124_559A3BD901CC_impl*
 DoStopCaching;
//#UC END# *5541F6FB0124_559A3BD901CC_impl*
end;//TdaJournal.StopCaching

procedure TdaJournal.SessionDone;
//#UC START# *554A037B0325_559A3BD901CC_var*
//#UC END# *554A037B0325_559A3BD901CC_var*
begin
//#UC START# *554A037B0325_559A3BD901CC_impl*
 LogEvent(da_oobSessionEnd, 0, 0, 0);
//#UC END# *554A037B0325_559A3BD901CC_impl*
end;//TdaJournal.SessionDone

procedure TdaJournal.Cleanup;
//#UC START# *479731C50290_559A3BD901CC_var*
//#UC END# *479731C50290_559A3BD901CC_var*
begin
//#UC START# *479731C50290_559A3BD901CC_impl*
 f_Factory := nil;
 FreeAndNil(f_CurStatTree);
 inherited;
//#UC END# *479731C50290_559A3BD901CC_impl*
end;//TdaJournal.Cleanup

procedure TdaJournal.ClearFields;
 {-}
begin
 f_Factory := nil;
 inherited;
end;//TdaJournal.ClearFields

end.