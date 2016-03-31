unit pgFreeIDHelper;

// Модуль: "w:\common\components\rtl\Garant\PG\pgFreeIDHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgFreeIDHelper" MUID: (56556EF3017C)

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
 , pgConnection
 , pgFunctionFactory
;

type
 TpgFreeIDHelper = class(Tl3ProtoObject, IdaComboAccessDataProviderHelper)
  private
   f_IntervalQuery: IdaTabledQuery;
   f_FamilyID: TdaFamilyID;
   f_GetFreeFunction: IdaFunction;
   f_DeleteIntervalFunction: IdaFunction;
   f_Connection: TpgConnection;
   f_ExclusiveUse: Boolean;
    {* Поле для свойства ExclusiveUse }
  private
   function KeyPrefix(const aKey: AnsiString): AnsiString;
   function RepairInterval(const aKey: AnsiString): Boolean;
   function GetFreeFromTable(const aKey: AnsiString;
    out theNumber: TdaDocID): Boolean;
   function GetFreeFromReplica(const aKey: AnsiString;
    out theNumber: TdaDocID): Boolean;
   function TableKind: TdaTables;
  protected
   procedure pm_SetExclusiveUse(aValue: Boolean); virtual;
   function RegisterFreeExtObjID(aFamilyID: TdaFamilyID;
    const aKey: AnsiString;
    anID: TdaDocID): Boolean;
   function RegisterFreeExtDocID(aFamilyID: TdaFamilyID;
    const aKey: AnsiString;
    anID: TdaDocID): Boolean;
   procedure SetAlienJournalData(aSessionID: TdaSessionID);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aConnection: TpgConnection;
    const aFactory: IdaTableQueryFactory;
    aFunctionFactory: TpgFunctionFactory;
    aFamilyID: TdaFamilyID); reintroduce;
   function GetFree(const aKey: AnsiString): TdaDocID;
   function AnyRangesPresent(const aKey: AnsiString): Boolean;
  public
   property ExclusiveUse: Boolean
    read f_ExclusiveUse
    write pm_SetExclusiveUse;
 end;//TpgFreeIDHelper
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , daScheme
 , daSchemeConsts
 , SysUtils
 , pgInterfaces
;

const
 cFreeTblErr = 'Ошибка получения свободного номера';

procedure TpgFreeIDHelper.pm_SetExclusiveUse(aValue: Boolean);
//#UC START# *565ECB810377_56556EF3017Cset_var*
//#UC END# *565ECB810377_56556EF3017Cset_var*
begin
//#UC START# *565ECB810377_56556EF3017Cset_impl*
 if f_ExclusiveUse <> aValue then
 begin
  f_ExclusiveUse := aValue;
  Assert(False);
//!! !!! Needs to be implemented !!!
 end;
//#UC END# *565ECB810377_56556EF3017Cset_impl*
end;//TpgFreeIDHelper.pm_SetExclusiveUse

constructor TpgFreeIDHelper.Create(aConnection: TpgConnection;
 const aFactory: IdaTableQueryFactory;
 aFunctionFactory: TpgFunctionFactory;
 aFamilyID: TdaFamilyID);
//#UC START# *5656EF8D0161_56556EF3017C_var*
const
 cGetFreeMap: array [MainTblsFamily..CurrentFamily] of AnsiString = (
  'get_admin_free_num',
  'get_free_num'
 );
 cDeleteIntervalMap: array [MainTblsFamily..CurrentFamily] of AnsiString = (
  'delete_admin_free_interval',
  'delete_free_interval'
 );
var
 l_Description: IdaTableDescription;
 l_FieldToSort: IdaSelectField;
//#UC END# *5656EF8D0161_56556EF3017C_var*
begin
//#UC START# *5656EF8D0161_56556EF3017C_impl*
 inherited Create;
 Assert(aFamilyID in [MainTblsFamily, CurrentFamily]);
 f_FamilyID := aFamilyID;
 l_Description := TdaScheme.Instance.Table(TableKind);
 try
  f_IntervalQuery := aFactory.MakeTabledQuery(l_Description);
  f_IntervalQuery.AddSelectField(aFactory.MakeSelectField('', l_Description.Field['start_num']));
  l_FieldToSort := aFactory.MakeSelectField('', l_Description.Field['last_num']);
  f_IntervalQuery.AddSelectField(l_FieldToSort);
  f_IntervalQuery.WhereCondition := aFactory.MakeParamsCondition('', l_Description.Field['table_name'], da_copEqual, 'p_Key');
  f_IntervalQuery.AddOrderBy(aFactory.MakeSortField(l_FieldToSort));
  f_IntervalQuery.Prepare;
 finally
  l_Description := nil;
 end;
 aConnection.SetRefTo(f_Connection);
 f_GetFreeFunction := aFunctionFactory.MakeFunction(cGetFreeMap[aFamilyID]);
 f_DeleteIntervalFunction := aFunctionFactory.MakeFunction(cDeleteIntervalMap[aFamilyID]);
