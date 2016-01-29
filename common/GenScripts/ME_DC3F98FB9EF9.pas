unit stListPrintAndExportFontSizeItem;

interface

uses
 l3IntfUses
 , ddAppConfigTypes
;

type
 TstListPrintAndExportFontSizeItem = class(TddComboBoxConfigItem)
  {* Визуализатор для настройки "Использовать для экспорта и печати следующий размер шрифта" }
  procedure Create(aMasterItem: TddBaseConfigItem);
 end;//TstListPrintAndExportFontSizeItem
 
implementation

uses
 l3ImplUses
 , ListPrintAndExportFontSizeSettingRes
 , l3Base
 , ddAppConfigConst
;

end.
