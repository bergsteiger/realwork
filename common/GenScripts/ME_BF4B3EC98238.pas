unit DocumentPrintAndExportSettingRes;
 {* ������� ��� ��������� "������ � �������" }

// ������: "w:\common\components\SandBox\VCM\View\Document\DocumentPrintAndExportSettingRes.pas"
// ���������: "UtilityPack"

{$Include sbDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 pi_Document_PrintAndExport = '��������/������ � �������';
  {* ������������� ��������� "������ � �������" }
 pi_Document_PrintAndExport_Default = '��������/������ � �������/������������ ��� �������� � ������ ������ ������, ������������� �� ������';
  {* ������������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
 pi_Document_PrintAndExport_Custom = '��������/������ � �������/������������ ��� �������� � ������ ��������� ������ ������';
  {* ������������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }
 {* ������������ ������ PrintAndExportValues }
 str_PrintAndExport_Default: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport_Default'; rValue : '������������ ��� �������� � ������ ������ ������, ������������� �� ������');
  {* ������������ ��� �������� � ������ ������ ������, ������������� �� ������ }
 str_PrintAndExport_Custom: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport_Custom'; rValue : '������������ ��� �������� � ������ ��������� ������ ������');
  {* ������������ ��� �������� � ������ ��������� ������ ������ }
 {* ������������ ������ PrintAndExportName }
 str_PrintAndExport: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport'; rValue : '������ � �������');
  {* ������ � ������� }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_PrintAndExport_Default.Init;
 {* ������������� str_PrintAndExport_Default }
 str_PrintAndExport_Custom.Init;
 {* ������������� str_PrintAndExport_Custom }
 str_PrintAndExport.Init;
 {* ������������� str_PrintAndExport }

end.
