unit VCMSandBoxRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "VCMSandBoxRes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: VCMApplication::Class Shared Delphi Sand Box$App::VCMSandBox::VCMSandBox
//
// �������� ���������� VCM
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
 { ������������ ������ Local }
str_VCMSandBoxTitle : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'VCMSandBoxTitle'; rValue : '�������� ���������� VCM');
 { '�������� ���������� VCM' }

type
TVCMSandBoxRes = {final} class(TvcmApplication)
 {* �������� ���������� VCM }
protected
   procedure RegisterFormSetFactories; override;
   class procedure RegisterModules(aMain: TvcmMainForm); override;
   procedure Loaded; override;
 public
 // modules operations
   class function DocumentPrintAndExportDefaultSetting: Boolean;
     {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
   class function DocumentPrintAndExportCustomSetting: Boolean;
     {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }
   class function DocumentPrintAndExportFontSizeSetting: Integer;
     {* ����� ��� ��������� �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
   class procedure WriteDocumentPrintAndExportFontSizeSetting(aValue: Integer);
     {* ����� ��� ������ �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
   class function ListPrintAndExportDefaultSetting: Boolean;
     {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
   class function ListPrintAndExportCustomSetting: Boolean;
     {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }
   class function ListPrintAndExportFontSizeSetting: Integer;
     {* ����� ��� ��������� �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
   class procedure WriteListPrintAndExportFontSizeSetting(aValue: Integer);
     {* ����� ��� ������ �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
end;//TVCMSandBoxRes
TvcmApplicationRef = TVCMSandBoxRes;
 {* ������ �� ���������� ��� DesignTime ���������� }


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
 PublishModule(Tmo_Document, '��������');
 PublishModule(Tmo_List, '������');
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
// ������������� str_VCMSandBoxTitle
 str_VCMSandBoxTitle.Init;

end.