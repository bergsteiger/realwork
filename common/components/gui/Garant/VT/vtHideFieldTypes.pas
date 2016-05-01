unit vtHideFieldTypes;

// Модуль: "w:\common\components\gui\Garant\VT\vtHideFieldTypes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vtHideFieldTypes" MUID: (572318050295)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
;

type
 ThfOption = (
  hfoCanHide
  , hfoHyperlink
 );//ThfOption

 ThfOptions = set of ThfOption;

implementation

uses
 l3ImplUses
;

end.
