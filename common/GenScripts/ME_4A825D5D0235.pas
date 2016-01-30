unit WorkJournalInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournalInterfaces.pas"
// Стереотип: "Interfaces"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3TreeInterfaces
 , SearchUnit
 , DocumentUnit
 , PrimWorkJournalInterfaces
;

type
 IbsWorkJournal = interface
  ['{2E30D6B8-6A4D-42B6-8441-14BF7C617DBC}']
  function MakeTree: Il3SimpleTree;
  procedure Clear;
  procedure AddQuery(const aQuery: IQuery);
  procedure AddBookMark(const aBookMark: IJournalBookmark);
  function MakeQueryHistory(aQueryType: TQueryType;
   aMaxCount: Cardinal): IQueryList;
  function MakeBookMarkHistory(ForInpharm: Boolean;
   aMaxCount: Cardinal): IJournalBookmarkList;
  procedure Delete(const aNode: Il3SimpleNode);
  procedure RegisterListener(const aListener: InsWorkJournalListener);
  procedure UnRegisterListener(const aListener: InsWorkJournalListener);
  procedure NotifyJournalShrinked;
 end;//IbsWorkJournal
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
