unit Document_Module;

interface

uses
 l3IntfUses
;

type
 TDocumentModule = class
  {* Документ }
  function DocumentPrintAndExportDefaultSetting: Boolean;
   {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати размер шрифта, отображаемого на экране" }
  function DocumentPrintAndExportCustomSetting: Boolean;
   {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати следующий размер шрифта" }
  function DocumentPrintAndExportFontSizeSetting: Integer;
   {* Метод для получения значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
  procedure WriteDocumentPrintAndExportFontSizeSetting(aValue: Integer);
   {* Метод для записи значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
 end;//TDocumentModule
 
implementation

uses
 l3ImplUses
 , DocumentPrintAndExportSettingRes
 , DocumentPrintAndExportFontSizeSettingRes
 , stDocumentPrintAndExportFontSizeItem
 , afwFacade
;

end.
