unit QueryCardInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\QueryCardInterfaces.pas"
// Стереотип: "ControllerInterfaces"
// Элемент модели: "QueryCardInterfaces" MUID: (4AA5503000D7)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , SearchUnit
 , SearchInterfaces
 , l3InternalInterfaces
 , l3TreeInterfaces
 , SearchDomainInterfaces
 , SimpleListInterfaces
;

type
 IdeQuery = IQuery;
  {* Данные для инициализации форм поиска }

 IdsQuery = interface
  {* БОС для карточек запроса }
  ['{51C5A41E-41B2-463E-8671-275D172E3B48}']
  function pm_GetQuery: IdeQuery;
  function pm_GetIsQuerySaved: Boolean;
  procedure pm_SetIsQuerySaved(aValue: Boolean);
  property Query: IdeQuery
   read pm_GetQuery;
  property IsQuerySaved: Boolean
   read pm_GetIsQuerySaved
   write pm_SetIsQuerySaved;
 end;//IdsQuery

 IdsSaveLoad = interface
  {* Бизнес объект контейнера карточки поиска }
  ['{E5584C58-C6DF-42D0-B1AE-ACB317071F37}']
 end;//IdsSaveLoad

 IsdsAttributeSelect = interface
  {* Форма выбора реквизитов }
  ['{DE5652A0-CBAC-4E05-863F-16A1F094E89B}']
  function pm_GetSearch: IdeSearch;
  property Search: IdeSearch
   read pm_GetSearch;
   {* информация для заполнения дерева реквизита }
 end;//IsdsAttributeSelect

 IdsTreeAttributeFirstLevel = interface(IdsSituation)
  {* Бизнес объекта формы "enTreeAttributeFirstLevel" }
  ['{5995C2CA-E6BD-4FB7-A029-94E0AB2A037C}']
 end;//IdsTreeAttributeFirstLevel

 IsdsSituation = interface(IsdsAttributeSelect)
  ['{53453074-B221-4E0D-8FB1-538D5C3A930D}']
  function pm_GetdsFilters: IdsFilters;
  function pm_GetdsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel;
  function pm_GetdsSaveLoad: IdsSaveLoad;
  function pm_GetdsSelectedAttributes: IdsSelectedAttributes;
  function pm_GetdsTreeAttributeSelect: IdsTreeAttributeSelect;
  function pm_GetdsAttributeSelect: IdsAttributeSelect;
  function As_IucpFilters: IucpFilters;
   {* Метод приведения нашего интерфейса к IucpFilters }
  function As_IbsCurrentChangedListener: IbsCurrentChangedListener;
   {* Метод приведения нашего интерфейса к IbsCurrentChangedListener }
  function As_IbsSelectedAttributes: IbsSelectedAttributes;
   {* Метод приведения нашего интерфейса к IbsSelectedAttributes }
  property dsFilters: IdsFilters
   read pm_GetdsFilters;
   {* БОС формы фильтры }
  property dsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel
   read pm_GetdsTreeAttributeFirstLevel;
   {* БОС формы "Ситуации первого уровня" }
  property dsSaveLoad: IdsSaveLoad
   read pm_GetdsSaveLoad;
   {* БОС формы контейнер карточек запроса }
  property dsSelectedAttributes: IdsSelectedAttributes
   read pm_GetdsSelectedAttributes;
   {* БОС формы выбранные атрибуты }
  property dsTreeAttributeSelect: IdsTreeAttributeSelect
   read pm_GetdsTreeAttributeSelect;
   {* БОС формы выбора атрибутов }
  property dsAttributeSelect: IdsAttributeSelect
   read pm_GetdsAttributeSelect;
   {* Бизнес-объект формы cfAttributeSelect }
 end;//IsdsSituation

 TnsFilterForm = (
  {* Типы карточек используемых при редактировании фильтров }
  ns_ffAttributeSearch
   {* ППР 6.х }
  , ns_ffPublishSource
   {* ППиО }
  , ns_ffSituation
   {* ППС }
  , ns_ffOldSituation
   {* старая карточка ППС }
  , ns_ffBaseSearch
   {* Базовый поиск }
  , ns_ffInpharmSearch
 );//TnsFilterForm

 TnsSearchListType = (
  {* Типы используемые для получения списка в nsSearchManager }
  ns_sltWithoutClass
  , ns_sltWithoutKey
  , ns_sltWithoutInluded
 );//TnsSearchListType
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin)

end.
