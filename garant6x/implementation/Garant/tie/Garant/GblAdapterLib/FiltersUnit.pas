unit FiltersUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/FiltersUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Filters
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  BaseTypesUnit,
  BaseTreeSupportUnit
  ;

type
 IFilterFromQuery = interface(IUnknown)
   ['{A81EFF04-FAB6-4D1B-846B-66C301594470}']
   function GetName: IString; stdcall;
   procedure SetName(const aValue: IString); stdcall;
   function GetQuery: IEntityBase; stdcall;
   function GetChangeable: ByteBool; stdcall;
   function GetPermanent: ByteBool; stdcall;
   procedure SetPermanent(aValue: Boolean); stdcall;
   function GetId: Cardinal; stdcall;
   function GetFlags: Cardinal; stdcall;
   procedure MarkToErase; stdcall;
     {* удалить фильтр после того, как он перестанет использоваться }
   function IsSame(const aOther: IFilterFromQuery): ByteBool; stdcall;
     {* возвращает true, если оригинальный и переданный фильтры совпадают }
   procedure GetServerQuery; stdcall;
   procedure SaveToServer(aQuery); stdcall;
   function Check: ByteBool; stdcall;
     {* проверить атрибуты в фильтре }
   function MarkedToErase: ByteBool; stdcall;
   function IsUsed: ByteBool; stdcall;
     {* наложен ли фильтр }
   property name: IString
     read GetName
     write SetName;
   property query: IEntityBase
     read GetQuery;
     {* если делать query Search::Query, каковым он и является, на модели получается дофига циклических связей, которые небыстро будет развязать }
   property changeable: ByteBool
     read GetChangeable;
   property permanent: ByteBool
     read GetPermanent
     write SetPermanent;
   property id: Cardinal
     read GetId;
     {* идентификатор нужен оболочке, чтобы идентифицировать установленные фильтры (К274848126) }
   property flags: Cardinal
     read GetFlags;
 end;//IFilterFromQuery

 NotAllAttributesRestored = class
  {* Не все атрибуты поискового запроса восстановлны из базы }
 end;//NotAllAttributesRestored

 IFiltersFromQuery = array of IFilterFromQuery;
  {* контейнер фильтров. }

 IFilterable = interface(IUnknown)
  {* Интерфейс фильтруемости. Должен поддерживаться объектами, желающими предоставлять сервис фильтров. Сейчас используется для списков. }
   ['{4C08EC41-3957-462B-B9C1-FB91B86469BA}']
   function GetHasActiveFilters: ByteBool; stdcall;
   function GetActiveFilters: IFiltersFromQuery; stdcall;
   procedure AddFilter(var aFilter: IFilterFromQuery;
    aAutoRefresh: Boolean); stdcall; // can raise AllContentIsFiltered, NotAllAttributesRestored
     {* Добавляет INode (из дерева папок) как фильтр. 
Если auto_refresh = true (значение по умолчанию), то
операция приводит к перефильтрации объекта. }
   procedure DeleteFilter(const aFilter: IFilterFromQuery;
    aAutoRefresh: Boolean); stdcall; // can raise CanNotFindData
     {* Удаляет фильтр из списка активных фильтров объекта. Если auto_refresh = true (значение по умолчанию), то операция приводит к перефильтрации объекта. }
   procedure ClearFilters; stdcall; // can raise CanNotFindData
     {* Удаляет все фильтры. В результате операции объект переходит в состояние, соответвующее отсутствию фильтров }
   procedure RefreshFilters; stdcall; // can raise CanNotFindData, AllContentIsFiltered
   procedure ApplyFilters(const aFilters: IFiltersFromQuery); stdcall; // can raise CanNotFindData
     {* Добавляет пачку фильтров с одновременным их применением. При этом эта пачка либо целиком применяется, либо (в случае, если все документы отфильтрованы) целиком отклоняется.

Если выясняется, что на сервере нет данных для построения списка, т.е. списка как такового нет (см. К244711732), летит CanNotFindData. }
   property has_active_filters: ByteBool
     read GetHasActiveFilters;
   property active_filters: IFiltersFromQuery
     read GetActiveFilters;
 end;//IFilterable

 IFilterNotifier = interface(IUnknown)
   ['{F41C0D69-A5BC-4836-9F33-85807FCAC1A7}']
   procedure FiltersChanged; stdcall;
   procedure FilterNameChanged; stdcall;
   procedure FilterPermanenceChanged; stdcall;
 end;//IFilterNotifier

 IFiltersManager = interface(IUnknown)
   ['{854B1550-A048-4551-AB1C-6FD08FDAF723}']
   procedure GetLegalFilters(out aRet {: IFiltersFromQuery}); stdcall;
     {* получить список фильтров для правовых документов }
   procedure GetPharmFilters(out aRet {: IFiltersFromQuery}); stdcall;
   procedure CreateFilter(const aQuery: IEntityBase;
    const aName: IString); stdcall;
     {* создать новый фильтр }
   procedure SetLegalNotifier(var aNotifier: IFilterNotifier); stdcall;
   procedure SetPharmNotifier(var aNotifier: IFilterNotifier); stdcall;
   procedure FilterNameChanged(aPharm: Boolean); stdcall;
   procedure FilterPermanenceChanged(aPharm: Boolean); stdcall;
   procedure FilterRemoved(aPharm: Boolean); stdcall;
   procedure ClearCache(aPharm: Boolean); stdcall;
 end;//IFiltersManager

implementation

end.