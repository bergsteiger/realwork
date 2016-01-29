////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodeDelegate
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeIterator_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeIterator_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FrozenNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FrozenNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/AllNodeIterator_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/AllNodeIterator_i_factory.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

NodeDelegate::NodeDelegate (TreeBase* owner_tree)
//#UC START# *45FE7A880196_BASE_INIT*
: DefaultNodeBase (owner_tree), DelegateNodeBase (owner_tree)	
//#UC END# *45FE7A880196_BASE_INIT*
{
	//#UC START# *45FE7A880196_BODY*
	//ADD_OBJECT_WATCHER
	//LOG_D (("%s[%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this));
	//#UC END# *45FE7A880196_BODY*
}

NodeDelegate::~NodeDelegate () {
	//#UC START# *45F7C68A0213_DESTR_BODY*
	//LOG_D (("%s[%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this));
	GCL::StaticNode_var first_child = this->first_child ();
	for (GCL::StaticNode* child = first_child.ptr (); child; GCL::StaticNode::shift_next (child)) {
		child->parent_is_dead ();
	}
	//REMOVE_OBJECT_WATCHER
	//#UC END# *45F7C68A0213_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

const GCI::IO::String& NodeDelegate::get_master_caption () const {
	//#UC START# *5087B0310185*
	const NodeBase* master = dynamic_cast<const NodeBase*> (this->cached_master_node ());
	GDS_ASSERT (master);
	return master->get_caption ();
	//#UC END# *5087B0310185*
}

// возвращает false, если нода принадлежит убитому дереву
bool NodeDelegate::is_alive () const {
	//#UC START# *5086B561033C*
	if (!this->is_root ()) {
		return true;
	}
	GCL::StaticNode_cvar first_child = this->first_child ();

	return !first_child.is_nil ();
	//#UC END# *5086B561033C*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from NodeBase
// аналогично add_last_childs но для одной ноды (как-либо полученной например, через
// create_new_node или напрямую из дерева, если это нода из дерева то будет сделана копия)
void NodeDelegate::add_last_child (NodeBase* node) /*throw (ConstantModify)*/ {
	//#UC START# *45EEB9590211_45F7C68A0213*
	CHECK_AND_LOCK_TREE (throw ConstantModify ();)

	dynamic_cast<NodeBase*>(this->cached_master_node ())->add_last_child (node);
	//#UC END# *45EEB9590211_45F7C68A0213*
}

// implemented method from NodeBase
// вставляет ноды из контейнера в конец списка детей - на самом деле если есть сортировка то
// позиции вставки могут стать другими, но ОБЯЗАТЕЛЬНО в указанном паранте
void NodeDelegate::add_last_childs (NodesClipboard* nodes) {
	//#UC START# *45EEB959020F_45F7C68A0213*
	CHECK_AND_LOCK_TREE (throw ConstantModify ();)

	dynamic_cast<NodeBase*>(this->cached_master_node ())->add_last_childs(nodes);
	//#UC END# *45EEB959020F_45F7C68A0213*
}

// implemented method from NodeBase
void NodeDelegate::add_notifier (NodeNotifier* notifier) {
	//#UC START# *45EEB95901C7_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), notifier));
	CHECK_AND_LOCK_TREE (return;)
	
	DelegateNodeBase::add_notifier(notifier);
	//#UC END# *45EEB95901C7_45F7C68A0213*
}

// implemented method from NodeBase
// аналогично add_prev_siblings но для одной ноды
void NodeDelegate::add_prev_sibling (NodeBase* node) /*throw (ConstantModify)*/ {
	//#UC START# *45EEB9590215_45F7C68A0213*
	CHECK_AND_LOCK_TREE (throw ConstantModify ();)

	dynamic_cast<NodeBase*>(this->cached_master_node ())->add_prev_sibling(node);
	//#UC END# *45EEB9590215_45F7C68A0213*
}

// implemented method from NodeBase
// аналогично add_last_childs, но ноды вставляется перед указанной как соседи, соответственно
// КОНСТАНТНЫМ будет парент текущей ноды
void NodeDelegate::add_prev_siblings (NodesClipboard* nodes) /*throw (ConstantModify)*/ {
	//#UC START# *45EEB9590213_45F7C68A0213*
	CHECK_AND_LOCK_TREE (throw ConstantModify ();)

	dynamic_cast<NodeBase*>(this->cached_master_node ())->add_prev_siblings(nodes);
	//#UC END# *45EEB9590213_45F7C68A0213*
}

// implemented method from NodeBase
// Пользовательское название ноды
const GCI::IO::String& NodeDelegate::get_caption () const {
	//#UC START# *45EEB9590222_45F7C68A0213_GET*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]::get_caption", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	// запил для http://mdp.garant.ru/x/mwBgFw
	if (!this->is_alive ()) {
		return this->get_master_caption ();
	}

	// todo: подумать что делать, если дерево залочено...
	CHECK_AND_LOCK_TREE (static GCI::IO::String_var tree_locked (GCI::IO::StringFactory::make ("")); return *tree_locked.ptr ();)
	return this->get_master_caption ();
	//#UC END# *45EEB9590222_45F7C68A0213_GET*
}

GCI::IO::String& NodeDelegate::get_caption () {
	return const_cast<GCI::IO::String&>(((const NodeDelegate*)this)->get_caption ());
}

// implemented method from NodeBase
long NodeDelegate::get_child_count () const {
	//#UC START# *45EEB9590227_45F7C68A0213_GET*
	return DelegateNodeBase::children_count ();
	//#UC END# *45EEB9590227_45F7C68A0213_GET*
}

// implemented method from NodeBase
// закрывает транзакцию, и если это больше нет "верхних" открытых транзакций - сохраняет все
// изменения сделанные на ноде (отправляет данные на сервер)
void NodeDelegate::commit_change_transaction () {
	//#UC START# *45EEB9590219_45F7C68A0213*
	dynamic_cast<NodeBase*>(this->cached_master_node ())->commit_change_transaction ();
	//#UC END# *45EEB9590219_45F7C68A0213*
}

// implemented method from NodeBase
// копирует ноды по заданному флагу и возвращает их в виде контейнера для последующей вставки в
// любое другое дерево.ВРЕМЕННО перенесен с каталога на ноду!!!
NodesClipboard* NodeDelegate::copy_nodes (FlagMask mask) {
	//#UC START# *45EEB959020C_45F7C68A0213*
	CHECK_AND_LOCK_TREE (return 0;)

	NodeIterator_var node_iterator = Core::TypeTraits<NodeIterator_i>::Factory::make (this, mask);	
	NodeIterator_i* it = dynamic_cast<NodeIterator_i*> (node_iterator.ptr ());
	GTree::CompactSelectorList_var sel = it->make_compact_selectors ();

	//NodeIterator_var dummy_it = new NodeIterator_i (this, mask);	
	//GTree::SelectorList_var dummy = dummy_it->make_selectors (); // load all nodes to prevent errors in apply delta routine

	GTree::Tree_var st = this->owner_tree ()->get_server_tree ();
	GTree::NodeHolder_var nh = st->copy_nodes_compact (sel);

	return NodesClipboardFactory::make (nh.in());
	//#UC END# *45EEB959020C_45F7C68A0213*
}

// implemented method from NodeBase
// Расширенная версия метода create_view. (покачто вью всегда создается от рута)
NodeBase* NodeDelegate::create_view_ex (
	const FilterList& filter
	, FlagMask shared_flags
	, const NodeBase* sync_node
	, VisibleIndex& sync_index
	, unsigned long levels
	, bool unfiltered
	, bool auto_open
	, bool truncate_this_view
) {
	//#UC START# *45EEB95901C9_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (shared_flags = %d, levels = %d, unfiltered = %d, auto_open = %d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), shared_flags, levels, unfiltered, auto_open));
	
	CHECK_AND_LOCK_TREE (return 0;)
	return dynamic_cast<NodeBase*>(
		DelegateNodeBase::create_view_ex (
			filter
			, shared_flags
			, dynamic_cast<const DefaultNodeBase*>(sync_node)
			, sync_index
			, levels
			, unfiltered
			, auto_open
			, truncate_this_view
		)
	);
	//#UC END# *45EEB95901C9_45F7C68A0213*
}

// implemented method from NodeBase
// удаляет текущую ноду
void NodeDelegate::delete_node () {
	//#UC START# *45EEB959020B_45F7C68A0213*
	CHECK_AND_LOCK_TREE (return;)
	dynamic_cast<NodeBase*>(this->cached_master_node ())->delete_node ();
	//#UC END# *45EEB959020B_45F7C68A0213*
}

// implemented method from NodeBase
// удаляет все ноды по заданному флагу. ВРЕМЕННО перенесен с каталога на ноду!!!
void NodeDelegate::delete_nodes (FlagMask mask) /*throw (ConstantModify)*/ {
	//#UC START# *45EEB9590209_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s ()", GDS_CURRENT_FUNCTION));
	CHECK_AND_LOCK_TREE (return;)

	NodeIterator_var node_iterator = Core::TypeTraits<NodeIterator_i>::Factory::make (this, mask);
	NodeIterator_i* it = dynamic_cast<NodeIterator_i*> (node_iterator.ptr ());
	GTree::CompactSelectorList_var sel = it->make_compact_selectors ();
	

	//NodeIterator_var dummy_it = new NodeIterator_i (this, mask);	
	//GTree::SelectorList_var dummy = dummy_it->make_selectors (); // load all nodes to prevent errors in apply delta routine
	
	if (sel->length()) {
		GTree::Tree_var st = this->owner_tree ()->get_server_tree ();		
		st->delete_nodes_compact (sel);
	}
	//#UC END# *45EEB9590209_45F7C68A0213*
}

// implemented method from NodeBase
const EntityBase* NodeDelegate::get_entity () const
	/*throw (NoEntity)*/
{
	//#UC START# *45F65BEA00DA_45F7C68A0213_GET*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	CHECK_AND_LOCK_TREE (throw NoEntity ();)	
	return dynamic_cast<const NodeBase*>(this->cached_master_node ())->get_entity ();
	//#UC END# *45F65BEA00DA_45F7C68A0213_GET*
}

EntityBase* NodeDelegate::get_entity ()
	/*throw (NoEntity)*/
{
	return const_cast<EntityBase*>(((const NodeDelegate*)this)->get_entity ());
}

void NodeDelegate::set_entity (EntityBase* entity) {
	//#UC START# *45F65BEA00DA_45F7C68A0213_SET*
	dynamic_cast<NodeBase*>(this->cached_master_node ())->set_entity (entity);
	//#UC END# *45F65BEA00DA_45F7C68A0213_SET*
}

// implemented method from NodeBase
// устанавливает и снимает флаг раскрытия всех нод в дереве
void NodeDelegate::expand_all (bool expand) {
	//#UC START# *45EEB9590220_45F7C68A0213*
	DefaultNodeBase::expand_all_nodes (expand);
	//#UC END# *45EEB9590220_45F7C68A0213*
}

// implemented method from NodeBase
// Поиск в дереве по условию, заданному в фильтре. В случае успеха возвращает итератор первого
// вхождения, иначе пустой итератор (is_good!=true).
FindIterator* NodeDelegate::find (const FilterList& filter, const NodePosition& find_from) const {
	//#UC START# *45EEB959021C_45F7C68A0213*
	CHECK_AND_LOCK_TREE (return 0;)
	return DelegateNodeBase::find (filter, find_from);
	//#UC END# *45EEB959021C_45F7C68A0213*
}

// implemented method from NodeBase
// ищет в текущем дереву ноду равную переданной
NodeBase* NodeDelegate::find_node (const NodeBase* node_to_find) const {
	//#UC START# *45EEB95901D2_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));
	
	CHECK_AND_LOCK_TREE (return 0;)
	return dynamic_cast<NodeDelegate*>(DefaultNodeBase::find_node_by_interface (node_to_find));
	//#UC END# *45EEB95901D2_45F7C68A0213*
}

// implemented method from NodeBase
// Получение индексного пути ноды. Первый индекс в пути сам узел node_to_find
NodeIndexPath* NodeDelegate::find_node_path (NodeBase* node_to_find) const {
	//#UC START# *45EEB95901D4_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	CHECK_AND_LOCK_TREE (return 0;)
	return DelegateNodeBase::find_node_path (node_to_find);
	//#UC END# *45EEB95901D4_45F7C68A0213*
}

// implemented method from NodeBase
const NodeBase* NodeDelegate::get_first_child () const {
	//#UC START# *45FE5E3000DA_45F7C68A0213_GET*
	//SLOG_SHIFT
	//SLOG_D (("%s [0x%X,%d]", GDS_CURRENT_FUNCTION, this->idptr (), this->get_server_pointer()));
	
	CHECK_AND_LOCK_TREE (return 0;)

	NodeBase_cvar first_child = dynamic_cast<const NodeDelegate*>(DefaultNodeBase::get_real_interface (DelegateNodeBase::first_child ()));	
	const_cast<NodeDelegate*> (this)->owner_tree ()->flush_counter_delta();
	return first_child._retn ();
	//#UC END# *45FE5E3000DA_45F7C68A0213_GET*
}

NodeBase* NodeDelegate::get_first_child () {
	return const_cast<NodeBase*>(((const NodeDelegate*)this)->get_first_child ());
}

// implemented method from NodeBase
// Возвращает абс. индекс для ноды
VisibleIndex NodeDelegate::get_abs_index () const /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901E6_45F7C68A0213*
	return DelegateNodeBase::get_abs_index ();
	//#UC END# *45EEB95901E6_45F7C68A0213*
}

// implemented method from NodeBase
LayerIdList* NodeDelegate::get_available_layers () const {
	//#UC START# *46236D06007D_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));
	
	return dynamic_cast<const NodeBase*>(this->cached_master_node ())->get_available_layers ();
	//#UC END# *46236D06007D_45F7C68A0213*
}

// implemented method from NodeBase
// возвращает ноду-соседа (т.е. "брата" текущей) по индексу
NodeBase* NodeDelegate::get_by_sibbling_index (VisibleIndex ind) {
	//#UC START# *45EEB95901D6_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), ind));
	
	CHECK_AND_LOCK_TREE (return 0;)

	{
		FlagNodeBase* ret = this;
		GCL::StaticNode_var for_constructed;
		
		if (ind > 0) {
			while (ind && ret) {
				ret = ret->next_one_level (ind, for_constructed);
				GDS_ASSERT (ind >= 0);
			}
		} else {
			while (ind && ret) {
				ret = ret->prev_one_level (ind, for_constructed);
				GDS_ASSERT (ind <= 0);
			}
		}
		if (!ret) {
			return  0;
		} else {
			GCL::StaticNode* node_for_compare = ret;
			if (node_for_compare == for_constructed.ptr() && !dynamic_cast<FlagNodeStub*> (ret)) {
				for_constructed.forget(); 
			}
			return dynamic_cast<NodeDelegate*>(DelegateNodeBase::get_real_interface (Core::IObject::_duplicate (ret)));
		}	
		//this->owner_tree ()->flush_counter_delta(); // - ???? why its commented???
	}
	//#UC END# *45EEB95901D6_45F7C68A0213*
}

// implemented method from NodeBase
// возвращает ноду по видемому индексу относительно текущей
NodeBase* NodeDelegate::get_by_visible_index (VisibleIndex ind) {
	//#UC START# *45EEB95901D8_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), ind));
	
	long timestamp = TimeStampSync::TimeStampObjectManager::instance()->timestamp ();
	
	CHECK_AND_LOCK_TREE (return 0;)
	
	if (timestamp != TimeStampSync::TimeStampObjectManager::instance()->timestamp ()) {
		return 0;
	}

	//VisibleIndex saved_ind = this->get_visible_index() + ind;
	//VisibleIndex sind = ind;
		
	try {
		FlagNodeBase* ret = this;
		GCL::StaticNode_var for_constructed;

		if (ind > 0) {
			while (ind && ret) {
				ret = ret->next_visible (ind, for_constructed);			
				GDS_ASSERT (ind >= 0);
			}
		} else {
			while (ind && ret) {
				ret = ret->prev_visible (ind, for_constructed);			
				GDS_ASSERT (ind <= 0);
			}
		}

		if (!ret) {
			this->owner_tree ()->flush_counter_delta();

			return 0;
		} else {
			GCL::StaticNode* node_for_compare = ret;
			if (node_for_compare == for_constructed.ptr() && !dynamic_cast<FlagNodeStub*> (ret)) {
				for_constructed.forget ();
			}
			NodeBase_var out_node = dynamic_cast<NodeDelegate*>(DelegateNodeBase::get_real_interface (Core::IObject::_duplicate(ret)));
			// если эта проверка прошла, значит в for_constructed лежит указатель на ноду
			// уже возвращёную в пул. См. http://mdp.garant.ru/x/ODHABQ
			if (node_for_compare == for_constructed.ptr() && !dynamic_cast<FlagNodeStub*> (ret)) {
				for_constructed.inout () = 0;
			}
			this->owner_tree ()->flush_counter_delta ();

			return out_node._retn ();
		}

	} catch (::TimeStampSync::InvalidTimeStamp& ex) {
		if (ex.catch_action == ::TimeStampSync::CA_RETRY) {
			return 0;
		}
	} catch (TreeBase::EmptyBranch&) {
		return 0;
	}

	// похоже, что мы не должы сюда попадать
	GDS_ASSERT (false);
	return 0;
	/*
	VisibleIndex out_index = out_node ? dynamic_cast<NodeBase*>(out_node)->get_visible_index() : -1;
	VisibleIndex my_index = this->get_visible_index();
	
	if (saved_ind != out_index) {
		SLOG_D (("looks like ERROR"));
	}

	SLOG_D ((
		"return [%d,%d,%d] (index %d (in %d))"
		, out_node ? dynamic_cast<StaticNode*>(out_node) : 0
		, out_node ? dynamic_cast<NodeBase*>(out_node)->get_server_pointer() : -1
		, my_index
		, out_index
		, saved_ind
	));*/

	//if (out_node == 0) {
	//	SLOG_D (("looks like ERROR"));
	//}
	//#UC END# *45EEB95901D8_45F7C68A0213*
}

// implemented method from NodeBase
// Возвращает путь к ноде по её абс. индексу
NodeIndexPath* NodeDelegate::get_child_path_by_abs_index (VisibleIndex index) const /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901E7_45F7C68A0213*
	return DelegateNodeBase::get_child_path_by_abs_index (index);
	//#UC END# *45EEB95901E7_45F7C68A0213*
}

