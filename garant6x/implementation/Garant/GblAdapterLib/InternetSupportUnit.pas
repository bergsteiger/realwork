unit InternetSupportUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/InternetSupportUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::InternetSupport
//
// �����������, ��������� ����� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	IOUnit
	//#UC START# *4423F94903C8_4BD132D103B9_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_4BD132D103B9_UNIT_FOR_Stream*
	;

type

IInternetSupport = interface;
{ - ��������������� �������� IInternetSupport. }

IDecisionsArchiveSupport = interface;
{ - ��������������� �������� IDecisionsArchiveSupport. }



// ��������� ������ ������������� ����� internet
IInternetSupport = interface (IInterface) ['{7DF56131-CBD6-47F5-B8B1-495409AFE6E4}']
	function DontUseMe: Pointer;
	// �������� URL ��� ��������� ���������
	procedure GetUrlForDocument (
		aDocId: Longword;
		aParaId: Longword;
		out aRet {: IString}
	); stdcall;

	// �������� URL ��� �������� ������
	procedure GetUrlForInternetVersion (
		out aRet {: IString}
	); stdcall;

	// �������� �� ��������-�����.
	function IsInternetAgentEnabled (): Bytebool; stdcall;

	// ��������� �� ������ �������� ������� ���������� (��� �������������� ������)
	function RevisionCheckEnabled (): Bytebool; stdcall;

	// ����� �� ���������� ������ �� ���������� ������ ��������
	function ShowWarning (): Bytebool; stdcall;
end;

// ��������� ������� � ������� �������� �������
IDecisionsArchiveSupport = interface (IInterface) ['{CD81011E-549D-406A-964C-9FE291552EB4}']
	function DontUseMe: Pointer;
	// ����� �������� ������� ��������
	function ArchiveAvailable (): Bytebool; stdcall;

	// �������� ������ ��� �������� �� ����� �������� �������
	procedure GetArchiveUrl (
		out aRet {: IString}
	); stdcall;

	procedure GetSearchServerUrl (
		const aQuery: IString;
		out aRet {: IString}
	); stdcall;

	// �������� ����������� ������� ������ � �������
	function SearchServerAvailable (): Bytebool; stdcall;
end;

implementation
end.