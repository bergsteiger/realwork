unit QueryCardInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/QueryCardInterfaces.pas"
// Начат: 07.09.2009 22:26
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 Common For Shell And Monitoring::Search::Search::QueryCardInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  SearchUnit
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  SearchInterfaces,
  SimpleListInterfaces,
  vcmControllers {a}
  ;

type
 IdeQuery = SearchUnit.IQuery;
  {* Данные для инициализации форм поиска }

 IdsQuery = interface(IvcmViewAreaController)
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

 IdsSaveLoad = interface(IvcmViewAreaController)
  {* Бизнес объект контейнера карточки поиска }
   ['{E5584C58-C6DF-42D0-B1AE-ACB317071F37}']
 end;//IdsSaveLoad

 IsdsAttributeSelect = interface(IvcmUseCaseController)
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

 IsdsSituation = interface(IsdsAttributeSelect{, IucpFilters, IbsCurrentChangedListener, IbsSelectedAttributes})
   ['{53453074-B221-4E0D-8FB1-538D5C3A930D}']
   function pm_GetDsFilters: IdsFilters;
   function pm_GetDsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel;
   function pm_GetDsSaveLoad: IdsSaveLoad;
   function pm_GetDsSelectedAttributes: IdsSelectedAttributes;
   function pm_GetDsTreeAttributeSelect: IdsTreeAttributeSelect;
   function pm_GetDsAttributeSelect: IdsAttributeSelect;
   property dsFilters: IdsFilters
     read pm_GetDsFilters;
     {* БОС формы фильтры }
   property dsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel
     read pm_GetDsTreeAttributeFirstLevel;
     {* БОС формы "Ситуации первого уровня" }
   property dsSaveLoad: IdsSaveLoad
     read pm_GetDsSaveLoad;
     {* БОС формы контейнер карточек запроса }
   property dsSelectedAttributes: IdsSelectedAttributes
     read pm_GetDsSelectedAttributes;
     {* БОС формы выбранные атрибуты }
   property dsTreeAttributeSelect: IdsTreeAttributeSelect
     read pm_GetDsTreeAttributeSelect;
     {* БОС формы выбора атрибутов }
   property dsAttributeSelect: IdsAttributeSelect
     read pm_GetDsAttributeSelect;
     {* Бизнес-объект формы cfAttributeSelect }
  // Методы преобразования к реализуемым интерфейсам
   function As_IucpFilters: IucpFilters;
   function As_IbsCurrentChangedListener: IbsCurrentChangedListener;
   function As_IbsSelectedAttributes: IbsSelectedAttributes;
 end;//IsdsSituation

 TnsFilterForm = (
  {* Типы карточек используемых при редактировании фильтров }
   ns_ffAttributeSearch // ППР 6.х
 , ns_ffPublishSource // ППиО
 , ns_ffSituation // ППС
 , ns_ffOldSituation // старая карточка ППС
 , ns_ffBaseSearch // Базовый поиск
 , ns_ffInpharmSearch
 );//TnsFilterForm

 TnsSearchListType = (
  {* Типы используемые для получения списка в nsSearchManager }
   ns_sltWithoutClass
 , ns_sltWithoutKey
 , ns_sltWithoutInluded
 );//TnsSearchListType
{$IfEnd} //not Admin

implementation

end.