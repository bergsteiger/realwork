unit k2AtomicTagRefList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2AtomicTagRefList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2AtomicTagRefList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2AtomicTagRefListPrim,
  l3Types
  ;

type
 _FindDataType_ = Integer;
 _l3Searcher_Parent_ = Tk2AtomicTagRefListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 Tk2AtomicTagRefList = class(_l3Searcher_)
 end;//Tk2AtomicTagRefList

implementation

// start class Tk2AtomicTagRefList

function CompareItemWithData(const anItem: _ItemType_;
  const aData: _FindDataType_;
  aSortIndex: Tl3SortIndex;
  aList: _l3Searcher_): Integer;
//#UC START# *47B9BAFD01F4_526918BD0308_var*
var
 l_I : Integer;
//#UC END# *47B9BAFD01F4_526918BD0308_var*
begin
//#UC START# *47B9BAFD01F4_526918BD0308_impl*
 Assert(aSortIndex = l3_siNative);
 l_I := anItem.AsLong;
 if (l_I < aData) then
  Result := -1
 else
 if (l_I > aData) then
  Result := +1
 else
  Result := 0;
//#UC END# *47B9BAFD01F4_526918BD0308_impl*
end;//CompareItemWithData

type _Instance_R_ = Tk2AtomicTagRefList;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

end.