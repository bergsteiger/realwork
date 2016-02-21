unit caTabledQuery;

// Модуль: "w:\common\components\rtl\Garant\ComboAccess\caTabledQuery.pas"
// Стереотип: "SimpleClass"

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
   function MakeFromTable(const aTable: IdaTableDescription;
    const anAlias: AnsiString): IdaFromTable; override;
   procedure PrepareTable; override;
   procedure UnPrepareTable; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
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
 end;//TcaTabledQuery
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
 , daFromTable
;

constructor TcaTabledQuery.Create(const aDataConverter: IdaDataConverter;
 const aTable: IdaTableDescription;
 const anAlias: AnsiString;
 const aHTQuery: IdaTabledQuery;
 const aPGQuery: IdaTabledQuery);
//#UC START# *56C6DC070160_56C6DB730289_var*
//#UC END# *56C6DC070160_56C6DB730289_var*
begin
//#UC START# *56C6DC070160_56C6DB730289_impl*
 Assert(False, 'AddParam and Field broken');
//!! !!! Needs to be implemented !!!
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
end;//TcaTabledQuery.Make

function TcaTabledQuery.MakeFromTable(const aTable: IdaTableDescription;
 const anAlias: AnsiString): IdaFromTable;
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
// f_HTQuery.PrepareTable;
// f_PGQuery.PrepareTable;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *566A892A0191_56C6DB730289_impl*
end;//TcaTabledQuery.PrepareTable

procedure TcaTabledQuery.UnPrepareTable;
//#UC START# *566A893B03C7_56C6DB730289_var*
//#UC END# *566A893B03C7_56C6DB730289_var*
begin
//#UC START# *566A893B03C7_56C6DB730289_impl*
// f_HTQuery.UnPrepareTable;
// f_PGQuery.UnPrepareTable;
 Assert(False);
//!! !!! Needs to be implemented !!!
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
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.
