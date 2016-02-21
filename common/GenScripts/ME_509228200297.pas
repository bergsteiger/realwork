unit evCellsOffsetsList;

// Модуль: "w:\common\components\gui\Garant\Everest\evCellsOffsetsList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , evCellsCharOffsets
 , evEditorInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TevCellsCharOffsets;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TevCellsOffsetsList = class(_l3UncomparabeObjectRefList_)
  public
   procedure Try2RemeberWidths(const anIterator: IedCellsIterator);
   function FindList(const anIterator: IedCellsIterator;
    aForTempate: Boolean): TevCellsCharOffsets;
 end;//TevCellsOffsetsList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_509228200297_var*
//#UC END# *47B2C42A0163_509228200297_var*
begin
//#UC START# *47B2C42A0163_509228200297_impl*
 Assert(false);
//#UC END# *47B2C42A0163_509228200297_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_509228200297_var*
//#UC END# *47B99D4503A2_509228200297_var*
begin
//#UC START# *47B99D4503A2_509228200297_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_509228200297_impl*
end;//CompareExistingItems

type _Instance_R_ = TevCellsOffsetsList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

procedure TevCellsOffsetsList.Try2RemeberWidths(const anIterator: IedCellsIterator);
//#UC START# *50922CA3006F_509228200297_var*
var
 l_Offsets: TevCellsCharOffsets;
//#UC END# *50922CA3006F_509228200297_var*
begin
//#UC START# *50922CA3006F_509228200297_impl*
 l_Offsets := FindList(anIterator, True);
 if l_Offsets = nil then
 begin
  l_Offsets := TevCellsCharOffsets.Create;
  try
   l_Offsets.CopyData(nil, anIterator);
   Add(l_Offsets);
  finally
   l3Free(l_Offsets);
  end;
 end
 else
  l_Offsets.IncUsingCount;
//#UC END# *50922CA3006F_509228200297_impl*
end;//TevCellsOffsetsList.Try2RemeberWidths

function TevCellsOffsetsList.FindList(const anIterator: IedCellsIterator;
 aForTempate: Boolean): TevCellsCharOffsets;
//#UC START# *509375AF03C8_509228200297_var*

 function lp_CheckItem(aData: PObject; anIndex: Long): Bool;
 var
  l_List   : TevCellsCharOffsets;
  l_Equals : Boolean;
 begin
  Result := True;
  l_List := TevCellsCharOffsets(aData^);
  l_Equals := l_List.Equals(anIterator, aForTempate);
  if l_Equals then
  begin
   FindList := l_List;
   Result := False;
  end; // if l_Equals then
 end;

//#UC END# *509375AF03C8_509228200297_var*
begin
//#UC START# *509375AF03C8_509228200297_impl*
 Result := nil;
 Self.IterateAllF(l3L2IA(@lp_CheckItem));
//#UC END# *509375AF03C8_509228200297_impl*
end;//TevCellsOffsetsList.FindList

end.
