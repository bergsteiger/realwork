unit BaseTypesUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTypesUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTypes
//
// ������� ����, ������������ � ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	//#UC START# *4423F94903C8_456EA56002BF_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_456EA56002BF_UNIT_FOR_Stream*
	;

type

INamedElement = interface;
{ - ��������������� �������� INamedElement. }

IEntityStorage = interface;
{ - ��������������� �������� IEntityStorage. }

IEntityBase = interface;
{ - ��������������� �������� IEntityBase. }

ISearchEntity = interface;
{ - ��������������� �������� ISearchEntity. }

IVariant = interface;
{ - ��������������� �������� IVariant. }

ILanguagesList = interface;
{ - ��������������� �������� ILanguagesList. }

IStringList = interface;
{ - ��������������� �������� IStringList. }


// ������������� ������ �������
PClassId = ^TClassId;
TClassId = Longword;

// ������������� ������� ������ ������
PObjectId = ^TObjectId;
TObjectId = Longword;

// Persistent ID, ��� ��� ������������� �������� ��������.
PPId = ^TPId;
TPId = packed record
	rClassId: TClassId; // ������������� ������
	rObjectId: TObjectId; // ������������� �������
end;

// ����.
PDate = ^TDate;
TDate = packed record
	rDay: Word; // �����
	rMonth: Word; // �����
	rYear: Word; // ���.
end;

// �������� ��� (����������).
PDateInterval = ^TDateInterval;
TDateInterval = packed record
	rStart: TDate; // ��������� ����
	rFinish: TDate; // ����������� ����
end;

// �����
PTime = ^TTime;
TTime = packed record
	rHour: Word; // ����
	rMin: Word; // ������
	rSec: Word; // �������
end;

// ���� � �����
PDateTime = ^TDateTime;
TDateTime = packed record
	rDate: TDate; // ����
	rTime: TTime; // �����
end;

// �����
PLanguages = ^TLanguages;
TLanguages = (
	LG_RUSSIAN // �������
	, LG_ENGLISH // ����������
	, LG_FRENCH // �����������
	, LG_GERMAN // ��������
	, LG_SPANISH // ���������
	, LG_ITALIAN // �����������
);

// ���������� ��������� ��� ������� �������� ����������� ���������.
EConstantModify = class (Exception);

// ������������ � ������ ��������� ���� �������.
EAccessDenied = class (Exception);

// ���������� ������������ � ������ ���� ����������� �������� �� ����� ���� ��������� �� ������, ��
// ������� �������� ����� �������������. �������� ���������� ��������� �����.
EInvalidTimeStamp = class (Exception);

// ���� �����������
EStorageLocked = class (Exception);

// ������������ � ������ ���� ��������� �������� �� �������������� ��������.
EUnsupported = class (Exception);

// ������������ ��� ������� ���������/������������ ��������� � ������������� (�.� �� ����������� �
// ����� ��������, �������� � ������) �������
ENotSaved = class (Exception);

// ����� ����������.
// ������������ � ������, ���� � ������������ ��� ������� � ������.
EFoldersNotAvailable = class (Exception);

// ����������� ������ �� �������.
// ������������ � ������, ���� ������ ����������� �� �������� get_<something> �����������.
ECanNotFindData = class (Exception);

// ��������� � ������ ���������� ���� � ������, ��� ��� ���� ����� �� ����. ��� ���� ������������
// ������������ ����� �����.
EDuplicateNode = class (Exception);

// ������ ��� ������
EInvalidType = class (Exception);

// ������ �� ����� ���� �������
ECanNotSave = class (Exception);

// ������ ��� ������� XML
EInvalidXMLType = class (Exception);

// �� ���������� �������������, ��� ������������ ������-������
EAllContentIsFiltered = class (Exception);

// ����� ������� ��������
PCodePage = ^TCodePage;
TCodePage = Smallint;

// ������������ ��� �������� �� ��������� ������ � ������, ���� ��������� ���������� ������, � ���
// ���������� ������� ������������ ������.
EEmptyResult = class (Exception);

