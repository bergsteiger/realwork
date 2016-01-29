unit DynamicTreeUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicTreeUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	, BaseTypesUnit
	, SearchDefinesUnit
	, DynamicTreeDefinesUnit
	//#UC START# *4423F94903C8_457450470167_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_457450470167_UNIT_FOR_Stream*
	;

type

IFilterForTree = interface;
{ - предварительное описание IFilterForTree. }

IFilterList = interface;
{ - предварительное описание IFilterList. }

INodeIndexPath = interface;
{ - предварительное описание INodeIndexPath. }

IFindPositionList = interface;
{ - предварительное описание IFindPositionList. }

ILayerIdList = interface;
{ - предварительное описание ILayerIdList. }

ISortFilter = interface;
{ - предварительное описание ISortFilter. }

ITrimFilter = interface;
{ - предварительное описание ITrimFilter. }

ILayerFilter = interface;
{ - предварительное описание ILayerFilter. }

IFindIterator = interface;
{ - предварительное описание IFindIterator. }

ISettingEntity = interface;
{ - предварительное описание ISettingEntity. }

INodesClipboard = interface;
{ - предварительное описание INodesClipboard. }

INodeBase = interface;
{ - предварительное описание INodeBase. }

INodeIterator = interface;
{ - предварительное описание INodeIterator. }

ICatalogBase = interface;
{ - предварительное описание ICatalogBase. }

ITrimLeafFilter = interface;
{ - предварительное описание ITrimLeafFilter. }

ICountryFilter = interface;
{ - предварительное описание ICountryFilter. }

ICutToLeafCountFilter = interface;
{ - предварительное описание ICutToLeafCountFilter. }

INodeIdList = interface;
{ - предварительное описание INodeIdList. }

IBlocksFilter = interface;
{ - предварительное описание IBlocksFilter. }

IInpharmFilter = interface;
{ - предварительное описание IInpharmFilter. }

IVariantsForDocFilter = interface;
{ - предварительное описание IVariantsForDocFilter. }

IFiltered = interface;
{ - предварительное описание IFiltered. }

IContextFilter = interface;
{ - предварительное описание IContextFilter. }


PContextPlace = ^TContextPlace;
TContextPlace = (
	CP_ANY
	, CP_BEGIN_OF_WORD
	, CP_BEGIN_OF_PHRASE
	, CP_WHOLE_WORD
);

PIndexInParent = ^TIndexInParent;
TIndexInParent = Longword;

// Порядок поиска
PFindOrder = ^TFindOrder;
TFindOrder = (
	FO_SEQUENCE
	, FO_ANY
);

// Позиция поискового итератора.
PFindPosition = ^TFindPosition;
TFindPosition = packed record
	rNode: INodeIndexPath; // Путь к ноде данной позиции итератора.
	rBegin: Longint; // Начало позиции.
	rEnd: Longint; // Конец позиции. Если -1 - то до конца.
end;

// Пользовательский тип ноды
PNodeType = ^TNodeType;
TNodeType = Int64;

// Идентификатор ноды дерева
PNodeId = ^TNodeId;
TNodeId = Longint;

// Область поиска
// SA_IN_ALL_TEXT - используется в контекстном поиске, ищем по всему тексту, результат по каждой
// ноде это списко всех вхождений любого слова внутри текста одной ноды.
// SA_IN_ONE_SENTENCES - используется в контекстном поиске двух и более слов, указывает что слова
// запроса должны находиться внутри предложения в любом порядке
PSearchArea = ^TSearchArea;
TSearchArea = (
	SA_ONE_LEVEL
	, SA_ALL_LEVEL
	, SA_IN_ALL_TEXT
	, SA_IN_ONE_SENTENCES
);

// Видимый индекс в дереве
PVisibleIndex = ^TVisibleIndex;
TVisibleIndex = Longint;

// Идентификатор уровня
PLayerId = ^TLayerId;
TLayerId = Word;

PNotifierID = ^TNotifierID;
TNotifierID = Longword;

