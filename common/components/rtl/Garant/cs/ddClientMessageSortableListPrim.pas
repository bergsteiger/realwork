unit ddClientMessageSortableListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ddClientMessageSortableListPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TddClientMessageSortableListPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoDataContainer,
  csClientMessageRequest,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 _ItemType_ = TddClientMessage;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TddClientMessageSortableListPrim = class(_l3UncomparabeObjectRefList_)
 end;//TddClientMessageSortableListPrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TddClientMessageSortableListPrim

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_52FA508003E5_var*
//#UC END# *47B2C42A0163_52FA508003E5_var*
begin
//#UC START# *47B2C42A0163_52FA508003E5_impl*
 Assert(false);
//#UC END# *47B2C42A0163_52FA508003E5_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_52FA508003E5_var*
//#UC END# *47B99D4503A2_52FA508003E5_var*
begin
//#UC START# *47B99D4503A2_52FA508003E5_impl*
 Result := CI.rA.CompareWith(CI.rB^);
//#UC END# *47B99D4503A2_52FA508003E5_impl*
end;//CompareExistingItems

type _Instance_R_ = TddClientMessageSortableListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}


{$IfEnd} //not Nemesis
end.