unit DynamicTreeUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DynamicTreeUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "DynamicTree" MUID: (457450470167)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , SearchDefinesUnit
 , DynamicTreeDefinesUnit
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
  node: ;
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
  function GetType: TSortType; stdcall;
  procedure SetType(aValue: TSortType); stdcall;
  function GetOrder: TSortOrder; stdcall;
  procedure SetOrder(aValue: TSortOrder); stdcall;
  procedure GetSubFilter; stdcall;
  procedure SetSubFilter(const aValue); stdcall;
  property Type: TSortType
   read GetType
   write SetType;
  property Order: TSortOrder
   read GetOrder
   write SetOrder;
  property SubFilter: 
   read GetSubFilter
   write SetSubFilter;
 end;//ISortFilter

 ITrimFilter = interface(IFilterForTree)
  ['{31549898-CEF0-46C3-94D9-1D6FA71A2C65}']
  function GetIsTrimmed: ByteBool; stdcall;
  procedure SetIsTrimmed(const aValue: ByteBool); stdcall;
  property IsTrimmed: ByteBool
   read GetIsTrimmed
   write SetIsTrimmed;
 end;//ITrimFilter

 ILayerFilter = interface(IFilterForTree)
  {* Класс фильтров для переключения визуального уровня (языка) }
  ['{217D0932-BA42-439D-8CCC-77ABAB9F12D6}']
  function GetLayer: TLayerId; stdcall;
  procedure SetLayer(aValue: TLayerId); stdcall;
  property Layer: TLayerId
   read GetLayer
   write SetLayer;
 end;//ILayerFilter

 IFindIterator = interface
  {* Итератор поиска. }
  ['{7C8B08E1-3BA1-4122-9E2F-4FDCC7935360}']
  function GetCount: Cardinal; stdcall;
  procedure Next; stdcall;
   {* Перемещенеи итератора на следующий элемент. }
  procedure Prev; stdcall;
   {* Перемещенеи итератора на предыдущий элемент. }
  procedure GetPosition(out aRet
   {* IFindPositionList }); stdcall;
  function IsGood: ByteBool; stdcall;
   {* Возвращает true, если по итератору можно получить данные, т.е. position. Иначе итератор за концом, т.е. равен end или вообще пуст }
  function IsFirst: ByteBool; stdcall;
   {* возвращает true, если нельзя перейти на предыдущий фрагмент }
  property Count: Cardinal
   read GetCount;
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
  procedure SaveInSetting(id: TPropertyID); stdcall;
   {* Сохраняет "ссылку" на данный экземпляр в настройках, связывая ее с переданным строковым ключем. Тип ссылки зависит зависит от конкретного класса реализующего джанный интерфейс. }
  procedure LoadFromSetting(id: TPropertyID;
   out aRet
   {* ISettingEntity }); stdcall;
   {* Восстанавливает "ссылку" из настроек свзанную с данным ключем и данным типом (классом, группой) объеков. }
 end;//ISettingEntity

 INodesClipboard = interface
  {* контейнер для скопированных нод }
  ['{B990C46B-9FF3-4C7C-8C61-2DD226FE644E}']
  function GetCount: Cardinal; stdcall;
  procedure AsEvd(style: TEVDGeneratorStyle;
   out aRet
   {* IStream }); stdcall;
  property Count: Cardinal
   read GetCount;
 end;//INodesClipboard

 IFakeFacetForFactory = interface
  {* когда будут локальные интерфейсы, фасет надо грохнуть }
  ['{6AFFD7FC-CA48-450D-8EB7-E7E47E04F9BF}']
 end;//IFakeFacetForFactory

 INodeNotifier = interface
  {* callback интерфейс для оповещения визуального дерева об изменениях на ноде }
  ['{D368CD98-23ED-4EA2-B1A8-E72679D98593}']
  procedure ChangeChildrenCount(node_index: TVisibleIndex;
   delta: Integer;
   const index_path: INodeIndexPath;
   child_index: TIndexInParent); stdcall;
   {* нотификация об изменении кол-ва видимых детей на ноде с указвнным индексом. В случае если изменение нод внутри рута не последовательное и не от начала, индекс должен быть задан как -1. 
parent_path - путь к УЗЛУ в котором произашли изменения (если delta < 0 - удаление, если delta > 0 - вставка)
    left_child_index - индекс ребенка в узле: если удаление, то начиная с которого (включительно) мы удаляем delta элементорв; если вставка, то сразу после которого вы вставляем delta элементов.
    left_child_index, может принять "специальное" значение IIP_BEFORE_LEFT_CHILD (-1) - означающее элемент "до первого" - например для вставки в начало детей. }
  procedure ResetChildrenCount; stdcall;
   {* устанавливает кол-во детей = 0 }
  function IsRootVisible: ByteBool; stdcall;
   {* признак аутлайнера что он с видимым рутом }
  function IsOneLevel: ByteBool; stdcall;
   {* признак аутлайнера что он одноуровневый }
  procedure Invalidate(const index_path: INodeIndexPath); stdcall;
   {* нотификация о необходимости перерисовки. Должна вызываться после change_children_count (которые можно группирвать) или самостоятельно при изменении дерева не связанном с кол-вом детей.
    parent_path - путь к НОДЕ в которой произашли изменения }
  procedure Changing; stdcall;
   {* Начало итерации изменения дерева }
  procedure Changed; stdcall;
   {* Конец итерации изменения дерева }
  function GetId: TNotifierID; stdcall;
   {* Возвращает уникальный идентификатор объекта }
 end;//INodeNotifier

 IListForFiltering = interface
  ['{89EBBAAC-B4DA-4DAB-9FEE-FE7F4A1BD86A}']
  function GetCount: Cardinal; stdcall;
  procedure Item(index: Cardinal;
   out aRet
   {* IString }); stdcall;
  property Count: Cardinal
   read GetCount;
 end;//IListForFiltering

 INodeIterator = interface;

 INodeBase = interface(ISettingEntity)
  {* Базовый интерфейс ноды "новых" деревьев }
  ['{954590CB-D1B3-44B3-8492-650D28A0CD8F}']
  procedure GetCaption; stdcall;
  function GetLevel: Integer; stdcall;
  function GetType: TNodeType; stdcall;
  procedure SetType(aValue: TNodeType); stdcall; { can raise ConstantModify }
  function GetChildCount: Integer; stdcall;
  function GetIsExpanded: ByteBool; stdcall;
  procedure GetEntity; stdcall; { can raise NoEntity }
  procedure SetEntity(const aValue); stdcall;
  procedure GetFirstChild; stdcall;
  procedure GetPrev; stdcall;
  procedure GetNext; stdcall;
  procedure GetParent; stdcall;
  procedure AddNotifier(var notifier: INodeNotifier); stdcall;
  procedure CreateViewEx(const filter: IFilterList;
   shared_flags: TFlagMask;
   const sync_node: INodeBase;
   out sync_index: TVisibleIndex;
   levels: Cardinal;
   unfiltered: Boolean;
   auto_open: Boolean;
   truncate_this_view: Boolean;
   out aRet
   {* INodeBase }); stdcall;
   {* Расширенная версия метода create_view. (покачто вью всегда создается от рута) }
  procedure FindNode(const node_to_find: INodeBase;
   out aRet
   {* INodeBase }); stdcall;
   {* ищет в текущем дереву ноду равную переданной }
  procedure FindNodePath(var node_to_find: INodeBase;
   out aRet
   {* INodeIndexPath }); stdcall;
   {* Получение индексного пути ноды. Первый индекс в пути сам узел node_to_find }
  procedure GetBySibblingIndex(ind: TVisibleIndex;
   out aRet
   {* INodeBase }); stdcall;
   {* возвращает ноду-соседа (т.е. "брата" текущей) по индексу }
  procedure GetByVisibleIndex(ind: TVisibleIndex;
   out aRet
   {* INodeBase }); stdcall;
   {* возвращает ноду по видемому индексу относительно текущей }
  procedure GetFirstFit(const filter: IFilterList;
   out aRet
   {* INodeIndexPath }); stdcall;
  function GetFlagCount(flag: TFlagMask): Cardinal; stdcall;
   {* возвращает кол-во зхаданных флагов в текущем поддереве }
  function GetFirstLevelChildrenFlagCount(flag: TFlagMask): Cardinal; stdcall;
  function GetNodeId: TNodeId; stdcall;
   {* Получение идентификатора ноды. Обычно возвращает пойнтер, но для документа value->id (), т.е. не уникален. }
  procedure SetNodeId(id: TNodeId); stdcall;
   {* Изменить идентификатор ноды. Обычно ничего не делает, но для документа изменяет value->id (). }
  procedure GetAvailableLayers(out aRet
   {* ILayerIdList }); stdcall;
  function GetVisibleDelta(const node: INodeBase): TVisibleIndex; stdcall; { can raise NotFound }
   {* возвращает разницу видимых индексов двух нод (может автоматически развернуть необходимые уровни) }
  function GetVisibleDeltaByEntity(const entity: IEntityBase): TVisibleIndex; stdcall; { can raise NotFound }
  function GetIndexFromParent: TVisibleIndex; stdcall;
   {* Возвращает порядковый номер узла относительно родителя (начиная с 1) }
  function GetAbsIndex: TVisibleIndex; stdcall; { can raise CanNotFindData }
   {* Возвращает абс. индекс для ноды }
  procedure GetChildPathByAbsIndex(index: TVisibleIndex;
   out aRet
   {* INodeIndexPath }); stdcall; { can raise CanNotFindData }
   {* Возвращает путь к ноде по её абс. индексу }
  procedure GetFrozenNode(out aRet
   {* INodeBase }); stdcall;
  procedure GetUnfilteredNode(out aRet
   {* INodeBase }); stdcall;
  function HasChildren: ByteBool; stdcall;
   {* признакк есть ли дети }
  function HasChildrenFlag(flag: TFlagMask): ByteBool; stdcall;
   {* признак взведен ли у детей указанный флаг }
  function HasFilteredChildren: ByteBool; stdcall;
   {* признак того что нода соджержит отфильтрованных детей }
  function HasFlag(flag: TFlagMask): ByteBool; stdcall;
   {* признак взведен ли указанный флаг }
  function HasParentFlag(flag: TFlagMask): ByteBool; stdcall;
   {* признак взведен ли у родителей указанный флаг }
  function IsFirst: ByteBool; stdcall;
   {* признак первый ли это ребенок }
  function IsItHigher(var it: INodeBase): ByteBool; stdcall;
   {* возвращает true если переданная нода (it) выше текущей }
  function IsLast: ByteBool; stdcall;
   {* признак последний ли это ребенок }
  function IsSameNode(var node: INodeBase): ByteBool; stdcall;
   {* проверяет на равенство две ноды }
  procedure IterateNodes(with_flag: TFlagMask;
   out aRet
   {* INodeIterator }); stdcall;
   {* возвращает сквозной итератор по нодам с указанным флагом }
  procedure MakeVisible; stdcall;
  procedure RemoveNotifier(var notifier: INodeNotifier); stdcall;
  procedure SetAllFlag(flag: TFlagMask;
   value: Boolean); stdcall;
   {* устанавливает у всего поддерева (КРОМЕ самой ноды на который была вызвана операция) указанный флаг (сейчас работает всегда от рута, и иногда глючит именно установка, сброс работает корректно) }
  procedure SetFlag(flag: TFlagMask;
   value: Boolean); stdcall;
   {* взводит указанный флаг }
  procedure SetRangeFlag(offset_from: TVisibleIndex;
   offset_to: TVisibleIndex;
   flag: TFlagMask;
   value: Boolean;
   clean_other: Boolean); stdcall;
   {* взводит указанный флаг на промежутке }
  procedure DeleteNodes(mask: TFlagMask); stdcall; { can raise ConstantModify }
   {* удаляет все ноды по заданному флагу. ВРЕМЕННО перенесен с каталога на ноду!!! }
  procedure DeleteNode; stdcall;
   {* удаляет текущую ноду }
  procedure CopyNodes(mask: TFlagMask;
   out aRet
   {* INodesClipboard }); stdcall;
   {* копирует ноды по заданному флагу и возвращает их в виде контейнера для последующей вставки в любое другое дерево.ВРЕМЕННО перенесен с каталога на ноду!!! }
  procedure AddLastChilds(var nodes: INodesClipboard); stdcall;
   {* вставляет ноды из контейнера в конец списка детей - на самом деле если есть сортировка то позиции вставки могут стать другими, но ОБЯЗАТЕЛЬНО в указанном паранте }
  procedure AddLastChild(var node: INodeBase); stdcall; { can raise ConstantModify }
   {* аналогично add_last_childs но для одной ноды (как-либо полученной например, через create_new_node или напрямую из дерева, если это нода из дерева то будет сделана копия) }
  procedure AddPrevSiblings(var nodes: INodesClipboard); stdcall; { can raise ConstantModify }
   {* аналогично add_last_childs, но ноды вставляется перед указанной как соседи, соответственно КОНСТАНТНЫМ будет парент текущей ноды }
  procedure AddPrevSibling(var node: INodeBase); stdcall; { can raise ConstantModify }
   {* аналогично add_prev_siblings но для одной ноды }
  procedure StartChangeTransaction; stdcall;
   {* указывает на начало транзакции изменения данных ноды. Транзакции могут быть вложенными }
  procedure RollbackChangeTransaction; stdcall;
   {* сбрасывает текущщую транзакцию (вместе со всеми вложенными),  сбрасывает все изменения (перечитывает с сервера или внутреннего буффера) }
  procedure CommitChangeTransaction; stdcall;
   {* закрывает транзакцию, и если это больше нет "верхних" открытых транзакций - сохраняет все изменения сделанные на ноде (отправляет данные на сервер) }
  procedure GetNodeByPath(const path: INodeIndexPath;
   out aRet
   {* INodeBase }); stdcall; { can raise NotFound }
   {* Дублирует с CatalogBase }
  procedure Find(const filter: IFilterList
   {* Условие поиска. };
   const find_from: TNodePosition
   {* Искать от позиции. };
   out aRet
   {* IFindIterator }); stdcall;
   {* Поиск в дереве по условию, заданному в фильтре. В случае успеха возвращает итератор первого вхождения, иначе пустой итератор (is_good!=true). }
  function IsRelevanceSearchSupported: ByteBool; stdcall;
  procedure ExpandAll(expand: Boolean); stdcall;
   {* устанавливает и снимает флаг раскрытия всех нод в дереве }
  class function Make; overload; stdcall; { can raise CanNotFindData }
  class function Make(var owner_tree: IFakeFacetForFactory;
   const snode); overload; stdcall;
  procedure IterateAllNodes(with_flag: TFlagMask;
   out aRet
   {* INodeIterator }); stdcall;
  procedure SetAllFlagExceptFirstChildrenOfRootChildren(flag: TFlagMask;
   value: Boolean); stdcall;
  procedure SetRangeFlagExceptFirstChildrenOfRootChildren(offset_from: TVisibleIndex;
   offset_to: TVisibleIndex;
   flag: TFlagMask;
   value: Boolean;
   clean_other: Boolean); stdcall;
  property Caption: 
   read GetCaption;
   {* Пользовательское название ноды }
  property Level: Integer
   read GetLevel;
   {* уровень ноды в дереве }
  property Type: TNodeType
   read GetType
   write SetType;
   {* Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться для диффиренцации отображения }
  property ChildCount: Integer
   read GetChildCount;
  property IsExpanded: ByteBool
   read GetIsExpanded;
   {* возвращает true, если установлен флаг раскрытия всех нод }
  property Entity: 
   read GetEntity
   write SetEntity;
  property FirstChild: 
   read GetFirstChild;
  property Prev: 
   read GetPrev;
  property Next: 
   read GetNext;
  property Parent: 
   read GetParent;
 end;//INodeBase

 INodeIterator = interface
  {* Интерфейс для получения линейного списка элементов дерева.
Должен поддерживаться пользователем для реализации операций с произвольным набором элементов дерева (например, со списком выделенных элементов). }
  ['{1F4887B9-4FA9-4B90-BB5C-0D3EAB6D0792}']
  procedure GetNext; stdcall;
  property Next: 
   read GetNext;
 end;//INodeIterator

 TNodePosition = record
  {* Позиция ноды в дереве и внутри этой ноды. }
  pos: Integer;
   {* Позиция внутри ноды node. }
  node: ;
 end;//TNodePosition

 ICatalogBase = interface
  {* Менеджер деревьев постренных на основе NodeBase и поддерживающие хранение сущностей (EntityBase). Заменяет устаревший BaseTreeSupport::BaseCatalog }
  ['{59A590F8-FB2D-49E6-A954-1B0CC9CCAD04}']
  procedure GetName; stdcall;
  procedure SetName(const aValue); stdcall;
  procedure GetRoot; stdcall;
  procedure Clone(out aRet
   {* ICatalogBase }); stdcall;
  procedure GetNodeByPath(const path: INodeIndexPath;
   out aRet
   {* INodeBase }); stdcall; { can raise NotFound }
  procedure IntersectTree(const tree: ICatalogBase); stdcall;
  procedure MergeTree(const tree: ICatalogBase); stdcall;
  procedure MinusTree(const tree: ICatalogBase); stdcall;
  procedure Create(var nodes: INodesClipboard;
   out aRet
   {* ICatalogBase }); stdcall;
  property Name: 
   read GetName
   write SetName;
  property Root: 
   read GetRoot;
 end;//ICatalogBase

 ITrimLeafFilter = interface(IFilterForTree)
  ['{7AC01117-FE4F-4D1C-AA39-44B55E57D5F7}']
 end;//ITrimLeafFilter

 ICountryFilter = interface(IFilterForTree)
  ['{88574AB6-4C05-455B-8E61-ACC170D68E31}']
  procedure GetCountry; stdcall;
  procedure SetCountry(const aValue); stdcall;
  property Country: 
   read GetCountry
   write SetCountry;
 end;//ICountryFilter

 ICutToLeafCountFilter = interface(IFilterForTree)
  {* оставляет в дереве количество детей, не большее заданного }
  ['{080EAE7F-D346-4600-AA65-6CD21B8C7370}']
  function GetLeafCount: Cardinal; stdcall;
  procedure SetLeafCount(aValue: Cardinal); stdcall;
  property LeafCount: Cardinal
   read GetLeafCount
   write SetLeafCount;
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
  function GetDocId: Cardinal; stdcall;
  property DocId: Cardinal
   read GetDocId;
   {* идентификатор документа }
 end;//IVariantsForDocFilter

 IFiltered = array of Cardinal;

 IContextFilter = interface(IFilterForTree)
  {* Класс контекстных фильтров }
  ['{FCB4593F-FD35-46E5-87BB-7112D61FEC5A}']
  function GetPlace: TContextPlace; stdcall;
  procedure SetPlace(aValue: TContextPlace); stdcall;
  function GetOrder: TFindOrder; stdcall;
  procedure SetOrder(aValue: TFindOrder); stdcall;
  function GetArea: TSearchArea; stdcall;
  procedure SetArea(aValue: TSearchArea); stdcall;
  procedure GetContext; stdcall;
  procedure SetContext(const aValue); stdcall;
  procedure Clone(out aRet
   {* IContextFilter }); stdcall;
  procedure Filtrate(const list: IListForFiltering;
   out aRet
   {* IFiltered }); stdcall;
  property Place: TContextPlace
   read GetPlace
   write SetPlace;
  property Order: TFindOrder
   read GetOrder
   write SetOrder;
  property Area: TSearchArea
   read GetArea
   write SetArea;
  property Context: 
   read GetContext
   write SetContext;
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

implementation

uses
 l3ImplUses
;

end.
