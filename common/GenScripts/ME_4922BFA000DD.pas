unit SimpleListInterfaces;
 {* Интерфейсы "простого списка" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\List\SimpleListInterfaces.pas"
// Стереотип: "ControllerInterfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , SearchUnit
 , FiltersUnit
 , l3TreeInterfaces
;

type
 IdsSimpleListSynchroViewPrim = interface
  {* Спецификация синхронного просмотра для списка }
  ['{92E3621F-75AE-4E7D-8BA5-9FA4E7478C0E}']
  function pm_GetHasDocument: Boolean;
  function pm_GetIsDocumentActive: Boolean;
  function pm_GetHasAttributes: Boolean;
  function pm_GetIsAttributesActive: Boolean;
  procedure OpenDocument;
   {* Открыть документ. }
  procedure OpenAttributes;
   {* Открыть атрибуты. }
  property HasDocument: Boolean
   read pm_GetHasDocument;
   {* Наличие документа. }
  property IsDocumentActive: Boolean
   read pm_GetIsDocumentActive;
   {* Текущим в зоне является документ. }
  property HasAttributes: Boolean
   read pm_GetHasAttributes;
   {* Наличие атрибутов. }
  property IsAttributesActive: Boolean
   read pm_GetIsAttributesActive;
   {* Текущими в зоне являются атрибуты документа. }
 end;//IdsSimpleListSynchroViewPrim

 IdsSimpleListSynchroView = interface(IdsSimpleListSynchroViewPrim)
  {* Синхронный просмотр для списка }
  ['{44989FBD-2A2E-4CB3-99C9-0B70D736FF76}']
  function pm_GetHasList: Boolean;
  function pm_GetIsListActive: Boolean;
  procedure OpenList;
   {* Открыть список. }
  property HasList: Boolean
   read pm_GetHasList;
   {* Наличие списка. }
  property IsListActive: Boolean
   read pm_GetIsListActive;
   {* Текущим в зоне является список. }
 end;//IdsSimpleListSynchroView

 IdeFilter = interface
  ['{E22F664C-64D9-498F-B436-D3A7753BD702}']
  function pm_GetQuery: IQuery;
  function pm_GetFilter: IFilterFromQuery;
  property Query: IQuery
   read pm_GetQuery;
  property Filter: IFilterFromQuery
   read pm_GetFilter;
   {* текущий узел фильтра выбранный в форме фильтров }
 end;//IdeFilter

 IucpFilters = interface
  {* Управляет открытием формы фильтров }
  ['{E3EF9091-08EE-47B6-9E0F-40436EE126D5}']
  procedure Open;
   {* открыть форму фильтры }
 end;//IucpFilters

 IdsFilters = interface
  ['{8B4E6C35-7EC0-41FA-A1C2-380236FC2B43}']
  function OpenFilter(const aNode: Il3SimpleNode): IdeFilter;
   {* возвращает данные необходимые редактироания фильтра }
 end;//IdsFilters

implementation

uses
 l3ImplUses
;

end.
