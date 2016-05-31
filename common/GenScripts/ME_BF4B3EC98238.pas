unit DocumentPrintAndExportSettingRes;
 {* ������� ��� ��������� "������ � �������" }

// ������: "w:\common\components\SandBox\VCM\View\Document\DocumentPrintAndExportSettingRes.pas"
// ���������: "UtilityPack"
// ������� ������: "DocumentPrintAndExportSettingRes" MUID: (BF4B3EC98238)

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ PrintAndExportName }
 str_PrintAndExport: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport'; rValue : '������ � �������');
  {* ������ � ������� }
 {* ������������ ������ PrintAndExportValues }
 str_PrintAndExport_Default: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport_Default'; rValue : '������������ ��� �������� � ������ ������ ������, ������������� �� ������');
  {* ������������ ��� �������� � ������ ������ ������, ������������� �� ������ }
 str_PrintAndExport_Custom: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport_Custom'; rValue : '������������ ��� �������� � ������ ��������� ������ ������');
  {* ������������ ��� �������� � ������ ��������� ������ ������ }
 pi_Document_PrintAndExport = '��������/������ � �������';
  {* ������������� ��������� "������ � �������" }
 pi_Document_PrintAndExport_Default = '��������/������ � �������/������������ ��� �������� � ������ ������ ������, ������������� �� ������';
  {* ������������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
 pi_Document_PrintAndExport_Custom = '��������/������ � �������/������������ ��� �������� � ������ ��������� ������ ������';
  {* ������������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }

implementation

uses
 l3ImplUses
;

initialization
 str_PrintAndExport.Init;
 {* ������������� str_PrintAndExport }
 str_PrintAndExport_Default.Init;
 {* ������������� str_PrintAndExport_Default }
 str_PrintAndExport_Custom.Init;
 {* ������������� str_PrintAndExport_Custom }

end.
