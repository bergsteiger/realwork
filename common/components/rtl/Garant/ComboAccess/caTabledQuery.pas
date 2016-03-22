unit caTabledQuery;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ComboAccess"
// Модуль: "w:/common/components/rtl/Garant/ComboAccess/caTabledQuery.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::ComboAccess::Provider::TcaTabledQuery
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\ComboAccess\caDefine.inc}

interface

{$If defined(TestComboAccess) AND defined(UsePostgres)}
uses
  daInterfaces,
  daTabledQuery
  ;
{$IfEnd} //TestComboAccess AND UsePostgres

{$If defined(TestComboAccess) AND defined(UsePostgres)}
type
 TcaTabledQuery = class(TdaTabledQuery)
 private
 // private fields
   f_PGQuery : IdaTabledQuery;
   f_HTQuery : IdaTabledQuery;
 protected
 // realized methods
   function MakeFromTable(const aTable: IdaTableDescription;
     const anAlias: AnsiString = ''): IdaFromTable; override;
   procedure PrepareTable; override;
     {* Сигнатура метода PrepareTable }
   procedure UnPrepareTable; override;
     {* Сигнатура метода UnPrepareTable }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function MakeResultSet(Unidirectional: Boolean): IdaResultSet; override;
   function DoMakeParam(const aParamDesc: IdaParamDescription): IdaParam; override;
 public
 // public methods
   constructor Create(const aDataConverter: IdaDataConverter;
     const aTable: IdaTableDescription;
     const anAlias: AnsiString;
     const aHTQuery: IdaTabledQuery;
     const aPGQuery: IdaTabledQuery); reintroduce;
   class function Make(const aDataConverter: IdaDataConverter;
     const aTable: IdaTableDescription;
     const anAlias: AnsiString;
     const aHTQuery: IdaTabledQuery;
     const aPGQuery: IdaTabledQuery): IdaTabledQuery; reintroduce;
     {* Сигнатура фабрики TcaTabledQuery.Make }
 end;//TcaTabledQuery
{$IfEnd} //TestComboAccess AND UsePostgres

implementation

{$If defined(TestComboAccess) AND defined(UsePostgres)}
uses
  daFromTable,
  caResultSet,
  caParam
  ;
{$IfEnd} //TestComboAccess AND UsePostgres

{$If defined(TestComboAccess) AND defined(UsePostgres)}

// start class TcaTabledQuery

constructor TcaTabledQuery.Create(const aDataConverter: IdaDataConverter;
  const aTable: IdaTableDescription;
  const anAlias: AnsiString;
  const aHTQuery: IdaTabledQuery;
  const aPGQuery: IdaTabledQuery);
//#UC START# *56C6DC070160_56C6DB730289_var*
//#UC END# *56C6DC070160_56C6DB730289_var*
begin
//#UC START# *56C6DC070160_56C6DB730289_impl*
 inherited Create(aDataConverter, aTable, anAlias);
 f_HTQuery := aHTQuery;
 f_PGQuery := aPGQuery;
//#UC END# *56C6DC070160_56C6DB730289_impl*
end;//TcaTabledQuery.Create

class function TcaTabledQuery.Make(const aDataConverter: IdaDataConverter;
  const aTable: IdaTableDescription;
  const anAlias: AnsiString;
  const aHTQuery: IdaTabledQuery;
  const aPGQuery: IdaTabledQuery): IdaTabledQuery;
var
 l_Inst : TcaTabledQuery;
begin
 l_Inst := Create(aDataConverter, aTable, anAlias, aHTQuery, aPGQuery);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TcaTabledQuery.MakeFromTable(const aTable: IdaTableDescription;
  const anAlias: AnsiString = ''): IdaFromTable;
//#UC START# *5600FFF80332_56C6DB730289_var*
//#UC END# *5600FFF80332_56C6DB730289_var*
begin
//#UC START# *5600FFF80332_56C6DB730289_impl*
 Result := TdaFromTable.Make(aTable, anAlias);
//#UC END# *5600FFF80332_56C6DB730289_impl*
end;//TcaTabledQuery.MakeFromTable

procedure TcaTabledQuery.PrepareTable;
//#UC START# *566A892A0191_56C6DB730289_var*
//#UC END# *566A892A0191_56C6DB730289_var*
begin
//#UC START# *566A892A0191_56C6DB730289_impl*
 f_HTQuery.Prepare;
 f_PGQuery.Prepare;
//#UC END# *566A892A0191_56C6DB730289_impl*
end;//TcaTabledQuery.PrepareTable

procedure TcaTabledQuery.UnPrepareTable;
//#UC START# *566A893B03C7_56C6DB730289_var*
//#UC END# *566A893B03C7_56C6DB730289_var*
begin
//#UC START# *566A893B03C7_56C6DB730289_impl*
 f_HTQuery.UnPrepare;
 f_PGQuery.UnPrepare;
//#UC END# *566A893B03C7_56C6DB730289_impl*
end;//TcaTabledQuery.UnPrepareTable

procedure TcaTabledQuery.Cleanup;
//#UC START# *479731C50290_56C6DB730289_var*
//#UC END# *479731C50290_56C6DB730289_var*
begin
//#UC START# *479731C50290_56C6DB730289_impl*
 f_HTQuery := nil;
 f_PGQuery := nil;
 inherited;
//#UC END# *479731C50290_56C6DB730289_impl*
end;//TcaTabledQuery.Cleanup

function TcaTabledQuery.MakeResultSet(Unidirectional: Boolean): IdaResultSet;
//#UC START# *56010A7801F2_56C6DB730289_var*
//#UC END# *56010A7801F2_56C6DB730289_var*
begin
//#UC START# *56010A7801F2_56C6DB730289_impl*
 Result := TcaResultSet.Make(SelectFields, f_HTQuery.OpenResultSet(Unidirectional), f_PGQuery.OpenResultSet(Unidirectional));
//#UC END# *56010A7801F2_56C6DB730289_impl*
end;//TcaTabledQuery.MakeResultSet

function TcaTabledQuery.DoMakeParam(const aParamDesc: IdaParamDescription): IdaParam;
//#UC START# *56E120F00095_56C6DB730289_var*
//#UC END# *56E120F00095_56C6DB730289_var*
begin
//#UC START# *56E120F00095_56C6DB730289_impl*
 Result := TcaParam.Make((f_HTQuery as IdaComboAccessQueryHelper).AddParam(aParamDesc), (f_PGQuery as IdaComboAccessQueryHelper).AddParam(aParamDesc));
//#UC END# *56E120F00095_56C6DB730289_impl*
end;//TcaTabledQuery.DoMakeParam

{$IfEnd} //TestComboAccess AND UsePostgres

end.