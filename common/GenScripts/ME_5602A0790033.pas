unit pgJournal;

// Модуль: "w:\common\components\rtl\Garant\PG\pgJournal.pas"
// Стереотип: "SimpleClass"

{$Include pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , daJournal
 , pgJournalCache
 , pgTableModifier
 , pgConnection
 , daInterfaces
 , l3Tree
 , daTypes
 , l3Date
;

type
 TpgJournal = class(TdaJournal)
  private
   f_CacheCounter: Integer;
   f_Cache: TpgJournalCacheList;
   f_Modifier: TpgTableModifier;
   f_Connection: TpgConnection;
  private
   procedure PurgeCache;
   function Modifier: TpgTableModifier;
  protected
   procedure LogEvent(aOperation: TdaJournalOperation;
    aFamilyID: TdaFamilyID;
    aExtID: LongInt;
    aData: LongInt); override;
   procedure CheckUser(anUserID: TdaUserID); override;
   procedure UserChanged(anUserID: TdaUserID); override;
   procedure SessionChanged; override;
   procedure DoStartCaching; override;
   procedure DoStopCaching; override;
   function MakeResultSet(FromDate: TStDate;
    ToDate: TStDate;
    aDocID: TdaDocID;
    UserOrGroupID: TdaUserID;
    UserGr: Boolean): IdaResultSet; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aConnection: TpgConnection;
    const aFactory: IdaTableQueryFactory); reintroduce;
   class function Make(aConnection: TpgConnection;
    const aFactory: IdaTableQueryFactory): IdaJournal; reintroduce;
 end;//TpgJournal
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , daScheme
 , SysUtils
 , l3Types
 , l3Base
;

constructor TpgJournal.Create(aConnection: TpgConnection;
 const aFactory: IdaTableQueryFactory);
//#UC START# *5602A3C10042_5602A0790033_var*
//#UC END# *5602A3C10042_5602A0790033_var*
begin
//#UC START# *5602A3C10042_5602A0790033_impl*
 inherited Create(aFactory);
//#UC END# *5602A3C10042_5602A0790033_impl*
end;//TpgJournal.Create

class function TpgJournal.Make(aConnection: TpgConnection;
 const aFactory: IdaTableQueryFactory): IdaJournal;
var
 l_Inst : TpgJournal;
begin
 l_Inst := Create(aConnection, aFactory);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TpgJournal.Make

procedure TpgJournal.PurgeCache;
//#UC START# *5649D8A70161_5602A0790033_var*
 function lp_LogEvent(Data: PpgJournalCacheRec; Index: Long): Bool;
 begin
  Result := True;
  LogEvent(Data^.rOperation, Data^.rFamilyID, Data^.rExtID, Data^.rData);
 end;
//#UC END# *5649D8A70161_5602A0790033_var*
begin
//#UC START# *5649D8A70161_5602A0790033_impl*
 f_Cache.IterateAllF(l3L2IA(@lp_LogEvent));
//#UC END# *5649D8A70161_5602A0790033_impl*
end;//TpgJournal.PurgeCache

function TpgJournal.Modifier: TpgTableModifier;
//#UC START# *564B218C013C_5602A0790033_var*
//#UC END# *564B218C013C_5602A0790033_var*
begin
//#UC START# *564B218C013C_5602A0790033_impl*
 if f_Modifier = nil then
  f_Modifier := TpgTableModifier.Create(da_mtJournal, f_Connection, Factory.DataConverter);
 Result := f_Modifier;
//#UC END# *564B218C013C_5602A0790033_impl*
end;//TpgJournal.Modifier

procedure TpgJournal.LogEvent(aOperation: TdaJournalOperation;
 aFamilyID: TdaFamilyID;
 aExtID: LongInt;
 aData: LongInt);
//#UC START# *5549F6220397_5602A0790033_var*
//#UC END# *5549F6220397_5602A0790033_var*
begin
//#UC START# *5549F6220397_5602A0790033_impl*
 Assert(False);
// !!! Needs to be implemented !!!
//#UC END# *5549F6220397_5602A0790033_impl*
end;//TpgJournal.LogEvent

procedure TpgJournal.CheckUser(anUserID: TdaUserID);
//#UC START# *559B6A290200_5602A0790033_var*
//#UC END# *559B6A290200_5602A0790033_var*
begin
//#UC START# *559B6A290200_5602A0790033_impl*
// Do nothing;
//#UC END# *559B6A290200_5602A0790033_impl*
end;//TpgJournal.CheckUser