// implemented method from NodeBase
NodeIndexPath* NodeDelegate::get_first_fit (const FilterList& filter) const {
	//#UC START# *45EEB95901DA_45F7C68A0213*
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	CHECK_AND_LOCK_TREE (return 0;)
	return DelegateNodeBase::get_first_fit (filter);
	//#UC END# *45EEB95901DA_45F7C68A0213*
}

// implemented method from NodeBase
unsigned long NodeDelegate::get_first_level_children_flag_count (FlagMask flag) const {
	//#UC START# *4677A5180213_45F7C68A0213*
	CHECK_AND_LOCK_TREE (return 0;)

	return DelegateNodeBase::get_first_level_children_flag_count(flag);	
	//#UC END# *4677A5180213_45F7C68A0213*
}

// implemented method from NodeBase
// возвращает кол-во зхаданных флагов в текущем поддереве
unsigned long NodeDelegate::get_flag_count (FlagMask flag) const {
	//#UC START# *45EEB95901DC_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d) = %d", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), flag, -1));
	CHECK_AND_LOCK_TREE (return 0;)

	return DelegateNodeBase::get_flag_count(flag);	
	//#UC END# *45EEB95901DC_45F7C68A0213*
}

// implemented method from NodeBase
NodeBase* NodeDelegate::get_frozen_node () const {
	//#UC START# *4624DEED008C_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));
	return Core::TypeTraits<FrozenNode_i>::Factory::make (this);	
	//#UC END# *4624DEED008C_45F7C68A0213*
}

