unit ddTableConvTypes;

// Модуль: "w:\common\components\rtl\Garant\dd\ddTableConvTypes.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
;

type
 TddCellSeparator = (
  csGraphic
  , csParagraph
  , csTab
  , csSemicolon
  , csSpace
  , csOther
 );//TddCellSeparator

 TddAutoFitBehavior = (
  afEqual
  , afContent
 );//TddAutoFitBehavior

implementation

uses
 l3ImplUses
;

end.
