unit caTabledQuery;

// Модуль: "w:\common\components\rtl\Garant\ComboAccess\caTabledQuery.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcaTabledQuery" MUID: (56C6DB730289)

{$Include w:\common\components\rtl\Garant\ComboAccess\caDefine.inc}

interface

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3IntfUses
 , daTabledQuery
 , daInterfaces
;

type
 TcaTabledQuery = class(TdaTabledQuery)
  private
   f_PGQuery: IdaTabledQuery;
   f_HTQuery: IdaTabledQuery;
  protected
   function MakeFromClause(const aTable: IdaTableDescription;
    const anAlias: AnsiString = ''): IdaFromClause; override;
   procedure PrepareTable; override;
   procedure UnPrepareTable; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function MakeResultSet(Unidirectional: Boolean): IdaResultSet; override;
   function DoMakeParam(const aParamDesc: IdaParamDescription): IdaParam; override;
  public
   constructor Create(const aFactory: IdaTableQueryFactory;
    const aDataConverter: IdaDataConverter;
    const aTable: IdaTableDescription;
    const anAlias: AnsiString;
    const aHTQuery: IdaTabledQuery;
    const aPGQuery: IdaTabledQuery); reintroduce;
   class function Make(const aFactory: IdaTableQueryFactory;
    const aDataConverter: IdaDataConverter;
    const aTable: IdaTableDescription;
    const anAlias: AnsiString;
    const aHTQuery: IdaTabledQuery;
    const aPGQuery: IdaTabledQuery): IdaTabledQuery; reintroduce;
 end;//TcaTabledQuery
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
 , daFromTable
 , caResultSet
 , caParam
;

constructor TcaTabledQuery.Create(const aFactory: IdaTableQueryFactory;
 const aDataConverter: IdaDataConverter;
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

class function TcaTabledQuery.Make(const aFactory: IdaTableQueryFactory;
 const aDataConverter: IdaDataConverter;
 const aTable: IdaTableDescription;
 const anAlias: AnsiString;
 const aHTQuery: IdaTabledQuery;
 const aPGQuery: IdaTabledQuery): IdaTabledQuery;
var
 l_Inst : TcaTabledQuery;
begin
 l_Inst := Create(aFactory, aDataConverter, aTable, anAlias, aHTQuery, aPGQuery);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TcaTabledQuery.Make

function TcaTabledQuery.MakeFromClause(const aTable: IdaTableDescription;
 const anAlias: AnsiString = ''): IdaFromClause;
//#UC START# *5600FFF80332_56C6DB730289_var*
//#UC END# *5600FFF80332_56C6DB730289_var*
begin
//#UC START# *5600FFF80332_56C6DB730289_impl*
 Result := TdaFromTable.Make(aTable, anAlias);
//#UC END# *5600FFF80332_56C6DB730289_impl*
end;//TcaTabledQuery.MakeFromClause

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
 {* Функция очистки полей объекта. }
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
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.
