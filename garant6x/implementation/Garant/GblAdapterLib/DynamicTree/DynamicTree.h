////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTreeDefines/DynamicTreeDefines.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchDefines/SearchDefines.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

class FilterForTree;
typedef ::Core::Var<FilterForTree> FilterForTree_var;
typedef ::Core::Var<const FilterForTree> FilterForTree_cvar;
// Абстрактный интерфейс фильтров деревьев
class FilterForTree
	: virtual public ::Core::IObject
{
};

// Список фильтров
typedef std::vector < FilterForTree_var > FilterList;

enum ContextPlace {
	CP_ANY
	, CP_BEGIN_OF_WORD
	, CP_BEGIN_OF_PHRASE
	, CP_WHOLE_WORD
};

typedef unsigned long IndexInParent;

// Порядок поиска
enum FindOrder {
	FO_SEQUENCE
	, FO_ANY
};

// путь в дереве, заданный списком индексов нод
typedef std::vector < IndexInParent > NodeIndexPath;

#pragma pack (push, 1)

// Позиция поискового итератора.
struct FindPosition {
	// Путь к ноде данной позиции итератора.
	NodeIndexPath node;
	// Начало позиции.
	long begin;
	// Конец позиции. Если -1 - то до конца.
	long end;
	FindPosition () : begin(0), end(-1) {
		//#UC START# *45EEC2A902BF_DEF_INIT_CTOR*
		//#UC END# *45EEC2A902BF_DEF_INIT_CTOR**cpp*
	}
};

#pragma pack (pop)

// Пользовательский тип ноды
typedef unsigned long long NodeType;

// Идентификатор ноды дерева
typedef long NodeId;

// Область поиска
// SA_IN_ALL_TEXT - используется в контекстном поиске, ищем по всему тексту, результат по каждой
// ноде это списко всех вхождений любого слова внутри текста одной ноды.
// SA_IN_ONE_SENTENCES - используется в контекстном поиске двух и более слов, указывает что слова
// запроса должны находиться внутри предложения в любом порядке
enum SearchArea {
	SA_ONE_LEVEL
	, SA_ALL_LEVEL
	, SA_IN_ALL_TEXT
	, SA_IN_ONE_SENTENCES
};

// Набор позиций итератора поиска.
typedef std::vector < FindPosition > FindPositionList;

// Видимый индекс в дереве
typedef long VisibleIndex;

// Идентификатор уровня
typedef unsigned short LayerId;

// Константы для флагов
static const FlagMask FM_SHARED_NONE = 0;
static const FlagMask FM_OPEN = 2;
static const FlagMask FM_SELECTION = 1;
static const FlagMask FM_FIRST_USER_FLAG = 4;
static const FlagMask FM_USER_FLAG_MASK = 65532;
static const FlagMask FM_SHARED_ALL = 65535;
static const IndexInParent IIP_BEFORE_LEFT_CHILD = 4294967295;
static const VisibleIndex VI_ALL_CHILDREN = -1; // Уведомление об изменении всех узлов.

// Список идентификаторов уровня
typedef std::vector < LayerId > LayerIdList;

class SortFilter;
typedef ::Core::Var<SortFilter> SortFilter_var;
typedef ::Core::Var<const SortFilter> SortFilter_cvar;
class SortFilter
	: virtual public FilterForTree
{
public:
	virtual SortType get_type () const = 0;

	virtual void set_type (SortType type) = 0;

	virtual SortOrder get_order () const = 0;

	virtual void set_order (SortOrder order) = 0;

	virtual const SortFilter* get_sub_filter () const = 0;
	virtual SortFilter* get_sub_filter () = 0;

	virtual void set_sub_filter (SortFilter* sub_filter) = 0;
};

