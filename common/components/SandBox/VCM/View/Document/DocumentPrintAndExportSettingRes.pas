unit DocumentPrintAndExportSettingRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "DocumentPrintAndExportSettingRes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: UtilityPack::Class Shared Delphi Sand Box$UC::Document::View::Document::DocumentPrintAndExportSettingRes
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
 pi_Document_PrintAndExport = '��������/������ � �������';
  { ������������� ��������� "������ � �������" }
 pi_Document_PrintAndExport_Default = '��������/������ � �������/������������ ��� �������� � ������ ������ ������, ������������� �� ������';
  { ������������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
 pi_Document_PrintAndExport_Custom = '��������/������ � �������/������������ ��� �������� � ������ ��������� ������ ������';
  { ������������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }

var
  { ������������ ������ PrintAndExportValues }
 str_PrintAndExport_Default : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport_Default'; rValue : '������������ ��� �������� � ������ ������ ������, ������������� �� ������');
  { ������������ ��� �������� � ������ ������ ������, ������������� �� ������ }
 str_PrintAndExport_Custom : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport_Custom'; rValue : '������������ ��� �������� � ������ ��������� ������ ������');
  { ������������ ��� �������� � ������ ��������� ������ ������ }

var
  { ������������ ������ PrintAndExportName }
 str_PrintAndExport : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExport'; rValue : '������ � �������');
  { ������ � ������� }

implementation

uses
  l3MessageID
  ;


initialization
// ������������� str_PrintAndExport_Default
 str_PrintAndExport_Default.Init;
// ������������� str_PrintAndExport_Custom
 str_PrintAndExport_Custom.Init;
// ������������� str_PrintAndExport
 str_PrintAndExport.Init;

end.