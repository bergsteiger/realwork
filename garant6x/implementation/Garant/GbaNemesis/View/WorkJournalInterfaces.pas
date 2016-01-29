unit WorkJournalInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/WorkJournalInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Core::Base Operations::View::WorkJournalInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  SearchUnit,
  l3TreeInterfaces,
  UserJournalUnit,
  PrimWorkJournalInterfaces
  ;

type
 IbsWorkJournal = interface(IUnknown)
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
{$IfEnd} //not Admin AND not Monitorings

implementation

end.