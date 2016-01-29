unit FoldersUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/FoldersUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Folders
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	IOUnit
	, BaseTypesUnit
	, BaseTreeSupportUnit
	, FiltersUnit
	, UnderControlUnit
	//#UC START# *4423F94903C8_4570501E037A_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_4570501E037A_UNIT_FOR_Stream*
	;

type

IFoldersNode = interface;
{ - ��������������� �������� IFoldersNode. }

IFolders = interface;
{ - ��������������� �������� IFolders. }

IFolder = interface;
{ - ��������������� �������� IFolder. }


// ��� �������� ����
PFolderId = ^TFolderId;
TFolderId = Longword;

// ������ ��������� �����.
PNotifyStatus = ^TNotifyStatus;
TNotifyStatus = (
	NS_NODE // �������� ��������� �����. �������� ��� ��������/��������� ���� �� �������� �����.
	, NS_CONTENT // �������� ���������� �����, �������� ��� �����, �����������, ����, � �.�.
);

IDoneNotifier = interface (IInterface) ['{B9089580-C0F0-43C8-B449-B2AA3A0D4FFF}']
	function DontUseMe: Pointer;
	function Done (): Bytebool; stdcall;
end;

// �������� object_type ���  �������� FolderNode.
PFoldersItemType = ^TFoldersItemType;
TFoldersItemType = (
	FIT_BOOKMARK // ��������� Bookamark
	, FIT_LIST // ��������� List
	, FIT_QUERY // ��������� Query
	, FIT_FOLDER // ������������ ������� (�����)
	, FIT_CONSULTATION // ������������
	, FIT_PHARM_LIST // ������ ���. ����������
	, FIT_PHARM_BOOKMARK // �������� �� ���. ��������
	, FIT_OLD_HISTORY // ������ �� ������ ������ ������
);

// ������ ����������� �� ��������� �����.
PNotifyData = ^TNotifyData;
TNotifyData = packed record
	rStatus: TNotifyStatus; // ������ ���������.
	rDoneNotifier: IDoneNotifier;
	rFolder: IFoldersNode;
end;

// ��������� ����������� ��������� ��������� �����.
IExternalFoldersChangeNotifier = interface (IInterface) ['{9AFA9214-42F7-439F-97DB-EB7827289CE0}']
	// ��������� ��������� �����. ��� ���� ���������� ���������� ������ ���������������� ����������
	// �����, �������� ����������� ��������� �������� �����.
	procedure Fire (
		const aData: TNotifyData
	); stdcall;
end;

// ������������������ ���� ��� �����. ������ �������������� ������� "���� ��������".
// �������� Caption � Hint �������������� �� Node ����������� ����� ��� �������� � ����������������
// ����������� ��������������.
// � �������� BaseEntity ���� ����� ��������� �������� �� ��������, ������, ������ ��� ����������
// ���� (Folder). ����� � ����� ���� ��������� (����� ����) ���������� ��� �������� � ����, ������
// ����� ����� ��������� ���������� (�.�. ��������� ����� ���� �� ������ �� ����� ��������� �����
// �������� ������������ � ���).
IFoldersNode = interface (INode) ['{6B1E4393-7BE4-4201-A8F9-D3C817C440B5}']
	// ��������� ����� �� � ���� ��������� ������ �� xml.
	function CanLoadFromXml (): Bytebool; stdcall;

	// ��������� ����� �� ������������ ���� ��������� � xml.
	function CanSaveConsultationToXml (): Bytebool; stdcall;

	// ����� �� ���� ���� ��������� ��� ���������� ����������
	function CanSaveToIntegrationXml (): Bytebool; stdcall;

	// ��������� ����� �� ���� ���� ��������� � xml.
	function CanSaveToXml (): Bytebool; stdcall;

	// ���� ��������
	procedure GetCreationDate (out a: TDate); stdcall;

	// ������� ����
	function GetId (): TFolderId; stdcall;

	// ��������� ���������� �� xml � ����� (������, �������������).
	procedure LoadFromXml (
		const aXmlFilePath: PAnsiChar
	); stdcall; // can raise EAccessDenied, EInvalidEntityType

	// ��������� ���������� � ��������, �������������� �������� ����� ������������ � xml.
	procedure SaveConsultationToXml (
		const aXmlFilePath: PAnsiChar
	); stdcall;

	// ��������� ���� ��� ���������� ����������
	procedure SaveToIntegrationXml (
		out aRet {: IString}
	); stdcall; // can raise EInvalidEntityType

	procedure SaveToXml (
		const aXmlFilePath: PAnsiChar
	); stdcall; // can raise EAccessDenied, EInvalidEntityType