// стиль выливки дерева или нод в evd
PEVDGeneratorStyle = ^TEVDGeneratorStyle;
TEVDGeneratorStyle = (
	GS_DEFAULT // выливаем только верхний уровень, нормальные имена
	, GS_FULL_TREE // выливаем дерево полностью, нормальные имена
	, GS_TOPIC_AS_NAME // выливаем только верхний уровень, вместо имён используем номера топиков
);

// генерируется при попытке получить сущность на ноде которая ее не содержит
ENoEntity = class (Exception);

// возвращается если get_visible_delta не может найти ноду
ENotFound = class (Exception);

PPropertyID = ^TPropertyID;
TPropertyID = PAnsiChar;

// когда будут локальные интерфейсы, фасет надо грохнуть
IFakeFacetForFactory = interface (IInterface) ['{6AFFD7FC-CA48-450D-8EB7-E7E47E04F9BF}']
	function DontUseMe: Pointer;

end;

// callback интерфейс для оповещения визуального дерева об изменениях на ноде
INodeNotifier = interface (IInterface) ['{D368CD98-23ED-4EA2-B1A8-E72679D98593}']
	// нотификация об изменении кол-ва видимых детей на ноде с указвнным индексом. В случае если
	// изменение нод внутри рута не последовательное и не от начала, индекс должен быть задан как -1.
	// parent_path - путь к УЗЛУ в котором произашли изменения (если delta < 0 - удаление, если delta
	// > 0 - вставка)
	// left_child_index - индекс ребенка в узле: если удаление, то начиная с которого
	// (включительно) мы удаляем delta элементорв; если вставка, то сразу после которого вы вставляем
	// delta элементов.
	// left_child_index, может принять "специальное" значение IIP_BEFORE_LEFT_CHILD (-1) -
	// означающее элемент "до первого" - например для вставки в начало детей.
	procedure ChangeChildrenCount (
		aNodeIndex: TVisibleIndex;
		aDelta: Longint;
		const aIndexPath: INodeIndexPath;
		aChildIndex: TIndexInParent
	); stdcall;

	// Конец итерации изменения дерева
	procedure Changed (); stdcall;

	// Начало итерации изменения дерева
	procedure Changing (); stdcall;

	// Возвращает уникальный идентификатор объекта
	function GetId (): TNotifierID; stdcall;

	// нотификация о необходимости перерисовки. Должна вызываться после change_children_count (которые
	// можно группирвать) или самостоятельно при изменении дерева не связанном с кол-вом детей.
	// parent_path - путь к НОДЕ в которой произашли изменения
	procedure Invalidate (
		const aIndexPath: INodeIndexPath
	); stdcall;

	// признак аутлайнера что он одноуровневый
	function IsOneLevel (): Bytebool; stdcall;

	// признак аутлайнера что он с видимым рутом
	function IsRootVisible (): Bytebool; stdcall;

	// устанавливает кол-во детей = 0
	procedure ResetChildrenCount (); stdcall;
end;

IListForFiltering = interface (IInterface) ['{89EBBAAC-B4DA-4DAB-9FEE-FE7F4A1BD86A}']
	function GetCount (): Longword; stdcall;

	procedure Item (
		aIndex: Longword;
		out aRet {: IString}
	); stdcall;
end;

// Позиция ноды в дереве и внутри этой ноды.
PNodePosition = ^TNodePosition;
TNodePosition = packed record
	rPos: Longint; // Позиция внутри ноды node.
	rNode: INodeBase;
end;

// Абстрактный интерфейс фильтров деревьев
IFilterForTree = interface (IInterface) ['{2EE1EBDC-4804-47C2-964A-89BABD67A457}']
	function DontUseMe: Pointer;

end;