//#UC END# *5656EF8D0161_56556EF3017C_impl*
end;//TpgFreeIDHelper.Create

function TpgFreeIDHelper.KeyPrefix(const aKey: AnsiString): AnsiString;
//#UC START# *565703DA0330_56556EF3017C_var*
const
 c_BadFamily = -1;
//#UC END# *565703DA0330_56556EF3017C_var*
begin
//#UC START# *565703DA0330_56556EF3017C_impl*
 Result := aKey;
 If (f_FamilyID <> MainTblsFamily)
  and (f_FamilyID = StrToIntDef(Copy(aKey, Length(aKey) - 2, 3), c_BadFamily)) // последние 3 символа являются номером семейства
 then
   SetLength(Result, Length(Result) - 3);
//#UC END# *565703DA0330_56556EF3017C_impl*
end;//TpgFreeIDHelper.KeyPrefix

function TpgFreeIDHelper.RepairInterval(const aKey: AnsiString): Boolean;
//#UC START# *5658228C0267_56556EF3017C_var*
//#UC END# *5658228C0267_56556EF3017C_var*
begin
//#UC START# *5658228C0267_56556EF3017C_impl*
 Result := False;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5658228C0267_56556EF3017C_impl*
end;//TpgFreeIDHelper.RepairInterval

function TpgFreeIDHelper.GetFreeFromTable(const aKey: AnsiString;
 out theNumber: TdaDocID): Boolean;
//#UC START# *5658229402A8_56556EF3017C_var*
const
 ATTEMPT_AMOUNT = 20;
 PAUSE_SIZE = 500; // 0,5 сек
var
 l_AttemptNo: Integer;
 l_Search: AnsiString;
 l_ResultSet: IdaResultSet;
//#UC END# *5658229402A8_56556EF3017C_var*
begin
//#UC START# *5658229402A8_56556EF3017C_impl*
 l_Search := KeyPrefix(aKey);
 theNumber := High(theNumber);
 for l_AttemptNo := 1 to ATTEMPT_AMOUNT + 1 do
 begin
  if l_AttemptNo > ATTEMPT_AMOUNT then
   raise Exception.Create('Не удалось получить свободный номер из таблицы FREE.');
  if f_Connection.BeginTransaction([TableKind]) then
  try
   f_IntervalQuery.Param['p_Key'].AsString := l_Search;
   l_ResultSet := f_IntervalQuery.OpenResultSet;
   try
    if not l_ResultSet.IsEmpty then
    begin
     theNumber := l_ResultSet.Field['start_num'].AsLargeInt;
     // проверка: диапазон или одиночное значение?
     if (l_ResultSet.Field['last_num'].AsLargeInt > 0) and (l_ResultSet.Field['start_num'].AsLargeInt < l_ResultSet.Field['last_num'].AsLargeInt) then
     begin
      f_GetFreeFunction.Param['p_table_name'].AsString := l_ResultSet.Field['table_name'].AsString;
      f_GetFreeFunction.Param['p_start_num'].AsLargeInt := l_ResultSet.Field['start_num'].AsLargeInt;
      f_GetFreeFunction.Param['p_last_num'].AsLargeInt := l_ResultSet.Field['last_num'].AsLargeInt;
      f_GetFreeFunction.Execute;
     end
     else
     begin
      f_DeleteIntervalFunction.Param['p_table_name'].AsString := l_ResultSet.Field['table_name'].AsString;
      f_DeleteIntervalFunction.Param['p_start_num'].AsLargeInt := l_ResultSet.Field['start_num'].AsLargeInt;
      f_DeleteIntervalFunction.Param['p_last_num'].AsLargeInt := l_ResultSet.Field['last_num'].AsLargeInt;
      f_DeleteIntervalFunction.Execute;
     end;
    end;
   finally
    l_ResultSet := nil;
   end;
   f_Connection.CommitTransaction;
   Break; // пора прекращать крутить цикл
  except
   theNumber := High(LongWord);
   f_Connection.RollbackTransaction;
   Sleep(PAUSE_SIZE);
  end;
 end; // for
 Result := theNumber <> High(theNumber);
//#UC END# *5658229402A8_56556EF3017C_impl*
end;//TpgFreeIDHelper.GetFreeFromTable

function TpgFreeIDHelper.GetFreeFromReplica(const aKey: AnsiString;
 out theNumber: TdaDocID): Boolean;
