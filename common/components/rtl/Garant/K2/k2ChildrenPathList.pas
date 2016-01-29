unit k2ChildrenPathList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2ChildrenPathList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2PrimObjects::Tk2ChildrenPathList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2ChildrenPathListPrim,
  l3Types
  ;

type
 _FindDataType_ = Integer;
 _l3Searcher_Parent_ = Tk2ChildrenPathListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 Tk2ChildrenPathList = class(_l3Searcher_)
 end;//Tk2ChildrenPathList

implementation

uses
  k2ChildrenPath,
  l3Memory
  ;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

// start class Tk2ChildrenPathList

function CompareItemWithData(const anItem: _ItemType_;
  const aData: _FindDataType_;
  aSortIndex: Tl3SortIndex;
  aList: _l3Searcher_): Integer;
//#UC START# *47B9BAFD01F4_47BAB0450293_var*
//#UC END# *47B9BAFD01F4_47BAB0450293_var*
begin
//#UC START# *47B9BAFD01F4_47BAB0450293_impl*
 Assert(aSortIndex = l3_siNative);
 Result := anItem.TagType - aData;
//#UC END# *47B9BAFD01F4_47BAB0450293_impl*
end;//CompareItemWithData

type _Instance_R_ = Tk2ChildrenPathList;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

end.