unit DynamicTreeUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DynamicTreeUnit.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , DynamicTreeDefinesUnit
 , BaseTypesUnit
 , IOUnit
;

const
 {* идентификаторы деревьев }
 AT_ANNO_INTEREST: PAnsiChar = AT_ANNO_INTEREST;
 AT_ANNO_KIND: PAnsiChar = AT_ANNO_KIND;
 AT_ANNO_ORG: PAnsiChar = AT_ANNO_ORG;
 AT_ANNO_TAX: PAnsiChar = AT_ANNO_TAX;
 AT_ANNO_USER: PAnsiChar = AT_ANNO_USER;
 AT_BASES: PAnsiChar = AT_BASES;
 AT_CLASS: PAnsiChar = AT_CLASS;
 AT_EDITION: PAnsiChar = AT_EDITION;
 AT_KW: PAnsiChar = AT_KW;
 AT_NORM: PAnsiChar = AT_NORM;
 AT_PREFIX: PAnsiChar = AT_PREFIX;
 AT_PUBLISH_SOURCE: PAnsiChar = AT_PUBLISH_SOURCE;
 AT_REG_IN_MU_NUM: PAnsiChar = AT_REG_IN_MU_NUM;
 AT_REG_IN_MU: PAnsiChar = AT_REG_IN_MU;
 AT_REG_NUM: PAnsiChar = AT_REG_NUM;
 AT_SOURCE: PAnsiChar = AT_SOURCE;
 AT_STATUS: PAnsiChar = AT_STATUS;
 AT_TERRITORY: PAnsiChar = AT_TERRITORY;
 AT_TYPE: PAnsiChar = AT_TYPE;
 AT_UC: PAnsiChar = AT_UC;
 AT_PHARM_INTERNATIONAL_NAME: PAnsiChar = AT_PHARM_INTERNATIONAL_NAME;
 AT_PHARM_TRADE_NAME: PAnsiChar = AT_PHARM_TRADE_NAME;
 AT_PHARM_CHAPTER: PAnsiChar = AT_PHARM_CHAPTER;
 AT_PHARM_COUNTRY: PAnsiChar = AT_PHARM_COUNTRY;
 AT_PHARM_FIRM: PAnsiChar = AT_PHARM_FIRM;
 AT_PHARM_REG_STATUS: PAnsiChar = AT_PHARM_REG_STATUS;
 AT_PHARM_MEDICINAL_FORM: PAnsiChar = AT_PHARM_MEDICINAL_FORM;
 AT_PHARM_ATC: PAnsiChar = AT_PHARM_ATC;
 AT_PHARM_MKB: PAnsiChar = AT_PHARM_MKB;
 AT_PHARM_GROUP: PAnsiChar = AT_PHARM_GROUP;
 AT_PHARM_EFFECT: PAnsiChar = AT_PHARM_EFFECT;
 AT_PHARM_NARCOTIC: PAnsiChar = AT_PHARM_NARCOTIC;
 AT_PHARM_UNRECIPE: PAnsiChar = AT_PHARM_UNRECIPE;
 AT_PHARM_IMPORTANT: PAnsiChar = AT_PHARM_IMPORTANT;
 AT_PHARM_COUNTRY_FOR_FILTER: PAnsiChar = AT_PHARM_COUNTRY_FOR_FILTER;
 AT_VARIANTS: PAnsiChar = AT_VARIANTS;
  {* дерево подсказок для базового поиска }
 AT_PREFIX_REVIEW: PAnsiChar = AT_PREFIX_REVIEW;
  {* Дерево Видов правовой информации в КЗ ОИЗ }
 AT_PUBLISH_SOURCE_FINANCE: PAnsiChar = AT_PUBLISH_SOURCE_FINANCE;
  {* Ветка дерева Источник опубликования для СМИ по налогам и бухучету }
 AT_PUBLISH_SOURCE_LEGAL: PAnsiChar = AT_PUBLISH_SOURCE_LEGAL;
  {* Ветка дерева Источник опубликования для СМИ для юриста }
 AT_PUBLISH_SOURCE_HR: PAnsiChar = AT_PUBLISH_SOURCE_HR;
  {* Ветка дерева Источник опубликования для СМИ для кадровика }
 AT_PUBLISH_SOURCE_BUDGET_ORGS: PAnsiChar = AT_PUBLISH_SOURCE_BUDGET_ORGS;
  {* Ветка дерева Источник опубликования для СМИ для бюджетных организаций }
 AT_BASE_SEARCH_PANES: PAnsiChar = AT_BASE_SEARCH_PANES;
  {* Вкладки Базового поиска }
 AT_CLASS_REVIEW: PAnsiChar = AT_CLASS_REVIEW;
 AT_SOURCE_REVIEW: PAnsiChar = AT_SOURCE_REVIEW;
 AT_PUBLISH_SOURCE_PHARM: PAnsiChar = AT_PUBLISH_SOURCE_PHARM;
 AT_IMPORTANT_DOCUMENTS: PAnsiChar = AT_IMPORTANT_DOCUMENTS;

