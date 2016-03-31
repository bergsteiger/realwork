unit Document_Module;
 {* Документ }

// Модуль: "w:\common\components\SandBox\VCM\View\Document\Document_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "Document" MUID: (5216345D004A)
// Имя типа: "TDocumentModule"

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
;

type
 TDocumentModule = class(TvcmModule)
  {* Документ }
  public
   class function DocumentPrintAndExportDefaultSetting: Boolean;
    {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати размер шрифта, отображаемого на экране" }
   class function DocumentPrintAndExportCustomSetting: Boolean;
    {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати следующий размер шрифта" }
   class function DocumentPrintAndExportFontSizeSetting: Integer;
    {* Метод для получения значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
   class procedure WriteDocumentPrintAndExportFontSizeSetting(aValue: Integer);
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

{$If NOT Defined(NoVCM)}
class function TDocumentModule.DocumentPrintAndExportDefaultSetting: Boolean;
 {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати размер шрифта, отображаемого на экране" }
//#UC START# *17DC451B397C_5216345D004A_var*
//#UC END# *17DC451B397C_5216345D004A_var*
begin
//#UC START# *17DC451B397C_5216345D004A_impl*
 !!! Needs to be implemented !!!
//#UC END# *17DC451B397C_5216345D004A_impl*
end;//TDocumentModule.DocumentPrintAndExportDefaultSetting

class function TDocumentModule.DocumentPrintAndExportCustomSetting: Boolean;
 {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати следующий размер шрифта" }
//#UC START# *D176CCBDE51D_5216345D004A_var*
//#UC END# *D176CCBDE51D_5216345D004A_var*
begin
//#UC START# *D176CCBDE51D_5216345D004A_impl*
 !!! Needs to be implemented !!!
//#UC END# *D176CCBDE51D_5216345D004A_impl*
end;//TDocumentModule.DocumentPrintAndExportCustomSetting

class function TDocumentModule.DocumentPrintAndExportFontSizeSetting: Integer;
 {* Метод для получения значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
//#UC START# *12B83765C323_5216345D004A_var*
//#UC END# *12B83765C323_5216345D004A_var*
begin
//#UC START# *12B83765C323_5216345D004A_impl*
 !!! Needs to be implemented !!!
//#UC END# *12B83765C323_5216345D004A_impl*
end;//TDocumentModule.DocumentPrintAndExportFontSizeSetting

class procedure TDocumentModule.WriteDocumentPrintAndExportFontSizeSetting(aValue: Integer);
 {* Метод для записи значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
//#UC START# *930B9F1EF1E3_5216345D004A_var*
//#UC END# *930B9F1EF1E3_5216345D004A_var*
begin
//#UC START# *930B9F1EF1E3_5216345D004A_impl*
 !!! Needs to be implemented !!!
//#UC END# *930B9F1EF1E3_5216345D004A_impl*
end;//TDocumentModule.WriteDocumentPrintAndExportFontSizeSetting
{$IfEnd} // NOT Defined(NoVCM)

end.
