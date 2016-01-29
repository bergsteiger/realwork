unit UserJournalUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/UserJournalUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UserJournal
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
  SearchUnit
  ;

type
 TJournalObjectType = (
  {* ���� ��������� ������� ������ }
   JOT_BOOKMARK // ��������
 , JOT_QUERY // ������
 , JOT_FOLDER // �����
 );//TJournalObjectType

 TBookmarkJournalType = (
   BJT_BOOKMARK // ��������
 , BJT_PHARM_BOOKMARK // �������� �������
 );//TBookmarkJournalType

 IUserJournal = interface(IUnknown)
  {* ��������� ������� ������ }
   ['{30769E5F-13F7-406E-8E2A-2D35B8BE5192}']
   procedure Save(const aObj: IUnknown;
    aObjectType: TJournalObjectType); stdcall;
     {* ��������� ������ � ������ ������ }
   procedure Remove(const aObj: INodeBase); stdcall;
     {* ������� ������ �� ������� ������ }
   procedure Clear; stdcall;
     {* �������� ������ ������ (���������� ������ remove (��� ������ ������� ������) }
   procedure GetUserJornalTree(out aRet {: INodeBase}); stdcall;
     {* �������� ������ ������� ������ }
   procedure GetBookmarkHistory(aType: TBookmarkJournalType;
    aMaxCount: Integer; out aRet {: IJournalBookmarkList}); stdcall; // can raise CanNotFindData
     {* ������ �������� ��������� ���� }
   procedure GetQueryHistory(aQueryType: TQueryType;
    aMaxCount: Integer; out aRet {: IQueryList}); stdcall; // can raise CanNotFindData
     {* ������� ������ �������� ��������� ���� �� ������� }
 end;//IUserJournal

implementation

end.