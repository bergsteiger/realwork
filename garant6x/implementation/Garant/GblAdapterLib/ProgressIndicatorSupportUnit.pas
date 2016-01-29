unit ProgressIndicatorSupportUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/ProgressIndicatorSupportUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ProgressIndicatorSupport
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface



type

ICancelLongProcess = interface;
{ - ��������������� �������� ICancelLongProcess. }


// ��������� ��� �������� ����� ��� ���������� ��������� �� �������.
// ������ ��������������� ������������� ��������.
IProgressIndicator = interface (IInterface) ['{885E85E3-E74C-4413-8408-2FB7533E7F8A}']
	function GetMaxCount (): Longint; stdcall;

	// ��������� ��������� ����������� ��������.
	// � �������� ��������� cur_count �������� ���� ����� ��� ������������ ���������, �����������
	// ������� � ���������� ��������, ���� ����� <=100 (��� ��������� � %).
	procedure SetCurrent (
		aCurCount: Longint;
		aArg: Longint
	); stdcall;
end;

// ��������� ��� ����������� ���������� ���������� �������� �� �������. ������������ � ����������
// IProgressIndicator.
ICancelLongProcess = interface (IInterface) ['{CD915CB2-6E7A-4788-A5B0-ED90959D8399}']
	function DontUseMe: Pointer;
	// ���������� ��� ���������� ����������� ��������.
	procedure CancelProcess (); stdcall;
end;

implementation
end.