unit ddAnnoKindStatisticList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/PipeOut/ddAnnoKindStatisticList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::PipeOut::TddAnnoKindStatisticList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
  ddAnnoKindStatisticListPrim,
  l3Types
  ;

type
 _FindDataType_ = Integer;
 _l3Searcher_Parent_ = TddAnnoKindStatisticListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TddAnnoKindStatisticList = class(_l3Searcher_)
 end;//TddAnnoKindStatisticList

implementation

uses
  l3String
  ;

// start class TddAnnoKindStatisticList

function CompareItemWithData(const anItem: _ItemType_;
  const aData: _FindDataType_;
  aSortIndex: Tl3SortIndex;
  aList: _l3Searcher_): Integer;
//#UC START# *47B9BAFD01F4_564C6BCB02EF_var*
//#UC END# *47B9BAFD01F4_564C6BCB02EF_var*
begin
//#UC START# *47B9BAFD01F4_564C6BCB02EF_impl*
 Result := anItem.ID - aData;
//#UC END# *47B9BAFD01F4_564C6BCB02EF_impl*
end;//CompareItemWithData

type _Instance_R_ = TddAnnoKindStatisticList;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

end.