procedure TpgJournal.UserChanged(anUserID: TdaUserID);
//#UC START# *559B6A7C03AA_5602A0790033_var*
//#UC END# *559B6A7C03AA_5602A0790033_var*
begin
//#UC START# *559B6A7C03AA_5602A0790033_impl*
// Do nothing;
//#UC END# *559B6A7C03AA_5602A0790033_impl*
end;//TpgJournal.UserChanged

procedure TpgJournal.SessionChanged;
//#UC START# *559B6A8C0034_5602A0790033_var*
//#UC END# *559B6A8C0034_5602A0790033_var*
begin
//#UC START# *559B6A8C0034_5602A0790033_impl*
// Do nothing;
//#UC END# *559B6A8C0034_5602A0790033_impl*
end;//TpgJournal.SessionChanged

procedure TpgJournal.DoStartCaching;
//#UC START# *559B889B030B_5602A0790033_var*
//#UC END# *559B889B030B_5602A0790033_var*
begin
//#UC START# *559B889B030B_5602A0790033_impl*
 Assert(False);
// !!! Needs to be implemented !!!
//#UC END# *559B889B030B_5602A0790033_impl*
end;//TpgJournal.DoStartCaching

procedure TpgJournal.DoStopCaching;
//#UC START# *559B88B00126_5602A0790033_var*
//#UC END# *559B88B00126_5602A0790033_var*
begin
//#UC START# *559B88B00126_5602A0790033_impl*
 Assert(False);
// !!! Needs to be implemented !!!
//#UC END# *559B88B00126_5602A0790033_impl*
end;//TpgJournal.DoStopCaching

function TpgJournal.MakeResultSet(FromDate: TStDate;
 ToDate: TStDate;
 aDocID: TdaDocID;
 UserOrGroupID: TdaUserID;
 UserGr: Boolean): IdaResultSet;
//#UC START# *559CF9D300FA_5602A0790033_var*
var
 l_Query: IdaQuery;
 l_SubQuery: IdaQuery;
 l_MainCondition: IdaCondition;
 l_DocCondition: IdaCondition;
 l_UserCondition: IdaCondition;
 l_UserQuery: IdaQuery;

 function lp_AddSelectField(aField: IdaFieldDescription): Boolean;
 begin
  Result := True;
  l_Query.AddSelectField(Factory.MakeSelectField('j', aField));
 end;

//#UC END# *559CF9D300FA_5602A0790033_var*
begin
//#UC START# *559CF9D300FA_5602A0790033_impl*
  Result := nil;
  Assert(False);
// !!! Needs to be implemented !!!
 CorrectDates(FromDate, ToDate);
 l_Query := Factory.MakeTabledQuery(TdaScheme.Instance.Table(da_mtJournal), 'j');
 try
  TdaScheme.Instance.Table(da_mtJournal).IterateFieldsF(L2DaTableDescriptionIteratorIterateFieldsFAction(@lp_AddSelectField));
  l_SubQuery := Factory.MakeTabledQuery(TdaScheme.Instance.Table(da_mtJournal), 's');
  try
   l_SubQuery.AddSelectField(Factory.MakeSelectField('s', TdaScheme.Instance.Table(da_mtJournal).Field['ID_Session']));

