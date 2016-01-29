unit VCMSandBoxRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "VCMSandBoxRes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: VCMApplication::Class Shared Delphi Sand Box$App::VCMSandBox::VCMSandBox
//
// Тестовое приложение VCM
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\VCM\sbDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmApplication
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx,
  vcmInterfaces {a},
  vcmExternalInterfaces {a},
  vcmMainForm {a}
  ;

var
 { Локализуемые строки Local }
str_VCMSandBoxTitle : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'VCMSandBoxTitle'; rValue : 'Тестовое приложение VCM');
 { 'Тестовое приложение VCM' }

type
TVCMSandBoxRes = {final} class(TvcmApplication)
 {* Тестовое приложение VCM }
protected
   procedure RegisterFormSetFactories; override;
   class procedure RegisterModules(aMain: TvcmMainForm); override;
   procedure Loaded; override;
 public
 // modules operations
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
TvcmApplicationRef = TVCMSandBoxRes;
 {* Ссылка на приложение для DesignTime редакторов }


implementation

uses
  moDocument,
  moList,
  l3MessageID,
  evExtFormat
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  Document_Module,
  List_Module
  ;

// start class TVCMSandBoxRes

procedure TVCMSandBoxRes.RegisterFormSetFactories;
begin
 inherited;
end;

class procedure TVCMSandBoxRes.RegisterModules(aMain: TvcmMainForm);
begin
 inherited;
 aMain.RegisterModule(Tmo_Document);
 aMain.RegisterModule(Tmo_List);
end;

procedure TVCMSandBoxRes.Loaded;
begin
 inherited;
 PublishModule(Tmo_Document, 'Документ');
 PublishModule(Tmo_List, 'Список');
end;

// modules operations

class function TVCMSandBoxRes.DocumentPrintAndExportDefaultSetting: Boolean;
begin
 Result := TDocumentModule.DocumentPrintAndExportDefaultSetting;
end;

class function TVCMSandBoxRes.DocumentPrintAndExportCustomSetting: Boolean;
begin
 Result := TDocumentModule.DocumentPrintAndExportCustomSetting;
end;

class function TVCMSandBoxRes.DocumentPrintAndExportFontSizeSetting: Integer;
begin
 Result := TDocumentModule.DocumentPrintAndExportFontSizeSetting;
end;

class procedure TVCMSandBoxRes.WriteDocumentPrintAndExportFontSizeSetting(aValue: Integer);
begin
 TDocumentModule.WriteDocumentPrintAndExportFontSizeSetting(aValue);
end;

class function TVCMSandBoxRes.ListPrintAndExportDefaultSetting: Boolean;
begin
 Result := TListModule.ListPrintAndExportDefaultSetting;
end;

class function TVCMSandBoxRes.ListPrintAndExportCustomSetting: Boolean;
begin
 Result := TListModule.ListPrintAndExportCustomSetting;
end;

class function TVCMSandBoxRes.ListPrintAndExportFontSizeSetting: Integer;
begin
 Result := TListModule.ListPrintAndExportFontSizeSetting;
end;

class procedure TVCMSandBoxRes.WriteListPrintAndExportFontSizeSetting(aValue: Integer);
begin
 TListModule.WriteListPrintAndExportFontSizeSetting(aValue);
end;

initialization
// Инициализация str_VCMSandBoxTitle
 str_VCMSandBoxTitle.Init;

end.