IFilterList = interface(IInterface)
['{B0B31EED-B9B1-4C7F-9177-C090C9FB6E95}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы для доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удаляет элемент по индексу Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* число элементов в хранилище. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: IFilterForTree); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IFilterForTree); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IFilterForTree): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: IFilterForTree); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IFilterList

INodeIndexPath = interface(IInterface)
['{E3DAF1B3-4170-4A80-9C3E-D372F46719CC}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы для доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удаляет элемент по индексу Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* число элементов в хранилище. }
  // property methods
    function  pm_GetItem(anIndex: Integer): TIndexInParent; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TIndexInParent); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TIndexInParent): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TIndexInParent); stdcall;
      {* - вставляет элемент Item по индексу Index. }
  // public properties
    property  Items[anIndex: Integer]: TIndexInParent
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - элементы списка. }
end;//INodeIndexPath

IFindPositionList = interface(IInterface)
['{DDC91DC6-F8F6-4682-AEB9-77B7D574E9A5}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы для доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удаляет элемент по индексу Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* число элементов в хранилище. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: TFindPosition); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TFindPosition); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TFindPosition): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TFindPosition); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IFindPositionList

ILayerIdList = interface(IInterface)
['{65349303-26F4-4D82-A588-1C425E8040D0}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы для доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удаляет элемент по индексу Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* число элементов в хранилище. }
  // property methods
    function  pm_GetItem(anIndex: Integer): TLayerId; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TLayerId); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TLayerId): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TLayerId); stdcall;
      {* - вставляет элемент Item по индексу Index. }
  // public properties
    property  Items[anIndex: Integer]: TLayerId
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - элементы списка. }
end;//ILayerIdList

ISortFilter = interface (IFilterForTree) ['{D0268B80-08CD-419D-BDF5-D3DA7A12199D}']
	function GetOrder (): TSortOrder; stdcall;
	procedure SetOrder (aOrder: TSortOrder); stdcall;

	procedure GetSubFilter (out aRet {: ISortFilter}); stdcall;
	procedure SetSubFilter (const aSubFilter: ISortFilter); stdcall;

	function GetType (): TSortType; stdcall;
	procedure SetType (aType: TSortType); stdcall;
end;

ITrimFilter = interface (IFilterForTree) ['{31549898-CEF0-46C3-94D9-1D6FA71A2C65}']
	function GetIsTrimmed (): Bytebool; stdcall;
	procedure SetIsTrimmed (aIsTrimmed: Bytebool); stdcall;
end;

// Класс фильтров для переключения визуального уровня (языка)
ILayerFilter = interface (IFilterForTree) ['{217D0932-BA42-439D-8CCC-77ABAB9F12D6}']
	function GetLayer (): TLayerId; stdcall;
	procedure SetLayer (aLayer: TLayerId); stdcall;
end;

// Итератор поиска.
IFindIterator = interface (IInterface) ['{7C8B08E1-3BA1-4122-9E2F-4FDCC7935360}']
	function DontUseMe: Pointer;
	// количество найденных фрагментов
	function GetCount (): Longword; stdcall;

	procedure GetPosition (
		out aRet {: IFindPositionList}
	); stdcall;

	// возвращает true, если нельзя перейти на предыдущий фрагмент
	function IsFirst (): Bytebool; stdcall;

	// Возвращает true, если по итератору можно получить данные, т.е. position. Иначе итератор за
	// концом, т.е. равен end или вообще пуст
	function IsGood (): Bytebool; stdcall;

	// Перемещенеи итератора на следующий элемент.
	procedure Next (); stdcall;

	// Перемещенеи итератора на предыдущий элемент.
	procedure Prev (); stdcall;
end;

// абстрактный интерфейс, наследники которого умеют "сохранять" себя в настройках
ISettingEntity = interface (IInterface) ['{3790FA3D-D4C9-4A31-9864-F3D1CE9E97B1}']
	function DontUseMe: Pointer;
	// Восстанавливает "ссылку" из настроек свзанную с данным ключем и данным типом (классом, группой)
	// объеков.
	procedure LoadFromSetting (
		const aId: TPropertyID;
		out aRet {: ISettingEntity}
	); stdcall;

	// Сохраняет "ссылку" на данный экземпляр в настройках, связывая ее с переданным строковым ключем.
	// Тип ссылки зависит зависит от конкретного класса реализующего джанный интерфейс.
	procedure SaveInSetting (
		const aId: TPropertyID
	); stdcall;
end;

