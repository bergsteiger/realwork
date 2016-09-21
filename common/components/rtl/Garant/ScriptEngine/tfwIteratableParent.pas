unit tfwIteratableParent;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwIteratableParent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwIteratableParent" MUID: (52E29ED5016B)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwIteratableParentPrim
 , l3PureMixIns
 , tfwScriptingInterfaces
;

type
 _ItemType_ = TtfwStackValue;
 TtfwIteratableParent = {abstract} class(TtfwIteratableParentPrim)
  protected
   function pm_GetFirst: _ItemType_;
   function pm_GetLast: _ItemType_;
   function pm_GetItems(anIndex: Integer): _ItemType_;
   function pm_GetEmpty: Boolean;
   function pm_GetCount: Integer;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   function IndexOf(const anItem: _ItemType_): Integer;
   function Add(const anItem: _ItemType_): Integer;
   procedure Clear;
   function IsView: Boolean;
   function SafeView: ItfwValueList;
 end;//TtfwIteratableParent
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwSafeArrayView
 //#UC START# *52E29ED5016Bimpl_uses*
 //#UC END# *52E29ED5016Bimpl_uses*
;

function TtfwIteratableParent.pm_GetFirst: _ItemType_;
//#UC START# *47D8233603DD_52E29ED5016Bget_var*
//#UC END# *47D8233603DD_52E29ED5016Bget_var*
begin
//#UC START# *47D8233603DD_52E29ED5016Bget_impl*
 Result := GetItem(0);
//#UC END# *47D8233603DD_52E29ED5016Bget_impl*
end;//TtfwIteratableParent.pm_GetFirst

function TtfwIteratableParent.pm_GetLast: _ItemType_;
//#UC START# *47D823570315_52E29ED5016Bget_var*
//#UC END# *47D823570315_52E29ED5016Bget_var*
begin
//#UC START# *47D823570315_52E29ED5016Bget_impl*
 Result := GetItem(GetCount - 1);
//#UC END# *47D823570315_52E29ED5016Bget_impl*
end;//TtfwIteratableParent.pm_GetLast

function TtfwIteratableParent.pm_GetItems(anIndex: Integer): _ItemType_;
//#UC START# *47D8248802AD_52E29ED5016Bget_var*
//#UC END# *47D8248802AD_52E29ED5016Bget_var*
begin
//#UC START# *47D8248802AD_52E29ED5016Bget_impl*
 Result := GetItem(anIndex);
//#UC END# *47D8248802AD_52E29ED5016Bget_impl*
end;//TtfwIteratableParent.pm_GetItems

function TtfwIteratableParent.pm_GetEmpty: Boolean;
//#UC START# *47E381E203D2_52E29ED5016Bget_var*
//#UC END# *47E381E203D2_52E29ED5016Bget_var*
begin
//#UC START# *47E381E203D2_52E29ED5016Bget_impl*
 Result := (GetCount = 0);
//#UC END# *47E381E203D2_52E29ED5016Bget_impl*
end;//TtfwIteratableParent.pm_GetEmpty

function TtfwIteratableParent.IndexOf(const anItem: _ItemType_): Integer;
//#UC START# *482955910076_52E29ED5016B_var*
//#UC END# *482955910076_52E29ED5016B_var*
begin
//#UC START# *482955910076_52E29ED5016B_impl*
 EtfwNotImplemented.Fail;
 Result := -1;
//#UC END# *482955910076_52E29ED5016B_impl*
end;//TtfwIteratableParent.IndexOf

function TtfwIteratableParent.Add(const anItem: _ItemType_): Integer;
//#UC START# *482958A203D0_52E29ED5016B_var*
//#UC END# *482958A203D0_52E29ED5016B_var*
begin
//#UC START# *482958A203D0_52E29ED5016B_impl*
 Result := DoAdd(anItem);
//#UC END# *482958A203D0_52E29ED5016B_impl*
end;//TtfwIteratableParent.Add

function TtfwIteratableParent.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_52E29ED5016Bget_var*
//#UC END# *4BB08B8902F2_52E29ED5016Bget_var*
begin
//#UC START# *4BB08B8902F2_52E29ED5016Bget_impl*
 Result := GetCount;
//#UC END# *4BB08B8902F2_52E29ED5016Bget_impl*
end;//TtfwIteratableParent.pm_GetCount

procedure TtfwIteratableParent.Clear;
//#UC START# *4F62FF5D0327_52E29ED5016B_var*
//#UC END# *4F62FF5D0327_52E29ED5016B_var*
begin
//#UC START# *4F62FF5D0327_52E29ED5016B_impl*
 EtfwConstantArray.Fail('Не реализовано');
//#UC END# *4F62FF5D0327_52E29ED5016B_impl*
end;//TtfwIteratableParent.Clear

function TtfwIteratableParent.IsView: Boolean;
//#UC START# *57B549300098_52E29ED5016B_var*
//#UC END# *57B549300098_52E29ED5016B_var*
begin
//#UC START# *57B549300098_52E29ED5016B_impl*
 Result := GetIsView;
//#UC END# *57B549300098_52E29ED5016B_impl*
end;//TtfwIteratableParent.IsView

function TtfwIteratableParent.SafeView: ItfwValueList;
//#UC START# *57C8213A0118_52E29ED5016B_var*
//#UC END# *57C8213A0118_52E29ED5016B_var*
begin
//#UC START# *57C8213A0118_52E29ED5016B_impl*
 Result := GetSafeView;
//#UC END# *57C8213A0118_52E29ED5016B_impl*
end;//TtfwIteratableParent.SafeView

{$If NOT Defined(DesignTimeLibrary)}
class function TtfwIteratableParent.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_52E29ED5016B_var*
//#UC END# *47A6FEE600FC_52E29ED5016B_var*
begin
//#UC START# *47A6FEE600FC_52E29ED5016B_impl*
 Result := true;
//#UC END# *47A6FEE600FC_52E29ED5016B_impl*
end;//TtfwIteratableParent.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$IfEnd} // NOT Defined(NoScripts)
end.
