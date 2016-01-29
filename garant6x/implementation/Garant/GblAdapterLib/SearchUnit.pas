unit SearchUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/SearchUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Search
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	, BaseTypesUnit
	, DynamicDocListUnit
	, FoldersUnit
	, DocumentUnit
	, DynamicTreeUnit
	, FiltersUnit
	, ProgressIndicatorSupportUnit
	, SearchDefinesUnit
	, SearchProgressIndicatorUnit
	//#UC START# *4423F94903C8_45EEAA8E034E_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_45EEAA8E034E_UNIT_FOR_Stream*
	;

type

IQueryAttribute = interface;
{ - ��������������� �������� IQueryAttribute. }

IQueryPhoneNumberAttribute = interface;
{ - ��������������� �������� IQueryPhoneNumberAttribute. }

IContextValueList = interface;
{ - ��������������� �������� IContextValueList. }

IDateValueList = interface;
{ - ��������������� �������� IDateValueList. }

IQueryDateAttribute = interface;
{ - ��������������� �������� IQueryDateAttribute. }

INodeValueList = interface;
{ - ��������������� �������� INodeValueList. }

IQueryNodeAttribute = interface;
{ - ��������������� �������� IQueryNodeAttribute. }

IQueryAttributeList = interface;
{ - ��������������� �������� IQueryAttributeList. }

IOperationList = interface;
{ - ��������������� �������� IOperationList. }

IQueryContextAttribute = interface;
{ - ��������������� �������� IQueryContextAttribute. }

IAttributeInfo = interface;
{ - ��������������� �������� IAttributeInfo. }

IContextWordList = interface;
{ - ��������������� �������� IContextWordList. }

IQuery = interface;
{ - ��������������� �������� IQuery. }

IQueryList = interface;
{ - ��������������� �������� IQueryList. }

ISearch = interface;
{ - ��������������� �������� ISearch. }

IFullAttributeInfo = interface;
{ - ��������������� �������� IFullAttributeInfo. }

IAttributeList = interface;
{ - ��������������� �������� IAttributeList. }

IQueryCardInfo = interface;
{ - ��������������� �������� IQueryCardInfo. }

IAttributesHelper = interface;
{ - ��������������� �������� IAttributesHelper. }


PQueryType = ^TQueryType;
TQueryType = (
	QT_KEYWORD
	, QT_ATTRIBUTE
	, QT_PUBLISHED_SOURCE
	, QT_COMMENTS
	, QT_REVIEW
	, QT_MAIL_LIST
	, QT_RUBRICATOR
	, QT_CONSULT
	, QT_HANDYCRAFT_CONSULT
	, QT_DETAIL // ����������� ���
	, QT_BASE_SEARCH // �������� �������� ������
	, QT_PHARM_SEARCH // ����� � �������
);

PQueryTagType = ^TQueryTagType;
TQueryTagType = (
	QTT_CONTEXT
	, QTT_NODE
	, QTT_DATE
	, QTT_PHONE_NUMBER // ����� ��������
);

// ��������� ���������� �������� ��� ����������� ��������� ��������� � �������.
PQueryLogicOperation = ^TQueryLogicOperation;
TQueryLogicOperation = (
	QLO_AND // ���������� �.
	, QLO_OR // ���������� ���.
	, QLO_AND_NOT // �����. ������ ���������� �������� ������������ ������ ��� ��������� ������ �������� ������� - Search::get_query_forms. ��� ��������� ���� �������� �� ����� �������� QueryNode, � ��� ������������ ���� negative.
);

PQueryNodeValue = ^TQueryNodeValue;
TQueryNodeValue = packed record
	rNode: INodeBase;
	rOperation: TQueryLogicOperation;
end;

PContextValue = ^TContextValue;
TContextValue = packed record
	rContext: IString;
	rOperation: TQueryLogicOperation;
end;

PDateValue = ^TDateValue;
TDateValue = packed record
	rFrom: TDate;
	rTo: TDate;
	rOperation: TQueryLogicOperation;
end;

// ��� �������� ��� �������� �� ���������
ENoDefaultValue = class (Exception);

PAttributeFilterType = ^TAttributeFilterType;
TAttributeFilterType = (
	AFT_NONE
	, AFT_TRIM
);

EQueryNotExecuted = class (Exception);

IQueryAttribute = interface (IInterface) ['{F7B99D7B-8104-4890-A107-57D3524BDEE1}']
	function DontUseMe: Pointer;
	procedure Clear (); stdcall;

	function GetTag (): TAttributeTag; stdcall;

	function GetType (): TQueryTagType; stdcall;
end;

// ������� �����
IQueryPhoneNumberAttribute = interface (IQueryAttribute) ['{D08C1696-445B-4611-93D3-D9B172B925AB}']
	procedure GetCityCode (out aRet {: IString}); stdcall;
	procedure SetCityCode (const aCityCode: IString); stdcall;

	procedure GetPhoneNumber (out aRet {: IString}); stdcall;
	procedure SetPhoneNumber (const aPhoneNumber: IString); stdcall;
