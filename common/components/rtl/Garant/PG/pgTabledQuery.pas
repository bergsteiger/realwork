unit pgTabledQuery;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "PG"
// Модуль: "w:/common/components/rtl/Garant/PG/pgTabledQuery.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::PG::Provider::TpgTabledQuery
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\PG\pgDefine.inc}

interface

{$If defined(UsePostgres)}
uses
  daInterfaces,
  pgInterfaces,
  pgConnection,
  daTabledQuery,
  daParamList
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}
type
 TpgTabledQuery = class(TdaTabledQuery)
 private
 // private fields
   f_Connection : TpgConnection;
   f_QueryName : AnsiString;
 private
 // private methods
   function BuildSQL: AnsiString;
   function BuildSelectClause: AnsiString;
   function BuildFromClause: AnsiString;
   function BuildWhereClause: AnsiString;
 protected
 // realized methods
   function MakeFromTable(const aTable: IdaTableDescription;
     const anAlias: AnsiString = ''): IdaFromTable; override;
   function MakeResultSet(Unidirectional: Boolean): IdaResultSet; override;
   procedure PrepareTables; override;
     {* Сигнатура метода PrepareTables }
   procedure UnprepareTables; override;
     {* Сигнатура метода UnprepareTables }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function MakeParamList: TdaParamList; override;
 public
 // public methods
   constructor Create(const aDataConverter: IpgDataConverter;
     const aTable: IdaTableDescription;
     aConnection: TpgConnection;
     const anAlias: AnsiString = ''); reintroduce;
   class function Make(const aDataConverter: IpgDataConverter;
     const aTable: IdaTableDescription;
     aConnection: TpgConnection;
     const anAlias: AnsiString = ''): IdaQuery; reintroduce;
     {* Сигнатура фабрики TpgTabledQuery.Make }
 end;//TpgTabledQuery
{$IfEnd} //UsePostgres

implementation

{$If defined(UsePostgres)}
uses
  pgFromTable,
  SysUtils,
  LibPQ,
  pgUtils,
  pgParamList,
  pgResultSet
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}

// start class TpgTabledQuery