(*
   l_DateCondition := Factory.MakeLogicCondition(Factory.MakeParamsCondition('s', TdaScheme.Instance.Table(da_mtJournal).Field['Date'], da_copGreaterOrEqual, 'p_DateFrom'),
     da_loAnd, Factory.MakeParamsCondition('s', TdaScheme.Instance.Table(da_mtJournal).Field['Date'], da_copEqual, 'p_DateTo'));
   try
    if UserOrGroupID <> 0 then
    begin
     l_UserCondition := Factory.MakeParamsCondition('s', TdaScheme.Instance.Table(da_mtJournal).Field['ID_Operat'], da_copEqual, 'p_StartSessionID');
     try
      if UserGr then
      begin
       l_UserQuery := Factory.MakeTabledQuery(TdaScheme.Instance.Table(da_mtGroupMembers), 'j');
       try
        l_UserQuery.AddSelectField(Factory.MakeSelectField('u', TdaScheme.Instance.Table(da_mtGroupMembers).Field['Us_ID']));
        l_UserQuery.WhereCondition := Factory.MakeParamsCondition('u', TdaScheme.Instance.Table(da_mtGroupMembers).Field['UsGr_ID'], da_copEqual, 'p_UserID');
        l_UserCondition := Factory.MakeLogicCondition(l_UserCondition, da_loAnd,
         Factory.MakeSubQueryCondition('s', TdaScheme.Instance.Table(da_mtJournal).Field['ID_Ext'], l_UserQuery));
       finally
        l_UserQuery := nil;
       end;
      end
      else
       l_UserCondition := Factory.MakeLogicCondition(l_UserCondition, da_loAnd, Factory.MakeParamsCondition('s', TdaScheme.Instance.Table(da_mtJournal).Field['ID_Ext'], da_copEqual, 'p_UserID'));
      l_DateCondition := Factory.MakeLogicCondition(l_DateCondition, da_loAnd, l_UserCondition);
     finally
      l_UserCondition := nil;
     end;
    end;
    if aDocID <> 0 then
    begin
     l_DateCondition := Factory.MakeLogicCondition(l_DateCondition, da_loAnd,
       Factory.MakeLogicCondition(Factory.MakeParamsCondition('s', TdaScheme.Instance.Table(da_mtJournal).Field['ID_Operat'], da_copNotEqual, 'p_StartSessionID'), da_loAnd,
       Factory.MakeLogicCondition(Factory.MakeParamsCondition('s', TdaScheme.Instance.Table(da_mtJournal).Field['ID_Ext'], da_copNotEqual, 'p_DocID'));
    end;
    l_SubQuery.WhereCondition := l_DateCondition;
   finally
    l_DateCondition := nil;
   end;
   l_MainCondition := Factory.MakeSubQueryCondition('j', TdaScheme.Instance.Table(da_mtJournal).Field['ID_Session'], l_SubQuery);
   try
    if aDocID <> 0 then
    begin
     l_DocCondition := Factory.MakeLogicCondition(Factory.MakeLogicCondition(Factory.MakeParamsCondition('j', TdaScheme.Instance.Table(da_mtJournal).Field['ID_Operat'], da_copEqual, 'p_StartSessionID'),
                       da_loOr, Factory.MakeParamsCondition('j', TdaScheme.Instance.Table(da_mtJournal).Field['ID_Operat'], da_copEqual, 'p_EndSessionID')),
                         da_loOr, Factory.MakeParamsCondition('j', TdaScheme.Instance.Table(da_mtJournal).Field['ID_Ext'], da_copEqual, 'p_DocID'));
     try
      l_Query.WhereCondition := Factory.MakeLogicCondition(l_MainCondition, da_loAnd, l_DocCondition);
     finally
      l_DocCondition := nil;
     end;
    end
    else
     l_Query.WhereCondition := l_MainCondition;
   finally
    l_MainCondition := nil;
   end; *)
  finally
   l_SubQuery := nil;
  end;
  l_Query.Prepare;
  l_Query.Param['p_DateFrom'].AsStDate := FromDate;
  l_Query.Param['p_DateTo'].AsStDate := ToDate;
  if aDocID <> 0 then
  begin
   l_Query.Param['p_DocID'].AsLargeInt := aDocID;
   l_Query.Param['p_StartSessionID'].AsInteger := Ord(da_oobSessionBegin);
   l_Query.Param['p_EndSessionID'].AsInteger := Ord(da_oobSessionEnd);
  end;
  if aDocID <> 0 then
    l_Query.Param['p_UserID'].AsLargeInt := UserOrGroupID;
  Result := l_Query.OpenResultSet;
 finally
  FreeAndNil(l_Query);
 end;
//#UC END# *559CF9D300FA_5602A0790033_impl*
end;//TpgJournal.MakeResultSet

procedure TpgJournal.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5602A0790033_var*
//#UC END# *479731C50290_5602A0790033_var*
begin
//#UC START# *479731C50290_5602A0790033_impl*
 FreeAndNil(f_Cache);
 FreeAndNil(f_Modifier);
 FreeAndNil(f_Connection);
 inherited;
//#UC END# *479731C50290_5602A0790033_impl*
end;//TpgJournal.Cleanup
{$IfEnd} // Defined(UsePostgres)

end.
