unit evStandardStylesList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evStandardStylesList.pas"
// Начат: 24.08.2011 19:06
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::StyleTable::TevStandardStylesList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evStandardStylesListPrim,
  evResultFontInterfaces,
  l3Types
  ;

type
 _FindDataType_ = Integer;
 _l3Searcher_Parent_ = TevStandardStylesListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TevStandardStylesList = class(_l3Searcher_)
 public
 // public methods
   function StyleByID(anID: Integer;
     aJust: Boolean;
     aVis: Boolean;
     aFixed: Boolean): IevResultFont;
   procedure AddStyleByID(anID: Integer;
     aJust: Boolean;
     aVis: Boolean;
     aFixed: Boolean;
     const aStyle: IevResultFont);
 end;//TevStandardStylesList

implementation

uses
  l3Base,
  evResultFontHolder
  ;

// start class TevStandardStylesList

function CompareItemWithData(const anItem: _ItemType_;
  const aData: _FindDataType_;
  aSortIndex: Tl3SortIndex;
  aList: _l3Searcher_): Integer;
//#UC START# *47B9BAFD01F4_4E55134F0348_var*
//#UC END# *47B9BAFD01F4_4E55134F0348_var*
begin
//#UC START# *47B9BAFD01F4_4E55134F0348_impl*
 Result := anItem.rID - aData;
//#UC END# *47B9BAFD01F4_4E55134F0348_impl*
end;//CompareItemWithData

type _Instance_R_ = TevStandardStylesList;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

// start class TevStandardStylesList

function TevStandardStylesList.StyleByID(anID: Integer;
  aJust: Boolean;
  aVis: Boolean;
  aFixed: Boolean): IevResultFont;
//#UC START# *4E551B9F0203_4E55134F0348_var*
var
 l_Index : Integer;
//#UC END# *4E551B9F0203_4E55134F0348_var*
begin
//#UC START# *4E551B9F0203_4E55134F0348_impl*
 if FindData(anID, l_Index) then
  Result := ItemSlot(l_Index)^.rValue[aJust, aVis, aFixed]
 else
  Result := nil;
//#UC END# *4E551B9F0203_4E55134F0348_impl*
end;//TevStandardStylesList.StyleByID

procedure TevStandardStylesList.AddStyleByID(anID: Integer;
  aJust: Boolean;
  aVis: Boolean;
  aFixed: Boolean;
  const aStyle: IevResultFont);
//#UC START# *4E551BCF0180_4E55134F0348_var*
var
 l_Item : TevStandardStylesCacheItem;
 l_Index : Integer;
//#UC END# *4E551BCF0180_4E55134F0348_var*
begin
//#UC START# *4E551BCF0180_4E55134F0348_impl*
 if FindData(anID, l_Index) then
  ItemSlot(l_Index)^.rValue[aJust, aVis, aFixed] := aStyle
 else
 begin
  l3FillChar(l_Item, SizeOf(l_Item));
  l_Item.rID := anID;
  l_Item.rValue[aJust, aVis, aFixed] := aStyle;
  DirectInsert(l_Index, l_Item);
 end;//FindData(anID, l_Index)
//#UC END# *4E551BCF0180_4E55134F0348_impl*
end;//TevStandardStylesList.AddStyleByID

end.