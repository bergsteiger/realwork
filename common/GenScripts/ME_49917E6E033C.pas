unit ProfilersInterfaces;
 {* Профайлеры прецедентов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Model\ProfilersInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "ProfilersInterfaces" MUID: (49917E6E033C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(vcmUseProfilers)}
uses
 l3IntfUses
;

type
 InsProfiler = interface
  {* Базовый интерфейс }
  ['{1D763660-D3D4-4061-8A81-9DC23C13C651}']
  procedure Start;
   {* начать замер, вызывается перед созданием сборки }
  procedure Finish;
   {* закончить измерения }
 end;//InsProfiler

 IprDocument = interface(InsProfiler)
  {* Используется оболочкой для замеров времени открытия документа }
  ['{B2515E49-A19D-4049-9919-56F7EC28A7EE}']
  procedure FormSetCreated;
   {* сборка создана }
  procedure DocumentReceived;
   {* документ получен с адаптера }
  procedure DocumentPainted;
   {* документ отрисован }
  procedure ContentsTreeOpened;
   {* открыта структура документа }
 end;//IprDocument

 IprQueryCard = interface(InsProfiler)
  {* Используется для замеров открытия карточки запросов }
  ['{789A98FD-0CF4-4201-A45E-C561BB951454}']
 end;//IprQueryCard

 IprListAfterSearch = interface(InsProfiler)
  {* Открытие списка после поиска }
  ['{C6674B5C-2E96-4BCC-B125-0B65DE2E3258}']
 end;//IprListAfterSearch

 IprMainMenu = interface(InsProfiler)
  {* Открытие основного меню }
  ['{39745C2C-BFC7-49B0-8354-6BF3FA66C8E3}']
 end;//IprMainMenu

 InsProfilersManager = interface
  {* Менеджер профайлеров }
  ['{8E294A8A-F992-453E-BEFE-15A04CE9950C}']
  function pm_GetDocument: IprDocument;
  function pm_GetQueryCard: IprQueryCard;
  function pm_GetListAfterSearch: IprListAfterSearch;
  function pm_GetMainMenu: IprMainMenu;
  property Document: IprDocument
   read pm_GetDocument;
   {* профайлер документа }
  property QueryCard: IprQueryCard
   read pm_GetQueryCard;
   {* профайлер карточки запроса }
  property ListAfterSearch: IprListAfterSearch
   read pm_GetListAfterSearch;
   {* открытие документа после поиска }
  property MainMenu: IprMainMenu
   read pm_GetMainMenu;
   {* открытие основного меню }
 end;//InsProfilersManager
{$IfEnd} // Defined(vcmUseProfilers)

implementation

{$If Defined(vcmUseProfilers)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(vcmUseProfilers)

end.