// ������ ��������.
PItemStatus = ^TItemStatus;
TItemStatus = (
	IS_ABOLISHED // ������� ����
	, IS_ACTIVE // �����������
	, IS_PREACTIVE // �� ������� � ����
	, IS_UNKNOWN // �����������
);

// ��������� ���� ��������� ��������� ����.
PNavigatorMenuItemType = ^TNavigatorMenuItemType;
TNavigatorMenuItemType = (
	NM_FOLDER // ������������� - �����.
	, NM_RUBRICATOR // ��������� �� ��������������.
	, NM_ATTRIBUTE_SEARCH // ����� �� ���������.
	, NM_SITUATION_SEARCH // ����� �� ��������.
	, NM_PUBLISH_SOURCE_SEARCH // ����� �� ��������� �������������.
	, NM_SINGLE_CONTEXT_SEARCH // ��������� (�������) ����� �� ���������.
	, NM_SINGLE_ATTRIBUTE_SEARCH // ��������� (�������) ����� �� ������������ ��������.
	, NM_SINGLE_DATE_NUMBER_SEARCH // ��������� (�������) ����� �� ���� � ������.
	, NM_FILTER_5X // �������� ������� �-�� ������ 5.�.
	, NM_ATTRIBUTE_SEARCH_5X // �������� ������ �� ��������� �-�� ������ 5.�.
	, NM_SITUATION_SEARCH_5X // �������� ������ �� ��������� �-�� ������ 5.�.
	, NM_UPDATE // ����������.
	, NM_CONFIGURATION_LIST // ������ ������������.
	, NM_LIST // ������.
	, NM_COMPLECT_INFO // ���������� � ���������.
	, NM_DOCUMENT // ��������
	, NM_LAW_NAVIGATOR_FOLDER // ����� "�������� ���������"
	, NM_BUSINESS_INFO_FOLDER // ����� "���������� ����������"
	, NM_SEARCH_FOLDER // ����� "�����"
	, NM_UPDATE_FOLDER // ����� "����������"
	, NM_RECENTLY_DOCUMENTS_FOLDER // ����� "��������� �������� ���������"
	, NM_EXPLANATORY_DICTIONARY // �������� �������
	, NM_NEW_DOCS // ����� ���������
	, NM_PRIME_FOLDER // ����� ���� �����
	, NM_REVIEW // ����� ���� ������ ����������������
	, NM_NEWS_LINE // �����������
	, NM_SEARCH_WITH_LAW_SUPPORT // ����� ����: ����� � �������� ����������
	, NM_LAW_SUPPORT // ����� ����: �������� ���������
	, NM_CALENDAR
	, NM_BUSINESS_REFERENCES
	, NM_HOT_INFORMATION
	, NM_CODEX // �������
	, NM_FORMS // ����� ���������
	, NM_MONITORINGS // �����������
	, NM_PHARM_SEARCH // ����� � �������
	, NM_INPHARM // ������
	, NM_PHARM_LEK // ������������� ���������
	, NM_PHARM_FIRMS // ����� �������������
	, NM_PHARM_DICT // ������� ����������� ��������
	, NM_PHARM_BASIC_SECTION // �������� ������� �����������
	, NM_TAXES_AND_FINANCE // ������ � �������
	, NM_BUSINESS_REFERENCES_FOLDER // ����� ������-�������
	, NM_LEGAL_ISSUES // ����������� �������
	, NM_HR // �������� � �����
	, NM_BUDGET_ORGS // ���. � ������������� ����������
	, NM_LAW_FOR_ALL // ����� ��� ����
);

// ��� ���������� ������
PSearchResultType = ^TSearchResultType;
TSearchResultType = (
	SRT_DOCUMENT_LIST // ������ ������ ����������
	, SRT_AUTOREFERAT // ������ �����������
	, SRT_CONSULTATION // ������� ������������
);

// ����������� ����������.
PSortOrder = ^TSortOrder;
TSortOrder = (
	SO_ASCENDING // �� ����������� ��������.
	, SO_DESCENDING // �� �������� ��������.
);

