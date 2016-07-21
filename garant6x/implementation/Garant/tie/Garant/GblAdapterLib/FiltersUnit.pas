unit FiltersUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\FiltersUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "Filters" MUID: (45EEA48F011F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , BaseTreeSupportUnit
;

type
 IFilterFromQuery = interface
  ['{A81EFF04-FAB6-4D1B-846B-66C301594470}']
  procedure GetName; stdcall;
  procedure SetName(const aValue); stdcall;
  procedure GetQuery; stdcall;
  function GetChangeable: ByteBool; stdcall;
  function GetPermanent: ByteBool; stdcall;
  procedure SetPermanent(const aValue: ByteBool); stdcall;
  function GetId: Cardinal; stdcall;
  function GetFlags: Cardinal; stdcall;
  procedure MarkToErase; stdcall;
   {* удалить фильтр после того, как он перестанет использоваться }
  function IsSame(const other: IFilterFromQuery): ByteBool; stdcall;
   {* возвращает true, если оригинальный и переданный фильтры совпадают }
  procedure GetServerQuery; stdcall;
  procedure SaveToServer(const query); stdcall;
  function Check: ByteBool; stdcall;
   {* проверить атрибуты в фильтре }
  function MarkedToErase: ByteBool; stdcall;
  function IsUsed: ByteBool; stdcall;
   {* наложен ли фильтр }
  property Name: 
   read GetName
   write SetName;
  property Query: 
   read GetQuery;
   {* если делать query Search::Query, каковым он и является, на модели получается дофига циклических связей, которые небыстро будет развязать }
  property Changeable: ByteBool
   read GetChangeable;
  property Permanent: ByteBool
   read GetPermanent
   write SetPermanent;
  property Id: Cardinal
   read GetId;
   {* идентификатор нужен оболочке, чтобы идентифицировать установленные фильтры (К274848126) }
  property Flags: Cardinal
   read GetFlags;
 end;//IFilterFromQuery

 NotAllAttributesRestored = class
  {* Не все атрибуты поискового запроса восстановлны из базы }
 end;//NotAllAttributesRestored

 IFiltersFromQuery = array of IFilterFromQuery;
  {* контейнер фильтров. }

 IFilterable = interface
  {* Интерфейс фильтруемости. Должен поддерживаться объектами, желающими предоставлять сервис фильтров. Сейчас используется для списков. }
  ['{4C08EC41-3957-462B-B9C1-FB91B86469BA}']
  function GetHasActiveFilters: ByteBool; stdcall;
  procedure GetActiveFilters; stdcall;
  procedure AddFilter(var filter: IFilterFromQuery;
   auto_refresh: Boolean); stdcall; { can raise AllContentIsFiltered, NotAllAttributesRestored }
   {* Добавляет INode (из дерева папок) как фильтр. 
Если auto_refresh = true (значение по умолчанию), то
операция приводит к перефильтрации объекта. }
  procedure DeleteFilter(const filter: IFilterFromQuery;
   auto_refresh: Boolean); stdcall; { can raise CanNotFindData, AllContentIsFiltered }
   {* Удаляет фильтр из списка активных фильтров объекта. Если auto_refresh = true (значение по умолчанию), то операция приводит к перефильтрации объекта. }
  procedure ClearFilters; stdcall; { can raise CanNotFindData }
   {* Удаляет все фильтры. В результате операции объект переходит в состояние, соответвующее отсутствию фильтров }
  procedure RefreshFilters; stdcall; { can raise CanNotFindData, AllContentIsFiltered }
  procedure ApplyFilters(const filters: IFiltersFromQuery); stdcall; { can raise CanNotFindData, AllContentIsFiltered }
   {* Добавляет пачку фильтров с одновременным их применением. При этом эта пачка либо целиком применяется, либо (в случае, если все документы отфильтрованы) целиком отклоняется.

Если выясняется, что на сервере нет данных для построения списка, т.е. списка как такового нет (см. К244711732), летит CanNotFindData. }
  property HasActiveFilters: ByteBool
   read GetHasActiveFilters;
  property ActiveFilters: 
   read GetActiveFilters;
 end;//IFilterable

 IFilterNotifier = interface
  ['{F41C0D69-A5BC-4836-9F33-85807FCAC1A7}']
  procedure FiltersChanged; stdcall;
  procedure FilterNameChanged; stdcall;
  procedure FilterPermanenceChanged; stdcall;
 end;//IFilterNotifier

 IFiltersManager = interface
  ['{854B1550-A048-4551-AB1C-6FD08FDAF723}']
  procedure GetLegalFilters(out aRet
   {* IFiltersFromQuery }); stdcall;
   {* получить список фильтров для правовых документов }
  procedure GetPharmFilters(out aRet
   {* IFiltersFromQuery }); stdcall;
  procedure CreateFilter(const query: IEntityBase;
   const name: IString); stdcall;
   {* создать новый фильтр }
  procedure SetLegalNotifier(var notifier: IFilterNotifier); stdcall;
  procedure SetPharmNotifier(var notifier: IFilterNotifier); stdcall;
  procedure FilterNameChanged(pharm: Boolean); stdcall;
  procedure FilterPermanenceChanged(pharm: Boolean); stdcall;
  procedure FilterRemoved(pharm: Boolean); stdcall;
  procedure ClearCache(pharm: Boolean); stdcall;
 end;//IFiltersManager

implementation

uses
 l3ImplUses
;

end.
