unit k2TagListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2TagListPrim.pas"
// Начат: 08.02.2008 17:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2TagListPrim
//
// Список тегов.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2ListTag,
  l3Variant,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

 {$Define l3Items_HasCustomSort}

 {$Define l3Items_NeedsAssignItem}

type
//#UC START# *47AC67EA00B9ci*
 {$Define l3Items_NoChanging}
 {$Define l3Items_NoOwner}
//#UC END# *47AC67EA00B9ci*
 _l3VariantListPrim_Parent_ = Tk2ListTag;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3VariantListPrim.imp.pas}
//#UC START# *47AC67EA00B9cit*
//#UC END# *47AC67EA00B9cit*
 Tk2TagListPrim = class(_l3VariantListPrim_)
  {* Список тегов. }
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
//#UC START# *47AC67EA00B9publ*
//#UC END# *47AC67EA00B9publ*
 end;//Tk2TagListPrim

implementation

uses
  k2BaseTypes,
  SysUtils,
  l3Base,
  l3MinMax,
  RTLConsts
  ;

// start class Tk2TagListPrim

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47AC67EA00B9_var*
//#UC END# *47B2C42A0163_47AC67EA00B9_var*
begin
//#UC START# *47B2C42A0163_47AC67EA00B9_impl*
 aTo.AsObject.AssignTag(aFrom.AsObject, k2_amAll - [k2_amNull]);
//#UC END# *47B2C42A0163_47AC67EA00B9_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_47AC67EA00B9_var*
//#UC END# *47B99D4503A2_47AC67EA00B9_var*
begin
//#UC START# *47B99D4503A2_47AC67EA00B9_impl*
 {$IfDef l3Items_HasCustomSort}
 assert(CI.rA^ <> nil);
 assert(CI.rB^ <> nil);
 Result := CI.rA^.AsObject.CompareWithTag(CI.rB^.AsObject, CI.rSortIndex);
 {$Else l3Items_HasCustomSort}
 Assert(false);
 Result := -1;
 {$EndIf l3Items_HasCustomSort}
//#UC END# *47B99D4503A2_47AC67EA00B9_impl*
end;//CompareExistingItems

type _Instance_R_ = Tk2TagListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3VariantListPrim.imp.pas}

// start class Tk2TagListPrim

{$If not defined(DesignTimeLibrary)}
class function Tk2TagListPrim.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_47AC67EA00B9_var*
//#UC END# *47A6FEE600FC_47AC67EA00B9_var*
begin
//#UC START# *47A6FEE600FC_47AC67EA00B9_impl*
 Result := true;
//#UC END# *47A6FEE600FC_47AC67EA00B9_impl*
end;//Tk2TagListPrim.IsCacheable
{$IfEnd} //not DesignTimeLibrary

//#UC START# *47AC67EA00B9impl*
//#UC END# *47AC67EA00B9impl*

end.