// ��� ����������.
PSortType = ^TSortType;
TSortType = (
	ST_PRIORITY // ���������� �� ����������� ����
	, ST_CREATE_DATE // ���������� �� ���� ��������
	, ST_LAST_EDIT_DATE // ���������� �� ���� ���������� ���������
	, ST_NOT_SORTED // �� ������������
	, ST_RELEVANCE // ���������� �� �������������
);

// ��������� ����������.
PSortParams = ^TSortParams;
TSortParams = packed record
	rSortOrder: TSortOrder; // ������� ����������
	rSortType: TSortType; // ��� �����������
end;

// ���� ������ �� ���������
PTextSearchOptionType = ^TTextSearchOptionType;
TTextSearchOptionType = (
	TSO_TEXT // ����� �� ������
	, TSO_NAME // ����� �� ���������
	, TSO_PARA // ����� �� ���������
	, TSO_SENTENCE // ����� �� �����������
);

// ��������� ��������� ������ ��� ��������� � ����
EInternalDatabaseError = class (Exception);

// ������������� �� �������, ������� ����� ��������� ������ � ��������� ������, �.�. ����� ������
ENoSession = class (Exception);

// ������� � ����� ������ ��� ����������, � ��� � ����� ��������� ������
EDuplicateName = class (Exception);

// ������������� ������������ ��� ������
PUid = ^TUid;
TUid = Longint;

PListNodeType = ^TListNodeType;
TListNodeType = (
	LNT_SUB // ���
	, LNT_PARA // ��������
	, LNT_EXTERNAL_OBJECT // ������, ����������� �� ������� ����������
	, LNT_EXTERNAL_LINK
	, LNT_DOCUMENT_ABOLISHED // ���������� ���� ��������
	, LNT_DOCUMENT_ACTIVE // ��������
	, LNT_DOCUMENT_PREACTIVE // �� ���������� � ���� ��������
	, LNT_DOCUMENT_UNKNOWN // ����������� ���
	, LNT_EDITION_ABOLISHED // ���������� ���� ��������
	, LNT_EDITION_ACTIVE // ���������� ��������
	, LNT_EDITION_PREACTIVE // ��������, ������� ��� �� ���������
	, LNT_EDITION_UNKNOWN // ����������� ��� ��������
	, LNT_EDITIONS_GROUP // ���� ��������
	, LNT_BLOCK // ����
	, LNT_DRUG_ANNULED // �������� �����������
	, LNT_DRUG_NARCOTIC // ������������� ��������
	, LNT_DRUG_NONANNULED_NONNARCOTIC // ����������� ��������������� ��������
	, LNT_FORM_ANNULED // �������������� ����� ���������
	, LNT_FORM_RUSSIAN_IMPORTANT // �������������� ���������� ��������
	, LNT_FORM_NONRUSSIAN_IMPORTANT // �������������� ����������� ��������
	, LNT_FORM_RUSSIAN_NONIMPORTANT // ���������� ��������
	, LNT_FORM_NONRUSSIAN_NONIMPORTANT // ����������� ��������
	, LNT_FIRM // �����
	, LNT_AAK // �������� ���
);

// ��� ������ ����, �.�. ���� �������� � ������� ActiveX � ��� ObjectId � ������ Document
PBaseTypesObjectId = ^TBaseTypesObjectId;
TBaseTypesObjectId = TObjectId;

// ����������� �������.
INamedElement = interface (IInterface) ['{E6AAFF18-FAD7-4E46-A586-CEEC45905094}']
	function DontUseMe: Pointer;
	// �����������
	procedure GetComment (out aRet {: IString}); stdcall;
	procedure SetComment (const aComment: IString); stdcall;

	// ���
	procedure GetName (out aRet {: IString}); stdcall;
	procedure SetName (const aName: IString); stdcall;
end;

// ��������� ���������
IEntityStorage = interface (IInterface) ['{D4613491-81A1-4AD8-B51E-95923E4DA97A}']
	function DontUseMe: Pointer;

