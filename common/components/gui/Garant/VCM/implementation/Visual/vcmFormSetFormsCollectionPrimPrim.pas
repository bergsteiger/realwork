unit vcmFormSetFormsCollectionPrimPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmFormSetFormsCollectionPrimPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::FormSets::TvcmFormSetFormsCollectionPrimPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3ProtoDataContainer,
  vcmFormSetFormsCollectionItemPrim,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 _ItemType_ = TvcmFormSetFormsCollectionItemPrim;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TvcmFormSetFormsCollectionPrimPrim = class(_l3UncomparabeObjectRefList_)
 end;//TvcmFormSetFormsCollectionPrimPrim
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TvcmFormSetFormsCollectionPrimPrim

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4FFC55AD02B3_var*
//#UC END# *47B2C42A0163_4FFC55AD02B3_var*
begin
//#UC START# *47B2C42A0163_4FFC55AD02B3_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4FFC55AD02B3_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4FFC55AD02B3_var*
//#UC END# *47B99D4503A2_4FFC55AD02B3_var*
begin
//#UC START# *47B99D4503A2_4FFC55AD02B3_impl*
 Assert(false);
 Result := -1;
//#UC END# *47B99D4503A2_4FFC55AD02B3_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmFormSetFormsCollectionPrimPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}


{$IfEnd} //not NoVCM
end.