unit stListPrintAndExportFontSizeItem;
 {* Визуализатор для настройки "Использовать для экспорта и печати следующий размер шрифта" }

// Модуль: "w:\common\components\SandBox\VCM\View\List\stListPrintAndExportFontSizeItem.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TstListPrintAndExportFontSizeItem" MUID: (DC3F98FB9EF9)

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
 , ddAppConfigTypes
;

type
 TstListPrintAndExportFontSizeItem = class(TddComboBoxConfigItem)
  {* Визуализатор для настройки "Использовать для экспорта и печати следующий размер шрифта" }
  public
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
 end;//TstListPrintAndExportFontSizeItem

implementation

uses
 l3ImplUses
 , ListPrintAndExportFontSizeSettingRes
 , l3Base
 , ddAppConfigConst
;

constructor TstListPrintAndExportFontSizeItem.Create(aMasterItem: TddBaseConfigItem = nil);
var
 l_Value : TddConfigValue;
begin
 l3FillChar(l_Value, SizeOf(l_Value));
 l_Value.Kind := dd_vkInteger;
 l_Value.AsInteger := dv__;
 inherited Create(pi__,
  str_.AsStr,
  l_Value, TValuesMapImpl.Make, aMasterItem);
end;//TstListPrintAndExportFontSizeItem.Create

end.
