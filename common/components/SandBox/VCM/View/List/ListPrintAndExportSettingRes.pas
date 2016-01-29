unit ListPrintAndExportSettingRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "ListPrintAndExportSettingRes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: UtilityPack::Class Shared Delphi Sand Box$UC::List::View::List::ListPrintAndExportSettingRes
//
// ������� ��� ��������� "������ � �������"
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
  l3StringIDEx
  ;

const
  { PrintAndExportKey }
 pi_List_PrintAndExport = '������/������ � �������';
  { ������������� ��������� "������ � �������" }
 pi_List_PrintAndExport_Default = '������/������ � �������/������������ ��� �������� � ������ ������ ������, ������������� �� ������';
  { ������������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
 pi_List_PrintAndExport_Custom = '������/������ � �������/������������ ��� �������� � ������ ��������� ������ ������';
  { ������������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }

var
  { ������������ ������ PrintAndExportName }
 str_PrintAndExport : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport'; rValue : '������ � �������');
  { ������ � ������� }

var
  { ������������ ������ PrintAndExportValues }
 str_PrintAndExport_Default : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport_Default'; rValue : '������������ ��� �������� � ������ ������ ������, ������������� �� ������');
  { ������������ ��� �������� � ������ ������ ������, ������������� �� ������ }
 str_PrintAndExport_Custom : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport_Custom'; rValue : '������������ ��� �������� � ������ ��������� ������ ������');
  { ������������ ��� �������� � ������ ��������� ������ ������ }

implementation

uses
  l3MessageID
  ;


initialization
// ������������� str_PrintAndExport
 str_PrintAndExport.Init;
// ������������� str_PrintAndExport_Default
 str_PrintAndExport_Default.Init;
// ������������� str_PrintAndExport_Custom
 str_PrintAndExport_Custom.Init;

end.