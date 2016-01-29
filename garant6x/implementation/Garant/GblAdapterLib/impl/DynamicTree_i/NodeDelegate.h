////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodeDelegate
// Заголовок реализации класса серванта для интерфеса NodeBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEDELEGATE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEDELEGATE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeBase.h"

// forward decls for defined friends
namespace GblAdapterLib {
	class NodeBase_i;
} // namespace GblAdapterLib


namespace GblAdapterLib {

class NodeDelegate; // self forward Var
typedef ::Core::Var<NodeDelegate> NodeDelegate_var;
typedef ::Core::Var<const NodeDelegate> NodeDelegate_cvar;

class NodeDelegateServantFactory;

class NodeDelegate:
	virtual public NodeBase
	, virtual public ::Core::RefCountObjectBase
	, virtual public DelegateNodeBase
{
	SET_OBJECT_COUNTER (NodeDelegate)
	friend class NodeDelegateServantFactory;
	friend class NodeBase_i; // defined friend

//////////////////////////////////////////////////////////////////////////////////////////
// Memory Pool initialization
private:
	typedef ::Core::PoolMemoryManager<NodeDelegate>::PoolMemoryManagerSingleton PoolNodeDelegate;
	typedef ::Core::PoolMemoryManager<NodeDelegate> Pool;
	friend class ::Core::PoolMemoryManager<NodeDelegate>;
	void* operator new (size_t cs) {              
		return PoolNodeDelegate::instance()->malloc(cs);
	}
	void operator delete (void* p) {
		PoolNodeDelegate::instance()->free(p);
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit NodeDelegate (TreeBase* owner_tree);

	virtual ~NodeDelegate ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	const GCI::IO::String& get_master_caption () const;

	// возвращает false, если нода принадлежит убитому дереву
	bool is_alive () const;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from NodeBase
	// аналогично add_last_childs но для одной ноды (как-либо полученной например, через
	// create_new_node или напрямую из дерева, если это нода из дерева то будет сделана копия)
	virtual void add_last_child (NodeBase* node) /*throw (ConstantModify)*/;

	// implemented method from NodeBase
	// вставляет ноды из контейнера в конец списка детей - на самом деле если есть сортировка то
	// позиции вставки могут стать другими, но ОБЯЗАТЕЛЬНО в указанном паранте
	virtual void add_last_childs (NodesClipboard* nodes);

	// implemented method from NodeBase
	virtual void add_notifier (NodeNotifier* notifier);

	// implemented method from NodeBase
	// аналогично add_prev_siblings но для одной ноды
	virtual void add_prev_sibling (NodeBase* node) /*throw (ConstantModify)*/;

	// implemented method from NodeBase
	// аналогично add_last_childs, но ноды вставляется перед указанной как соседи, соответственно
	// КОНСТАНТНЫМ будет парент текущей ноды
	virtual void add_prev_siblings (NodesClipboard* nodes) /*throw (ConstantModify)*/;

	// implemented method from NodeBase
	// Пользовательское название ноды
	virtual const GCI::IO::String& get_caption () const;
	virtual GCI::IO::String& get_caption ();

	// implemented method from NodeBase
	virtual long get_child_count () const;

	// implemented method from NodeBase
	// закрывает транзакцию, и если это больше нет "верхних" открытых транзакций - сохраняет все
	// изменения сделанные на ноде (отправляет данные на сервер)
	virtual void commit_change_transaction ();

	// implemented method from NodeBase
	// копирует ноды по заданному флагу и возвращает их в виде контейнера для последующей вставки в
	// любое другое дерево.ВРЕМЕННО перенесен с каталога на ноду!!!
	virtual NodesClipboard* copy_nodes (FlagMask mask);

	// implemented method from NodeBase
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
	);

	// implemented method from NodeBase
	// удаляет текущую ноду
	virtual void delete_node ();

	// implemented method from NodeBase
	// удаляет все ноды по заданному флагу. ВРЕМЕННО перенесен с каталога на ноду!!!
	virtual void delete_nodes (FlagMask mask) /*throw (ConstantModify)*/;

	// implemented method from NodeBase
	virtual const EntityBase* get_entity () const
		/*throw (NoEntity)*/;
	virtual EntityBase* get_entity ()
		/*throw (NoEntity)*/;

	virtual void set_entity (EntityBase* entity);

	// implemented method from NodeBase
	// устанавливает и снимает флаг раскрытия всех нод в дереве
	virtual void expand_all (bool expand);

	// implemented method from NodeBase
	// Поиск в дереве по условию, заданному в фильтре. В случае успеха возвращает итератор первого
	// вхождения, иначе пустой итератор (is_good!=true).
	virtual FindIterator* find (const FilterList& filter, const NodePosition& find_from) const;

	// implemented method from NodeBase
	// ищет в текущем дереву ноду равную переданной
	virtual NodeBase* find_node (const NodeBase* node_to_find) const;

	// implemented method from NodeBase
	// Получение индексного пути ноды. Первый индекс в пути сам узел node_to_find
	virtual NodeIndexPath* find_node_path (NodeBase* node_to_find) const;

	// implemented method from NodeBase
	virtual const NodeBase* get_first_child () const;
	virtual NodeBase* get_first_child ();

	// implemented method from NodeBase
	// Возвращает абс. индекс для ноды
	virtual VisibleIndex get_abs_index () const /*throw (CanNotFindData)*/;

	// implemented method from NodeBase
	virtual LayerIdList* get_available_layers () const;

	// implemented method from NodeBase
	// возвращает ноду-соседа (т.е. "брата" текущей) по индексу
	virtual NodeBase* get_by_sibbling_index (VisibleIndex ind);

	// implemented method from NodeBase
	// возвращает ноду по видемому индексу относительно текущей
	virtual NodeBase* get_by_visible_index (VisibleIndex ind);

	// implemented method from NodeBase
	// Возвращает путь к ноде по её абс. индексу
	virtual NodeIndexPath* get_child_path_by_abs_index (VisibleIndex index) const /*throw (CanNotFindData)*/;

	// implemented method from NodeBase
	virtual NodeIndexPath* get_first_fit (const FilterList& filter) const;

	// implemented method from NodeBase
	virtual unsigned long get_first_level_children_flag_count (FlagMask flag) const;

	// implemented method from NodeBase
	// возвращает кол-во зхаданных флагов в текущем поддереве
	virtual unsigned long get_flag_count (FlagMask flag) const;

	// implemented method from NodeBase
	virtual NodeBase* get_frozen_node () const;

	// implemented method from NodeBase
	// Возвращает порядковый номер узла относительно родителя (начиная с 1)
	virtual VisibleIndex get_index_from_parent () const;

	// implemented method from NodeBase
	// Дублирует с CatalogBase
	virtual NodeBase* get_node_by_path (const NodeIndexPath& path) const /*throw (NotFound)*/;

	// implemented method from NodeBase
	// Получение идентификатора ноды. Обычно возвращает пойнтер, но для документа value->id (), т.е.
	// не уникален.
	virtual NodeId get_node_id () const;

	// implemented method from NodeBase
	virtual NodeBase* get_unfiltered_node () const;

	// implemented method from NodeBase
	// возвращает разницу видимых индексов двух нод (может автоматически развернуть необходимые уровни)
	virtual VisibleIndex get_visible_delta (const NodeBase* node) const /*throw (NotFound)*/;

	// implemented method from NodeBase
	virtual VisibleIndex get_visible_delta_by_entity (const EntityBase* entity) const /*throw (NotFound)*/;

	// implemented method from NodeBase
	// признакк есть ли дети
	virtual bool has_children () const;

	// implemented method from NodeBase
	// признак взведен ли у детей указанный флаг
	virtual bool has_children_flag (FlagMask flag) const;

	// implemented method from NodeBase
	// признак того что нода соджержит отфильтрованных детей
	virtual bool has_filtered_children () const;

	// implemented method from NodeBase
	// признак взведен ли указанный флаг
	virtual bool has_flag (FlagMask flag) const;

	// implemented method from NodeBase
	// признак взведен ли у родителей указанный флаг
	virtual bool has_parent_flag (FlagMask flag) const;

	// implemented method from NodeBase
	// возвращает true, если установлен флаг раскрытия всех нод
	virtual bool get_is_expanded () const;

	// implemented method from NodeBase
	// признак первый ли это ребенок
	virtual bool is_first () const;

	// implemented method from NodeBase
	// возвращает true если переданная нода (it) выше текущей
	virtual bool is_it_higher (NodeBase* it) const;

	// implemented method from NodeBase
	// признак последний ли это ребенок
	virtual bool is_last () const;

	// implemented method from NodeBase
	virtual bool is_relevance_search_supported () const;

	// implemented method from NodeBase
	// проверяет на равенство две ноды
	virtual bool is_same_node (NodeBase* node) const;

	// implemented method from NodeBase
	virtual NodeIterator* iterate_all_nodes (FlagMask with_flag);

	// implemented method from NodeBase
	// возвращает сквозной итератор по нодам с указанным флагом
	virtual NodeIterator* iterate_nodes (FlagMask with_flag);

	// implemented method from NodeBase
	// уровень ноды в дереве
	virtual long get_level () const;

	// implemented method from NodeBase
	virtual void make_visible ();

	// implemented method from NodeBase
	virtual const NodeBase* get_next () const;
	virtual NodeBase* get_next ();

	// implemented method from NodeBase
	virtual const NodeBase* get_parent () const;
	virtual NodeBase* get_parent ();

	// implemented method from NodeBase
	virtual const NodeBase* get_prev () const;
	virtual NodeBase* get_prev ();

	// implemented method from NodeBase
	virtual void remove_notifier (NodeNotifier* notifier);

	// implemented method from NodeBase
	// сбрасывает текущщую транзакцию (вместе со всеми вложенными),  сбрасывает все изменения
	// (перечитывает с сервера или внутреннего буффера)
	virtual void rollback_change_transaction ();

	// implemented method from NodeBase
	// устанавливает у всего поддерева (КРОМЕ самой ноды на который была вызвана операция) указанный
	// флаг (сейчас работает всегда от рута, и иногда глючит именно установка, сброс работает
	// корректно)
	virtual void set_all_flag (FlagMask flag, bool value);

	// implemented method from NodeBase
	virtual void set_all_flag_except_first_children_of_root_children (FlagMask flag, bool value);

	// implemented method from NodeBase
	// взводит указанный флаг
	virtual void set_flag (FlagMask flag, bool value);

	// implemented method from NodeBase
	// Изменить идентификатор ноды. Обычно ничего не делает, но для документа изменяет value->id ().
	virtual void set_node_id (NodeId id);

	// implemented method from NodeBase
	// взводит указанный флаг на промежутке
	virtual void set_range_flag (
		VisibleIndex offset_from
		, VisibleIndex offset_to
		, FlagMask flag
		, bool value
		, bool clean_other
	);

	// implemented method from NodeBase
	virtual void set_range_flag_except_first_children_of_root_children (
		VisibleIndex offset_from
		, VisibleIndex offset_to
		, FlagMask flag
		, bool value
		, bool clean_other
	);

	// implemented method from NodeBase
	// указывает на начало транзакции изменения данных ноды. Транзакции могут быть вложенными
	virtual void start_change_transaction ();

	// implemented method from NodeBase
	// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
	// для диффиренцации отображения
	virtual NodeType get_type () const;

	virtual void set_type (NodeType type)
		/*throw (ConstantModify)*/;

	// implemented method from SettingEntity
	// Восстанавливает "ссылку" из настроек свзанную с данным ключем и данным типом (классом, группой)
	// объеков.
	virtual SettingEntity* load_from_setting (PropertyID_const id) const;

	// implemented method from SettingEntity
	// Сохраняет "ссылку" на данный экземпляр в настройках, связывая ее с переданным строковым ключем.
	// Тип ссылки зависит зависит от конкретного класса реализующего джанный интерфейс.
	virtual void save_in_setting (PropertyID_const id) const;
}; // class NodeDelegate

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_NODEDELEGATE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
