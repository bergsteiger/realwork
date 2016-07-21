unit MonitoringUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\MonitoringUnit.pas"
// ���������: "Interfaces"
// ������� ������: "Monitoring" MUID: (45EEA87E0209)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
 , DynamicDocListUnit
 , DocumentUnit
 , DynamicTreeUnit
 , SearchUnit
 , FiltersUnit
 , IOUnit
 , SearchProgressIndicatorUnit
;

type
 IMonitoringList = interface(ISearchEntity)
  {* ���������-������, ��� ���� ��� �� ������ �������� � ������������ ����� ������ �� ��������� ������. ����� ����� ��������� MonitoringList ����������� ������������� ��� � ���������, ����� ����� summary }
  ['{F6B6B6C2-1E10-41B3-8251-B37665DE05BB}']
  procedure GetSummary; stdcall;
  property Summary: 
   read GetSummary;
 end;//IMonitoringList

 IMonitoring = interface
  ['{FD231406-37D4-4C3C-A82F-592343031D3B}']
  procedure GetNewsLineRoot; stdcall;
  function IsNewsLineDefined: ByteBool; stdcall;
  function IsExist: ByteBool; stdcall;
  property NewsLineRoot: 
   read GetNewsLineRoot;
 end;//IMonitoring

implementation

uses
 l3ImplUses
;

end.
