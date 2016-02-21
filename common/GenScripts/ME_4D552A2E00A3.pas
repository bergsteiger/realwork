unit vgTypesPrim;

// Модуль: "w:\common\components\rtl\external\VGScene\vgTypesPrim.pas"
// Стереотип: "UtilityPack"

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
;
{$IfEnd} // NOT Defined(NoVGScene)

end.