/// factory interface for SortFilter
class SortFilterFactory {
public:
	static SortFilter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class TrimFilter;
typedef ::Core::Var<TrimFilter> TrimFilter_var;
typedef ::Core::Var<const TrimFilter> TrimFilter_cvar;
class TrimFilter
	: virtual public FilterForTree
{
public:
	virtual bool get_is_trimmed () const = 0;

	virtual void set_is_trimmed (bool is_trimmed) = 0;
};

/// factory interface for TrimFilter
class TrimFilterFactory {
public:
	static TrimFilter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class LayerFilter;
typedef ::Core::Var<LayerFilter> LayerFilter_var;
typedef ::Core::Var<const LayerFilter> LayerFilter_cvar;
// Класс фильтров для переключения визуального уровня (языка)
class LayerFilter
	: virtual public FilterForTree
{
public:
	virtual LayerId get_layer () const = 0;

	virtual void set_layer (LayerId layer) = 0;
};

/// factory interface for LayerFilter
class LayerFilterFactory {
public:
	static LayerFilter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class FindIterator;
typedef ::Core::Var<FindIterator> FindIterator_var;
typedef ::Core::Var<const FindIterator> FindIterator_cvar;
// Итератор поиска.
class FindIterator
	: virtual public ::Core::IObject
{
public:
	// количество найденных фрагментов
	virtual const unsigned long get_count () const = 0;

	// Перемещенеи итератора на следующий элемент.
	virtual void next () = 0;

	// Перемещенеи итератора на предыдущий элемент.
	virtual void prev () = 0;

	virtual FindPositionList* get_position () const = 0;

	// Возвращает true, если по итератору можно получить данные, т.е. position. Иначе итератор за
	// концом, т.е. равен end или вообще пуст
	virtual bool is_good () const = 0;

	// возвращает true, если нельзя перейти на предыдущий фрагмент
	virtual bool is_first () const = 0;
};

/// factory interface for FindIterator
class FindIteratorFactory {
public:
	static FindIterator* make (GTree::FindIterator* iterator)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

typedef unsigned long NotifierID;

// стиль выливки дерева или нод в evd
enum EVDGeneratorStyle {
	GS_DEFAULT // выливаем только верхний уровень, нормальные имена
	, GS_FULL_TREE // выливаем дерево полностью, нормальные имена
	, GS_TOPIC_AS_NAME // выливаем только верхний уровень, вместо имён используем номера топиков
};

// генерируется при попытке получить сущность на ноде которая ее не содержит
class NoEntity : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// возвращается если get_visible_delta не может найти ноду
class NotFound : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

typedef char* PropertyID;
typedef const char* PropertyID_const;


class SettingEntity;
typedef ::Core::Var<SettingEntity> SettingEntity_var;
typedef ::Core::Var<const SettingEntity> SettingEntity_cvar;
// абстрактный интерфейс, наследники которого умеют "сохранять" себя в настройках
class SettingEntity
	: virtual public ::Core::IObject
{
public:
	// Сохраняет "ссылку" на данный экземпляр в настройках, связывая ее с переданным строковым ключем.
	// Тип ссылки зависит зависит от конкретного класса реализующего джанный интерфейс.
	virtual void save_in_setting (PropertyID_const id) const = 0;

	// Восстанавливает "ссылку" из настроек свзанную с данным ключем и данным типом (классом, группой)
	// объеков.
	virtual SettingEntity* load_from_setting (PropertyID_const id) const = 0;
};

// константы типов ноды
static const NodeType NT_UNKNOWN = 0;

class NodesClipboard;
typedef ::Core::Var<NodesClipboard> NodesClipboard_var;
typedef ::Core::Var<const NodesClipboard> NodesClipboard_cvar;
// контейнер для скопированных нод
class NodesClipboard
	: virtual public ::Core::IObject
{
public:
	virtual unsigned long get_count () const = 0;

	virtual GCI::IO::Stream* as_evd (EVDGeneratorStyle style) const = 0;
};

/// factory interface for NodesClipboard
class NodesClipboardFactory {
public:
	static NodesClipboard* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	static NodesClipboard* make (GTree::NodeHolder* node_holder)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class FakeFacetForFactory;
typedef ::Core::Var<FakeFacetForFactory> FakeFacetForFactory_var;
typedef ::Core::Var<const FakeFacetForFactory> FakeFacetForFactory_cvar;
// когда будут локальные интерфейсы, фасет надо грохнуть
class FakeFacetForFactory
	: virtual public ::Core::IObject
{
};

class NodeNotifier;
typedef ::Core::Var<NodeNotifier> NodeNotifier_var;
typedef ::Core::Var<const NodeNotifier> NodeNotifier_cvar;
// callback интерфейс для оповещения визуального дерева об изменениях на ноде
class NodeNotifier
	: virtual public ::Core::IObject
{
public:
	// нотификация об изменении кол-ва видимых детей на ноде с указвнным индексом. В случае если
	// изменение нод внутри рута не последовательное и не от начала, индекс должен быть задан как -1.
	// parent_path - путь к УЗЛУ в котором произашли изменения (если delta < 0 - удаление, если delta
	// > 0 - вставка)
	// left_child_index - индекс ребенка в узле: если удаление, то начиная с которого
	// (включительно) мы удаляем delta элементорв; если вставка, то сразу после которого вы вставляем
	// delta элементов.
	// left_child_index, может принять "специальное" значение IIP_BEFORE_LEFT_CHILD (-1) -
	// означающее элемент "до первого" - например для вставки в начало детей.
	virtual void change_children_count (
		VisibleIndex node_index
		, long delta
		, const NodeIndexPath& index_path
		, IndexInParent child_index
	) const = 0;

	// Конец итерации изменения дерева
	virtual void changed () const = 0;

	// Начало итерации изменения дерева
	virtual void changing () const = 0;

	// Возвращает уникальный идентификатор объекта
	virtual NotifierID get_id () const = 0;

	// нотификация о необходимости перерисовки. Должна вызываться после change_children_count (которые
	// можно группирвать) или самостоятельно при изменении дерева не связанном с кол-вом детей.
	// parent_path - путь к НОДЕ в которой произашли изменения
	virtual void invalidate (const NodeIndexPath& index_path) const = 0;

	// признак аутлайнера что он одноуровневый
	virtual bool is_one_level () const = 0;

	// признак аутлайнера что он с видимым рутом
	virtual bool is_root_visible () const = 0;

	// устанавливает кол-во детей = 0
	virtual void reset_children_count () const = 0;
};

class ListForFiltering;
typedef ::Core::Var<ListForFiltering> ListForFiltering_var;
typedef ::Core::Var<const ListForFiltering> ListForFiltering_cvar;
class ListForFiltering
	: virtual public ::Core::IObject
{
public:
	virtual const unsigned long get_count () const = 0;

	virtual GCI::IO::String* item (unsigned long index) const = 0;
};

class NodeBase;
typedef ::Core::Var<NodeBase> NodeBase_var;
typedef ::Core::Var<const NodeBase> NodeBase_cvar;

class NodeIterator;
struct NodePosition;

// Базовый интерфейс ноды "новых" деревьев
class NodeBase
	: virtual public SettingEntity
{
public:
	// Пользовательское название ноды
	virtual const GCI::IO::String& get_caption () const = 0;
	virtual GCI::IO::String& get_caption () = 0;

	// уровень ноды в дереве
	virtual long get_level () const = 0;

	// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
	// для диффиренцации отображения
	virtual NodeType get_type () const = 0;

	virtual void set_type (NodeType type)
		/*throw (ConstantModify)*/ = 0;

	virtual long get_child_count () const = 0;

	// возвращает true, если установлен флаг раскрытия всех нод
	virtual bool get_is_expanded () const = 0;

	virtual const EntityBase* get_entity () const
		/*throw (NoEntity)*/ = 0;
	virtual EntityBase* get_entity ()
		/*throw (NoEntity)*/ = 0;

	virtual void set_entity (EntityBase* entity) = 0;

	virtual const NodeBase* get_first_child () const = 0;
	virtual NodeBase* get_first_child () = 0;

	virtual const NodeBase* get_prev () const = 0;
	virtual NodeBase* get_prev () = 0;

	virtual const NodeBase* get_next () const = 0;
	virtual NodeBase* get_next () = 0;

	virtual const NodeBase* get_parent () const = 0;
	virtual NodeBase* get_parent () = 0;

	virtual void add_notifier (NodeNotifier* notifier) = 0;

	// Расширенная версия метода create_view. (покачто вью всегда создается от рута)
	virtual NodeBase* create_view_ex (
		const FilterList& filter
		, FlagMask shared_flags
		, const NodeBase* sync_node
		, VisibleIndex& sync_index
		, unsigned long levels
		, bool unfiltered
		, bool auto_open
		, bool truncate_this_view
	) = 0;

	// ищет в текущем дереву ноду равную переданной
	virtual NodeBase* find_node (const NodeBase* node_to_find) const = 0;

	// Получение индексного пути ноды. Первый индекс в пути сам узел node_to_find
	virtual NodeIndexPath* find_node_path (NodeBase* node_to_find) const = 0;

	// возвращает ноду-соседа (т.е. "брата" текущей) по индексу
	virtual NodeBase* get_by_sibbling_index (VisibleIndex ind) = 0;

	// возвращает ноду по видемому индексу относительно текущей
	virtual NodeBase* get_by_visible_index (VisibleIndex ind) = 0;

	virtual NodeIndexPath* get_first_fit (const FilterList& filter) const = 0;

	// возвращает кол-во зхаданных флагов в текущем поддереве
	virtual unsigned long get_flag_count (FlagMask flag) const = 0;

	virtual unsigned long get_first_level_children_flag_count (FlagMask flag) const = 0;

	// Получение идентификатора ноды. Обычно возвращает пойнтер, но для документа value->id (), т.е.
	// не уникален.
	virtual NodeId get_node_id () const = 0;

	// Изменить идентификатор ноды. Обычно ничего не делает, но для документа изменяет value->id ().
	virtual void set_node_id (NodeId id) = 0;

	virtual LayerIdList* get_available_layers () const = 0;

	// возвращает разницу видимых индексов двух нод (может автоматически развернуть необходимые уровни)
	virtual VisibleIndex get_visible_delta (const NodeBase* node) const /*throw (NotFound)*/ = 0;

	virtual VisibleIndex get_visible_delta_by_entity (const EntityBase* entity) const /*throw (NotFound)*/ = 0;

	// Возвращает порядковый номер узла относительно родителя (начиная с 1)
	virtual VisibleIndex get_index_from_parent () const = 0;

	// Возвращает абс. индекс для ноды
	virtual VisibleIndex get_abs_index () const /*throw (CanNotFindData)*/ = 0;

	// Возвращает путь к ноде по её абс. индексу
	virtual NodeIndexPath* get_child_path_by_abs_index (VisibleIndex index) const /*throw (CanNotFindData)*/ = 0;

	virtual NodeBase* get_frozen_node () const = 0;

	virtual NodeBase* get_unfiltered_node () const = 0;

	// признакк есть ли дети
	virtual bool has_children () const = 0;

	// признак взведен ли у детей указанный флаг
	virtual bool has_children_flag (FlagMask flag) const = 0;

	// признак того что нода соджержит отфильтрованных детей
	virtual bool has_filtered_children () const = 0;

	// признак взведен ли указанный флаг
	virtual bool has_flag (FlagMask flag) const = 0;

	// признак взведен ли у родителей указанный флаг
	virtual bool has_parent_flag (FlagMask flag) const = 0;

	// признак первый ли это ребенок
	virtual bool is_first () const = 0;

	// возвращает true если переданная нода (it) выше текущей
	virtual bool is_it_higher (NodeBase* it) const = 0;

	// признак последний ли это ребенок
	virtual bool is_last () const = 0;

	// проверяет на равенство две ноды
	virtual bool is_same_node (NodeBase* node) const = 0;

	// возвращает сквозной итератор по нодам с указанным флагом
	virtual NodeIterator* iterate_nodes (FlagMask with_flag) = 0;

	virtual void make_visible () = 0;

	virtual void remove_notifier (NodeNotifier* notifier) = 0;

	// устанавливает у всего поддерева (КРОМЕ самой ноды на который была вызвана операция) указанный
	// флаг (сейчас работает всегда от рута, и иногда глючит именно установка, сброс работает
	// корректно)
	virtual void set_all_flag (FlagMask flag, bool value) = 0;

	// взводит указанный флаг
	virtual void set_flag (FlagMask flag, bool value) = 0;

	// взводит указанный флаг на промежутке
	virtual void set_range_flag (
		VisibleIndex offset_from
		, VisibleIndex offset_to
		, FlagMask flag
		, bool value
		, bool clean_other
	) = 0;

	// удаляет все ноды по заданному флагу. ВРЕМЕННО перенесен с каталога на ноду!!!
	virtual void delete_nodes (FlagMask mask) /*throw (ConstantModify)*/ = 0;

	// удаляет текущую ноду
	virtual void delete_node () = 0;

	// копирует ноды по заданному флагу и возвращает их в виде контейнера для последующей вставки в
	// любое другое дерево.ВРЕМЕННО перенесен с каталога на ноду!!!
	virtual NodesClipboard* copy_nodes (FlagMask mask) = 0;

	// вставляет ноды из контейнера в конец списка детей - на самом деле если есть сортировка то
	// позиции вставки могут стать другими, но ОБЯЗАТЕЛЬНО в указанном паранте
	virtual void add_last_childs (NodesClipboard* nodes) = 0;

	// аналогично add_last_childs но для одной ноды (как-либо полученной например, через
	// create_new_node или напрямую из дерева, если это нода из дерева то будет сделана копия)
	virtual void add_last_child (NodeBase* node) /*throw (ConstantModify)*/ = 0;

	// аналогично add_last_childs, но ноды вставляется перед указанной как соседи, соответственно
	// КОНСТАНТНЫМ будет парент текущей ноды
	virtual void add_prev_siblings (NodesClipboard* nodes) /*throw (ConstantModify)*/ = 0;

	// аналогично add_prev_siblings но для одной ноды
	virtual void add_prev_sibling (NodeBase* node) /*throw (ConstantModify)*/ = 0;

	// указывает на начало транзакции изменения данных ноды. Транзакции могут быть вложенными
	virtual void start_change_transaction () = 0;

	// сбрасывает текущщую транзакцию (вместе со всеми вложенными),  сбрасывает все изменения
	// (перечитывает с сервера или внутреннего буффера)
	virtual void rollback_change_transaction () = 0;

	// закрывает транзакцию, и если это больше нет "верхних" открытых транзакций - сохраняет все
	// изменения сделанные на ноде (отправляет данные на сервер)
	virtual void commit_change_transaction () = 0;

	// Дублирует с CatalogBase
	virtual NodeBase* get_node_by_path (const NodeIndexPath& path) const /*throw (NotFound)*/ = 0;

	// Поиск в дереве по условию, заданному в фильтре. В случае успеха возвращает итератор первого
	// вхождения, иначе пустой итератор (is_good!=true).
	virtual FindIterator* find (const FilterList& filter, const NodePosition& find_from) const = 0;

	virtual bool is_relevance_search_supported () const = 0;

	// устанавливает и снимает флаг раскрытия всех нод в дереве
	virtual void expand_all (bool expand) = 0;

	virtual NodeIterator* iterate_all_nodes (FlagMask with_flag) = 0;

	virtual void set_all_flag_except_first_children_of_root_children (FlagMask flag, bool value) = 0;

	virtual void set_range_flag_except_first_children_of_root_children (
		VisibleIndex offset_from
		, VisibleIndex offset_to
		, FlagMask flag
		, bool value
		, bool clean_other
	) = 0;
};

/// factory interface for NodeBase
class NodeBaseFactory {
public:
	typedef std::vector<std::string> KeySet;
	
