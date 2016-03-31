unit MainMenuDomainInterfaces;
 {* Главное меню }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\MainMenuDomainInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "MainMenuDomainInterfaces" MUID: (49904AF102FD)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUnit
 , SearchUnit
 , l3Interfaces
 , l3TreeInterfaces
 , OldTreeInterfaces
;

type
 InsMainMenuNode = interface(Il3SimpleNode)
  {* Элемент дерева простого основного меню }
  ['{F66C6EFD-42D9-495B-8598-53375CF94925}']
  function pm_GetNodeType: Integer;
  property NodeType: Integer
   read pm_GetNodeType;
 end;//InsMainMenuNode

 InsDocumentNode = interface
  {* Узел который содержит документ }
  ['{CB2D4809-618E-4A09-822A-EF66239CA8E5}']
  function pm_GetData: IDocument;
  property Data: IDocument
   read pm_GetData;
 end;//InsDocumentNode

 InsQueryNode = interface(InsWrapperNode)
  ['{91E2885F-DB08-40D1-B272-3B342E791954}']
  function pm_GetDocCount: Integer;
  function pm_GetQuery: IQuery;
  property DocCount: Integer
   read pm_GetDocCount;
  property Query: IQuery
   read pm_GetQuery;
   {* адаптерный запрос }
 end;//InsQueryNode

 InsJournalBookmarkNode = interface(InsWrapperNode)
  ['{3D80D697-C525-428C-A010-4B946FEE49CD}']
  function Get_DocName: Il3CString;
  function Get_Bookmark: IJournalBookmark;
  property DocName: Il3CString
   read Get_DocName;
  property Bookmark: IJournalBookmark
   read Get_Bookmark;
 end;//InsJournalBookmarkNode
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