type
 IFilterForTree = interface
  {* Абстрактный интерфейс фильтров деревьев }
  ['{2EE1EBDC-4804-47C2-964A-89BABD67A457}']
 end;//IFilterForTree

 IFilterList = array of IFilterForTree;
  {* Список фильтров }

 TContextPlace = (
  CP_ANY
  , CP_BEGIN_OF_WORD
  , CP_BEGIN_OF_PHRASE
  , CP_WHOLE_WORD
 );//TContextPlace

 TIndexInParent = Cardinal;

 TFindOrder = (
  {* Порядок поиска }
  FO_SEQUENCE
  , FO_ANY
 );//TFindOrder

 INodeIndexPath = array of TIndexInParent;
  {* путь в дереве, заданный списком индексов нод }

 TFindPosition = record
  {* Позиция поискового итератора. }
  node: INodeIndexPath;
   {* Путь к ноде данной позиции итератора. }
  begin: Integer;
   {* Начало позиции. }
  end: Integer;
   {* Конец позиции. Если -1 - то до конца. }
 end;//TFindPosition

 TNodeType = unsigned long long;
  {* Пользовательский тип ноды }

 TNodeId = Integer;
  {* Идентификатор ноды дерева }

 TSearchArea = (
  {* Область поиска
SA_IN_ALL_TEXT - используется в контекстном поиске, ищем по всему тексту, результат по каждой ноде это списко всех вхождений любого слова внутри текста одной ноды.
SA_IN_ONE_SENTENCES - используется в контекстном поиске двух и более слов, указывает что слова запроса должны находиться внутри предложения в любом порядке }
  SA_ONE_LEVEL
  , SA_ALL_LEVEL
  , SA_IN_ALL_TEXT
  , SA_IN_ONE_SENTENCES
 );//TSearchArea

 IFindPositionList = array of TFindPosition;
  {* Набор позиций итератора поиска. }

 TVisibleIndex = Integer;
  {* Видимый индекс в дереве }

 TLayerId = unsigned short;
  {* Идентификатор уровня }

 ILayerIdList = array of TLayerId;
  {* Список идентификаторов уровня }

 ISortFilter = interface(IFilterForTree)
  ['{D0268B80-08CD-419D-BDF5-D3DA7A12199D}']
  function Get_type: TSortType;
  procedure Set_type(aValue: TSortType);
  function Get_order: TSortOrder;
  procedure Set_order(aValue: TSortOrder);
  function Get_sub_filter: ISortFilter;
  procedure Set_sub_filter(const aValue: ISortFilter);
  property type: TSortType
   read Get_type
   write Set_type;
  property order: TSortOrder
   read Get_order
   write Set_order;
  property sub_filter: ISortFilter
   read Get_sub_filter
   write Set_sub_filter;
 end;//ISortFilter

 ITrimFilter = interface(IFilterForTree)
  ['{31549898-CEF0-46C3-94D9-1D6FA71A2C65}']
  function Get_is_trimmed: Boolean;
  procedure Set_is_trimmed(aValue: Boolean);
  property is_trimmed: Boolean
   read Get_is_trimmed
   write Set_is_trimmed;
 end;//ITrimFilter

 ILayerFilter = interface(IFilterForTree)
  {* Класс фильтров для переключения визуального уровня (языка) }
  ['{217D0932-BA42-439D-8CCC-77ABAB9F12D6}']
  function Get_layer: TLayerId;
  procedure Set_layer(aValue: TLayerId);
  property layer: TLayerId
   read Get_layer
   write Set_layer;
 end;//ILayerFilter

 IFindIterator = interface
  {* Итератор поиска. }
  ['{7C8B08E1-3BA1-4122-9E2F-4FDCC7935360}']
  function Get_count: Cardinal;
  procedure next;
   {* Перемещенеи итератора на следующий элемент. }
  procedure prev;
   {* Перемещенеи итератора на предыдущий элемент. }
  function get_position: IFindPositionList;
  function is_good: Boolean;
   {* Возвращает true, если по итератору можно получить данные, т.е. position. Иначе итератор за концом, т.е. равен end или вообще пуст }
  function is_first: Boolean;
   {* возвращает true, если нельзя перейти на предыдущий фрагмент }
  property count: Cardinal
   read Get_count;
   {* количество найденных фрагментов }
 end;//IFindIterator

 TNotifierID = Cardinal;

 TEVDGeneratorStyle = (
  {* стиль выливки дерева или нод в evd }
  GS_DEFAULT
   {* выливаем только верхний уровень, нормальные имена }
  , GS_FULL_TREE
   {* выливаем дерево полностью, нормальные имена }
  , GS_TOPIC_AS_NAME
   {* выливаем только верхний уровень, вместо имён используем номера топиков }
 );//TEVDGeneratorStyle

 NoEntity = class
  {* генерируется при попытке получить сущность на ноде которая ее не содержит }
 end;//NoEntity

 NotFound = class
  {* возвращается если get_visible_delta не может найти ноду }
 end;//NotFound

 TPropertyID = PAnsiChar;

 ISettingEntity = interface
  {* абстрактный интерфейс, наследники которого умеют "сохранять" себя в настройках }
  ['{3790FA3D-D4C9-4A31-9864-F3D1CE9E97B1}']
  procedure save_in_setting(id: TPropertyID);
   {* Сохраняет "ссылку" на данный экземпляр в настройках, связывая ее с переданным строковым ключем. Тип ссылки зависит зависит от конкретного класса реализующего джанный интерфейс. }
  function load_from_setting(id: TPropertyID): ISettingEntity;
   {* Восстанавливает "ссылку" из настроек свзанную с данным ключем и данным типом (классом, группой) объеков. }
 end;//ISettingEntity

 INodesClipboard = interface
  {* контейнер для скопированных нод }
  ['{B990C46B-9FF3-4C7C-8C61-2DD226FE644E}']
  function Get_count: Cardinal;
  function as_evd(style: TEVDGeneratorStyle): IStream;
  property count: Cardinal
   read Get_count;
 end;//INodesClipboard

 IFakeFacetForFactory = interface
  {* когда будут локальные интерфейсы, фасет надо грохнуть }
  ['{6AFFD7FC-CA48-450D-8EB7-E7E47E04F9BF}']
 end;//IFakeFacetForFactory

 INodeNotifier = interface
  {* callback интерфейс для оповещения визуального дерева об изменениях на ноде }
  ['{D368CD98-23ED-4EA2-B1A8-E72679D98593}']
  procedure change_children_count(node_index: TVisibleIndex;
   delta: Integer;
   const index_path: INodeIndexPath;
   child_index: TIndexInParent);
   {* нотификация об изменении кол-ва видимых детей на ноде с указвнным индексом. В случае если изменение нод внутри рута не последовательное и не от начала, индекс должен быть задан как -1. 
parent_path - путь к УЗЛУ в котором произашли изменения (если delta < 0 - удаление, если delta > 0 - вставка)
    left_child_index - индекс ребенка в узле: если удаление, то начиная с которого (включительно) мы удаляем delta элементорв; если вставка, то сразу после которого вы вставляем delta элементов.
    left_child_index, может принять "специальное" значение IIP_BEFORE_LEFT_CHILD (-1) - означающее элемент "до первого" - например для вставки в начало детей. }
  procedure reset_children_count;
   {* устанавливает кол-во детей = 0 }
  function is_root_visible: Boolean;
   {* признак аутлайнера что он с видимым рутом }
  function is_one_level: Boolean;
   {* признак аутлайнера что он одноуровневый }
  procedure invalidate(const index_path: INodeIndexPath);
   {* нотификация о необходимости перерисовки. Должна вызываться после change_children_count (которые можно группирвать) или самостоятельно при изменении дерева не связанном с кол-вом детей.
    parent_path - путь к НОДЕ в которой произашли изменения }
  procedure changing;
   {* Начало итерации изменения дерева }
  procedure changed;
   {* Конец итерации изменения дерева }
  function get_id: TNotifierID;
   {* Возвращает уникальный идентификатор объекта }
 end;//INodeNotifier

 IListForFiltering = interface
  ['{89EBBAAC-B4DA-4DAB-9FEE-FE7F4A1BD86A}']
  function Get_count: Cardinal;
  function item(index: Cardinal): IString;
  property count: Cardinal
   read Get_count;
 end;//IListForFiltering

 INodeIterator = interface;

 INodeBase = interface(ISettingEntity)
  {* Базовый интерфейс ноды "новых" деревьев }
  ['{954590CB-D1B3-44B3-8492-650D28A0CD8F}']
  function Get_caption: IString;
  function Get_level: Integer;
  function Get_type: TNodeType;
  procedure Set_type(aValue: TNodeType); { can raise ConstantModify }
  function Get_child_count: Integer;
  function Get_is_expanded: Boolean;
  function Get_entity: IEntityBase; { can raise NoEntity }
  procedure Set_entity(const aValue: IEntityBase);
  function Get_first_child: INodeBase;
  function Get_prev: INodeBase;
  function Get_next: INodeBase;
  function Get_parent: INodeBase;
  procedure add_notifier(var notifier: INodeNotifier);
  function create_view_ex(const filter: IFilterList;
   shared_flags: TFlagMask;
   const sync_node: INodeBase;
   out sync_index: TVisibleIndex;
   levels: Cardinal;
   unfiltered: Boolean;
   auto_open: Boolean;
   truncate_this_view: Boolean): INodeBase;
   {* Расширенная версия метода create_view. (покачто вью всегда создается от рута) }
  function find_node(const node_to_find: INodeBase): INodeBase;
   {* ищет в текущем дереву ноду равную переданной }
  function find_node_path(var node_to_find: INodeBase): INodeIndexPath;
   {* Получение индексного пути ноды. Первый индекс в пути сам узел node_to_find }
  function get_by_sibbling_index(ind: TVisibleIndex): INodeBase;
   {* возвращает ноду-соседа (т.е. "брата" текущей) по индексу }
  function get_by_visible_index(ind: TVisibleIndex): INodeBase;
   {* возвращает ноду по видемому индексу относительно текущей }
  function get_first_fit(const filter: IFilterList): INodeIndexPath;
  function get_flag_count(flag: TFlagMask): Cardinal;
   {* возвращает кол-во зхаданных флагов в текущем поддереве }
  function get_first_level_children_flag_count(flag: TFlagMask): Cardinal;
  function get_node_id: TNodeId;
   {* Получение идентификатора ноды. Обычно возвращает пойнтер, но для документа value->id (), т.е. не уникален. }
  procedure set_node_id(id: TNodeId);
   {* Изменить идентификатор ноды. Обычно ничего не делает, но для документа изменяет value->id (). }
  function get_available_layers: ILayerIdList;
  function get_visible_delta(const node: INodeBase): TVisibleIndex; { can raise NotFound }
   {* возвращает разницу видимых индексов двух нод (может автоматически развернуть необходимые уровни) }
  function get_visible_delta_by_entity(const entity: IEntityBase): TVisibleIndex; { can raise NotFound }
  function get_index_from_parent: TVisibleIndex;
   {* Возвращает порядковый номер узла относительно родителя (начиная с 1) }
  function get_abs_index: TVisibleIndex; { can raise CanNotFindData }
   {* Возвращает абс. индекс для ноды }
  function get_child_path_by_abs_index(index: TVisibleIndex): INodeIndexPath; { can raise CanNotFindData }
   {* Возвращает путь к ноде по её абс. индексу }
  function get_frozen_node: INodeBase;
  function get_unfiltered_node: INodeBase;
  function has_children: Boolean;
   {* признакк есть ли дети }
  function has_children_flag(flag: TFlagMask): Boolean;
   {* признак взведен ли у детей указанный флаг }
  function has_filtered_children: Boolean;
   {* признак того что нода соджержит отфильтрованных детей }
  function has_flag(flag: TFlagMask): Boolean;
   {* признак взведен ли указанный флаг }
  function has_parent_flag(flag: TFlagMask): Boolean;
   {* признак взведен ли у родителей указанный флаг }
  function is_first: Boolean;
   {* признак первый ли это ребенок }
  function is_it_higher(var it: INodeBase): Boolean;
   {* возвращает true если переданная нода (it) выше текущей }
  function is_last: Boolean;
   {* признак последний ли это ребенок }
  function is_same_node(var node: INodeBase): Boolean;
   {* проверяет на равенство две ноды }
  function iterate_nodes(with_flag: TFlagMask): INodeIterator;
   {* возвращает сквозной итератор по нодам с указанным флагом }
  procedure make_visible;
  procedure remove_notifier(var notifier: INodeNotifier);
  procedure set_all_flag(flag: TFlagMask;
   value: Boolean);
   {* устанавливает у всего поддерева (КРОМЕ самой ноды на который была вызвана операция) указанный флаг (сейчас работает всегда от рута, и иногда глючит именно установка, сброс работает корректно) }
  procedure set_flag(flag: TFlagMask;
   value: Boolean);
   {* взводит указанный флаг }
  procedure set_range_flag(offset_from: TVisibleIndex;
   offset_to: TVisibleIndex;
   flag: TFlagMask;
   value: Boolean;
   clean_other: Boolean);
   {* взводит указанный флаг на промежутке }
  procedure delete_nodes(mask: TFlagMask); { can raise ConstantModify }
   {* удаляет все ноды по заданному флагу. ВРЕМЕННО перенесен с каталога на ноду!!! }
  procedure delete_node;
   {* удаляет текущую ноду }
  function copy_nodes(mask: TFlagMask): INodesClipboard;
   {* копирует ноды по заданному флагу и возвращает их в виде контейнера для последующей вставки в любое другое дерево.ВРЕМЕННО перенесен с каталога на ноду!!! }
  procedure add_last_childs(var nodes: INodesClipboard);
   {* вставляет ноды из контейнера в конец списка детей - на самом деле если есть сортировка то позиции вставки могут стать другими, но ОБЯЗАТЕЛЬНО в указанном паранте }
  procedure add_last_child(var node: INodeBase); { can raise ConstantModify }
   {* аналогично add_last_childs но для одной ноды (как-либо полученной например, через create_new_node или напрямую из дерева, если это нода из дерева то будет сделана копия) }
  procedure add_prev_siblings(var nodes: INodesClipboard); { can raise ConstantModify }
   {* аналогично add_last_childs, но ноды вставляется перед указанной как соседи, соответственно КОНСТАНТНЫМ будет парент текущей ноды }
  procedure add_prev_sibling(var node: INodeBase); { can raise ConstantModify }
   {* аналогично add_prev_siblings но для одной ноды }
  procedure start_change_transaction;
   {* указывает на начало транзакции изменения данных ноды. Транзакции могут быть вложенными }
  procedure rollback_change_transaction;
   {* сбрасывает текущщую транзакцию (вместе со всеми вложенными),  сбрасывает все изменения (перечитывает с сервера или внутреннего буффера) }
  procedure commit_change_transaction;
   {* закрывает транзакцию, и если это больше нет "верхних" открытых транзакций - сохраняет все изменения сделанные на ноде (отправляет данные на сервер) }
  function get_node_by_path(const path: INodeIndexPath): INodeBase; { can raise NotFound }
   {* Дублирует с CatalogBase }
  function find(const filter: IFilterList
   {* Условие поиска. };
   const find_from: TNodePosition
   {* Искать от позиции. }): IFindIterator;
   {* Поиск в дереве по условию, заданному в фильтре. В случае успеха возвращает итератор первого вхождения, иначе пустой итератор (is_good!=true). }
  function is_relevance_search_supported: Boolean;
  procedure expand_all(expand: Boolean);
   {* устанавливает и снимает флаг раскрытия всех нод в дереве }
  class function make: BadFactoryType; overload; { can raise CanNotFindData }
  class function make(var owner_tree: IFakeFacetForFactory;
   const snode): BadFactoryType; overload;
  function iterate_all_nodes(with_flag: TFlagMask): INodeIterator;
  procedure set_all_flag_except_first_children_of_root_children(flag: TFlagMask;
   value: Boolean);
  procedure set_range_flag_except_first_children_of_root_children(offset_from: TVisibleIndex;
   offset_to: TVisibleIndex;
   flag: TFlagMask;
   value: Boolean;
   clean_other: Boolean);
  property caption: IString
   read Get_caption;
   {* Пользовательское название ноды }
  property level: Integer
   read Get_level;
   {* уровень ноды в дереве }
  property type: TNodeType
   read Get_type
   write Set_type;
   {* Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться для диффиренцации отображения }
  property child_count: Integer
   read Get_child_count;
  property is_expanded: Boolean
   read Get_is_expanded;
   {* возвращает true, если установлен флаг раскрытия всех нод }
  property entity: IEntityBase
   read Get_entity
   write Set_entity;
  property first_child: INodeBase
   read Get_first_child;
  property prev: INodeBase
   read Get_prev;
  property next: INodeBase
   read Get_next;
  property parent: INodeBase
   read Get_parent;
 end;//INodeBase

 INodeIterator = interface
  {* Интерфейс для получения линейного списка элементов дерева.
Должен поддерживаться пользователем для реализации операций с произвольным набором элементов дерева (например, со списком выделенных элементов). }
  ['{1F4887B9-4FA9-4B90-BB5C-0D3EAB6D0792}']
  function Get_next: INodeBase;
  property next: INodeBase
   read Get_next;
 end;//INodeIterator

 TNodePosition = record
  {* Позиция ноды в дереве и внутри этой ноды. }
  pos: Integer;
   {* Позиция внутри ноды node. }
  node: INodeBase;
 end;//TNodePosition

 ICatalogBase = interface
  {* Менеджер деревьев постренных на основе NodeBase и поддерживающие хранение сущностей (EntityBase). Заменяет устаревший BaseTreeSupport::BaseCatalog }
  ['{59A590F8-FB2D-49E6-A954-1B0CC9CCAD04}']
  function Get_name: IString;
  procedure Set_name(const aValue: IString);
  function Get_root: INodeBase;
  function clone: ICatalogBase;
  function get_node_by_path(const path: INodeIndexPath): INodeBase; { can raise NotFound }
  procedure intersect_tree(const tree: ICatalogBase);
  procedure merge_tree(const tree: ICatalogBase);
  procedure minus_tree(const tree: ICatalogBase);
  function create(var nodes: INodesClipboard): ICatalogBase;
  property name: IString
   read Get_name
   write Set_name;
  property root: INodeBase
   read Get_root;
 end;//ICatalogBase

 ITrimLeafFilter = interface(IFilterForTree)
  ['{7AC01117-FE4F-4D1C-AA39-44B55E57D5F7}']
 end;//ITrimLeafFilter

 ICountryFilter = interface(IFilterForTree)
  ['{88574AB6-4C05-455B-8E61-ACC170D68E31}']
  function Get_country: INodeBase;
  procedure Set_country(const aValue: INodeBase);
  property country: INodeBase
   read Get_country
   write Set_country;
 end;//ICountryFilter

 ICutToLeafCountFilter = interface(IFilterForTree)
  {* оставляет в дереве количество детей, не большее заданного }
  ['{080EAE7F-D346-4600-AA65-6CD21B8C7370}']
  function Get_leaf_count: Cardinal;
  procedure Set_leaf_count(aValue: Cardinal);
  property leaf_count: Cardinal
   read Get_leaf_count
   write Set_leaf_count;
   {* получить число листьев для фильтра }
 end;//ICutToLeafCountFilter

 INodeIdList = array of TNodeId;
  {* список идентификаторов нод }

 IBlocksFilter = interface(IFilterForTree)
  {* Фильтр оставляет только те блоки, которые доступны конкретному пользователю }
  ['{30D760A8-3BA6-47C7-A2A7-08F504585CB8}']
 end;//IBlocksFilter

 IInpharmFilter = interface(IFilterForTree)
  {* не показывать в дереве блоков блоки для инфарм }
  ['{9F35901C-BCED-426C-9B29-45F0EFCA688C}']
 end;//IInpharmFilter

 IVariantsForDocFilter = interface(IFilterForTree)
  {* получить подсказки для заданного документа }
  ['{7E6C4CC8-5E83-4074-BC63-93286053A532}']
  function Get_doc_id: Cardinal;
  property doc_id: Cardinal
   read Get_doc_id;
   {* идентификатор документа }
 end;//IVariantsForDocFilter

 IFiltered = array of Cardinal;

 IContextFilter = interface(IFilterForTree)
  {* Класс контекстных фильтров }
  ['{FCB4593F-FD35-46E5-87BB-7112D61FEC5A}']
  function Get_place: TContextPlace;
  procedure Set_place(aValue: TContextPlace);
  function Get_order: TFindOrder;
  procedure Set_order(aValue: TFindOrder);
  function Get_area: TSearchArea;
  procedure Set_area(aValue: TSearchArea);
  function Get_context: IString;
  procedure Set_context(const aValue: IString);
  function clone: IContextFilter;
  function filtrate(const list: IListForFiltering): IFiltered;
  property place: TContextPlace
   read Get_place
   write Set_place;
  property order: TFindOrder
   read Get_order
   write Set_order;
  property area: TSearchArea
   read Get_area
   write Set_area;
  property context: IString
   read Get_context
   write Set_context;
 end;//IContextFilter

