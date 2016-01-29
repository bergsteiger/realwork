unit UserJournalUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/UserJournalUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UserJournal
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	IOUnit
	, BaseTypesUnit
	, DocumentUnit
	, DynamicTreeUnit
	, SearchUnit
	//#UC START# *4423F94903C8_4A7FF5F301B2_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_4A7FF5F301B2_UNIT_FOR_Stream*
	;

type

IUserJournal = interface;
{ - ��������������� �������� IUserJournal. }


// ���� ��������� ������� ������
PJournalObjectType = ^TJournalObjectType;
TJournalObjectType = (
	JOT_BOOKMARK // ��������
	, JOT_QUERY // ������
	, JOT_FOLDER // �����
);

PBookmarkJournalType = ^TBookmarkJournalType;
TBookmarkJournalType = (
	BJT_BOOKMARK // ��������
	, BJT_PHARM_BOOKMARK // �������� �������
);

// ��������� ������� ������
IUserJournal = interface (IInterface) ['{30769E5F-13F7-406E-8E2A-2D35B8BE5192}']
	function DontUseMe: Pointer;
	// �������� ������ ������ (���������� ������ remove (��� ������ ������� ������)
	procedure Clear (); stdcall;

	// ������ �������� ��������� ����
	procedure GetBookmarkHistory (
		aType: TBookmarkJournalType;
		aMaxCount: Longint;
		out aRet {: IJournalBookmarkList}
	); stdcall; // can raise ECanNotFindData

	// ������� ������ �������� ��������� ���� �� �������
	procedure GetQueryHistory (
		aQueryType: TQueryType;
		aMaxCount: Longint;
		out aRet {: IQueryList}
	); stdcall; // can raise ECanNotFindData

	// �������� ������ ������� ������
	procedure GetUserJornalTree (
		out aRet {: INodeBase}
	); stdcall;

	// ������� ������ �� ������� ������
	procedure Remove (
		const aObj: INodeBase
	); stdcall;

	// ��������� ������ � ������ ������
	procedure Save (
		const aObj: IUnknown;
		aObjectType: TJournalObjectType
	); stdcall;
end;

implementation
end.