// контейнер для скопированных нод
INodesClipboard = interface (IInterface) ['{B990C46B-9FF3-4C7C-8C61-2DD226FE644E}']
	function DontUseMe: Pointer;
	procedure AsEvd (
		aStyle: TEVDGeneratorStyle;
		out aRet {: IStream}
	); stdcall;

	function GetCount (): Longword; stdcall;
end;

// Базовый интерфейс ноды "новых" деревьев
INodeBase = interface (ISettingEntity) ['{954590CB-D1B3-44B3-8492-650D28A0CD8F}']
	// аналогично add_last_childs но для одной ноды (как-либо полученной например, через
	// create_new_node или напрямую из дерева, если это нода из дерева то будет сделана копия)
	procedure AddLastChild (
		const aNode: INodeBase
	); stdcall; // can raise EConstantModify

	// вставляет ноды из контейнера в конец списка детей - на самом деле если есть сортировка то
	// позиции вставки могут стать другими, но ОБЯЗАТЕЛЬНО в указанном паранте
	procedure AddLastChilds (
		const aNodes: INodesClipboard
	); stdcall;

	procedure AddNotifier (
		const aNotifier: INodeNotifier
	); stdcall;

	// аналогично add_prev_siblings но для одной ноды
	procedure AddPrevSibling (
		const aNode: INodeBase
	); stdcall; // can raise EConstantModify

	// аналогично add_last_childs, но ноды вставляется перед указанной как соседи, соответственно
	// КОНСТАНТНЫМ будет парент текущей ноды
	procedure AddPrevSiblings (
		const aNodes: INodesClipboard
	); stdcall; // can raise EConstantModify

	// Пользовательское название ноды
	procedure GetCaption (out aRet {: IString}); stdcall;

	function GetChildCount (): Longint; stdcall;

	// закрывает транзакцию, и если это больше нет "верхних" открытых транзакций - сохраняет все
	// изменения сделанные на ноде (отправляет данные на сервер)
	procedure CommitChangeTransaction (); stdcall;

	// копирует ноды по заданному флагу и возвращает их в виде контейнера для последующей вставки в
	// любое другое дерево.ВРЕМЕННО перенесен с каталога на ноду!!!
	procedure CopyNodes (
		aMask: TFlagMask;
		out aRet {: INodesClipboard}
	); stdcall;

	// Расширенная версия метода create_view. (покачто вью всегда создается от рута)
	procedure CreateViewEx (
		const aFilter: IFilterList;
		aSharedFlags: TFlagMask;
		const aSyncNode: INodeBase;
		out aSyncIndex: TVisibleIndex;
		aLevels: Longword;
		aUnfiltered: Bytebool;
		aAutoOpen: Bytebool;
		aTruncateThisView: Bytebool;
		out aRet {: INodeBase}
	); stdcall;

	// удаляет текущую ноду
	procedure DeleteNode (); stdcall;

	// удаляет все ноды по заданному флагу. ВРЕМЕННО перенесен с каталога на ноду!!!
	procedure DeleteNodes (
		aMask: TFlagMask
	); stdcall; // can raise EConstantModify

	procedure GetEntity (out aRet {: IEntityBase}); stdcall;
	procedure SetEntity (const aEntity: IEntityBase); stdcall;

	// устанавливает и снимает флаг раскрытия всех нод в дереве
	procedure ExpandAll (
		aExpand: Bytebool
	); stdcall;

	// Поиск в дереве по условию, заданному в фильтре. В случае успеха возвращает итератор первого
	// вхождения, иначе пустой итератор (is_good!=true).
	procedure Find (
		const aFilter: IFilterList;
		const aFindFrom: TNodePosition;
		out aRet {: IFindIterator}
	); stdcall;

	// ищет в текущем дереву ноду равную переданной
	procedure FindNode (
		const aNodeToFind: INodeBase;
		out aRet {: INodeBase}
	); stdcall;

	// Получение индексного пути ноды. Первый индекс в пути сам узел node_to_find
	procedure FindNodePath (
		const aNodeToFind: INodeBase;
		out aRet {: INodeIndexPath}
	); stdcall;

	procedure GetFirstChild (out aRet {: INodeBase}); stdcall;

	// Возвращает абс. индекс для ноды
	function GetAbsIndex (): TVisibleIndex; stdcall; // can raise ECanNotFindData

	procedure GetAvailableLayers (
		out aRet {: ILayerIdList}
	); stdcall;

	// возвращает ноду-соседа (т.е. "брата" текущей) по индексу
	procedure GetBySibblingIndex (
		aInd: TVisibleIndex;
		out aRet {: INodeBase}
	); stdcall;

	// возвращает ноду по видемому индексу относительно текущей
	procedure GetByVisibleIndex (
		aInd: TVisibleIndex;
		out aRet {: INodeBase}
	); stdcall;

	// Возвращает путь к ноде по её абс. индексу
	procedure GetChildPathByAbsIndex (
		aIndex: TVisibleIndex;
		out aRet {: INodeIndexPath}
	); stdcall; // can raise ECanNotFindData

	procedure GetFirstFit (
		const aFilter: IFilterList;
		out aRet {: INodeIndexPath}
	); stdcall;

	function GetFirstLevelChildrenFlagCount (
		aFlag: TFlagMask
	): Longword; stdcall;

	// возвращает кол-во зхаданных флагов в текущем поддереве
	function GetFlagCount (
		aFlag: TFlagMask
	): Longword; stdcall;

	procedure GetFrozenNode (
		out aRet {: INodeBase}
	); stdcall;

	// Возвращает порядковый номер узла относительно родителя (начиная с 1)
	function GetIndexFromParent (): TVisibleIndex; stdcall;

	// Дублирует с CatalogBase
	procedure GetNodeByPath (
		const aPath: INodeIndexPath;
		out aRet {: INodeBase}
	); stdcall; // can raise ENotFound

	// Получение идентификатора ноды. Обычно возвращает пойнтер, но для документа value->id (), т.е.
	// не уникален.
	function GetNodeId (): TNodeId; stdcall;

	procedure GetUnfilteredNode (
		out aRet {: INodeBase}
	); stdcall;

	// возвращает разницу видимых индексов двух нод (может автоматически развернуть необходимые уровни)
	function GetVisibleDelta (
		const aNode: INodeBase
	): TVisibleIndex; stdcall; // can raise ENotFound

	function GetVisibleDeltaByEntity (
		const aEntity: IEntityBase
	): TVisibleIndex; stdcall; // can raise ENotFound

	// признакк есть ли дети
	function HasChildren (): Bytebool; stdcall;

	// признак взведен ли у детей указанный флаг
	function HasChildrenFlag (
		aFlag: TFlagMask
	): Bytebool; stdcall;

	// признак того что нода соджержит отфильтрованных детей
	function HasFilteredChildren (): Bytebool; stdcall;

	// признак взведен ли указанный флаг
	function HasFlag (
		aFlag: TFlagMask
	): Bytebool; stdcall;

	// признак взведен ли у родителей указанный флаг
	function HasParentFlag (
		aFlag: TFlagMask
	): Bytebool; stdcall;

	// возвращает true, если установлен флаг раскрытия всех нод
	function GetIsExpanded (): Bytebool; stdcall;

	// признак первый ли это ребенок
	function IsFirst (): Bytebool; stdcall;

	// возвращает true если переданная нода (it) выше текущей
	function IsItHigher (
		const aIt: INodeBase
	): Bytebool; stdcall;

	// признак последний ли это ребенок
	function IsLast (): Bytebool; stdcall;

	function IsRelevanceSearchSupported (): Bytebool; stdcall;

	// проверяет на равенство две ноды
	function IsSameNode (
		const aNode: INodeBase
	): Bytebool; stdcall;

	procedure IterateAllNodes (
		aWithFlag: TFlagMask;
		out aRet {: INodeIterator}
	); stdcall;

	// возвращает сквозной итератор по нодам с указанным флагом
	procedure IterateNodes (
		aWithFlag: TFlagMask;
		out aRet {: INodeIterator}
	); stdcall;

	// уровень ноды в дереве
	function GetLevel (): Longint; stdcall;

	procedure MakeVisible (); stdcall;

	procedure GetNext (out aRet {: INodeBase}); stdcall;

	procedure GetParent (out aRet {: INodeBase}); stdcall;

	procedure GetPrev (out aRet {: INodeBase}); stdcall;

	procedure RemoveNotifier (
		const aNotifier: INodeNotifier
	); stdcall;

	// сбрасывает текущщую транзакцию (вместе со всеми вложенными),  сбрасывает все изменения
	// (перечитывает с сервера или внутреннего буффера)
	procedure RollbackChangeTransaction (); stdcall;

	// устанавливает у всего поддерева (КРОМЕ самой ноды на который была вызвана операция) указанный
	// флаг (сейчас работает всегда от рута, и иногда глючит именно установка, сброс работает
	// корректно)
	procedure SetAllFlag (
		aFlag: TFlagMask;
		aValue: Bytebool
	); stdcall;

	procedure SetAllFlagExceptFirstChildrenOfRootChildren (
		aFlag: TFlagMask;
		aValue: Bytebool
	); stdcall;

	// взводит указанный флаг
	procedure SetFlag (
		aFlag: TFlagMask;
		aValue: Bytebool
	); stdcall;

	// Изменить идентификатор ноды. Обычно ничего не делает, но для документа изменяет value->id ().
	procedure SetNodeId (
		aId: TNodeId
	); stdcall;

	// взводит указанный флаг на промежутке
	procedure SetRangeFlag (
		aOffsetFrom: TVisibleIndex;
		aOffsetTo: TVisibleIndex;
		aFlag: TFlagMask;
		aValue: Bytebool;
		aCleanOther: Bytebool
	); stdcall;

	procedure SetRangeFlagExceptFirstChildrenOfRootChildren (
		aOffsetFrom: TVisibleIndex;
		aOffsetTo: TVisibleIndex;
		aFlag: TFlagMask;
		aValue: Bytebool;
		aCleanOther: Bytebool
	); stdcall;

	// указывает на начало транзакции изменения данных ноды. Транзакции могут быть вложенными
	procedure StartChangeTransaction (); stdcall;

	// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
	// для диффиренцации отображения
	function GetType (): TNodeType; stdcall;
	procedure SetType (aType: TNodeType); stdcall;