end;

IContextValueList = interface(IInterface)
['{8EDC6AA0-7C9D-4E76-B25F-F38E82E5A974}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TContextValue); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TContextValue); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TContextValue): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TContextValue); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IContextValueList

IDateValueList = interface(IInterface)
['{A97316BC-57EC-4203-B89B-887DA2905858}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TDateValue); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TDateValue); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TDateValue): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TDateValue); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IDateValueList

IQueryDateAttribute = interface (IQueryAttribute) ['{3CAD67CD-205A-4E98-9240-49311D9B33D2}']
	procedure AddValue (
		aOperation: TQueryLogicOperation;
		const aFrom: TDate;
		const aTo: TDate
	); stdcall;

	procedure GetValues (out aRet {: IDateValueList}); stdcall;
end;

INodeValueList = interface(IInterface)
['{22FC2FF8-6660-4E16-9AF5-ECCFE3FE4385}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TQueryNodeValue); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TQueryNodeValue); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TQueryNodeValue): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TQueryNodeValue); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//INodeValueList

IQueryNodeAttribute = interface (IQueryAttribute) ['{6BD5D1EC-803B-4923-BAB6-DBBC28685620}']
	procedure AddValue (
		aOperation: TQueryLogicOperation;
		const aNode: INodeBase
	); stdcall;

	procedure GetValues (out aRet {: INodeValueList}); stdcall;
end;

IQueryAttributeList = interface(IInterface)
['{286CCB59-7339-4EFE-83E2-8AFF5625A4CA}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: IQueryAttribute); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IQueryAttribute); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IQueryAttribute): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: IQueryAttribute); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IQueryAttributeList

IOperationList = interface(IInterface)
['{78C80DA4-3163-4569-9BB6-7A775BB17185}']
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
    function  pm_GetItem(anIndex: Integer): TQueryLogicOperation; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TQueryLogicOperation); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TQueryLogicOperation): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TQueryLogicOperation); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
  // public properties
    property  Items[anIndex: Integer]: TQueryLogicOperation
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - �������� ������. }
end;//IOperationList

IQueryContextAttribute = interface (IQueryAttribute) ['{3219EAF4-9E07-4548-9955-B0B8460FB3C8}']
	procedure AddValue (
		aOperation: TQueryLogicOperation;
		const aContext: IString
	); stdcall;

	procedure GetValues (out aRet {: IContextValueList}); stdcall;
end;

IAttributeInfo = interface (IInterface) ['{866DFFF9-C146-4174-B3A8-831190DFEA4D}']
	function DontUseMe: Pointer;
	procedure GetAvailableOperations (out aRet {: IOperationList}); stdcall;

	// �������� ��������� �������� ��������
	procedure GetDefaultValue (
		out aRet {: IQueryAttribute}
	); stdcall;

	function GetIsExist (): Bytebool; stdcall;
end;

IContextWordList = interface(IInterface)
['{78BEBCCD-97F9-4835-87AF-134DF480645D}']
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
end;//IContextWordList

// ��������� �������������� ������ � ��������. ������� ����� ���������� ����������� � �����
// ����������.
// ��������� ������ ����������� ��� ������ ����� QueryOperationNode � QueryAttributeNode,
// ��������������� � ���� ����������� ��������� ������.
IQuery = interface (IEntityBase) ['{73F075AC-4899-45B6-8C26-44A4C1EAA2C2}']
	procedure GetAttributes (out aRet {: IQueryAttributeList}); stdcall;

	procedure AttributesByTag (
		const aTag: TAttributeTag;
		out aRet {: IQueryAttributeList}
	); stdcall;

	procedure Clear (); stdcall;

	procedure Clone (
		out aRet {: IQuery}
	); stdcall;

	// ���������� ��������� ���������� ��� ��������� ������.
	function GetCount (): Longword; stdcall;

	procedure GetDate (out a: TDate); stdcall;

	procedure Execute (
		const aFiltrateList: IDynList;
		const aProgress: IProgressIndicatorForSearch;
		out aCancelProcess {: ICancelSearch}
	); stdcall;

	procedure GetComment (
		out aRet {: IString}
	); stdcall;

	procedure GetContextAttribute (
		const aTag: TAttributeTag;
		out aRet {: IQueryContextAttribute}
	); stdcall;

	procedure GetDateAttribute (
		const aTag: TAttributeTag;
		out aRet {: IQueryDateAttribute}
	); stdcall;

	procedure GetName (
		out aRet {: IString}
	); stdcall;

	procedure GetNodeAttribute (
		const aTag: TAttributeTag;
		out aRet {: IQueryNodeAttribute}
	); stdcall;

	procedure GetPhoneNumberAttribute (
		const aTag: TAttributeTag;
		out aRet {: IQueryPhoneNumberAttribute}
	); stdcall;

	// ������� �� ������ � �������
	function IsFilterQuery (): Bytebool; stdcall;

	// ��������� ������ �� ������������
	procedure SendQuery (); stdcall;

	procedure SetComment (
		const aComment: IString
	); stdcall;

	procedure SetName (
		const aName: IString
	); stdcall;

	function GetType (): TQueryType; stdcall;
