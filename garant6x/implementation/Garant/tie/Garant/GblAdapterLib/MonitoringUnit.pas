unit MonitoringUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/MonitoringUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Monitoring
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTypesUnit,
  DynamicDocListUnit,
  DocumentUnit,
  DynamicTreeUnit,
  SearchUnit,
  IOUnit,
  FiltersUnit,
  SearchProgressIndicatorUnit
  ;

type
 IMonitoringList = interface(ISearchEntity{, IDynList})
  {* ���������-������, ��� ���� ��� �� ������ �������� � ������������ ����� ������ �� ��������� ������. ����� ����� ��������� MonitoringList ����������� ������������� ��� � ���������, ����� ����� summary }
   ['{F6B6B6C2-1E10-41B3-8251-B37665DE05BB}']
   function GetSummary: IDocument; stdcall;
   property summary: IDocument
     read GetSummary;
 end;//IMonitoringList

 IMonitoring = interface(IUnknown)
   ['{FD231406-37D4-4C3C-A82F-592343031D3B}']
   function GetNewsLineRoot: INodeBase; stdcall;
   function IsNewsLineDefined: ByteBool; stdcall;
   function IsExist: ByteBool; stdcall;
   property news_line_root: INodeBase
     read GetNewsLineRoot;
 end;//IMonitoring

implementation

end.