end;

// Интерфейс для получения линейного списка элементов дерева.
// Должен поддерживаться пользователем для реализации операций с произвольным набором элементов
// дерева (например, со списком выделенных элементов).
INodeIterator = interface (IInterface) ['{1F4887B9-4FA9-4B90-BB5C-0D3EAB6D0792}']
	function DontUseMe: Pointer;
	procedure GetNext (out aRet {: INodeBase}); stdcall;
end;

// Менеджер деревьев постренных на основе NodeBase и поддерживающие хранение сущностей
// (EntityBase). Заменяет устаревший BaseTreeSupport::BaseCatalog
ICatalogBase = interface (IInterface) ['{59A590F8-FB2D-49E6-A954-1B0CC9CCAD04}']
	function DontUseMe: Pointer;
	procedure Clone (
		out aRet {: ICatalogBase}
	); stdcall;

	procedure Create (
		const aNodes: INodesClipboard;
		out aRet {: ICatalogBase}
	); stdcall;

	procedure GetNodeByPath (
		const aPath: INodeIndexPath;
		out aRet {: INodeBase}
	); stdcall; // can raise ENotFound

	procedure IntersectTree (
		const aTree: ICatalogBase
	); stdcall;

	procedure MergeTree (
		const aTree: ICatalogBase
	); stdcall;

	procedure MinusTree (
		const aTree: ICatalogBase
	); stdcall;

	procedure GetName (out aRet {: IString}); stdcall;
	procedure SetName (const aName: IString); stdcall;

	procedure GetRoot (out aRet {: INodeBase}); stdcall;
