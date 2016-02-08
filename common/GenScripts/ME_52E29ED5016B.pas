unit tfwIteratableParent;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwIteratableParent.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3PureMixIns
 , tfwScriptingInterfaces
;

type
 _ItemType_ = TtfwStackValue;
 TtfwIteratableParent = {abstract} class(Tl3ProtoObject)
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
 end;//TtfwIteratableParent
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

function TtfwIteratableParent.pm_GetFirst: _ItemType_;
//#UC START# *47D8233603DD_52E29ED5016Bget_var*
//#UC END# *47D8233603DD_52E29ED5016Bget_var*
begin
//#UC START# *47D8233603DD_52E29ED5016Bget_impl*
 Result := TtfwStackValue_E;
 Assert(false, 'Не реализовано');
//#UC END# *47D8233603DD_52E29ED5016Bget_impl*
end;//TtfwIteratableParent.pm_GetFirst

function TtfwIteratableParent.pm_GetLast: _ItemType_;
//#UC START# *47D823570315_52E29ED5016Bget_var*
//#UC END# *47D823570315_52E29ED5016Bget_var*
begin
//#UC START# *47D823570315_52E29ED5016Bget_impl*
 Result := TtfwStackValue_E;
 Assert(false, 'Не реализовано');
//#UC END# *47D823570315_52E29ED5016Bget_impl*
end;//TtfwIteratableParent.pm_GetLast

function TtfwIteratableParent.pm_GetItems(anIndex: Integer): _ItemType_;
//#UC START# *47D8248802AD_52E29ED5016Bget_var*
//#UC END# *47D8248802AD_52E29ED5016Bget_var*
begin
//#UC START# *47D8248802AD_52E29ED5016Bget_impl*
 Result := TtfwStackValue_E;
 Assert(false, 'Не реализовано');
//#UC END# *47D8248802AD_52E29ED5016Bget_impl*
end;//TtfwIteratableParent.pm_GetItems

function TtfwIteratableParent.pm_GetEmpty: Boolean;
//#UC START# *47E381E203D2_52E29ED5016Bget_var*
//#UC END# *47E381E203D2_52E29ED5016Bget_var*
begin
//#UC START# *47E381E203D2_52E29ED5016Bget_impl*
 Result := false;
 Assert(false, 'Не реализовано');
//#UC END# *47E381E203D2_52E29ED5016Bget_impl*
end;//TtfwIteratableParent.pm_GetEmpty

function TtfwIteratableParent.IndexOf(const anItem: _ItemType_): Integer;
//#UC START# *482955910076_52E29ED5016B_var*
//#UC END# *482955910076_52E29ED5016B_var*
begin
//#UC START# *482955910076_52E29ED5016B_impl*
 Result := -1;
 Assert(false, 'Не реализовано');
//#UC END# *482955910076_52E29ED5016B_impl*
end;//TtfwIteratableParent.IndexOf

function TtfwIteratableParent.Add(const anItem: _ItemType_): Integer;
//#UC START# *482958A203D0_52E29ED5016B_var*
//#UC END# *482958A203D0_52E29ED5016B_var*
begin
//#UC START# *482958A203D0_52E29ED5016B_impl*
 Result := -1;
 Assert(false, 'Не реализовано');
//#UC END# *482958A203D0_52E29ED5016B_impl*
end;//TtfwIteratableParent.Add

function TtfwIteratableParent.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_52E29ED5016Bget_var*
//#UC END# *4BB08B8902F2_52E29ED5016Bget_var*
begin
//#UC START# *4BB08B8902F2_52E29ED5016Bget_impl*
 Result := 0;
 Assert(false, 'Не реализовано');
//#UC END# *4BB08B8902F2_52E29ED5016Bget_impl*
end;//TtfwIteratableParent.pm_GetCount

procedure TtfwIteratableParent.Clear;
//#UC START# *4F62FF5D0327_52E29ED5016B_var*
//#UC END# *4F62FF5D0327_52E29ED5016B_var*
begin
//#UC START# *4F62FF5D0327_52E29ED5016B_impl*
 Assert(false, 'Не реализовано');
//#UC END# *4F62FF5D0327_52E29ED5016B_impl*
end;//TtfwIteratableParent.Clear

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