end;

// ��������� (��������) �������������� ������ � ������� �����. ������ �������� ��� ����� (Folder).
IFolders = interface (IBaseCatalog) ['{085870DB-A1B6-48E7-ADDD-3C9F3911FEF5}']
	// ������� �����, ���������� ����� ��������� ��������� BaseEntity ���� Folder.
	procedure CreateFolder (
		out aRet {: IFolder}
	); stdcall;

	// ����� ���� ����� �� ��� ��������������. ���� �� ������ �� CanNotFindData.
	procedure FindFolderNode (
		aId: TFolderId;
		out aRet {: IFoldersNode}
	); stdcall;
end;

// ���������� BaseEntity ����������� ������� ������� ����� �����.
IFolder = interface (INamedElement) ['{4B736A91-FDC7-4F00-B445-9C91CE120AB9}']
	// ����� �� ��������� �����
	function CanShare (): Bytebool; stdcall;

	// ��� ������� ������.
	// ������� ���� ��� ����� �������� ������� (�.�. �� ����������� � ������������� �������
	// ������������).
	function GetExternal (): Bytebool; stdcall;

	// ��� ������� ������. ������� ���� ��� ����� �������� �������������, �.� ������� ������
	// �������������.
	// ����. ������� ����� ����� �������� ��������������.
	// ��� ������� �������� ������ ������� � ������� ����� ������������ ���������� ConstantModify.
	function GetShared (): Bytebool; stdcall;
	procedure SetShared (aShared: Bytebool); stdcall;
end;

const

 { �������� flags ���  �������� FoldersNode. }
	NF_CONTROLLED = Longword(1);
 { ����������� ������� ����� �� ��������. }
	NF_SHARED = Longword(2);
 { �������� �� ���� ���� (���� �����). }
	NF_EXTERNAL = Longword(4);
 { ������� ����. }
	NF_IN_SHARED = Longword(8);
 { ���������� �� ���� ���� � ������� �����. }
	NF_HAS_SHARED = Longword(16);
 { ���� �� � ���� ���� (���� �����) �������� �����. }
	NF_COMMENTS = Longword(32);
 { ����� ��� ����������� }
	NF_IN_COMMENTS = Longword(64);
 { ������� ������ ����� ��� ����������� }
	NF_COMMON = Longword(128);
 { ����� ����� }
	NF_USER = Longword(256);
 { ����� ������ ����� ����� (�� ������ �������������) }
	NF_MY_DOCUMENTS = Longword(512);
 { ����� ��� ��������� }
	NF_MY_CONSULTATIONS = Longword(1024);
 { ����� ��� ������������ }
	NF_FOLDER_SENT = Longword(2048);
 { ����� ��� ������������/������� � ��������� }
	NF_FOLDER_RECEIVED = Longword(4096);
 { ����� ��� ������������/������ }
	NF_CONSULTATION_SENT = Longword(8192);
 { ������������ �� �������� CS_SENT }
	NF_PAYMENT_REQUEST = Longword(16384);
 { ������������ �� �������� CS_PAYMAND_REQUEST (��������� ������) }
	NF_ANSWER_RECEIVED = Longword(32768);
 { ������������ �� �������� CS_ANSWER_RECEIVED (������� �����) }
	NF_ANSWER_READ = Longword(65536);
 { ������������ �� �������� CS_ANSWER_READ (����� ��������) }
	NF_ESTIMATION_SENT = Longword(131072);
 { ������������ �� �������� CS_ESTIMATION_SENT (���������� ������) }
	NF_FOLDER_DRAFTS = Longword(262144);
 { ����� ��� ������������/��������� ������� }
	NF_FOLDER_PAYMENT_REFUSAL = Longword(524288);
 { ����� ��� ������������/���������������� }
	NF_DRAFTS = Longword(1048576);
 { ������������ �� �������� CS_DRAFTS (���������, �� ��� �� ������������ ������������) }
	NF_PAYMENT_REFUSAL = Longword(2097152);
 { ������������ �� �������� CS_PAYMENT_REFUSAL (������������ � ���������������� �������) }
	NF_PAYMENT_CONFIRM = Longword(4194304);
 { ������������ �� �������� CS_PAYMENT_CONFIRM (������������ � �������������� �������) }
	NF_VALIDATION_FAILED = Longword(8388608);
 { ������������ �� �������� CS_VALIDATION_FAILED (������������ �� ����������, ��� ��� ���� ��������������) }

implementation
end.