end;

ITrimLeafFilter = interface (IFilterForTree) ['{7AC01117-FE4F-4D1C-AA39-44B55E57D5F7}']

end;

ICountryFilter = interface (IFilterForTree) ['{88574AB6-4C05-455B-8E61-ACC170D68E31}']
	procedure GetCountry (out aRet {: INodeBase}); stdcall;
	procedure SetCountry (const aCountry: INodeBase); stdcall;
end;

// оставляет в дереве количество детей, не большее заданного
ICutToLeafCountFilter = interface (IFilterForTree) ['{080EAE7F-D346-4600-AA65-6CD21B8C7370}']
	// получить число листьев для фильтра
	function GetLeafCount (): Longword; stdcall;
	procedure SetLeafCount (aLeafCount: Longword); stdcall;
end;

INodeIdList = interface(IInterface)
['{645EE87E-58A6-4EFD-9C27-FF98DEF4AC9E}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы для доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удаляет элемент по индексу Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* число элементов в хранилище. }
  // property methods
    function  pm_GetItem(anIndex: Integer): TNodeId; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TNodeId); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TNodeId): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TNodeId); stdcall;
      {* - вставляет элемент Item по индексу Index. }
  // public properties
    property  Items[anIndex: Integer]: TNodeId
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - элементы списка. }
end;//INodeIdList

