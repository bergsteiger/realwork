unit m4WordIDStrListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m4"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/m4/m4WordIDStrListPrim.pas"
// Начат: 18.09.2009 16:36
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m4::Dict::Tm4WordIDStrListPrim
//
// Список списков идентификаторов слов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m4\m4Define.inc}

interface

uses
  l3ProtoDataContainer,
  m4WordIDStr,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Tm4WordIDStr;
 _l3ObjectRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectRefListPrim.imp.pas}
 Tm4WordIDStrListPrim = class(_l3ObjectRefListPrim_)
  {* Список списков идентификаторов слов }
 end;//Tm4WordIDStrListPrim

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class Tm4WordIDStrListPrim

procedure FillItem(var aPlace: _ItemType_;
  const anItem: _ItemType_
  {$If defined(l3Items_FillItem_NeedsList)}
  ;
  anItems: _l3Items_
  {$IfEnd} //l3Items_FillItem_NeedsList
  ); forward;

procedure FreeItem(var aPlace: _ItemType_
  {$If defined(l3Items_FreeItem_NeedsList)}
  ;
  aList: _l3Items_
  {$IfEnd} //l3Items_FreeItem_NeedsList
  ); forward;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4AB37CFD0365_var*
//#UC END# *47B2C42A0163_4AB37CFD0365_var*
begin
//#UC START# *47B2C42A0163_4AB37CFD0365_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4AB37CFD0365_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

procedure FillItem(var aPlace: _ItemType_;
  const anItem: _ItemType_
  {$If defined(l3Items_FillItem_NeedsList)}
  ;
  anItems: _l3Items_
  {$IfEnd} //l3Items_FillItem_NeedsList
  );
//#UC START# *47B935AF0066_4AB37CFD0365_var*
//#UC END# *47B935AF0066_4AB37CFD0365_var*
begin
//#UC START# *47B935AF0066_4AB37CFD0365_impl*
 aPlace := anItem.Use;
//#UC END# *47B935AF0066_4AB37CFD0365_impl*
end;//FillItem

procedure FreeItem(var aPlace: _ItemType_
  {$If defined(l3Items_FreeItem_NeedsList)}
  ;
  aList: _l3Items_
  {$IfEnd} //l3Items_FreeItem_NeedsList
  );
//#UC START# *47B94A5C006E_4AB37CFD0365_var*
//#UC END# *47B94A5C006E_4AB37CFD0365_var*
begin
//#UC START# *47B94A5C006E_4AB37CFD0365_impl*
 FreeAndNil(aPlace);
//#UC END# *47B94A5C006E_4AB37CFD0365_impl*
end;//FreeItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4AB37CFD0365_var*
//#UC END# *47B99D4503A2_4AB37CFD0365_var*
begin
//#UC START# *47B99D4503A2_4AB37CFD0365_impl*
  Result := CI.rA.Compare(CI.rB^);
//#UC END# *47B99D4503A2_4AB37CFD0365_impl*
end;//CompareExistingItems

type _Instance_R_ = Tm4WordIDStrListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectRefListPrim.imp.pas}

end.