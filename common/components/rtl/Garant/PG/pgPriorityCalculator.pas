unit pgPriorityCalculator;

// Модуль: "w:\common\components\rtl\Garant\PG\pgPriorityCalculator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgPriorityCalculator" MUID: (5751377C006E)

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
;

type
 TpgPriorityCalculator = class(Tl3ProtoObject, IdaPriorityCalculator)
  private
   f_PriorityQuery: IdaTabledQuery;
  private
   function PriorityQuery: IdaTabledQuery;
  protected
   function Calc(aUserId: TdaUserID;
    out aImportPriority: TdaPriority;
    out aExportPriority: TdaPriority): Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   class function Make: IdaPriorityCalculator; reintroduce;
 end;//TpgPriorityCalculator
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
;

constructor TpgPriorityCalculator.Create;
//#UC START# *575137CF01E2_5751377C006E_var*
//#UC END# *575137CF01E2_5751377C006E_var*
begin
//#UC START# *575137CF01E2_5751377C006E_impl*
 inherited Create;
//#UC END# *575137CF01E2_5751377C006E_impl*
end;//TpgPriorityCalculator.Create

class function TpgPriorityCalculator.Make: IdaPriorityCalculator;
var
 l_Inst : TpgPriorityCalculator;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TpgPriorityCalculator.Make

function TpgPriorityCalculator.PriorityQuery: IdaTabledQuery;
//#UC START# *57513C4C02C0_5751377C006E_var*
//#UC END# *57513C4C02C0_5751377C006E_var*
begin
//#UC START# *57513C4C02C0_5751377C006E_impl*
 Result := nil;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *57513C4C02C0_5751377C006E_impl*
end;//TpgPriorityCalculator.PriorityQuery

function TpgPriorityCalculator.Calc(aUserId: TdaUserID;
 out aImportPriority: TdaPriority;
 out aExportPriority: TdaPriority): Boolean;
//#UC START# *575000000164_5751377C006E_var*
var
 l_ResultSet: IdaResultSet;
//#UC END# *575000000164_5751377C006E_var*
begin
//#UC START# *575000000164_5751377C006E_impl*
 PriorityQuery.Param['p_userID'].AsLargeInt := aUserID;
 l_ResultSet := PriorityQuery.OpenResultSet;
 try
  Result := not l_ResultSet.IsEmpty;
  if Result then
  begin
   aImportPriority := TdaPriority(l_ResultSet.Field['import_priority'].AsInteger);
   aExportPriority := TdaPriority(l_ResultSet.Field['export_priority'].AsInteger);
  end;
 finally
  l_ResultSet := nil;
 end;
//#UC END# *575000000164_5751377C006E_impl*
end;//TpgPriorityCalculator.Calc

procedure TpgPriorityCalculator.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5751377C006E_var*
//#UC END# *479731C50290_5751377C006E_var*
begin
//#UC START# *479731C50290_5751377C006E_impl*
 f_PriorityQuery := nil;
 inherited;
//#UC END# *479731C50290_5751377C006E_impl*
end;//TpgPriorityCalculator.Cleanup
{$IfEnd} // Defined(UsePostgres)

end.
