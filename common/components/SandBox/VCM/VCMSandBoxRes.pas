unit VCMSandBoxRes;
 {* Тестовое приложение VCM }

// Модуль: "w:\common\components\SandBox\VCM\VCMSandBoxRes.pas"
// Стереотип: "VCMApplication"
// Элемент модели: "VCMSandBox" MUID: (521649770277)
// Имя типа: "TVCMSandBoxRes"

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_VCMSandBoxTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'VCMSandBoxTitle'; rValue : 'Тестовое приложение VCM');
  {* 'Тестовое приложение VCM' }

type
 TVCMSandBoxRes = {final} class
  {* Тестовое приложение VCM }
  public
   class function DocumentPrintAndExportDefaultSetting: Boolean;
    {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати размер шрифта, отображаемого на экране" }
   class function DocumentPrintAndExportCustomSetting: Boolean;
    {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати следующий размер шрифта" }
   class function DocumentPrintAndExportFontSizeSetting: Integer;
    {* Метод для получения значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
   class procedure WriteDocumentPrintAndExportFontSizeSetting(aValue: Integer);
    {* Метод для записи значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
   class function ListPrintAndExportDefaultSetting: Boolean;
    {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати размер шрифта, отображаемого на экране" }
   class function ListPrintAndExportCustomSetting: Boolean;
    {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати следующий размер шрифта" }
   class function ListPrintAndExportFontSizeSetting: Integer;
    {* Метод для получения значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
   class procedure WriteListPrintAndExportFontSizeSetting(aValue: Integer);
    {* Метод для записи значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
 end;//TVCMSandBoxRes

implementation

uses
 l3ImplUses
 , moDocument
 , moList
 , Document_Module
 , List_Module
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , evExtFormat
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *521649770277impl_uses*
 //#UC END# *521649770277impl_uses*
;

class function TVCMSandBoxRes.DocumentPrintAndExportDefaultSetting: Boolean;
 {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати размер шрифта, отображаемого на экране" }
begin
 Result := TDocumentModule.DocumentPrintAndExportDefaultSetting;
end;//TVCMSandBoxRes.DocumentPrintAndExportDefaultSetting

class function TVCMSandBoxRes.DocumentPrintAndExportCustomSetting: Boolean;
 {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати следующий размер шрифта" }
begin
 Result := TDocumentModule.DocumentPrintAndExportCustomSetting;
end;//TVCMSandBoxRes.DocumentPrintAndExportCustomSetting

class function TVCMSandBoxRes.DocumentPrintAndExportFontSizeSetting: Integer;
 {* Метод для получения значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
begin
 Result := TDocumentModule.DocumentPrintAndExportFontSizeSetting;
end;//TVCMSandBoxRes.DocumentPrintAndExportFontSizeSetting

class procedure TVCMSandBoxRes.WriteDocumentPrintAndExportFontSizeSetting(aValue: Integer);
 {* Метод для записи значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
begin
 TDocumentModule.WriteDocumentPrintAndExportFontSizeSetting(aValue);
end;//TVCMSandBoxRes.WriteDocumentPrintAndExportFontSizeSetting

class function TVCMSandBoxRes.ListPrintAndExportDefaultSetting: Boolean;
 {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати размер шрифта, отображаемого на экране" }
begin
 Result := TListModule.ListPrintAndExportDefaultSetting;
end;//TVCMSandBoxRes.ListPrintAndExportDefaultSetting

class function TVCMSandBoxRes.ListPrintAndExportCustomSetting: Boolean;
 {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати следующий размер шрифта" }
begin
 Result := TListModule.ListPrintAndExportCustomSetting;
end;//TVCMSandBoxRes.ListPrintAndExportCustomSetting

class function TVCMSandBoxRes.ListPrintAndExportFontSizeSetting: Integer;
 {* Метод для получения значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
begin
 Result := TListModule.ListPrintAndExportFontSizeSetting;
end;//TVCMSandBoxRes.ListPrintAndExportFontSizeSetting

class procedure TVCMSandBoxRes.WriteListPrintAndExportFontSizeSetting(aValue: Integer);
 {* Метод для записи значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
begin
 TListModule.WriteListPrintAndExportFontSizeSetting(aValue);
end;//TVCMSandBoxRes.WriteListPrintAndExportFontSizeSetting

initialization
 str_VCMSandBoxTitle.Init;
 {* Инициализация str_VCMSandBoxTitle }

end.
