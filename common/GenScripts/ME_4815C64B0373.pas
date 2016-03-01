unit nevFormatInfoList;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevFormatInfoList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevFormatInfo
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TnevFormatInfo;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TnevFormatInfoList = class(_l3UncomparabeObjectRefList_)
  public
   procedure ClearReferencesToParentFormatInfo;
 end;//TnevFormatInfoList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type
 TnevFormatInfoHack = {abstract} class(TnevFormatInfo)
 end;//TnevFormatInfoHack

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4815C64B0373_var*
//#UC END# *47B2C42A0163_4815C64B0373_var*
begin
//#UC START# *47B2C42A0163_4815C64B0373_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4815C64B0373_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
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
