unit UserJournalUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\UserJournalUnit.pas"
// ���������: "Interfaces"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , DynamicTreeUnit
 , DocumentUnit
 , SearchUnit
 , BaseTypesUnit
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
  procedure save(const obj: IUnknown;
   object_type: TJournalObjectType);
   {* ��������� ������ � ������ ������ }
  procedure remove(const obj: INodeBase);
   {* ������� ������ �� ������� ������ }
  procedure clear;
   {* �������� ������ ������ (���������� ������ remove (��� ������ ������� ������) }
  function get_user_jornal_tree: INodeBase;
   {* �������� ������ ������� ������ }
  function get_bookmark_history(type: TBookmarkJournalType;
   max_count: Integer): IJournalBookmarkList; { can raise CanNotFindData }
   {* ������ �������� ��������� ���� }
  function get_query_history(query_type: TQueryType;
   max_count: Integer): IQueryList; { can raise CanNotFindData }
   {* ������� ������ �������� ��������� ���� �� ������� }
 end;//IUserJournal

class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
var
 l_Inst : IUserJournal;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
