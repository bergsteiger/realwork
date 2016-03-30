unit DynamicDocListUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DynamicDocListUnit.pas"
// ���������: "Interfaces"
// ������� ������: "DynamicDocList" MUID: (45700BFD0251)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , DocumentUnit
 , DynamicTreeUnit
 , FiltersUnit
 , DynamicTreeDefinesUnit
 , SearchProgressIndicatorUnit
;

type
 ISortTypes = array of TSortType;

 TDynListType = (
  T_RESPONDENT
  , T_CORRESPONDENT
  , T_RESPONDENT_TO_PART
  , T_CORRESPONDENT_TO_PART
  , T_SAME_DOCUMENTS
   {* ������� ��������� }
 );//TDynListType

 TDynListContent = (
  {* ����� ��� ������ }
  DLC_LEGAL_DOCUMENTS
   {* ����������� ��������� }
  , DLC_MEDICAL_DOCUMENTS
   {* ��������� ������� }
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
  property Type: TPositionType
   read GetType;
  property Position: Cardinal
   read GetPosition;
  property Relevance: short
   read GetRelevance;
   {* �������������. ��� ������� ��� ������������� ������ 0. }
  property Pid: TPId
   read GetPid;
  property Doc: IDocument
   read GetDoc;
 end;//IListEntryInfo

 TSpecialListKey = (
  SLK_ALL_ALLOWED_DRUGS
   {* ��� ���������������� ��������� }
 );//TSpecialListKey

 IDynList = interface(IEntityBase)
  ['{00B91ACF-6CDD-437F-935A-07287C0E2DF0}']
  function GetHistory: IString; stdcall;
  function GetIsFiltered: ByteBool; stdcall;
  function GetContentType: TDynListContent; stdcall;
  function GetIsShort: ByteBool; stdcall;
  function GetIsSnippet: ByteBool; stdcall;
  function GetCurrentSortParams: TSortParams; stdcall;
  function GetAvailableSortTypes: ISortTypes; stdcall;
  procedure Sort(const params: TSortParams); stdcall;
  procedure SetContextFilter(var context: IContextFilter); stdcall;
  procedure SaveToFile(path: PAnsiChar;
   const nodes: INodesClipboard); stdcall;
   {* ��������� ������ ��� ��� ���������� �������� � ����. }
  function AsEvd(style: TEVDGeneratorStyle): IStream; stdcall;
  function GetShortName: IString; stdcall;
   {* �������� "��������" ��� ������, ������������ ��� ������ �� ������ }
  procedure SetListStorage(const saved_list); stdcall;
  procedure GetFullList(var progress: IProgressIndicatorForSearch;
   out cancel_process: ICancelSearch); stdcall; { can raise CanNotFindData }
   {* �������� ������ ������ }
  function GetAnalysisTree: INodeBase; stdcall; { can raise CanNotFindData }
   {* �������� ������ ������� ��� ������ }
  function GetFullListSize: Cardinal; stdcall;
   {* �������� ����� ������� ��� �������� ������ }
  property History: IString
   read GetHistory;
  property IsFiltered: ByteBool
   read GetIsFiltered;
  property ContentType: TDynListContent
   read GetContentType;
  property IsShort: ByteBool
   read GetIsShort;
   {* ��� �������� ������ (��������) }
  property IsSnippet: ByteBool
   read GetIsSnippet;
   {* �������, �������� �� ������ ��������� }
  property CurrentSortParams: TSortParams
   read GetCurrentSortParams;
  property AvailableSortTypes: ISortTypes
   read GetAvailableSortTypes;
 end;//IDynList

 ISearchDynList = interface(ISearchEntity)
  {* ������ - ��������� ������ }
  ['{DB91FE90-832B-4753-9222-4313AB5CA667}']
  function GetDynList: IDynList; stdcall;
 end;//ISearchDynList

 TDynListFlags = (
  DLF_ANALYSIS_NODE_HAS_DATA
   {* ����� ���� �������� ������ }
  , DLF_ANALYSIS_NODE_EMPTY
 );//TDynListFlags

 IDocListFactory = interface
  {* ������� ��� �������� ������� }
  ['{C894D5B5-37CF-4463-A426-E30550F408F8}']
  function MakeList(file_name: PAnsiChar;
   inner_numbers: Boolean): IDynList; stdcall; { can raise AccessDenied, InvalidType }
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

 IDynListNode = interface
  ['{FAE957F6-A5EA-4AB6-9EC2-8514B696A1C1}']
  function GetDocumentId: TObjectId; stdcall;
   {* �������� ������������ ��������� �� ���� ������ }
  function GetSnippetText: IString; stdcall;
 end;//IDynListNode

implementation

uses
 l3ImplUses
;

end.
