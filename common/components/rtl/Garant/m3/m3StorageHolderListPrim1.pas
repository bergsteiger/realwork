unit m3StorageHolderListPrim1;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3StorageHolderListPrim1.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::StorageHolder::Tm3StorageHolderListPrim1
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3StorageHolderListPrim,
  l3Types
  ;

type
 _FindDataType_ = WideString;
 _l3Searcher_Parent_ = Tm3StorageHolderListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 Tm3StorageHolderListPrim1 = class(_l3Searcher_)
 end;//Tm3StorageHolderListPrim1

implementation

uses
  l3String
  ;

// start class Tm3StorageHolderListPrim1

function CompareItemWithData(const anItem: _ItemType_;
  const aData: _FindDataType_;
  aSortIndex: Tl3SortIndex;
  aList: _l3Searcher_): Integer;
//#UC START# *47B9BAFD01F4_542E8D2902F1_var*
//#UC END# *47B9BAFD01F4_542E8D2902F1_var*
begin
//#UC START# *47B9BAFD01F4_542E8D2902F1_impl*
 Result := l3Compare(l3PCharLen(anItem.FileName), l3PCharLen(aData), l3_siCaseUnsensitive);
//#UC END# *47B9BAFD01F4_542E8D2902F1_impl*
end;//CompareItemWithData

type _Instance_R_ = Tm3StorageHolderListPrim1;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

end.