unit vcmMenuForChromeLikeItems;

interface
uses
 Classes,
 Types,
 Menus,
 l3Interfaces,
 l3ProtoObject,
 l3ProtoDataContainer,
 l3Core,
 l3Types,
 l3Memory,
 l3Base,
 vcmMainMenuForChromeLikeTypes;

type
 _ItemType_ = TvcmMenuForChromeLikeItem;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
 TvcmMenuForChromeLikeItems = class(_l3RecordWithEQList_)
 (* - список с пунктами меню *)
 public
  function FindItemAtPoint(const aPoint: TPoint): TvcmMenuForChromeLikeItem;
 end;//TvgTabButtonArray


implementation
uses
 Math,
 RTLConsts,
 SysUtils,
 l3Except;

function CompareExistingItems(const CI: CompareItemsRec): Integer;
begin
 Result := -1;
 Assert(false);
end;//CompareExistingItems

type _Instance_R_ = TvcmMenuForChromeLikeItems;
{$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}

function TvcmMenuForChromeLikeItems.FindItemAtPoint(const aPoint: TPoint): TvcmMenuForChromeLikeItem;
var
 l_Item: TvcmMenuForChromeLikeItem;

 function lp_DoFindItemAtPoint(anItem: PvcmMenuForChromeLikeItem;
  anIndex: Integer): Boolean;
 var
  l_Intersects: Boolean;
 begin
  l_Intersects := anItem^.Intersects(aPoint);
  if l_Intersects then
   l_Item := anItem^;
  Result := not l_Intersects;
 end;//lp_DoFindItemAtPoint

begin
 l_Item := cNullMenuForChromeLikeItem;
 IterateAllF(l3L2IA(@lp_DoFindItemAtPoint));
 Result := l_Item;
end;

end.
