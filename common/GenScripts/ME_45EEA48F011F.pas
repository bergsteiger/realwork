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
;

type
 IFilterFromQuery = interface
  ['{A81EFF04-FAB6-4D1B-846B-66C301594470}']
  function Get_name: IString;
  procedure Set_name(const aValue: IString);
  function Get_query: IEntityBase;
  function Get_changeable: Boolean;
  function Get_permanent: Boolean;
  procedure Set_permanent(aValue: Boolean);
  function Get_id: Cardinal;
  function Get_flags: Cardinal;
  procedure mark_to_erase;
   {* удалить фильтр после того, как он перестанет использоваться }
  function is_same(const other: IFilterFromQuery): Boolean;
   {* возвращает true, если оригинальный и переданный фильтры совпадают }
  procedure get_server_query;
  procedure save_to_server(const query);
  function check: Boolean;
   {* проверить атрибуты в фильтре }
  function marked_to_erase: Boolean;
  function is_used: Boolean;
   {* наложен ли фильтр }
  property name: IString
   read Get_name
   write Set_name;
  property query: IEntityBase
   read Get_query;
   {* если делать query Search::Query, каковым он и является, на модели получается дофига циклических связей, которые небыстро будет развязать }
  property changeable: Boolean
   read Get_changeable;
  property permanent: Boolean
   read Get_permanent
   write Set_permanent;
  property id: Cardinal
   read Get_id;
   {* идентификатор нужен оболочке, чтобы идентифицировать установленные фильтры (К274848126) }
  property flags: Cardinal
   read Get_flags;
 end;//IFilterFromQuery

 NotAllAttributesRestored = class
  {* Не все атрибуты поискового запроса восстановлны из базы }
 end;//NotAllAttributesRestored

 IFiltersFromQuery = array of IFilterFromQuery;
  {* контейнер фильтров. }

 IFilterable = interface
  {* Интерфейс фильтруемости. Должен поддерживаться объектами, желающими предоставлять сервис фильтров. Сейчас используется для списков. }
  ['{4C08EC41-3957-462B-B9C1-FB91B86469BA}']
  function Get_has_active_filters: Boolean;
  function Get_active_filters: IFiltersFromQuery;
  procedure add_filter(var filter: IFilterFromQuery;
   auto_refresh: Boolean); { can raise AllContentIsFiltered, NotAllAttributesRestored }
   {* Добавляет INode (из дерева папок) как фильтр. 
Если auto_refresh = true (значение по умолчанию), то
операция приводит к перефильтрации объекта. }
  procedure delete_filter(const filter: IFilterFromQuery;
   auto_refresh: Boolean); { can raise CanNotFindData, AllContentIsFiltered }
   {* Удаляет фильтр из списка активных фильтров объекта. Если auto_refresh = true (значение по умолчанию), то операция приводит к перефильтрации объекта. }
  procedure clear_filters; { can raise CanNotFindData }
   {* Удаляет все фильтры. В результате операции объект переходит в состояние, соответвующее отсутствию фильтров }
  procedure refresh_filters; { can raise CanNotFindData, AllContentIsFiltered }
  procedure apply_filters(const filters: IFiltersFromQuery); { can raise CanNotFindData, AllContentIsFiltered }
   {* Добавляет пачку фильтров с одновременным их применением. При этом эта пачка либо целиком применяется, либо (в случае, если все документы отфильтрованы) целиком отклоняется.

Если выясняется, что на сервере нет данных для построения списка, т.е. списка как такового нет (см. К244711732), летит CanNotFindData. }
  property has_active_filters: Boolean
   read Get_has_active_filters;
  property active_filters: IFiltersFromQuery
   read Get_active_filters;
 end;//IFilterable

 IFilterNotifier = interface
  ['{F41C0D69-A5BC-4836-9F33-85807FCAC1A7}']
  procedure filters_changed;
  procedure filter_name_changed;
  procedure filter_permanence_changed;
 end;//IFilterNotifier

 IFiltersManager = interface
  ['{854B1550-A048-4551-AB1C-6FD08FDAF723}']
  function get_legal_filters: IFiltersFromQuery;
   {* получить список фильтров для правовых документов }
  function get_pharm_filters: IFiltersFromQuery;
  procedure create_filter(const query: IEntityBase;
   const name: IString);
   {* создать новый фильтр }
  procedure set_legal_notifier(var notifier: IFilterNotifier);
  procedure set_pharm_notifier(var notifier: IFilterNotifier);
  procedure filter_name_changed(pharm: Boolean);
  procedure filter_permanence_changed(pharm: Boolean);
  procedure filter_removed(pharm: Boolean);
  procedure clear_cache(pharm: Boolean);
 end;//IFiltersManager

class function make(const filter): BadFactoryType;
class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make(const filter): BadFactoryType;
var
 l_Inst : IFilterFromQuery;
begin
 l_Inst := Create(filter);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IFiltersManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