end;

IQueryList = interface(IInterface)
['{0DE9E8D7-AFF7-4561-BEB9-74104FCBC7D7}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: IQuery); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IQuery); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IQuery): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: IQuery); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IQueryList

// �����.
ISearch = interface (IInterface) ['{E15D4E0A-900B-460A-BC2C-F35D282B3766}']
	function DontUseMe: Pointer;
	// ���������� ������ ����, ������� �� ������ ��������������� � ����������������� ������
	procedure CorrectContext (
		const aContextForCheck: IContextWordList;
		aForInpharm: Bytebool;
		out aCorrectedContext {: IContextWordList};
		out aRet {: IContextWordList}
	); stdcall;

	// ������� ����� ��������� ������. � ��������� ��������� ������� �� ��������� ���������� ��������
	// QueryOperationNode � ��������� LO_AND.
	procedure CreateQuery (
		aType: TQueryType;
		out aRet {: IQuery}
	); stdcall;

	procedure GetAttributeInfo (
		const aTag: TAttributeTag;
		out aRet {: IAttributeInfo}
	); stdcall;

	// ������ ���������� ��� ������� CLASS
	procedure GetDocumentsWithoutClass (
		out aRet {: IDynList}
	); stdcall;

	// C����� ���������� � �������� vanonced � ��� ������� vincluded
	procedure GetDocumentsWithoutIncluded (
		out aRet {: IDynList}
	); stdcall;

	// C����� ���������� ��� ������� key
	procedure GetDocumentsWithoutKey (
		out aRet {: IDynList}
	); stdcall;

	// �������� ����� ������� �� �������� ������� pos
	procedure GetExampleText (
		aPos: Longword;
		out aRet {: IString}
	); stdcall; // can raise ECanNotFindData

	// �������� ���������� ��������
	function GetExampleTextCount (): Longword; stdcall;

	function GetIsMorphoExist (): Bytebool; stdcall;
end;

// ���������� �� �������� ��� ��
IFullAttributeInfo = interface (IAttributeInfo) ['{5898650D-3C1B-4820-AA3E-6C7A9809F267}']
	procedure GetTag (out aRet {: IString}); stdcall;
end;

IAttributeList = interface(IInterface)
['{0051F266-26A3-4387-A8B6-0C9257B357AE}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: IFullAttributeInfo); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IFullAttributeInfo); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IFullAttributeInfo): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: IFullAttributeInfo); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IAttributeList

// ����������, ��������� � ��������� �������
IQueryCardInfo = interface (IInterface) ['{F9D884BA-B356-4A7C-8997-D3E74A8FB8F1}']
	function DontUseMe: Pointer;
	procedure GetEvdCard (out aRet {: IStream}); stdcall;

	// �������� ������ ������������ ��������� ��� ��
	procedure GetExistAttrs (
		out aRet {: IAttributeList}
	); stdcall;
end;

// ���������� �� ���������, ������� �������� �� �������� ��������
IAttributesHelper = interface (IInterface) ['{03CD2930-3AE2-4CC9-9BE4-501A2B758C64}']
	function DontUseMe: Pointer;
	function AttributeKWExists (): Bytebool; stdcall;

	function AttributePublishSourceExists (): Bytebool; stdcall;
end;

const

 { ��������� ��� �������� - �121160631 }
	AT_CONSULTATION_TEXT = 'AT_CONSULTATION_TEXT';
	AT_LAW_SUPPORT_TEXT = 'AT_LAW_SUPPORT_TEXT';
	AT_TEXT = 'AT_TEXT';
	AT_TEXT_NAME = 'AT_TEXT_NAME';
	AT_TEXT_BODY = 'AT_TEXT_BODY';
	AT_THEMES_NAME = 'AT_THEMES_NAME';
	AT_CONSULTATION_DESCRIPTION = 'AT_CONSULTATION_DESCRIPTION';
	AT_USER_NAME = 'AT_USER_NAME';
	AT_EMAIL = 'AT_EMAIL';
	AT_PHARM_NAME = 'AT_PHARM_NAME';
	AT_PHARM_TEXT = 'AT_PHARM_TEXT';
	AT_SHORT_LIST = 'AT_SHORT_LIST';
	AT_USER_PHONE = 'AT_USER_PHONE';

 { QueryCardType }
	QCT_PRIME = 'QCT_PRIME';
 { �������� ������ }
	QCT_ATTRIBUTE = 'QCT_ATTRIBUTE';
 { �������� ��� }
	QCT_REVIEW = 'QCT_REVIEW';
 { �������� ������ �� ���������� ���������������� }
	QCT_CONSULTING = 'QCT_CONSULTING';
 { �������� ������� � ����������� }
	QCT_PHARM = 'QCT_PHARM';
 { �������� ������� }

implementation
end.