// implemented method from NodeBase
// Возвращает порядковый номер узла относительно родителя (начиная с 1)
VisibleIndex NodeDelegate::get_index_from_parent () const {
	//#UC START# *45EEB95901E5_45F7C68A0213*
	return DelegateNodeBase::get_index_from_parent ();
	//#UC END# *45EEB95901E5_45F7C68A0213*
}

// implemented method from NodeBase
// Дублирует с CatalogBase
NodeBase* NodeDelegate::get_node_by_path (const NodeIndexPath& path) const /*throw (NotFound)*/ {
	//#UC START# *45EEB959021A_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	CHECK_AND_LOCK_TREE (return 0;)
	return DelegateNodeBase::get_node_by_path (path);
	//#UC END# *45EEB959021A_45F7C68A0213*
}

// implemented method from NodeBase
// Получение идентификатора ноды. Обычно возвращает пойнтер, но для документа value->id (), т.е. не
// уникален.
NodeId NodeDelegate::get_node_id () const {
	//#UC START# *45EEB95901DE_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	return this->get_server_pointer ();
	//#UC END# *45EEB95901DE_45F7C68A0213*
}

// implemented method from NodeBase
NodeBase* NodeDelegate::get_unfiltered_node () const {
	//#UC START# *4625D15D0138_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	return dynamic_cast<NodeBase*> (const_cast<RealNodeBase*> (Core::IObject::_duplicate (this->cached_master_node ())));
	//#UC END# *4625D15D0138_45F7C68A0213*
}

