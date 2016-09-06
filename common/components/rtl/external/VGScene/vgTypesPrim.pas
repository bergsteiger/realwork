unit vgTypesPrim;

// Модуль: "w:\common\components\rtl\external\VGScene\vgTypesPrim.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vgTypesPrim" MUID: (4D552A2E00A3)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , vgCustomObject
;

type
 TvgObjectSortCompare = function(item1: TvgCustomObject;
  item2: TvgCustomObject): integer;
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 //#UC START# *4D552A2E00A3impl_uses*
 //#UC END# *4D552A2E00A3impl_uses*
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
