unit List_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "List_Module.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: VCMFormsPack::Class Shared Delphi Sand Box$UC::List::View::List::List
//
// ������
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
  {* ������ }
 public
 // public methods
   class function ListPrintAndExportDefaultSetting: Boolean;
     {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
   class function ListPrintAndExportCustomSetting: Boolean;
     {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }
   class function ListPrintAndExportFontSizeSetting: Integer;
     {* ����� ��� ��������� �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
   class procedure WriteListPrintAndExportFontSizeSetting(aValue: Integer);
     {* ����� ��� ������ �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
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