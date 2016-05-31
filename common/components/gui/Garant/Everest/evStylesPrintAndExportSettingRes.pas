unit evStylesPrintAndExportSettingRes;
 {* ������� ��� ��������� "������ � �������" }

// ������: "w:\common\components\gui\Garant\Everest\evStylesPrintAndExportSettingRes.pas"
// ���������: "UtilityPack"
// ������� ������: "evStylesPrintAndExportSettingRes" MUID: (870F97A58415)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

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
 pi_evStyles_PrintAndExport = '�����/������ � �������';
  {* ������������� ��������� "������ � �������" }
 pi_evStyles_PrintAndExport_Default = '�����/������ � �������/������������ ��� �������� � ������ ������ ������, ������������� �� ������';
  {* ������������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
 pi_evStyles_PrintAndExport_Custom = '�����/������ � �������/������������ ��� �������� � ������ ��������� ������ ������';
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
