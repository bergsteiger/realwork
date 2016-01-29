unit nevFormatInfoList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevFormatInfoList.pas"
// Начат: 28.04.2008 16:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevFormatInfoList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevFormatInfo,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = TnevFormatInfo;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TnevFormatInfoList = class(_l3UncomparabeObjectRefList_)
 public
 // public methods
   procedure ClearReferencesToParentFormatInfo;
 end;//TnevFormatInfoList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TnevFormatInfoList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4815C64B0373_var*
//#UC END# *47B2C42A0163_4815C64B0373_var*
begin
//#UC START# *47B2C42A0163_4815C64B0373_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4815C64B0373_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4815C64B0373_var*
//#UC END# *47B99D4503A2_4815C64B0373_var*
begin
//#UC START# *47B99D4503A2_4815C64B0373_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4815C64B0373_impl*
end;//CompareExistingItems

type _Instance_R_ = TnevFormatInfoList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

type
  TnevFormatInfoHack = {abstract} class(TnevFormatInfo)
  end;//TnevFormatInfoHack

// start class TnevFormatInfoList

procedure TnevFormatInfoList.ClearReferencesToParentFormatInfo;
//#UC START# *4EA5701600EF_4815C64B0373_var*
var
 l_Index : Integer;
//#UC END# *4EA5701600EF_4815C64B0373_var*
begin
//#UC START# *4EA5701600EF_4815C64B0373_impl*
 for l_Index := 0 to Pred(Count) do
  if (Items[l_Index] <> nil) then
   TnevFormatInfoHack(Items[l_Index]).ClearParentRef;
//#UC END# *4EA5701600EF_4815C64B0373_impl*
end;//TnevFormatInfoList.ClearReferencesToParentFormatInfo

end.