// Фильтр оставляет только те блоки, которые доступны конкретному пользователю
IBlocksFilter = interface (IFilterForTree) ['{30D760A8-3BA6-47C7-A2A7-08F504585CB8}']

end;

// не показывать в дереве блоков блоки для инфарм
IInpharmFilter = interface (IFilterForTree) ['{9F35901C-BCED-426C-9B29-45F0EFCA688C}']

end;

// получить подсказки для заданного документа
IVariantsForDocFilter = interface (IFilterForTree) ['{7E6C4CC8-5E83-4074-BC63-93286053A532}']

end;

IFiltered = interface(IInterface)
['{B8FD4E84-685B-4A65-BA63-C4E83B8A50EE}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы для доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удаляет элемент по индексу Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* число элементов в хранилище. }
  // property methods
    function  pm_GetItem(anIndex: Integer): Longword; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: Longword); stdcall;
      {-}
  // public methods
    function  Add(const anItem: Longword): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: Longword); stdcall;
      {* - вставляет элемент Item по индексу Index. }
  // public properties
    property  Items[anIndex: Integer]: Longword
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - элементы списка. }
end;//IFiltered

// Класс контекстных фильтров
IContextFilter = interface (IFilterForTree) ['{FCB4593F-FD35-46E5-87BB-7112D61FEC5A}']
	function GetArea (): TSearchArea; stdcall;
	procedure SetArea (aArea: TSearchArea); stdcall;

	procedure Clone (
		out aRet {: IContextFilter}
	); stdcall;

	procedure GetContext (out aRet {: IString}); stdcall;
	procedure SetContext (const aContext: IString); stdcall;

	procedure Filtrate (
		const aList: IListForFiltering;
		out aRet {: IFiltered}
	); stdcall;

	function GetOrder (): TFindOrder; stdcall;
	procedure SetOrder (aOrder: TFindOrder); stdcall;

	function GetPlace (): TContextPlace; stdcall;
	procedure SetPlace (aPlace: TContextPlace); stdcall;
end;

