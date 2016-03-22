unit ddTableConvTypes;

// Модуль: "w:\common\components\rtl\Garant\dd\ddTableConvTypes.pas"
// Стереотип: "Interfaces"
// Элемент модели: "ddTableConvTypes" MUID: (4E0D98F50163)

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
