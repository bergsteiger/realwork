unit Document_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "Document_Module.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: VCMFormsPack::Class Shared Delphi Sand Box$UC::Document::View::Document::Document
//
// ��������
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
  {* �������� }
 public
 // public methods
   class function DocumentPrintAndExportDefaultSetting: Boolean;
     {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
   class function DocumentPrintAndExportCustomSetting: Boolean;
     {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }
   class function DocumentPrintAndExportFontSizeSetting: Integer;
     {* ����� ��� ��������� �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
   class procedure WriteDocumentPrintAndExportFontSizeSetting(aValue: Integer);
     {* ����� ��� ������ �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
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