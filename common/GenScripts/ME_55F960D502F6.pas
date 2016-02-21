unit pgTabledQuery;

// Модуль: "w:\common\components\rtl\Garant\PG\pgTabledQuery.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , daTabledQuery
 , pgConnection
 , pgInterfaces
 , daInterfaces
 , daParamList
;

type
 TpgTabledQuery = class(TdaTabledQuery)
  private
   f_Connection: TpgConnection;
   f_QueryName: AnsiString;
  private
   function BuildSQL: AnsiString;
  protected
   function MakeFromTable(const aTable: IdaTableDescription;
    const anAlias: AnsiString): IdaFromTable; override;
   procedure PrepareTable; override;
   procedure UnPrepareTable; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function MakeResultSet(Unidirectional: Boolean): IdaResultSet; override;
   function MakeParamList: TdaParamList; override;
  public
   constructor Create(const aDataConverter: IpgDataConverter;
    const aTable: IdaTableDescription;
    aConnection: TpgConnection;
    const anAlias: AnsiString = ''); reintroduce;
   class function Make(const aDataConverter: IpgDataConverter;
    const aTable: IdaTableDescription;
    aConnection: TpgConnection;
    const anAlias: AnsiString = ''): IdaTabledQuery; reintroduce;
 end;//TpgTabledQuery
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , SysUtils
 , LibPQ
 , pgUtils
 , pgParamList
 , pgResultSet
 , daFromTable
;

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
 const anAlias: AnsiString = ''): IdaTabledQuery;
var
 l_Inst : TpgTabledQuery;
begin
 l_Inst := Create(aDataConverter, aTable, aConnection, anAlias);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TpgTabledQuery.Make

function TpgTabledQuery.BuildSQL: AnsiString;
//#UC START# *560506760367_55F960D502F6_var*
//#UC END# *560506760367_55F960D502F6_var*
begin
//#UC START# *560506760367_55F960D502F6_impl*
 Result := Format('%s'#13#10+'  %s'#13#10+' %s', [BuildSelectClause, BuildFromClause, BuildWhereClause]);
//#UC END# *560506760367_55F960D502F6_impl*
end;//TpgTabledQuery.BuildSQL

function TpgTabledQuery.MakeFromTable(const aTable: IdaTableDescription;
 const anAlias: AnsiString): IdaFromTable;
//#UC START# *5600FFF80332_55F960D502F6_var*
//#UC END# *5600FFF80332_55F960D502F6_var*
begin
//#UC START# *5600FFF80332_55F960D502F6_impl*
 Result := TpgFromTable.Make(aTable, anAlias);
//#UC END# *5600FFF80332_55F960D502F6_impl*
end;//TpgTabledQuery.MakeFromTable

procedure TpgTabledQuery.PrepareTable;
//#UC START# *566A892A0191_55F960D502F6_var*
var
 l_Result: PPGResult;
//#UC END# *566A892A0191_55F960D502F6_var*
begin
//#UC START# *566A892A0191_55F960D502F6_impl*
 f_QueryName := Format('Qry%p', [Pointer(Self)]);
 l_Result := PQprepare(f_Connection.Handle, PAnsiChar(f_QueryName),  PAnsiChar(BuildSQL), Params.Count, nil);
 try
  pgCheckStatus(l_Result);
 finally
  PQclear(l_Result);
 end;
//#UC END# *566A892A0191_55F960D502F6_impl*
end;//TpgTabledQuery.PrepareTable

procedure TpgTabledQuery.UnPrepareTable;
//#UC START# *566A893B03C7_55F960D502F6_var*
var
 l_Result: PPGResult;
//#UC END# *566A893B03C7_55F960D502F6_var*
begin
//#UC START# *566A893B03C7_55F960D502F6_impl*
 f_QueryName := '';
 exit;
 l_Result := PQExec(f_Connection.Handle, PAnsiChar(Format('DEALLOCATE %s', [f_QueryName])));
 try
  pgCheckStatus(l_Result);
  f_QueryName := '';
 finally
  PQClear(l_Result);
 end;
//#UC END# *566A893B03C7_55F960D502F6_impl*
end;//TpgTabledQuery.UnPrepareTable

procedure TpgTabledQuery.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55F960D502F6_var*
//#UC END# *479731C50290_55F960D502F6_var*
begin
//#UC START# *479731C50290_55F960D502F6_impl*
 FreeAndNil(f_Connection);
 inherited;
//#UC END# *479731C50290_55F960D502F6_impl*
end;//TpgTabledQuery.Cleanup

function TpgTabledQuery.MakeResultSet(Unidirectional: Boolean): IdaResultSet;
//#UC START# *56010A7801F2_55F960D502F6_var*
//#UC END# *56010A7801F2_55F960D502F6_var*
begin
//#UC START# *56010A7801F2_55F960D502F6_impl*
 Result := TpgResultSet.Make(f_Connection, DataConverter as IpgDataConverter, f_QueryName, Params, SelectFields, Unidirectional);
//#UC END# *56010A7801F2_55F960D502F6_impl*
end;//TpgTabledQuery.MakeResultSet

function TpgTabledQuery.MakeParamList: TdaParamList;
//#UC START# *560B861302E9_55F960D502F6_var*
//#UC END# *560B861302E9_55F960D502F6_var*
begin
//#UC START# *560B861302E9_55F960D502F6_impl*
 Result := TpgParamList.Make;
//#UC END# *560B861302E9_55F960D502F6_impl*
end;//TpgTabledQuery.MakeParamList
{$IfEnd} // Defined(UsePostgres)

end.
