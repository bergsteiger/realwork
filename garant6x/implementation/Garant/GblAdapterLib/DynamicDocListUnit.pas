unit DynamicDocListUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicDocListUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicDocList
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
	, FiltersUnit
	, DynamicTreeDefinesUnit
	, SearchProgressIndicatorUnit
	//#UC START# *4423F94903C8_45700BFD0251_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_45700BFD0251_UNIT_FOR_Stream*
	;

type

ISortTypes = interface;
{ - ��������������� �������� ISortTypes. }

IListEntryInfo = interface;
{ - ��������������� �������� IListEntryInfo. }

IDynList = interface;
{ - ��������������� �������� IDynList. }

ISearchDynList = interface;
{ - ��������������� �������� ISearchDynList. }

IDocListFactory = interface;
{ - ��������������� �������� IDocListFactory. }

IDynListNode = interface;
{ - ��������������� �������� IDynListNode. }


PDynListType = ^TDynListType;
TDynListType = (
	T_RESPONDENT
	, T_CORRESPONDENT
	, T_RESPONDENT_TO_PART
	, T_CORRESPONDENT_TO_PART
	, T_SAME_DOCUMENTS // ������� ���������
);

// ����� ��� ������
PDynListContent = ^TDynListContent;
TDynListContent = (
	DLC_LEGAL_DOCUMENTS // ����������� ���������
	, DLC_MEDICAL_DOCUMENTS // ��������� �������
);

PSpecialListKey = ^TSpecialListKey;
TSpecialListKey = (
	SLK_ALL_ALLOWED_DRUGS // ��� ���������������� ���������
);

PDynListFlags = ^TDynListFlags;
TDynListFlags = (
	DLF_ANALYSIS_NODE_HAS_DATA // ����� ���� �������� ������
	, DLF_ANALYSIS_NODE_EMPTY
);

ISortTypes = interface(IInterface)
['{A4E750C6-5513-44B2-ABE0-67CC2D4C503E}']
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
    function  pm_GetItem(anIndex: Integer): TSortType; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TSortType); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TSortType): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: TSortType); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
  // public properties
    property  Items[anIndex: Integer]: TSortType
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - �������� ������. }
end;//ISortTypes

IListEntryInfo = interface (IEntityBase) ['{5B3CE8D5-3CB9-4EA6-B3AC-37EADA8FDF9C}']
	procedure GetDoc (out aRet {: IDocument}); stdcall;

	procedure GetPid (out a: TPId); stdcall;

	function GetPosition (): Longword; stdcall;

	// �������������. ��� ������� ��� ������������� ������ 0.
	function GetRelevance (): Smallint; stdcall;

	function GetType (): TPositionType; stdcall;
end;

IDynList = interface (ICatalogBase) ['{00B91ACF-6CDD-437F-935A-07287C0E2DF0}']
	procedure AsEvd (
		aStyle: TEVDGeneratorStyle;
		out aRet {: IStream}
	); stdcall;

	procedure GetAvailableSortTypes (out aRet {: ISortTypes}); stdcall;

	function GetContentType (): TDynListContent; stdcall;

	procedure GetCurrentSortParams (out a: TSortParams); stdcall;

	// �������� ������ ������� ��� ������
	procedure GetAnalysisTree (
		out aRet {: INodeBase}
	); stdcall; // can raise ECanNotFindData

	// �������� ������ ������
	procedure GetFullList (
		const aProgress: IProgressIndicatorForSearch;
		out aCancelProcess {: ICancelSearch}
	); stdcall; // can raise ECanNotFindData

	// �������� ����� ������� ��� �������� ������
	function GetFullListSize (): Longword; stdcall;

	// �������� "��������" ��� ������, ������������ ��� ������ �� ������
	procedure GetShortName (
		out aRet {: IString}
	); stdcall;

	procedure GetHistory (out aRet {: IString}); stdcall;

	function GetIsFiltered (): Bytebool; stdcall;

	// ��� �������� ������ (��������)
	function GetIsShort (): Bytebool; stdcall;

	// �������, �������� �� ������ ���������
	function GetIsSnippet (): Bytebool; stdcall;

	// ��������� ������ ��� ��� ���������� �������� � ����.
	procedure SaveToFile (
		const aPath: PAnsiChar;
		const aNodes: INodesClipboard
	); stdcall;

	procedure SetContextFilter (
		const aContext: IContextFilter
	); stdcall;

	procedure Sort (
		const aParams: TSortParams
	); stdcall;
end;

// ������ - ��������� ������
ISearchDynList = interface (ISearchEntity) ['{DB91FE90-832B-4753-9222-4313AB5CA667}']
	procedure GetDynList (
		out aRet {: IDynList}
	); stdcall;
end;

// ������� ��� �������� �������
IDocListFactory = interface (IInterface) ['{C894D5B5-37CF-4463-A426-E30550F408F8}']
	function DontUseMe: Pointer;
	// ��������� ������ �� ������ �� ����� file_name.
	// inner_numbers - ���� ����������� ����� ������ ���������� ������������ (���� inner_numbers=true
	// - ����������)
	// 
	// ������ ����� (�195757811):
	// <����� ������>{.<����� ����/�����>}{<������ ��� ���������><����� �������>}
	// <����� ������>{.<����� ����/�����>}{<������ ��� ���������><����� �������>}
	// <����� ������>{.<����� ����/�����>}{<������ ��� ���������><����� �������>}
	// ...
	// 
	// ����������:
	// AccessDenied - �� ������ ��������� ������ �� �����
	// InvalidType - � ����� ������������ ������
	procedure MakeList (
		const aFileName: PAnsiChar;
		aInnerNumbers: Bytebool;
		out aRet {: IDynList}
	); stdcall; // can raise EAccessDenied, EInvalidType
end;

IDynListNode = interface (IInterface) ['{FAE957F6-A5EA-4AB6-9EC2-8514B696A1C1}']
	function DontUseMe: Pointer;
	// �������� ������������ ��������� �� ���� ������
	function GetDocumentId (): TObjectId; stdcall;

	procedure GetSnippetText (
		out aRet {: IString}
	); stdcall;
end;

implementation
end.