const
 {* Константы для флагов }
 FM_SHARED_NONE: TFlagMask = 0;
 FM_OPEN: TFlagMask = 2;
 FM_SELECTION: TFlagMask = 1;
 FM_FIRST_USER_FLAG: TFlagMask = 4;
 FM_USER_FLAG_MASK: TFlagMask = 65532;
 FM_SHARED_ALL: TFlagMask = 65535;
 IIP_BEFORE_LEFT_CHILD: TIndexInParent = 4294967295;
 VI_ALL_CHILDREN: TVisibleIndex = -1;
  {* Уведомление об изменении всех узлов. }
 {* константы типов ноды }
 NT_UNKNOWN: TNodeType = 0;

class function make: BadFactoryType;
class function make(const iterator): BadFactoryType;
class function make: BadFactoryType; overload;
class function make(const node_holder): BadFactoryType; overload;
class function make: BadFactoryType;
class function make(const country: INodeBase): BadFactoryType;
class function make(leaf_count: Cardinal): BadFactoryType;
 {* создает фильтр, оставляющий в дереве не более leaf_count листьев }
class function make(doc_id: Cardinal): BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
var
 l_Inst : IFilterForTree;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const iterator): BadFactoryType;
var
 l_Inst : IFindIterator;
begin
 l_Inst := Create(iterator);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : INodesClipboard;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const node_holder): BadFactoryType;
var
 l_Inst : INodesClipboard;
begin
 l_Inst := Create(node_holder);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : INodeIterator;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const country: INodeBase): BadFactoryType;
var
 l_Inst : ICountryFilter;
begin
 l_Inst := Create(country);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(leaf_count: Cardinal): BadFactoryType;
 {* создает фильтр, оставляющий в дереве не более leaf_count листьев }
var
 l_Inst : ICutToLeafCountFilter;
begin
 l_Inst := Create(leaf_count);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(doc_id: Cardinal): BadFactoryType;
var
 l_Inst : IVariantsForDocFilter;
begin
 l_Inst := Create(doc_id);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
