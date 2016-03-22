unit List_Module;
 {* Список }

// Модуль: "w:\common\components\SandBox\VCM\View\List\List_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "List" MUID: (521DA6370197)
// Имя типа: "TListModule"

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
;

type
 TListModule = class
  {* Список }
  public
   class function ListPrintAndExportDefaultSetting: Boolean;
    {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати размер шрифта, отображаемого на экране" }
   class function ListPrintAndExportCustomSetting: Boolean;
    {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати следующий размер шрифта" }
   class function ListPrintAndExportFontSizeSetting: Integer;
    {* Метод для получения значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
   class procedure WriteListPrintAndExportFontSizeSetting(aValue: Integer);
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

class function TListModule.ListPrintAndExportDefaultSetting: Boolean;
 {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати размер шрифта, отображаемого на экране" }
//#UC START# *7C0BFDDC64B7_521DA6370197_var*
//#UC END# *7C0BFDDC64B7_521DA6370197_var*
begin
//#UC START# *7C0BFDDC64B7_521DA6370197_impl*
 !!! Needs to be implemented !!!
//#UC END# *7C0BFDDC64B7_521DA6370197_impl*
end;//TListModule.ListPrintAndExportDefaultSetting

class function TListModule.ListPrintAndExportCustomSetting: Boolean;
 {* Метод для получения значения настройки "Печать и экспорт"."Использовать для экспорта и печати следующий размер шрифта" }
//#UC START# *3BB8CB52B214_521DA6370197_var*
//#UC END# *3BB8CB52B214_521DA6370197_var*
begin
//#UC START# *3BB8CB52B214_521DA6370197_impl*
 !!! Needs to be implemented !!!
//#UC END# *3BB8CB52B214_521DA6370197_impl*
end;//TListModule.ListPrintAndExportCustomSetting

class function TListModule.ListPrintAndExportFontSizeSetting: Integer;
 {* Метод для получения значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
//#UC START# *1044DD7C8862_521DA6370197_var*
//#UC END# *1044DD7C8862_521DA6370197_var*
begin
//#UC START# *1044DD7C8862_521DA6370197_impl*
 !!! Needs to be implemented !!!
//#UC END# *1044DD7C8862_521DA6370197_impl*
end;//TListModule.ListPrintAndExportFontSizeSetting

class procedure TListModule.WriteListPrintAndExportFontSizeSetting(aValue: Integer);
 {* Метод для записи значения настройки "Использовать для экспорта и печати следующий размер шрифта" }
//#UC START# *35644933EC2C_521DA6370197_var*
//#UC END# *35644933EC2C_521DA6370197_var*
begin
//#UC START# *35644933EC2C_521DA6370197_impl*
 !!! Needs to be implemented !!!
//#UC END# *35644933EC2C_521DA6370197_impl*
end;//TListModule.WriteListPrintAndExportFontSizeSetting

end.
