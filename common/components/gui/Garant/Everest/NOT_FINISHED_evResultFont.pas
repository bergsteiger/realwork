unit NOT_FINISHED_evResultFont;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evResultFont.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evResultFont" MUID: (480DBE6E01D0)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , k2Tags
;

type
 PevResultFontEx = ^TevResultFontEx;

 TevFontArray = array [Tk2FontParam] of Integer;

 TevResultFont = {$IfDef XE4}record{$Else}object{$EndIf}
 end;//TevResultFont

implementation

uses
 l3ImplUses
;

end.
