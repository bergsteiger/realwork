unit l3BaseWithIDList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3BaseWithIDList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3BaseWithIDList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3BaseWithIDListPrim,
  l3Types
  ;

type
 _FindDataType_ = Integer;
 _l3Searcher_Parent_ = Tl3BaseWithIDListPrim;
 {$Include ..\L3\l3Searcher.imp.pas}
 Tl3BaseWithIDList = class(_l3Searcher_)
 end;//Tl3BaseWithIDList

implementation

uses
  l3Memory
  ;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

// start class Tl3BaseWithIDList

function CompareItemWithData(const anItem: _ItemType_;
  const aData: _FindDataType_;
  aSortIndex: Tl3SortIndex;
  aList: _l3Searcher_): Integer;
//#UC START# *47B9BAFD01F4_47BD8675002D_var*
//#UC END# *47B9BAFD01F4_47BD8675002D_var*
begin
//#UC START# *47B9BAFD01F4_47BD8675002D_impl*
 Assert(aSortIndex = l3_siNative);
 Result := anItem.ID - aData;
//#UC END# *47B9BAFD01F4_47BD8675002D_impl*
end;//CompareItemWithData

type _Instance_R_ = Tl3BaseWithIDList;

{$Include ..\L3\l3Searcher.imp.pas}

end.