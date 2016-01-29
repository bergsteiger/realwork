unit DynamicDocListUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/DynamicDocListUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicDocList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  BaseTypesUnit,
  DocumentUnit,
  DynamicTreeUnit,
  FiltersUnit,
  DynamicTreeDefinesUnit,
  SearchProgressIndicatorUnit
  ;

type
 ISortTypes = array of TSortType;

 TDynListType = (
   T_RESPONDENT
 , T_CORRESPONDENT
 , T_RESPONDENT_TO_PART
 , T_CORRESPONDENT_TO_PART
 , T_SAME_DOCUMENTS // ������� ���������
 );//TDynListType

 TDynListContent = (
  {* ����� ��� ������ }
   DLC_LEGAL_DOCUMENTS // ����������� ���������
 , DLC_MEDICAL_DOCUMENTS // ��������� �������
 );//TDynListContent

 IListEntryInfo = interface(IEntityBase)
   ['{5B3CE8D5-3CB9-4EA6-B3AC-37EADA8FDF9C}']
   function GetType: TPositionType; stdcall;
   function GetPosition: Cardinal; stdcall;
   function GetRelevance: short; stdcall;
   function GetPid: TPId; stdcall;
   function GetDoc: IDocument; stdcall;
   procedure GetEntryList; stdcall;
   procedure GetRelevanceWordsList; stdcall;
   property type: TPositionType
     read GetType;
   property position: Cardinal
     read GetPosition;
   property relevance: short
     read GetRelevance;
     {* �������������. ��� ������� ��� ������������� ������ 0. }
   property pid: TPId
     read GetPid;
   property doc: IDocument
     read GetDoc;
 end;//IListEntryInfo

 TSpecialListKey = (
   SLK_ALL_ALLOWED_DRUGS // ��� ���������������� ���������
 );//TSpecialListKey

 IDynList = interface(IEntityBase{, ICatalogBase})
   ['{00B91ACF-6CDD-437F-935A-07287C0E2DF0}']
   function GetHistory: IString; stdcall;
   function GetIsFiltered: ByteBool; stdcall;
   function GetContentType: TDynListContent; stdcall;
   function GetIsShort: ByteBool; stdcall;
   function GetIsSnippet: ByteBool; stdcall;
   function GetCurrentSortParams: TSortParams; stdcall;
   function GetAvailableSortTypes: ISortTypes; stdcall;
   procedure Sort(const aParams: TSortParams); stdcall;
   procedure SetContextFilter(var aContext: IContextFilter); stdcall;
   procedure SaveToFile(aPath: PAnsiChar;
    const aNodes: INodesClipboard); stdcall;
     {* ��������� ������ ��� ��� ���������� �������� � ����. }
   procedure AsEvd(aStyle: TEVDGeneratorStyle; out aRet {: IStream}); stdcall;
   procedure GetShortName(out aRet {: IString}); stdcall;
     {* �������� "��������" ��� ������, ������������ ��� ������ �� ������ }
   procedure SetListStorage(aSavedList); stdcall;
   procedure GetFullList(var aProgress: IProgressIndicatorForSearch;
    out aCancelProcess: ICancelSearch); stdcall; // can raise CanNotFindData
     {* �������� ������ ������ }
   procedure GetAnalysisTree(out aRet {: INodeBase}); stdcall; // can raise CanNotFindData
     {* �������� ������ ������� ��� ������ }
   function GetFullListSize: Cardinal; stdcall;
     {* �������� ����� ������� ��� �������� ������ }
   property history: IString
     read GetHistory;
   property is_filtered: ByteBool
     read GetIsFiltered;
   property content_type: TDynListContent
     read GetContentType;
   property is_short: ByteBool
     read GetIsShort;
     {* ��� �������� ������ (��������) }
   property is_snippet: ByteBool
     read GetIsSnippet;
     {* �������, �������� �� ������ ��������� }
   property current_sort_params: TSortParams
     read GetCurrentSortParams;
   property available_sort_types: ISortTypes
     read GetAvailableSortTypes;
 end;//IDynList

 ISearchDynList = interface(ISearchEntity)
  {* ������ - ��������� ������ }
   ['{DB91FE90-832B-4753-9222-4313AB5CA667}']
   procedure GetDynList(out aRet {: IDynList}); stdcall;
 end;//ISearchDynList

 TDynListFlags = (
   DLF_ANALYSIS_NODE_HAS_DATA // ����� ���� �������� ������
 , DLF_ANALYSIS_NODE_EMPTY
 );//TDynListFlags

 IDocListFactory = interface(IUnknown)
  {* ������� ��� �������� ������� }
   ['{C894D5B5-37CF-4463-A426-E30550F408F8}']
   procedure MakeList(aFileName: PAnsiChar;
    aInnerNumbers: Boolean; out aRet {: IDynList}); stdcall; // can raise AccessDenied, InvalidType
     {* ��������� ������ �� ������ �� ����� file_name.
 inner_numbers - ���� ����������� ����� ������ ���������� ������������ (���� inner_numbers=true - ����������)

������ ����� (�195757811):
<����� ������>[.<����� ����/�����>][<������ ��� ���������><����� �������>]
<����� ������>[.<����� ����/�����>][<������ ��� ���������><����� �������>]
<����� ������>[.<����� ����/�����>][<������ ��� ���������><����� �������>]
...

����������:
AccessDenied - �� ������ ��������� ������ �� �����
InvalidType - � ����� ������������ ������ }
 end;//IDocListFactory

 IDynListNode = interface(IUnknown)
   ['{FAE957F6-A5EA-4AB6-9EC2-8514B696A1C1}']
   function GetDocumentId: TObjectId; stdcall;
     {* �������� ������������ ��������� �� ���� ������ }
 end;//IDynListNode

implementation

end.