//#UC START# *565822B40312_56556EF3017C_var*
//#UC END# *565822B40312_56556EF3017C_var*
begin
//#UC START# *565822B40312_56556EF3017C_impl*
 Result := False;
 if ExclusiveUse then
 begin
  Result := False;
  Assert(False);
//!! !!! Needs to be implemented !!!
 end;
//#UC END# *565822B40312_56556EF3017C_impl*
end;//TpgFreeIDHelper.GetFreeFromReplica

function TpgFreeIDHelper.TableKind: TdaTables;
//#UC START# *56A7208C003C_56556EF3017C_var*
const cTableKindMap: array [MainTblsFamily..CurrentFamily] of TdaTables = (
  da_mtFree,
  da_ftFree
 );
//#UC END# *56A7208C003C_56556EF3017C_var*
begin
//#UC START# *56A7208C003C_56556EF3017C_impl*
 Result := cTableKindMap[f_FamilyID];
//#UC END# *56A7208C003C_56556EF3017C_impl*
end;//TpgFreeIDHelper.TableKind

function TpgFreeIDHelper.GetFree(const aKey: AnsiString): TdaDocID;
//#UC START# *565589E102C3_56556EF3017C_var*
//#UC END# *565589E102C3_56556EF3017C_var*
begin
//#UC START# *565589E102C3_56556EF3017C_impl*
 if not GetFreeFromReplica(aKey, Result) then
  if not GetFreeFromTable(aKey, Result) then
   // поиск и попытка освобождения залоченных интервалов
   if not RepairInterval(aKey) then
    raise EpgError.Create(cFreeTblErr)
   else  // вторая попытка
   begin
    if not GetFreeFromReplica(aKey, Result) then
     if not GetFreeFromTable(aKey, Result) then
      // выстрел в голову
      raise EpgError.Create(cFreeTblErr);
   end;
//#UC END# *565589E102C3_56556EF3017C_impl*
end;//TpgFreeIDHelper.GetFree

function TpgFreeIDHelper.AnyRangesPresent(const aKey: AnsiString): Boolean;
//#UC START# *56558EF30265_56556EF3017C_var*
var
 l_ResultSet: IdaResultSet;
//#UC END# *56558EF30265_56556EF3017C_var*
begin
//#UC START# *56558EF30265_56556EF3017C_impl*
 f_IntervalQuery.Param['p_Key'].AsString := KeyPrefix(aKey);
 l_ResultSet := f_IntervalQuery.OpenResultSet;
 try
  Result := not l_ResultSet.IsEmpty;
 finally
  l_ResultSet := nil;
 end;
//#UC END# *56558EF30265_56556EF3017C_impl*
end;//TpgFreeIDHelper.AnyRangesPresent

function TpgFreeIDHelper.RegisterFreeExtObjID(aFamilyID: TdaFamilyID;
 const aKey: AnsiString;
 anID: TdaDocID): Boolean;
//#UC START# *56BC642200D0_56556EF3017C_var*
//#UC END# *56BC642200D0_56556EF3017C_var*
begin
//#UC START# *56BC642200D0_56556EF3017C_impl*
 Result := False;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *56BC642200D0_56556EF3017C_impl*
end;//TpgFreeIDHelper.RegisterFreeExtObjID

function TpgFreeIDHelper.RegisterFreeExtDocID(aFamilyID: TdaFamilyID;
 const aKey: AnsiString;
 anID: TdaDocID): Boolean;
//#UC START# *56BC6437030F_56556EF3017C_var*
//#UC END# *56BC6437030F_56556EF3017C_var*
begin
//#UC START# *56BC6437030F_56556EF3017C_impl*
 Result := False;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *56BC6437030F_56556EF3017C_impl*
end;//TpgFreeIDHelper.RegisterFreeExtDocID

procedure TpgFreeIDHelper.SetAlienJournalData(aSessionID: TdaSessionID);
//#UC START# *56EBDD7002F8_56556EF3017C_var*
//#UC END# *56EBDD7002F8_56556EF3017C_var*
begin
//#UC START# *56EBDD7002F8_56556EF3017C_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *56EBDD7002F8_56556EF3017C_impl*
end;//TpgFreeIDHelper.SetAlienJournalData

procedure TpgFreeIDHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56556EF3017C_var*
//#UC END# *479731C50290_56556EF3017C_var*
begin
//#UC START# *479731C50290_56556EF3017C_impl*
 f_GetFreeFunction := nil;
 FreeAndNil(f_Connection);
 f_IntervalQuery := nil;
 inherited;
//#UC END# *479731C50290_56556EF3017C_impl*
end;//TpgFreeIDHelper.Cleanup
{$IfEnd} // Defined(UsePostgres)

end.
