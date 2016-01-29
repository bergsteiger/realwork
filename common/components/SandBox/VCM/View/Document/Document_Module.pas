unit Document_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "Document_Module.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: VCMFormsPack::Class Shared Delphi Sand Box$UC::Document::View::Document::Document
//
// Документ
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
 TDocumentModule = {formspack} class(TvcmModule)
  {* Документ }
 public
 // public methods
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
  afwFacade,
  DocumentPrintAndExportSettingRes,
  DocumentPrintAndExportFontSizeSettingRes,
  stDocumentPrintAndExportFontSizeItem,
  vcmFormSetFactory {a},
  StdRes {a}
  ;

// start class TDocumentModule

class function TDocumentModule.DocumentPrintAndExportDefaultSetting: Boolean;
 {-}
begin
 if (afw.Settings = nil) then
  Result := true
 else
  Result := afw.Settings.LoadBoolean(pi_Document_PrintAndExport_Default, true);
end;//TDocumentModule.DocumentPrintAndExportDefaultSetting

class function TDocumentModule.DocumentPrintAndExportCustomSetting: Boolean;
 {-}
begin
 if (afw.Settings = nil) then
  Result := false
 else
  Result := afw.Settings.LoadBoolean(pi_Document_PrintAndExport_Custom, false);
end;//TDocumentModule.DocumentPrintAndExportCustomSetting

class function TDocumentModule.DocumentPrintAndExportFontSizeSetting: Integer;
 {-}
begin
 if (afw.Settings = nil) then
  Result := dv_Document_PrintAndExportFontSize
 else
  Result := afw.Settings.LoadInteger(pi_Document_PrintAndExportFontSize, dv_Document_PrintAndExportFontSize);
end;//TDocumentModule.DocumentPrintAndExportFontSizeSetting

class procedure TDocumentModule.WriteDocumentPrintAndExportFontSizeSetting(aValue: Integer);
 {-}
begin
 if (afw.Settings <> nil) then
  afw.Settings.SaveInteger(pi_Document_PrintAndExportFontSize, aValue);
end;//TDocumentModule.WriteDocumentPrintAndExportFontSizeSetting

end.