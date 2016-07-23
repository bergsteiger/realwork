unit stDocumentPrintAndExportFontSizeItem;
 {* Визуализатор для настройки "Использовать для экспорта и печати следующий размер шрифта" }

// Модуль: "w:\common\components\SandBox\VCM\View\Document\stDocumentPrintAndExportFontSizeItem.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TstDocumentPrintAndExportFontSizeItem" MUID: (1599BCBFE969)

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
 , ddAppConfigTypes
;

type
 TstDocumentPrintAndExportFontSizeItem = class(TddComboBoxConfigItem)
  {* Визуализатор для настройки "Использовать для экспорта и печати следующий размер шрифта" }
  public
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
 end;//TstDocumentPrintAndExportFontSizeItem

implementation

uses
 l3ImplUses
 , DocumentPrintAndExportFontSizeSettingRes
 , l3Base
 , ddAppConfigConst
;

constructor TstDocumentPrintAndExportFontSizeItem.Create(aMasterItem: TddBaseConfigItem = nil);
var
 l_Value : TddConfigValue;
begin
 l3FillChar(l_Value, SizeOf(l_Value));
 l_Value.Kind := dd_vkInteger;
 l_Value.AsInteger := dv__;
 inherited Create(pi__,
  str_.AsStr,
  l_Value, TValuesMapImpl.Make, aMasterItem);
end;//TstDocumentPrintAndExportFontSizeItem.Create

end.
