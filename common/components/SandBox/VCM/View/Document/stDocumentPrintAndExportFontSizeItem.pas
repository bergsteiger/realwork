unit stDocumentPrintAndExportFontSizeItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "stDocumentPrintAndExportFontSizeItem.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Sand Box$UC::Document::View::Document::TstDocumentPrintAndExportFontSizeItem
//
// Визуализатор для настройки "Использовать для экспорта и печати следующий размер шрифта"
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
  ddAppConfigTypes
  ;

type
 TstDocumentPrintAndExportFontSizeItem = class(TddComboBoxConfigItem)
  {* Визуализатор для настройки "Использовать для экспорта и печати следующий размер шрифта" }
 public
 // public methods
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
     {* undefined }
 end;//TstDocumentPrintAndExportFontSizeItem

implementation

uses
  DocumentPrintAndExportFontSizeSettingRes,
  l3Base,
  ddAppConfigConst
  ;

// start class TstDocumentPrintAndExportFontSizeItem

constructor TstDocumentPrintAndExportFontSizeItem.Create(aMasterItem: TddBaseConfigItem = nil);
var
 l_Value : TddConfigValue;
begin
 l3FillChar(l_Value, SizeOf(l_Value));
 l_Value.Kind := dd_vkInteger;
 l_Value.AsInteger := dv_Document_PrintAndExportFontSize;
 inherited Create(pi_Document_PrintAndExportFontSize,
  str_PrintAndExportFontSize.AsStr,
  l_Value, TPrintAndExportFontSizeValuesMapImpl.Make, aMasterItem);
end;//TstDocumentPrintAndExportFontSizeItem.Create

end.