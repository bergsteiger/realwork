unit caJournal;

// Модуль: "w:\common\components\rtl\Garant\ComboAccess\caJournal.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ComboAccess\caDefine.inc}

interface

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3IntfUses
 , daJournal
 , htJournal
 , pgJournal
 , daInterfaces
 , l3Tree
 , daTypes
 , l3Date
;

type
 TcaJournal = class(TdaJournal)
  private
   f_HTJournal: ThtJournal;
   f_PGJournal: TpgJournal;
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
  public
   constructor Create(const aFactory: IdaTableQueryFactory;
    aHTJournal: ThtJournal;
    aPGJournal: TpgJournal); reintroduce;
   class function Make(const aFactory: IdaTableQueryFactory;
    aHTJournal: ThtJournal;
    aPGJournal: TpgJournal): IdaJournal; reintroduce;
 end;//TcaJournal
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
;

constructor TcaJournal.Create(const aFactory: IdaTableQueryFactory;
 aHTJournal: ThtJournal;
 aPGJournal: TpgJournal);
//#UC START# *56BD9BFD0109_56BD8F200154_var*
//#UC END# *56BD9BFD0109_56BD8F200154_var*
begin
//#UC START# *56BD9BFD0109_56BD8F200154_impl*
 inherited Create(aFactory);
//!! !!! Needs to be implemented !!!
//#UC END# *56BD9BFD0109_56BD8F200154_impl*
end;//TcaJournal.Create

class function TcaJournal.Make(const aFactory: IdaTableQueryFactory;
 aHTJournal: ThtJournal;
 aPGJournal: TpgJournal): IdaJournal;
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
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5549F6220397_56BD8F200154_impl*
end;//TcaJournal.LogEvent

procedure TcaJournal.CheckUser(anUserID: TdaUserID);
//#UC START# *559B6A290200_56BD8F200154_var*
//#UC END# *559B6A290200_56BD8F200154_var*
begin
//#UC START# *559B6A290200_56BD8F200154_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *559B6A290200_56BD8F200154_impl*
end;//TcaJournal.CheckUser

procedure TcaJournal.UserChanged(anUserID: TdaUserID);
//#UC START# *559B6A7C03AA_56BD8F200154_var*
//#UC END# *559B6A7C03AA_56BD8F200154_var*
begin
//#UC START# *559B6A7C03AA_56BD8F200154_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *559B6A7C03AA_56BD8F200154_impl*
end;//TcaJournal.UserChanged

procedure TcaJournal.SessionChanged;
//#UC START# *559B6A8C0034_56BD8F200154_var*
//#UC END# *559B6A8C0034_56BD8F200154_var*
begin
//#UC START# *559B6A8C0034_56BD8F200154_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *559B6A8C0034_56BD8F200154_impl*
end;//TcaJournal.SessionChanged

procedure TcaJournal.DoStartCaching;
//#UC START# *559B889B030B_56BD8F200154_var*
//#UC END# *559B889B030B_56BD8F200154_var*
begin
//#UC START# *559B889B030B_56BD8F200154_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *559B889B030B_56BD8F200154_impl*
end;//TcaJournal.DoStartCaching

procedure TcaJournal.DoStopCaching;
//#UC START# *559B88B00126_56BD8F200154_var*
//#UC END# *559B88B00126_56BD8F200154_var*
begin
//#UC START# *559B88B00126_56BD8F200154_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *559B88B00126_56BD8F200154_impl*
end;//TcaJournal.DoStopCaching

function TcaJournal.MakeResultSet(const FromDate: TStDate;
 const ToDate: TStDate;
 aDocID: TdaDocID;
 UserOrGroupID: TdaUserID;
 UserGr: Boolean): IdaResultSet;
//#UC START# *559CF9D300FA_56BD8F200154_var*
//#UC END# *559CF9D300FA_56BD8F200154_var*
begin
//#UC START# *559CF9D300FA_56BD8F200154_impl*
 Result := nil;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *559CF9D300FA_56BD8F200154_impl*
end;//TcaJournal.MakeResultSet
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.
