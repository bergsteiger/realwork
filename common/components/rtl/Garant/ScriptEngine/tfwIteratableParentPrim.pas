unit tfwIteratableParentPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwIteratableParentPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwIteratableParentPrim" MUID: (57C81527030E)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoObject
 , tfwScriptingInterfaces
;

type
 TtfwIteratableParentPrim = class(Tl3ProtoObject)
  protected
   function GetCount: Integer; virtual;
   function GetItem(anIndex: Integer): TtfwStackValue; virtual;
   function GetSafeView: ItfwValueList; virtual;
   function GetIsView: Boolean; virtual;
   function DoAdd(const anItem: TtfwStackValue): Integer; virtual;
 end;//TtfwIteratableParentPrim
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwSafeArrayView
 //#UC START# *57C81527030Eimpl_uses*
 //#UC END# *57C81527030Eimpl_uses*
;

function TtfwIteratableParentPrim.GetCount: Integer;
//#UC START# *57C811A30375_57C81527030E_var*
//#UC END# *57C811A30375_57C81527030E_var*
begin
//#UC START# *57C811A30375_57C81527030E_impl*
 EtfwNotImplemented.Fail;
 Result := 0;
//#UC END# *57C811A30375_57C81527030E_impl*
end;//TtfwIteratableParentPrim.GetCount

function TtfwIteratableParentPrim.GetItem(anIndex: Integer): TtfwStackValue;
//#UC START# *57C8146602DB_57C81527030E_var*
//#UC END# *57C8146602DB_57C81527030E_var*
begin
//#UC START# *57C8146602DB_57C81527030E_impl*
 EtfwNotImplemented.Fail;
 Result := TtfwStackValue_E;
//#UC END# *57C8146602DB_57C81527030E_impl*
end;//TtfwIteratableParentPrim.GetItem

function TtfwIteratableParentPrim.GetSafeView: ItfwValueList;
//#UC START# *57C821A402BB_57C81527030E_var*
//#UC END# *57C821A402BB_57C81527030E_var*
begin
//#UC START# *57C821A402BB_57C81527030E_impl*
 Result := TtfwSafeArrayView.Make(Self As ItfwValueList);
//#UC END# *57C821A402BB_57C81527030E_impl*
end;//TtfwIteratableParentPrim.GetSafeView

function TtfwIteratableParentPrim.GetIsView: Boolean;
//#UC START# *57C9E8AC03C6_57C81527030E_var*
//#UC END# *57C9E8AC03C6_57C81527030E_var*
begin
//#UC START# *57C9E8AC03C6_57C81527030E_impl*
 Result := true;
//#UC END# *57C9E8AC03C6_57C81527030E_impl*
end;//TtfwIteratableParentPrim.GetIsView

function TtfwIteratableParentPrim.DoAdd(const anItem: TtfwStackValue): Integer;
//#UC START# *57E2B4C50080_57C81527030E_var*
//#UC END# *57E2B4C50080_57C81527030E_var*
begin
//#UC START# *57E2B4C50080_57C81527030E_impl*
 EtfwConstantArray.Fail('Не реализовано');
 Result := -1;
//#UC END# *57E2B4C50080_57C81527030E_impl*
end;//TtfwIteratableParentPrim.DoAdd
{$IfEnd} // NOT Defined(NoScripts)

end.