// implemented method from NodeBase
// возвращает разницу видимых индексов двух нод (может автоматически развернуть необходимые уровни)
VisibleIndex NodeDelegate::get_visible_delta (const NodeBase* node) const /*throw (NotFound)*/ {
	//#UC START# *45EEB95901E1_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] ([%d,%d])", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), dynamic_cast<StaticNode*>(node), dynamic_cast<NodeBase*>(node)->get_server_pointer()));

	CHECK_AND_LOCK_TREE (throw NotFound ();)
	
	VisibleIndex ret = -1;
	if (this->owner_tree ()) {		
		const DefaultNodeBase* nb = dynamic_cast<const DefaultNodeBase*>(node);
		if (nb) {		
			ret = DefaultNodeBase::get_visible_delta (const_cast<DefaultNodeBase*> (nb));
		} else {
			const FrozenNode_i* fn = dynamic_cast<const FrozenNode_i*>(node);
			if (fn) {
				GTree::NodePath_var path = fn->get_server_path ();
				ret = DefaultNodeBase::get_visible_delta (path.in ());
			}
		}	
		const_cast<NodeDelegate*> (this)->owner_tree ()->flush_counter_delta();
	}

	return ret;
	//#UC END# *45EEB95901E1_45F7C68A0213*
}

// implemented method from NodeBase
VisibleIndex NodeDelegate::get_visible_delta_by_entity (const EntityBase* entity) const /*throw (NotFound)*/ {
	//#UC START# *45EEB95901E3_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	CHECK_AND_LOCK_TREE (throw NotFound ();)
	return DefaultNodeBase::get_visible_delta (entity);
	//#UC END# *45EEB95901E3_45F7C68A0213*
}

