unit k2DictionaryIDIndex;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2DictionaryIDIndex.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2DictionaryIDIndex
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2DictionaryIDIndexPrim,
  l3Types
  ;

type
 _FindDataType_ = Integer;
 _l3Searcher_Parent_ = Tk2DictionaryIDIndexPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 Tk2DictionaryIDIndex = class(_l3Searcher_)
 end;//Tk2DictionaryIDIndex

implementation

uses
  k2Tags,
  l3Memory,
  l3Variant
  ;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}
{$If not Declared(_ItemType_)}type _ItemType_ = Tl3Variant;{$IfEnd}

// start class Tk2DictionaryIDIndex

function CompareItemWithData(const anItem: _ItemType_;
  const aData: _FindDataType_;
  aSortIndex: Tl3SortIndex;
  aList: _l3Searcher_): Integer;
//#UC START# *47B9BAFD01F4_5304CAB003D1_var*
//#UC END# *47B9BAFD01F4_5304CAB003D1_var*
begin
//#UC START# *47B9BAFD01F4_5304CAB003D1_impl*
 Result := anItem.IntA[k2_tiHandle] - aData;
//#UC END# *47B9BAFD01F4_5304CAB003D1_impl*
end;//CompareItemWithData

type _Instance_R_ = Tk2DictionaryIDIndex;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

end.