unit evStyles_SH;

interface

uses
 l3IntfUses
 , evInterface
 , l3ProtoObject
 , afwInterfaces
;

type
 SHevStyles = class(TevInterface)
  {* Стили }
  function PrintAndExportFontSize: Integer;
   {* Эффективный размер шрифта для печати и экспорта }
  function PrintAndExportDefaultSetting: Boolean;
   {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати размер шрифта, отображаемого на экране" }
  function PrintAndExportCustomSetting: Boolean;
   {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати следующий размер шрифта" }
  function PrintAndExportFontSizeSetting: Integer;
   {* Метод для получения значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
  procedure WritePrintAndExportFontSizeSetting(aValue: Integer);
   {* Метод для записи значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
 end;//SHevStyles
 
implementation

uses
 l3ImplUses
 , evStyleTableSpy
 , evStylesPrintAndExportSettingRes
 , evStylesPrintAndExportFontSizeSettingRes
 , SysUtils
 , afwFacade
 , afwSettingsChangePublisher
;

type
 TevStylesSettingsListener = class(Tl3ProtoObject)
  {* Экземпляр evStyles, который подписывается к настройкам }
  procedure CheckSubscribe;
   {* Метод для проверки того факта, что TevStylesSettingsListener подписан на изменения необходимых настроек }
  function IsSettingAffectsUs(const aSettingId: TafwSettingId): Boolean;
   {* Метод для проверки того факта, что TevStylesSettingsListener касается изменение указанной настройки }
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TevStylesSettingsListener
 
end.