// implemented method from NodeBase
// признакк есть ли дети
bool NodeDelegate::has_children () const {
	//#UC START# *45EEB95901EA_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	CHECK_AND_LOCK_TREE (return false;)
	return DelegateNodeBase::has_children ();
	//#UC END# *45EEB95901EA_45F7C68A0213*
}

// implemented method from NodeBase
// признак взведен ли у детей указанный флаг
bool NodeDelegate::has_children_flag (FlagMask flag) const {
	//#UC START# *45EEB95901EB_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));
	CHECK_AND_LOCK_TREE (return false;)

	return DelegateNodeBase::has_children_flag(flag);	
	//#UC END# *45EEB95901EB_45F7C68A0213*
}

// implemented method from NodeBase
// признак того что нода соджержит отфильтрованных детей
bool NodeDelegate::has_filtered_children () const {
	//#UC START# *45EEB95901ED_45F7C68A0213*
	return DelegateNodeBase::get_has_filtered_children ();
	//#UC END# *45EEB95901ED_45F7C68A0213*
}

// implemented method from NodeBase
// признак взведен ли указанный флаг
bool NodeDelegate::has_flag (FlagMask flag) const {
	//#UC START# *45EEB95901EE_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));
	CHECK_AND_LOCK_TREE (return false;)

	return DelegateNodeBase::has_flag(flag);
	//#UC END# *45EEB95901EE_45F7C68A0213*
}

