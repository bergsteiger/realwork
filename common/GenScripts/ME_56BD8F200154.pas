unit caJournal;

// Модуль: "w:\common\components\rtl\Garant\ComboAccess\caJournal.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ComboAccess\caDefine.inc}

interface

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3IntfUses
 , daJournal
 , daInterfaces
 , l3Tree
 , daTypes
 , l3Date
;

type
 TcaJournal = class(TdaJournal)
  private
   f_HTJournal: IdaJournal;
   f_PGJournal: IdaJournal;
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
   function MakeResultSet(const FromDate: TStDate;
    const ToDate: TStDate;
    aDocID: TdaDocID;
    UserOrGroupID: TdaUserID;
    UserGr: Boolean): IdaResultSet; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aFactory: IdaTableQueryFactory;
    const aHTJournal: IdaJournal;
    const aPGJournal: IdaJournal); reintroduce;
   class function Make(const aFactory: IdaTableQueryFactory;
    const aHTJournal: IdaJournal;
    const aPGJournal: IdaJournal): IdaJournal; reintroduce;
 end;//TcaJournal
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
 , daScheme
 , daSelectFieldList
 , caResultSet
 , SysUtils
;

constructor TcaJournal.Create(const aFactory: IdaTableQueryFactory;
 const aHTJournal: IdaJournal;
 const aPGJournal: IdaJournal);
//#UC START# *56BD9BFD0109_56BD8F200154_var*
//#UC END# *56BD9BFD0109_56BD8F200154_var*
begin
//#UC START# *56BD9BFD0109_56BD8F200154_impl*
 inherited Create(aFactory);
 f_HTJournal := aHTJournal;
 f_PGJournal := aHTJournal;
//#UC END# *56BD9BFD0109_56BD8F200154_impl*
end;//TcaJournal.Create

class function TcaJournal.Make(const aFactory: IdaTableQueryFactory;
 const aHTJournal: IdaJournal;
 const aPGJournal: IdaJournal): IdaJournal;
var
 l_Inst : TcaJournal;
begin
 l_Inst := Create(aFactory, aHTJournal, aPGJournal);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TcaJournal.Make

procedure TcaJournal.LogEvent(aOperation: TdaJournalOperation;
 aFamilyID: TdaFamilyID;
 aExtID: LongInt;
 aData: LongInt);
//#UC START# *5549F6220397_56BD8F200154_var*
//#UC END# *5549F6220397_56BD8F200154_var*
begin
//#UC START# *5549F6220397_56BD8F200154_impl*
 (f_HTJournal as IdaComboAccessJournalHelper).LogAlienEvent(aOperation, aFamilyID, aExtID, aData);
 (f_PGJournal as IdaComboAccessJournalHelper).LogAlienEvent(aOperation, aFamilyID, aExtID, aData);
//#UC END# *5549F6220397_56BD8F200154_impl*
end;//TcaJournal.LogEvent

procedure TcaJournal.CheckUser(anUserID: TdaUserID);
//#UC START# *559B6A290200_56BD8F200154_var*
//#UC END# *559B6A290200_56BD8F200154_var*
begin
//#UC START# *559B6A290200_56BD8F200154_impl*
// Do nothing
//#UC END# *559B6A290200_56BD8F200154_impl*
end;//TcaJournal.CheckUser

procedure TcaJournal.UserChanged(anUserID: TdaUserID);
//#UC START# *559B6A7C03AA_56BD8F200154_var*
//#UC END# *559B6A7C03AA_56BD8F200154_var*
begin
//#UC START# *559B6A7C03AA_56BD8F200154_impl*
// Do nothing
//#UC END# *559B6A7C03AA_56BD8F200154_impl*
end;//TcaJournal.UserChanged

procedure TcaJournal.SessionChanged;
//#UC START# *559B6A8C0034_56BD8F200154_var*
//#UC END# *559B6A8C0034_56BD8F200154_var*
begin
//#UC START# *559B6A8C0034_56BD8F200154_impl*
 (f_HTJournal as IdaComboAccessJournalHelper).SetAlienSessionID(CurSessionID);
 (f_PGJournal as IdaComboAccessJournalHelper).SetAlienSessionID(CurSessionID);
//#UC END# *559B6A8C0034_56BD8F200154_impl*
end;//TcaJournal.SessionChanged

procedure TcaJournal.DoStartCaching;
//#UC START# *559B889B030B_56BD8F200154_var*
//#UC END# *559B889B030B_56BD8F200154_var*
begin
//#UC START# *559B889B030B_56BD8F200154_impl*
 f_HTJournal.StartCaching;
 f_PGJournal.StartCaching;
//#UC END# *559B889B030B_56BD8F200154_impl*
end;//TcaJournal.DoStartCaching

procedure TcaJournal.DoStopCaching;
//#UC START# *559B88B00126_56BD8F200154_var*
//#UC END# *559B88B00126_56BD8F200154_var*
begin
//#UC START# *559B88B00126_56BD8F200154_impl*
 f_HTJournal.StopCaching;
 f_PGJournal.StopCaching;
//#UC END# *559B88B00126_56BD8F200154_impl*
end;//TcaJournal.DoStopCaching

function TcaJournal.MakeResultSet(const FromDate: TStDate;
 const ToDate: TStDate;
 aDocID: TdaDocID;
 UserOrGroupID: TdaUserID;
 UserGr: Boolean): IdaResultSet;
//#UC START# *559CF9D300FA_56BD8F200154_var*
var
 l_SelectFields : TdaSelectFieldList;

 function lp_AddSelectField(aField: IdaFieldDescription): Boolean;
 begin
  Result := True;
  l_SelectFields.Add(Factory.MakeSelectField('', aField));
 end;

//#UC END# *559CF9D300FA_56BD8F200154_var*
begin
//#UC START# *559CF9D300FA_56BD8F200154_impl*
 l_SelectFields := TdaSelectFieldList.Make;
 try
  TdaScheme.Instance.Table(da_mtJournal).IterateFieldsF(L2DaTableDescriptionIteratorIterateFieldsFAction(@lp_AddSelectField));
  Result := TcaResultSet.Make(l_SelectFields,
    (f_HTJournal as IdaComboAccessJournalHelper).MakeAlienResultSet(FromDate, ToDate, aDocID, UserOrGroupID, UserGr),
    (f_PGJournal as IdaComboAccessJournalHelper).MakeAlienResultSet(FromDate, ToDate, aDocID, UserOrGroupID, UserGr));
 finally
  FreeAndNil(l_SelectFields);
 end;
//#UC END# *559CF9D300FA_56BD8F200154_impl*
end;//TcaJournal.MakeResultSet

procedure TcaJournal.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56BD8F200154_var*
//#UC END# *479731C50290_56BD8F200154_var*
begin
//#UC START# *479731C50290_56BD8F200154_impl*
 f_HTJournal := nil;
 f_PGJournal := nil;
 inherited;
//#UC END# *479731C50290_56BD8F200154_impl*
end;//TcaJournal.Cleanup
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.
