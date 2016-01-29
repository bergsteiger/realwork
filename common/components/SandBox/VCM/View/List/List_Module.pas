unit List_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "List_Module.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: VCMFormsPack::Class Shared Delphi Sand Box$UC::List::View::List::List
//
// Список
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmModule {a}
  ;

type
 TListModule = {formspack} class(TvcmModule)
  {* Список }
 public
 // public methods
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
  afwFacade,
  ListPrintAndExportSettingRes,
  ListPrintAndExportFontSizeSettingRes,
  stListPrintAndExportFontSizeItem,
  vcmFormSetFactory {a},
  StdRes {a}
  ;

// start class TListModule

class function TListModule.ListPrintAndExportDefaultSetting: Boolean;
 {-}
begin
 if (afw.Settings = nil) then
  Result := true
 else
  Result := afw.Settings.LoadBoolean(pi_List_PrintAndExport_Default, true);
end;//TListModule.ListPrintAndExportDefaultSetting

class function TListModule.ListPrintAndExportCustomSetting: Boolean;
 {-}
begin
 if (afw.Settings = nil) then
  Result := false
 else
  Result := afw.Settings.LoadBoolean(pi_List_PrintAndExport_Custom, false);
end;//TListModule.ListPrintAndExportCustomSetting

class function TListModule.ListPrintAndExportFontSizeSetting: Integer;
 {-}
begin
 if (afw.Settings = nil) then
  Result := dv_List_PrintAndExportFontSize
 else
  Result := afw.Settings.LoadInteger(pi_List_PrintAndExportFontSize, dv_List_PrintAndExportFontSize);
end;//TListModule.ListPrintAndExportFontSizeSetting

class procedure TListModule.WriteListPrintAndExportFontSizeSetting(aValue: Integer);
 {-}
begin
 if (afw.Settings <> nil) then
  afw.Settings.SaveInteger(pi_List_PrintAndExportFontSize, aValue);
end;//TListModule.WriteListPrintAndExportFontSizeSetting

end.