// implemented method from NodeBase
// признак взведен ли у родителей указанный флаг
bool NodeDelegate::has_parent_flag (FlagMask flag) const {
	//#UC START# *45EEB95901F0_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));
	CHECK_AND_LOCK_TREE (return false;)

	return DelegateNodeBase::has_parent_flag(flag);	
	//#UC END# *45EEB95901F0_45F7C68A0213*
}

// implemented method from NodeBase
// возвращает true, если установлен флаг раскрытия всех нод
bool NodeDelegate::get_is_expanded () const {
	//#UC START# *45EEB9590228_45F7C68A0213_GET*
	return DefaultNodeBase::is_all_expanded ();
	//#UC END# *45EEB9590228_45F7C68A0213_GET*
}

// implemented method from NodeBase
// признак первый ли это ребенок
bool NodeDelegate::is_first () const {
	//#UC START# *45EEB95901F2_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	CHECK_AND_LOCK_TREE (return true;)
	return DelegateNodeBase::is_first();
	//#UC END# *45EEB95901F2_45F7C68A0213*
}

// implemented method from NodeBase
// возвращает true если переданная нода (it) выше текущей
bool NodeDelegate::is_it_higher (NodeBase* it) const {
	//#UC START# *45EEB95901F3_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));
	CHECK_AND_LOCK_TREE (return false;)

	return DefaultNodeBase::is_it_higher (dynamic_cast<GCL::StaticNode*>(it));
	//#UC END# *45EEB95901F3_45F7C68A0213*
}

// implemented method from NodeBase
// признак последний ли это ребенок
bool NodeDelegate::is_last () const {
	//#UC START# *45EEB95901F5_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	CHECK_AND_LOCK_TREE (return true;)
	return DelegateNodeBase::is_last();
	//#UC END# *45EEB95901F5_45F7C68A0213*
}

// implemented method from NodeBase
bool NodeDelegate::is_relevance_search_supported () const {
	//#UC START# *45EEB959021F_45F7C68A0213*
	return DelegateNodeBase::is_relevance_search_supported ();
	//#UC END# *45EEB959021F_45F7C68A0213*
}

// implemented method from NodeBase
// проверяет на равенство две ноды
bool NodeDelegate::is_same_node (NodeBase* node) const {
	//#UC START# *45EEB95901F6_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	if (!node) {
		return false;
	}

	NodeDelegate* nd = dynamic_cast <NodeDelegate*> (node);
	if (nd) {
		return const_cast<RealNodeBase*> (this->cached_master_node ())->is_equal (nd->cached_master_node ());
	}

	NodeBase_i* ni = dynamic_cast <NodeBase_i*> (node);
	if (ni) {
		return const_cast<RealNodeBase*> (this->cached_master_node ())->is_equal (ni);
	}

	if (dynamic_cast <FrozenNode_i*> (node)) {
		return node->is_same_node (const_cast<NodeBase*> (dynamic_cast<const NodeBase*>(this->cached_master_node ())));
	}

	GDS_ASSERT (false);
	return false;
	//return DelegateNodeBase::is_equal (dynamic_cast<StaticNode*>(node));
	//#UC END# *45EEB95901F6_45F7C68A0213*
}

// implemented method from NodeBase
NodeIterator* NodeDelegate::iterate_all_nodes (FlagMask with_flag) {
	//#UC START# *473D89660266_45F7C68A0213*
	if (this->owner_tree ()->is_mode(with_flag)) {
		return Core::TypeTraits<AllNodeIterator_i>::Factory::make (
			dynamic_cast<DefaultNodeBase*> (this->cached_master_node ())
			, with_flag
		);
	} else {
		return Core::TypeTraits<AllNodeIterator_i>::Factory::make (this, with_flag);
	}
	//#UC END# *473D89660266_45F7C68A0213*
}

// implemented method from NodeBase
// возвращает сквозной итератор по нодам с указанным флагом
NodeIterator* NodeDelegate::iterate_nodes (FlagMask with_flag) {
	//#UC START# *45EEB95901F8_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	if (this->owner_tree ()->is_mode(with_flag)) {
		return Core::TypeTraits<NodeIterator_i>::Factory::make (
			dynamic_cast<DefaultNodeBase*> (this->cached_master_node ())
			, with_flag
		);
	} else {
		return Core::TypeTraits<NodeIterator_i>::Factory::make (this, with_flag);
	}
	//#UC END# *45EEB95901F8_45F7C68A0213*
}

