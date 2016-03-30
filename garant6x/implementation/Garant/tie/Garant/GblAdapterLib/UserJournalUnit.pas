unit UserJournalUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\UserJournalUnit.pas"
// ���������: "Interfaces"
// ������� ������: "UserJournal" MUID: (4A7FF5F301B2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , DocumentUnit
 , DynamicTreeUnit
 , SearchUnit
;

type
 TJournalObjectType = (
  {* ���� ��������� ������� ������ }
  JOT_BOOKMARK
   {* �������� }
  , JOT_QUERY
   {* ������ }
  , JOT_FOLDER
   {* ����� }
 );//TJournalObjectType

 TBookmarkJournalType = (
  BJT_BOOKMARK
   {* �������� }
  , BJT_PHARM_BOOKMARK
   {* �������� ������� }
 );//TBookmarkJournalType

 IUserJournal = interface
  {* ��������� ������� ������ }
  ['{30769E5F-13F7-406E-8E2A-2D35B8BE5192}']
  procedure Save(const obj: IUnknown;
   object_type: TJournalObjectType); stdcall;
   {* ��������� ������ � ������ ������ }
  procedure Remove(const obj: INodeBase); stdcall;
   {* ������� ������ �� ������� ������ }
  procedure Clear; stdcall;
   {* �������� ������ ������ (���������� ������ remove (��� ������ ������� ������) }
  function GetUserJornalTree: INodeBase; stdcall;
   {* �������� ������ ������� ������ }
  function GetBookmarkHistory(type: TBookmarkJournalType;
   max_count: Integer): IJournalBookmarkList; stdcall; { can raise CanNotFindData }
   {* ������ �������� ��������� ���� }
  function GetQueryHistory(query_type: TQueryType;
   max_count: Integer): IQueryList; stdcall; { can raise CanNotFindData }
   {* ������� ������ �������� ��������� ���� �� ������� }
 end;//IUserJournal

implementation

uses
 l3ImplUses
;

end.