const

 { Константы для флагов }
	FM_SHARED_NONE = TFlagMask(0);
	FM_OPEN = TFlagMask(2);
	FM_SELECTION = TFlagMask(1);
	FM_FIRST_USER_FLAG = TFlagMask(4);
	FM_USER_FLAG_MASK = TFlagMask(65532);
	FM_SHARED_ALL = TFlagMask(65535);
	IIP_BEFORE_LEFT_CHILD = TIndexInParent(4294967295);
	VI_ALL_CHILDREN = TVisibleIndex(-1);
 { Уведомление об изменении всех узлов. }

 { константы типов ноды }
	NT_UNKNOWN = TNodeType(0);

 { идентификаторы деревьев }
	AT_ANNO_INTEREST = 'AT_ANNO_INTEREST';
	AT_ANNO_KIND = 'AT_ANNO_KIND';
	AT_ANNO_ORG = 'AT_ANNO_ORG';
	AT_ANNO_TAX = 'AT_ANNO_TAX';
	AT_ANNO_USER = 'AT_ANNO_USER';
	AT_BASES = 'AT_BASES';
	AT_CLASS = 'AT_CLASS';
	AT_EDITION = 'AT_EDITION';
	AT_KW = 'AT_KW';
	AT_NORM = 'AT_NORM';
	AT_PREFIX = 'AT_PREFIX';
	AT_PUBLISH_SOURCE = 'AT_PUBLISH_SOURCE';
	AT_REG_IN_MU_NUM = 'AT_REG_IN_MU_NUM';
	AT_REG_IN_MU = 'AT_REG_IN_MU';
	AT_REG_NUM = 'AT_REG_NUM';
	AT_SOURCE = 'AT_SOURCE';
	AT_STATUS = 'AT_STATUS';
	AT_TERRITORY = 'AT_TERRITORY';
	AT_TYPE = 'AT_TYPE';
	AT_UC = 'AT_UC';
	AT_PHARM_INTERNATIONAL_NAME = 'AT_PHARM_INTERNATIONAL_NAME';
	AT_PHARM_TRADE_NAME = 'AT_PHARM_TRADE_NAME';
	AT_PHARM_CHAPTER = 'AT_PHARM_CHAPTER';
	AT_PHARM_COUNTRY = 'AT_PHARM_COUNTRY';
	AT_PHARM_FIRM = 'AT_PHARM_FIRM';
	AT_PHARM_REG_STATUS = 'AT_PHARM_REG_STATUS';
	AT_PHARM_MEDICINAL_FORM = 'AT_PHARM_MEDICINAL_FORM';
	AT_PHARM_ATC = 'AT_PHARM_ATC';
	AT_PHARM_MKB = 'AT_PHARM_MKB';
	AT_PHARM_GROUP = 'AT_PHARM_GROUP';
	AT_PHARM_EFFECT = 'AT_PHARM_EFFECT';
	AT_PHARM_NARCOTIC = 'AT_PHARM_NARCOTIC';
	AT_PHARM_UNRECIPE = 'AT_PHARM_UNRECIPE';
	AT_PHARM_IMPORTANT = 'AT_PHARM_IMPORTANT';
	AT_PHARM_COUNTRY_FOR_FILTER = 'AT_PHARM_COUNTRY_FOR_FILTER';
	AT_VARIANTS = 'AT_VARIANTS';
 { дерево подсказок для базового поиска }
	AT_PREFIX_REVIEW = 'AT_PREFIX_REVIEW';
 { Дерево Видов правовой информации в КЗ ОИЗ }
	AT_PUBLISH_SOURCE_FINANCE = 'AT_PUBLISH_SOURCE_FINANCE';
 { Ветка дерева Источник опубликования для СМИ по налогам и бухучету }
	AT_PUBLISH_SOURCE_LEGAL = 'AT_PUBLISH_SOURCE_LEGAL';
 { Ветка дерева Источник опубликования для СМИ для юриста }
	AT_PUBLISH_SOURCE_HR = 'AT_PUBLISH_SOURCE_HR';
 { Ветка дерева Источник опубликования для СМИ для кадровика }
	AT_PUBLISH_SOURCE_BUDGET_ORGS = 'AT_PUBLISH_SOURCE_BUDGET_ORGS';
 { Ветка дерева Источник опубликования для СМИ для бюджетных организаций }
	AT_BASE_SEARCH_PANES = 'AT_BASE_SEARCH_PANES';
 { Вкладки Базового поиска }
	AT_CLASS_REVIEW = 'AT_CLASS_REVIEW';
	AT_SOURCE_REVIEW = 'AT_SOURCE_REVIEW';
	AT_PUBLISH_SOURCE_PHARM = 'AT_PUBLISH_SOURCE_PHARM';
	AT_IMPORTANT_DOCUMENTS = 'AT_IMPORTANT_DOCUMENTS';

implementation
end.