// implemented method from NodeBase
// уровень ноды в дереве
long NodeDelegate::get_level () const {
	//#UC START# *45EEB9590223_45F7C68A0213_GET*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	return DelegateNodeBase::level ();
	//#UC END# *45EEB9590223_45F7C68A0213_GET*
}

// implemented method from NodeBase
void NodeDelegate::make_visible () {
	//#UC START# *45EEB95901FA_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));
	CHECK_AND_LOCK_TREE (return;)
	
	DelegateNodeBase::make_visible ();
	//#UC END# *45EEB95901FA_45F7C68A0213*
}

// implemented method from NodeBase
const NodeBase* NodeDelegate::get_next () const {
	//#UC START# *45FE5E9C0109_45F7C68A0213_GET*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d,%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));
	
	CHECK_AND_LOCK_TREE (return 0;)

	NodeBase_cvar next = dynamic_cast<const NodeDelegate*>(DefaultNodeBase::get_real_interface (DelegateNodeBase::next()));	
	const_cast<NodeDelegate*> (this)->owner_tree ()->flush_counter_delta ();
	return next._retn ();
	//#UC END# *45FE5E9C0109_45F7C68A0213_GET*
}

NodeBase* NodeDelegate::get_next () {
	return const_cast<NodeBase*>(((const NodeDelegate*)this)->get_next ());
}

// implemented method from NodeBase
const NodeBase* NodeDelegate::get_parent () const {
	//#UC START# *45FE5ECB0261_45F7C68A0213_GET*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	return dynamic_cast<const NodeDelegate*> (DelegateNodeBase::parent());	
	//#UC END# *45FE5ECB0261_45F7C68A0213_GET*
}

NodeBase* NodeDelegate::get_parent () {
	return const_cast<NodeBase*>(((const NodeDelegate*)this)->get_parent ());
}

// implemented method from NodeBase
const NodeBase* NodeDelegate::get_prev () const {
	//#UC START# *45FE5E5902FD_45F7C68A0213_GET*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d,%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));
	
	CHECK_AND_LOCK_TREE (return 0;)

	NodeBase_cvar prev = dynamic_cast<const NodeDelegate*> (DefaultNodeBase::get_real_interface (DelegateNodeBase::prev()));
	const_cast<NodeDelegate*> (this)->owner_tree ()->flush_counter_delta();
	return prev._retn ();
	//#UC END# *45FE5E5902FD_45F7C68A0213_GET*
}

NodeBase* NodeDelegate::get_prev () {
	return const_cast<NodeBase*>(((const NodeDelegate*)this)->get_prev ());
}

// implemented method from NodeBase
void NodeDelegate::remove_notifier (NodeNotifier* notifier) {
	//#UC START# *45EEB95901FB_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), notifier));
	CHECK_AND_LOCK_TREE (return;)
	
	DelegateNodeBase::remove_notifier(notifier);
	//#UC END# *45EEB95901FB_45F7C68A0213*
}

// implemented method from NodeBase
// сбрасывает текущщую транзакцию (вместе со всеми вложенными),  сбрасывает все изменения
// (перечитывает с сервера или внутреннего буффера)
void NodeDelegate::rollback_change_transaction () {
	//#UC START# *45EEB9590218_45F7C68A0213*
	dynamic_cast<NodeBase*>(this->cached_master_node ())->rollback_change_transaction();
	//#UC END# *45EEB9590218_45F7C68A0213*
}

// implemented method from NodeBase
// устанавливает у всего поддерева (КРОМЕ самой ноды на который была вызвана операция) указанный
// флаг (сейчас работает всегда от рута, и иногда глючит именно установка, сброс работает корректно)
void NodeDelegate::set_all_flag (FlagMask flag, bool value) {
	//#UC START# *45EEB95901FD_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d,%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), flag, value ? 1 : 0));
	
	CHECK_AND_LOCK_TREE (return;)

#ifdef _USE_FIRST_DROP_SELECTION_HACK
	if (!value && flag == FM_SELECTION && this->owner_tree ()->m_first_drop_selection) {
		this->owner_tree ()->m_first_drop_selection = false;
		return;		
	}
#endif
	DelegateNodeBase::set_all_flag(flag, value, false);
	this->owner_tree ()->flush_counter_delta();
	//#UC END# *45EEB95901FD_45F7C68A0213*
}

// implemented method from NodeBase
void NodeDelegate::set_all_flag_except_first_children_of_root_children (FlagMask flag, bool value) {
	//#UC START# *51EFC4100162_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d,%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), flag, value ? 1 : 0));
	
	CHECK_AND_LOCK_TREE (return;)

#ifdef _USE_FIRST_DROP_SELECTION_HACK
	if (!value && flag == FM_SELECTION && this->owner_tree ()->m_first_drop_selection) {
		this->owner_tree ()->m_first_drop_selection = false;
		return;		
	}
#endif
	DelegateNodeBase::set_all_flag_except_first_children_of_root_children(flag, value, false);
	this->owner_tree ()->flush_counter_delta();
	//#UC END# *51EFC4100162_45F7C68A0213*
}

