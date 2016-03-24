unit tfwHash16Table;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwHash16Table.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwHash16Table" MUID: (56F3E80A018E)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwIteratableParent
 , tfwScriptingInterfaces
;

type
 TtfwHash16Table = class(TtfwIteratableParent, ItfwValueList)
  protected
   procedure SetItem(anIndex: Integer;
    const aValue: TtfwStackValue);
   function ItemsCountInSlice: Integer;
  public
   constructor Create; reintroduce;
   class function Make: ItfwValueList; reintroduce;
   procedure ForEach(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
   procedure ForEachBack(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
 end;//TtfwHash16Table
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , m2HasLib
;

constructor TtfwHash16Table.Create;
//#UC START# *56F3E8BE02A5_56F3E80A018E_var*
//#UC END# *56F3E8BE02A5_56F3E80A018E_var*
begin
//#UC START# *56F3E8BE02A5_56F3E80A018E_impl*
 inherited;
//#UC END# *56F3E8BE02A5_56F3E80A018E_impl*
end;//TtfwHash16Table.Create

class function TtfwHash16Table.Make: ItfwValueList;
var
 l_Inst : TtfwHash16Table;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwHash16Table.Make

procedure TtfwHash16Table.ForEach(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23B7A00EC_56F3E80A018E_var*
var
 l_T : Pm2HASTable16;
 l_Index : Integer;
//#UC END# *52E23B7A00EC_56F3E80A018E_var*
begin
//#UC START# *52E23B7A00EC_56F3E80A018E_impl*
 l_T := m2Hash16Table;
 for l_Index := Low(Tm2HASTable16) to High(Tm2HASTable16) do
 begin
  aCtx.rEngine.PushInt(l_T^[l_Index]);
  aLambda.DoIt(aCtx);
 end;//for l_Index
//#UC END# *52E23B7A00EC_56F3E80A018E_impl*
end;//TtfwHash16Table.ForEach

procedure TtfwHash16Table.ForEachBack(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23BB102FA_56F3E80A018E_var*
var
 l_T : Pm2HASTable16;
 l_Index : Integer;
//#UC END# *52E23BB102FA_56F3E80A018E_var*
begin
//#UC START# *52E23BB102FA_56F3E80A018E_impl*
 l_T := m2Hash16Table;
 for l_Index := High(Tm2HASTable16) downto Low(Tm2HASTable16) do
 begin
  aCtx.rEngine.PushInt(l_T^[l_Index]);
  aLambda.DoIt(aCtx);
 end;//for l_Index
//#UC END# *52E23BB102FA_56F3E80A018E_impl*
end;//TtfwHash16Table.ForEachBack

procedure TtfwHash16Table.SetItem(anIndex: Integer;
 const aValue: TtfwStackValue);
//#UC START# *55CDF40C03D4_56F3E80A018E_var*
//#UC END# *55CDF40C03D4_56F3E80A018E_var*
begin
//#UC START# *55CDF40C03D4_56F3E80A018E_impl*
 EtfwCheck.Fail('Массив неизменяемый');
//#UC END# *55CDF40C03D4_56F3E80A018E_impl*
end;//TtfwHash16Table.SetItem

function TtfwHash16Table.ItemsCountInSlice: Integer;
//#UC START# *55E849210175_56F3E80A018E_var*
//#UC END# *55E849210175_56F3E80A018E_var*
begin
//#UC START# *55E849210175_56F3E80A018E_impl*
 Result := 1;
//#UC END# *55E849210175_56F3E80A018E_impl*
end;//TtfwHash16Table.ItemsCountInSlice
{$IfEnd} // NOT Defined(NoScripts)

end.
