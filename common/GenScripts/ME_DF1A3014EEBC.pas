unit stevStylesPrintAndExportFontSizeItem;

interface

uses
 l3IntfUses
 , ddAppConfigTypes
;

type
 TstevStylesPrintAndExportFontSizeItem = class(TddComboBoxConfigItem)
  {* Визуализатор для настройки "Использовать для экспорта и печати следующий размер шрифта" }
  procedure Create(aMasterItem: TddBaseConfigItem);
 end;//TstevStylesPrintAndExportFontSizeItem
 
implementation

uses
 l3ImplUses
 , evStylesPrintAndExportFontSizeSettingRes
 , l3Base
 , ddAppConfigConst
;

end.
