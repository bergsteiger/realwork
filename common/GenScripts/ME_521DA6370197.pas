unit List_Module;

interface

uses
 l3IntfUses
;

type
 TListModule = class
  {* Список }
  function ListPrintAndExportDefaultSetting: Boolean;
   {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати размер шрифта, отображаемого на экране" }
  function ListPrintAndExportCustomSetting: Boolean;
   {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати следующий размер шрифта" }
  function ListPrintAndExportFontSizeSetting: Integer;
   {* Метод для получения значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
  procedure WriteListPrintAndExportFontSizeSetting(aValue: Integer);
   {* Метод для записи значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
 end;//TListModule
 
implementation

uses
 l3ImplUses
 , ListPrintAndExportSettingRes
 , ListPrintAndExportFontSizeSettingRes
 , stListPrintAndExportFontSizeItem
 , afwFacade
;

end.