	static KeySet* keys ();
public:
	static NodeBase* make (const char* key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed, CanNotFindData)*/;

	static NodeBase* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode, const char* key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

class NodeIterator;
typedef ::Core::Var<NodeIterator> NodeIterator_var;
typedef ::Core::Var<const NodeIterator> NodeIterator_cvar;
// Интерфейс для получения линейного списка элементов дерева.
// Должен поддерживаться пользователем для реализации операций с произвольным набором элементов
// дерева (например, со списком выделенных элементов).
class NodeIterator
	: virtual public ::Core::IObject
{
public:
	virtual const NodeBase* get_next () const = 0;
	virtual NodeBase* get_next () = 0;
};

/// factory interface for NodeIterator
class NodeIteratorFactory {
public:
	static NodeIterator* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// Позиция ноды в дереве и внутри этой ноды.
struct NodePosition {
	// Позиция внутри ноды node.
	long pos;
	NodeBase_var node;
};

#pragma pack (pop)

class CatalogBase;
typedef ::Core::Var<CatalogBase> CatalogBase_var;
typedef ::Core::Var<const CatalogBase> CatalogBase_cvar;
// Менеджер деревьев постренных на основе NodeBase и поддерживающие хранение сущностей
// (EntityBase). Заменяет устаревший BaseTreeSupport::BaseCatalog
class CatalogBase
	: virtual public ::Core::IObject
{
public:
	virtual const GCI::IO::String& get_name () const = 0;
	virtual GCI::IO::String& get_name () = 0;

	virtual void set_name (GCI::IO::String* name) = 0;

	virtual const NodeBase* get_root () const = 0;

	virtual CatalogBase* clone () const = 0;

	virtual NodeBase* get_node_by_path (const NodeIndexPath& path) const /*throw (NotFound)*/ = 0;

	virtual void intersect_tree (const CatalogBase* tree) = 0;

	virtual void merge_tree (const CatalogBase* tree) = 0;

	virtual void minus_tree (const CatalogBase* tree) = 0;

	virtual CatalogBase* create (NodesClipboard* nodes) const = 0;
};

class TrimLeafFilter;
typedef ::Core::Var<TrimLeafFilter> TrimLeafFilter_var;
typedef ::Core::Var<const TrimLeafFilter> TrimLeafFilter_cvar;
class TrimLeafFilter
	: virtual public FilterForTree
{
};

/// factory interface for TrimLeafFilter
class TrimLeafFilterFactory {
public:
	static TrimLeafFilter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// идентификаторы деревьев
static const char* AT_ANNO_INTEREST = "AT_ANNO_INTEREST";
static const char* AT_ANNO_KIND = "AT_ANNO_KIND";
static const char* AT_ANNO_ORG = "AT_ANNO_ORG";
static const char* AT_ANNO_TAX = "AT_ANNO_TAX";
static const char* AT_ANNO_USER = "AT_ANNO_USER";
static const char* AT_BASES = "AT_BASES";
static const char* AT_CLASS = "AT_CLASS";
static const char* AT_EDITION = "AT_EDITION";
static const char* AT_KW = "AT_KW";
static const char* AT_NORM = "AT_NORM";
static const char* AT_PREFIX = "AT_PREFIX";
static const char* AT_PUBLISH_SOURCE = "AT_PUBLISH_SOURCE";
static const char* AT_REG_IN_MU_NUM = "AT_REG_IN_MU_NUM";
static const char* AT_REG_IN_MU = "AT_REG_IN_MU";
static const char* AT_REG_NUM = "AT_REG_NUM";
static const char* AT_SOURCE = "AT_SOURCE";
static const char* AT_STATUS = "AT_STATUS";
static const char* AT_TERRITORY = "AT_TERRITORY";
static const char* AT_TYPE = "AT_TYPE";
static const char* AT_UC = "AT_UC";
static const char* AT_PHARM_INTERNATIONAL_NAME = "AT_PHARM_INTERNATIONAL_NAME";
static const char* AT_PHARM_TRADE_NAME = "AT_PHARM_TRADE_NAME";
static const char* AT_PHARM_CHAPTER = "AT_PHARM_CHAPTER";
static const char* AT_PHARM_COUNTRY = "AT_PHARM_COUNTRY";
static const char* AT_PHARM_FIRM = "AT_PHARM_FIRM";
static const char* AT_PHARM_REG_STATUS = "AT_PHARM_REG_STATUS";
static const char* AT_PHARM_MEDICINAL_FORM = "AT_PHARM_MEDICINAL_FORM";
static const char* AT_PHARM_ATC = "AT_PHARM_ATC";
static const char* AT_PHARM_MKB = "AT_PHARM_MKB";
static const char* AT_PHARM_GROUP = "AT_PHARM_GROUP";
static const char* AT_PHARM_EFFECT = "AT_PHARM_EFFECT";
static const char* AT_PHARM_NARCOTIC = "AT_PHARM_NARCOTIC";
static const char* AT_PHARM_UNRECIPE = "AT_PHARM_UNRECIPE";
static const char* AT_PHARM_IMPORTANT = "AT_PHARM_IMPORTANT";
static const char* AT_PHARM_COUNTRY_FOR_FILTER = "AT_PHARM_COUNTRY_FOR_FILTER";
static const char* AT_VARIANTS = "AT_VARIANTS"; // дерево подсказок для базового поиска
static const char* AT_PREFIX_REVIEW = "AT_PREFIX_REVIEW"; // Дерево Видов правовой информации в КЗ ОИЗ
static const char* AT_PUBLISH_SOURCE_FINANCE = "AT_PUBLISH_SOURCE_FINANCE"; // Ветка дерева Источник опубликования для СМИ по налогам и бухучету
static const char* AT_PUBLISH_SOURCE_LEGAL = "AT_PUBLISH_SOURCE_LEGAL"; // Ветка дерева Источник опубликования для СМИ для юриста
static const char* AT_PUBLISH_SOURCE_HR = "AT_PUBLISH_SOURCE_HR"; // Ветка дерева Источник опубликования для СМИ для кадровика
static const char* AT_PUBLISH_SOURCE_BUDGET_ORGS = "AT_PUBLISH_SOURCE_BUDGET_ORGS"; // Ветка дерева Источник опубликования для СМИ для бюджетных организаций
static const char* AT_BASE_SEARCH_PANES = "AT_BASE_SEARCH_PANES"; // Вкладки Базового поиска
static const char* AT_CLASS_REVIEW = "AT_CLASS_REVIEW";
static const char* AT_SOURCE_REVIEW = "AT_SOURCE_REVIEW";
static const char* AT_PUBLISH_SOURCE_PHARM = "AT_PUBLISH_SOURCE_PHARM";
static const char* AT_IMPORTANT_DOCUMENTS = "AT_IMPORTANT_DOCUMENTS";

class CountryFilter;
typedef ::Core::Var<CountryFilter> CountryFilter_var;
typedef ::Core::Var<const CountryFilter> CountryFilter_cvar;
class CountryFilter
	: virtual public FilterForTree
{
public:
	virtual const NodeBase* get_country () const = 0;
	virtual NodeBase* get_country () = 0;

	virtual void set_country (NodeBase* country) = 0;
};

/// factory interface for CountryFilter
class CountryFilterFactory {
public:
	static CountryFilter* make (const NodeBase* country)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	static CountryFilter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class CutToLeafCountFilter;
typedef ::Core::Var<CutToLeafCountFilter> CutToLeafCountFilter_var;
typedef ::Core::Var<const CutToLeafCountFilter> CutToLeafCountFilter_cvar;
// оставляет в дереве количество детей, не большее заданного
class CutToLeafCountFilter
	: virtual public FilterForTree
{
public:
	// получить число листьев для фильтра
	virtual unsigned long get_leaf_count () const = 0;

	virtual void set_leaf_count (unsigned long leaf_count) = 0;
};

/// factory interface for CutToLeafCountFilter
class CutToLeafCountFilterFactory {
public:
	// создает фильтр, оставляющий в дереве не более leaf_count листьев
	static CutToLeafCountFilter* make (unsigned long leaf_count)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	static CutToLeafCountFilter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// список идентификаторов нод
typedef std::vector < NodeId > NodeIdList;

class BlocksFilter;
typedef ::Core::Var<BlocksFilter> BlocksFilter_var;
typedef ::Core::Var<const BlocksFilter> BlocksFilter_cvar;
// Фильтр оставляет только те блоки, которые доступны конкретному пользователю
class BlocksFilter
	: virtual public FilterForTree
{
};

/// factory interface for BlocksFilter
class BlocksFilterFactory {
public:
	static BlocksFilter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class InpharmFilter;
typedef ::Core::Var<InpharmFilter> InpharmFilter_var;
typedef ::Core::Var<const InpharmFilter> InpharmFilter_cvar;
// не показывать в дереве блоков блоки для инфарм
class InpharmFilter
	: virtual public FilterForTree
{
};

/// factory interface for InpharmFilter
class InpharmFilterFactory {
public:
	static InpharmFilter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class VariantsForDocFilter;
typedef ::Core::Var<VariantsForDocFilter> VariantsForDocFilter_var;
typedef ::Core::Var<const VariantsForDocFilter> VariantsForDocFilter_cvar;
// получить подсказки для заданного документа
class VariantsForDocFilter
	: virtual public FilterForTree
{
public:
	// идентификатор документа
	virtual const unsigned long get_doc_id () const = 0;
};

/// factory interface for VariantsForDocFilter
class VariantsForDocFilterFactory {
public:
	static VariantsForDocFilter* make (unsigned long doc_id)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	static VariantsForDocFilter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

typedef std::vector < unsigned long > Filtered;

class ContextFilter;
typedef ::Core::Var<ContextFilter> ContextFilter_var;
typedef ::Core::Var<const ContextFilter> ContextFilter_cvar;
// Класс контекстных фильтров
class ContextFilter
	: virtual public FilterForTree
{
public:
	virtual ContextPlace get_place () const = 0;

	virtual void set_place (ContextPlace place) = 0;

	virtual FindOrder get_order () const = 0;

	virtual void set_order (FindOrder order) = 0;

	virtual SearchArea get_area () const = 0;

	virtual void set_area (SearchArea area) = 0;

	virtual const GCI::IO::String& get_context () const = 0;
	virtual GCI::IO::String& get_context () = 0;

	virtual void set_context (GCI::IO::String* context) = 0;

	virtual ContextFilter* clone () const = 0;

	virtual Filtered* filtrate (const ListForFiltering* list) const = 0;
};

/// factory interface for ContextFilter
class ContextFilterFactory {
public:
	static ContextFilter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::SortFilter> {
	typedef GblAdapterLib::SortFilterFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::TrimFilter> {
	typedef GblAdapterLib::TrimFilterFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::LayerFilter> {
	typedef GblAdapterLib::LayerFilterFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::FindIterator> {
	typedef GblAdapterLib::FindIteratorFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::NodesClipboard> {
	typedef GblAdapterLib::NodesClipboardFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::NodeBase> {
	typedef GblAdapterLib::NodeBaseFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::NodeIterator> {
	typedef GblAdapterLib::NodeIteratorFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::TrimLeafFilter> {
	typedef GblAdapterLib::TrimLeafFilterFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::CountryFilter> {
	typedef GblAdapterLib::CountryFilterFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::CutToLeafCountFilter> {
	typedef GblAdapterLib::CutToLeafCountFilterFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::BlocksFilter> {
	typedef GblAdapterLib::BlocksFilterFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::InpharmFilter> {
	typedef GblAdapterLib::InpharmFilterFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::VariantsForDocFilter> {
	typedef GblAdapterLib::VariantsForDocFilterFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::ContextFilter> {
	typedef GblAdapterLib::ContextFilterFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
