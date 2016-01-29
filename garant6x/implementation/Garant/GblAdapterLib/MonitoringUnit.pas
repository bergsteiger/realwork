unit MonitoringUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/MonitoringUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Monitoring
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	BaseTypesUnit
	, DynamicDocListUnit
	, DocumentUnit
	, DynamicTreeUnit
	, SearchUnit
	;

type

IMonitoringList = interface;
{ - ��������������� �������� IMonitoringList. }

IMonitoring = interface;
{ - ��������������� �������� IMonitoring. }



// ���������-������, ��� ���� ��� �� ������ �������� � ������������ ����� ������ �� ���������
// ������. ����� ����� ��������� MonitoringList ����������� ������������� ��� � ���������, �����
// ����� summary
IMonitoringList = interface (IDynList) ['{F6B6B6C2-1E10-41B3-8251-B37665DE05BB}']
	procedure GetSummary (out aRet {: IDocument}); stdcall;
end;

IMonitoring = interface (IInterface) ['{FD231406-37D4-4C3C-A82F-592343031D3B}']
	function DontUseMe: Pointer;
	function IsExist (): Bytebool; stdcall;

	function IsNewsLineDefined (): Bytebool; stdcall;

	procedure GetNewsLineRoot (out aRet {: INodeBase}); stdcall;
end;

implementation
end.