// implemented method from NodeBase
// взводит указанный флаг
void NodeDelegate::set_flag (FlagMask flag, bool value) {
	//#UC START# *45EEB9590200_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d,%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), flag, value ? 1 : 0));
	
	CHECK_AND_LOCK_TREE (return;)

#ifdef _USE_FIRST_DROP_SELECTION_HACK
	if (value && flag == FM_SELECTION && this->owner_tree ()->m_first_drop_selection) {
		//this->owner_tree ()->m_first_drop_selection = false;
		return;		
	}
#endif

	DelegateNodeBase::set_flag(flag, value, false);	
	this->owner_tree ()->flush_counter_delta();
	//#UC END# *45EEB9590200_45F7C68A0213*
}

// implemented method from NodeBase
// Изменить идентификатор ноды. Обычно ничего не делает, но для документа изменяет value->id ().
void NodeDelegate::set_node_id (NodeId id) {
	//#UC START# *45EEB95901DF_45F7C68A0213*
	GDS_ASSERT (0);
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45EEB95901DF_45F7C68A0213*
}

// implemented method from NodeBase
// взводит указанный флаг на промежутке
void NodeDelegate::set_range_flag (
	VisibleIndex offset_from
	, VisibleIndex offset_to
	, FlagMask flag
	, bool value
	, bool clean_other
) {
	//#UC START# *45EEB9590203_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d,%d,%d,%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), from, to, flag, value ? 1 : 0));
	
	CHECK_AND_LOCK_TREE (return;)

	DelegateNodeBase::set_range_flag(offset_from, offset_to, flag, value, clean_other, false);
	this->owner_tree ()->flush_counter_delta ();
	//#UC END# *45EEB9590203_45F7C68A0213*
}

// implemented method from NodeBase
void NodeDelegate::set_range_flag_except_first_children_of_root_children (
	VisibleIndex offset_from
	, VisibleIndex offset_to
	, FlagMask flag
	, bool value
	, bool clean_other
) {
	//#UC START# *51EFD26E03DF_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d,%d,%d,%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), from, to, flag, value ? 1 : 0));
	
	CHECK_AND_LOCK_TREE (return;)

	DelegateNodeBase::set_range_flag_except_first_children_of_root_children(offset_from, offset_to, flag, value, clean_other, false);
	this->owner_tree ()->flush_counter_delta ();
	//#UC END# *51EFD26E03DF_45F7C68A0213*
}

// implemented method from NodeBase
// указывает на начало транзакции изменения данных ноды. Транзакции могут быть вложенными
void NodeDelegate::start_change_transaction () {
	//#UC START# *45EEB9590217_45F7C68A0213*
	dynamic_cast<NodeBase*>(this->cached_master_node ())->start_change_transaction();
	//#UC END# *45EEB9590217_45F7C68A0213*
}

// implemented method from NodeBase
// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
// для диффиренцации отображения
NodeType NodeDelegate::get_type () const {
	//#UC START# *45EEB9590224_45F7C68A0213_GET*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	return dynamic_cast<const NodeBase*>(this->cached_master_node ())->get_type();
	//#UC END# *45EEB9590224_45F7C68A0213_GET*
}

void NodeDelegate::set_type (NodeType type)
	/*throw (ConstantModify)*/
{
	//#UC START# *45EEB9590224_45F7C68A0213_SET*
	dynamic_cast<NodeBase*>(this->cached_master_node ())->set_type (type);
	//#UC END# *45EEB9590224_45F7C68A0213_SET*
}

// implemented method from SettingEntity
// Восстанавливает "ссылку" из настроек свзанную с данным ключем и данным типом (классом, группой)
// объеков.
SettingEntity* NodeDelegate::load_from_setting (PropertyID_const id) const {
	//#UC START# *45EECD5D02F1_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	return dynamic_cast<const NodeBase*>(this->cached_master_node ())->load_from_setting (id);
	//#UC END# *45EECD5D02F1_45F7C68A0213*
}

// implemented method from SettingEntity
// Сохраняет "ссылку" на данный экземпляр в настройках, связывая ее с переданным строковым ключем.
// Тип ссылки зависит зависит от конкретного класса реализующего джанный интерфейс.
void NodeDelegate::save_in_setting (PropertyID_const id) const {
	//#UC START# *45EECD5D02EF_45F7C68A0213*
	//SLOG_SHIFT
	//SLOG_D (("%s[%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));

	dynamic_cast<const NodeBase*>(this->cached_master_node ())->save_in_setting (id);
	//#UC END# *45EECD5D02EF_45F7C68A0213*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