function TpgTabledQuery.BuildSQL: AnsiString;
//#UC START# *560506760367_55F960D502F6_var*
//#UC END# *560506760367_55F960D502F6_var*
begin
//#UC START# *560506760367_55F960D502F6_impl*
 Result := Format('%s'#13#10+'  %s'#13#10+' %s', [BuildSelectClause, BuildFromClause, BuildWhereClause]);
//#UC END# *560506760367_55F960D502F6_impl*
end;//TpgTabledQuery.BuildSQL

function TpgTabledQuery.BuildSelectClause: AnsiString;
//#UC START# *56050F3E0081_55F960D502F6_var*
var
 l_IDX: Integer;
 l_Count: Integer;
//#UC END# *56050F3E0081_55F960D502F6_var*
begin
//#UC START# *56050F3E0081_55F960D502F6_impl*
 Assert(SelectFields.Count > 0);
 Result := 'select ';
 for l_IDX := 0 to SelectFields.Count - 1 do
 begin
  if l_IDX > 0 then
   Result := Result + ', '#13#10+'       ';
  Result := Result + SelectFields[l_IDX].BuildSQLValue;
 end;
//#UC END# *56050F3E0081_55F960D502F6_impl*
end;//TpgTabledQuery.BuildSelectClause

function TpgTabledQuery.BuildFromClause: AnsiString;
//#UC START# *56050F450363_55F960D502F6_var*
var
 l_IDX: Integer;
//#UC END# *56050F450363_55F960D502F6_var*
begin
//#UC START# *56050F450363_55F960D502F6_impl*
 if Tables.Count > 0 then
 begin
  Result := '  from ';
  for l_IDX := 0 to Tables.Count - 1 do
  begin
   if l_IDX > 0 then
    Result := Result + ', '#13#10+'       ';
   Result := Result + Tables[l_IDX].BuildSQLValue;
  end;
 end
 else
  Result := '';
//#UC END# *56050F450363_55F960D502F6_impl*
end;//TpgTabledQuery.BuildFromClause

function TpgTabledQuery.BuildWhereClause: AnsiString;
//#UC START# *56050F510228_55F960D502F6_var*
var
 l_IDX: Integer;
//#UC END# *56050F510228_55F960D502F6_var*
begin
//#UC START# *56050F510228_55F960D502F6_impl*
 if WhereCondition <> nil then
  Result := '  where ' + WhereCondition.BuildSQLValue(Params)
 else
  Result := '';
//#UC END# *56050F510228_55F960D502F6_impl*
end;//TpgTabledQuery.BuildWhereClause

constructor TpgTabledQuery.Create(const aDataConverter: IpgDataConverter;
  const aTable: IdaTableDescription;
  aConnection: TpgConnection;
  const anAlias: AnsiString = '');
//#UC START# *55F9617402F2_55F960D502F6_var*
//#UC END# *55F9617402F2_55F960D502F6_var*
begin
//#UC START# *55F9617402F2_55F960D502F6_impl*
 inherited Create(aDataConverter, aTable, anAlias);
 aConnection.SetRefTo(f_Connection);
//#UC END# *55F9617402F2_55F960D502F6_impl*
end;//TpgTabledQuery.Create

class function TpgTabledQuery.Make(const aDataConverter: IpgDataConverter;
  const aTable: IdaTableDescription;
  aConnection: TpgConnection;
  const anAlias: AnsiString = ''): IdaQuery;
var
 l_Inst : TpgTabledQuery;
begin
 l_Inst := Create(aDataConverter, aTable, aConnection, anAlias);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TpgTabledQuery.MakeFromTable(const aTable: IdaTableDescription;
  const anAlias: AnsiString = ''): IdaFromTable;
//#UC START# *5600FFF80332_55F960D502F6_var*
//#UC END# *5600FFF80332_55F960D502F6_var*
begin
//#UC START# *5600FFF80332_55F960D502F6_impl*
 Result := TpgFromTable.Make(aTable, anAlias);
//#UC END# *5600FFF80332_55F960D502F6_impl*
end;//TpgTabledQuery.MakeFromTable

function TpgTabledQuery.MakeResultSet(Unidirectional: Boolean): IdaResultSet;
//#UC START# *56010A7801F2_55F960D502F6_var*
//#UC END# *56010A7801F2_55F960D502F6_var*
begin
//#UC START# *56010A7801F2_55F960D502F6_impl*
 Result := TpgResultSet.Make(f_Connection, DataConverter as IpgDataConverter, f_QueryName, Params, SelectFields, Unidirectional);
//#UC END# *56010A7801F2_55F960D502F6_impl*
end;//TpgTabledQuery.MakeResultSet

procedure TpgTabledQuery.PrepareTables;
//#UC START# *56010AB70258_55F960D502F6_var*
var
 l_Result: PPGResult;
//#UC END# *56010AB70258_55F960D502F6_var*
begin
//#UC START# *56010AB70258_55F960D502F6_impl*
 f_QueryName := Format('Qry%p', [Pointer(Self)]);
 l_Result := PQprepare(f_Connection.Handle, PAnsiChar(f_QueryName),  PAnsiChar(BuildSQL), Params.Count, nil);
 try
  pgCheckStatus(l_Result);
 finally
  PQclear(l_Result);
 end;
// !!! Needs to be implemented !!!
//#UC END# *56010AB70258_55F960D502F6_impl*
end;//TpgTabledQuery.PrepareTables

procedure TpgTabledQuery.UnprepareTables;
//#UC START# *56010ACB00F0_55F960D502F6_var*
var
 l_Result: PPGResult;
//#UC END# *56010ACB00F0_55F960D502F6_var*
begin
//#UC START# *56010ACB00F0_55F960D502F6_impl*
 l_Result := PQExec(f_Connection.Handle, PAnsiChar(Format('DEALLOCATE PREPARED %s', [f_QueryName])));
 try
  f_QueryName := '';
  pgCheckStatus(l_Result);
 finally
  PQClear(l_Result);
 end;
//#UC END# *56010ACB00F0_55F960D502F6_impl*
end;//TpgTabledQuery.UnprepareTables

procedure TpgTabledQuery.Cleanup;
//#UC START# *479731C50290_55F960D502F6_var*
//#UC END# *479731C50290_55F960D502F6_var*
begin
//#UC START# *479731C50290_55F960D502F6_impl*
 FreeAndNil(f_Connection);
 inherited;
//#UC END# *479731C50290_55F960D502F6_impl*
end;//TpgTabledQuery.Cleanup

function TpgTabledQuery.MakeParamList: TdaParamList;
//#UC START# *560B861302E9_55F960D502F6_var*
//#UC END# *560B861302E9_55F960D502F6_var*
begin
//#UC START# *560B861302E9_55F960D502F6_impl*
 Result := TpgParamList.Make;
//#UC END# *560B861302E9_55F960D502F6_impl*
end;//TpgTabledQuery.MakeParamList

{$IfEnd} //UsePostgres

end.