end;

// ������� ����������� ��������� ��� ���������. ������ ��������� ������ �������� �����������
// BaseTreeSupport::BaseEntity .
IEntityBase = interface (IInterface) ['{AC2E64E2-18A5-4F4A-B16F-A186B4F6BB37}']
	function DontUseMe: Pointer;
	// ��������� � ����  ���������� ��������� �������.
	// ��������� � � ����� ������������ �������
	procedure AppendTo (
		const aStorage: IEntityStorage;
		out aRet {: IEntityStorage}
	); stdcall; // can raise EConstantModify, EAccessDenied, EUnsupported, ECanNotSave

	// �������������
	function GetEid (): Longword; stdcall;

	// �������� �����������
	function GetIsChanged (): Bytebool; stdcall;

	// ������� ���� ��� ������ ������ ��� �������� � ���� ������. ��� �� ����������� ������� �������
	// ���������� ������� ����� �������� (���� ����� �����). ��� �� ����������� �������� �������� save
	// ������ ����������.
	function GetIsSaved (): Bytebool; stdcall;

	// ������������ �������� ������� ���������.
	procedure SaveTo (
		const aStorage: IEntityStorage;
		out aRet {: IEntityStorage}
	); stdcall; // can raise EAccessDenied, EUnsupported, ENotSaved, EDuplicateNode, ECanNotSave
end;

// ��������, ������������ � ����� finish_process �� �������� ����������, ��� ��������� ������
ISearchEntity = interface (IInterface) ['{8299FB1B-C061-4407-84D9-AF61A0E35754}']
	function DontUseMe: Pointer;
	// ���������� ��������� ����������
	function GetDocumentCount (): Cardinal; stdcall;

	// ���������� ��������
	function GetEditionCount (): Cardinal; stdcall;

	// ���������� ���������
	function GetEntryCount (): Cardinal; stdcall;

	// ��� ���������� ������ (������, �����������, ������������)
	function GetResultType (): TSearchResultType; stdcall;
end;

// ��� ������ ��� �����������
IVariant = interface (IInterface) ['{0B872568-888B-4CC1-B7ED-D0E555EDA7B7}']
	function DontUseMe: Pointer;
	// ������� ������ ��������
	function GetBool (): Bytebool; stdcall; // can raise EInvalidType

	// ������� �����
	function GetLong (): Longint; stdcall; // can raise EInvalidType

	// ������� ������
	procedure GetObject (
		out aRet {: IUnknown}
	); stdcall; // can raise EInvalidType

	// ������� ������
	procedure GetString (
		out aRet {: IString}
	); stdcall; // can raise EInvalidType
end;

ILanguagesList = interface(IInterface)
['{47BCBDD9-CFDB-45E8-9F95-F36B63C7D91B}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    function  pm_GetItem(anIndex: Integer): TLanguages; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TLanguages); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TLanguages): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TLanguages); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
  // public properties
    property  Items[anIndex: Integer]: TLanguages
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - �������� ������. }
end;//ILanguagesList

IStringList = interface(IInterface)
['{A315F0A6-6BEE-4779-936A-D3E119E97C7D}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: IString); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IString); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IString): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: IString); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IStringList

const

 { ����� ���������, ������������ � GblAdapter }
	NODE_FLAG_STORABLE_ENTITY = Longint(1);
 { �����, ����������� � Node::flags. ���� BaseEntity::storable == true, �� (Node::flags AND NODE_FLAG_STORABLE_ENTITY) ���������� true }
	PROPERTY_PATH_DELIMITER = '/';
 { ������ - ����������� ������ ���� }
	DEFAULT_PRELOAD_CACHE = Longword(50);
 { ������ �� ��������� ��� ��������� ������������� ��������� ������ ���������. }
	LIBRARY_NAME = 'GblAdapter.dll';
 { �������� ���������� }

 { KindConstants }
	ALL_DOCUMENTS_KIND = Int64(-1);

implementation
end.