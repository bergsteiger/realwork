unit VCMSandBoxRes;
 {* �������� ���������� VCM }

// ������: "w:\common\components\SandBox\VCM\VCMSandBoxRes.pas"
// ���������: "VCMApplication"
// ������� ������: "VCMSandBox" MUID: (521649770277)
// ��� ����: "TVCMSandBoxRes"

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ Local }
 str_VCMSandBoxTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'VCMSandBoxTitle'; rValue : '�������� ���������� VCM');
  {* '�������� ���������� VCM' }

type
 TVCMSandBoxRes = {final} class
  {* �������� ���������� VCM }
  public
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
 {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
begin
 Result := TDocumentModule.DocumentPrintAndExportDefaultSetting;
end;//TVCMSandBoxRes.DocumentPrintAndExportDefaultSetting

class function TVCMSandBoxRes.DocumentPrintAndExportCustomSetting: Boolean;
 {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }
begin
 Result := TDocumentModule.DocumentPrintAndExportCustomSetting;
end;//TVCMSandBoxRes.DocumentPrintAndExportCustomSetting

class function TVCMSandBoxRes.DocumentPrintAndExportFontSizeSetting: Integer;
 {* ����� ��� ��������� �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
begin
 Result := TDocumentModule.DocumentPrintAndExportFontSizeSetting;
end;//TVCMSandBoxRes.DocumentPrintAndExportFontSizeSetting

class procedure TVCMSandBoxRes.WriteDocumentPrintAndExportFontSizeSetting(aValue: Integer);
 {* ����� ��� ������ �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
begin
 TDocumentModule.WriteDocumentPrintAndExportFontSizeSetting(aValue);
end;//TVCMSandBoxRes.WriteDocumentPrintAndExportFontSizeSetting

class function TVCMSandBoxRes.ListPrintAndExportDefaultSetting: Boolean;
 {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
begin
 Result := TListModule.ListPrintAndExportDefaultSetting;
end;//TVCMSandBoxRes.ListPrintAndExportDefaultSetting

class function TVCMSandBoxRes.ListPrintAndExportCustomSetting: Boolean;
 {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }
begin
 Result := TListModule.ListPrintAndExportCustomSetting;
end;//TVCMSandBoxRes.ListPrintAndExportCustomSetting

class function TVCMSandBoxRes.ListPrintAndExportFontSizeSetting: Integer;
 {* ����� ��� ��������� �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
begin
 Result := TListModule.ListPrintAndExportFontSizeSetting;
end;//TVCMSandBoxRes.ListPrintAndExportFontSizeSetting

class procedure TVCMSandBoxRes.WriteListPrintAndExportFontSizeSetting(aValue: Integer);
 {* ����� ��� ������ �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
begin
 TListModule.WriteListPrintAndExportFontSizeSetting(aValue);
end;//TVCMSandBoxRes.WriteListPrintAndExportFontSizeSetting

initialization
 str_VCMSandBoxTitle.Init;
 {* ������������� str_VCMSandBoxTitle }

end.
