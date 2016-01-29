////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodeBase_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodesClipboard_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodesClipboard_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeIterator_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeIterator_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FrozenNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FrozenNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/AllNodeIterator_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/AllNodeIterator_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeServerTree.h"
// by <<friend>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.h"

//#UC START# *45F7D7F503C8_CUSTOM_INCLUDES*
//#UC END# *45F7D7F503C8_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45F7D7F503C8*
NodeBase* make_tree_and_root (const char* key) {
	TreeBase_var tree = NodeServerTree<NodeBase_i>::make_tree (key);
	return tree.is_nil () ? 0 : dynamic_cast<NodeBase*> (tree->root ()); // RealRootNode
}

NodeBase* make_from_owner_tree (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {	
	TreeBase* tree = dynamic_cast<TreeBase*> (owner_tree);
	return new NodeBase_i (tree, snode);
}
//#UC END# *45F7D7F503C8*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

NodeBase_i::NodeBase_i (TreeBase* owner_tree, const GTree::Node& snode)
//#UC START# *45FFFAAD00DA_BASE_INIT*
	: RealNodeBase (owner_tree, snode)
	, DefaultNodeBase (owner_tree)
//#UC END# *45FFFAAD00DA_BASE_INIT*
{
	//#UC START# *45FFFAAD00DA_BODY*
	//ADD_OBJECT_WATCHER
	//Core::GDS::StopWatchEx sw ("NodeBase_i", "NodeBase_i(%d)::NodeBase_i", (StaticNode*)this);
	//LOG_D (("%s[%d] (%d, %s)", GDS_CURRENT_FUNCTION, (StaticNode*)this, snode.pointer, (const char*)snode.name));
	//#UC END# *45FFFAAD00DA_BODY*
}

NodeBase_i::NodeBase_i ()
//#UC START# *461DE04001F4_BASE_INIT*
//#UC END# *461DE04001F4_BASE_INIT*
{
	//#UC START# *461DE04001F4_BODY*
	//#UC END# *461DE04001F4_BODY*
}

NodeBase_i::~NodeBase_i () {
	//#UC START# *45F7D7F503C8_DESTR_BODY*
	//Core::GDS::StopWatchEx sw ("~NodeBase_i", "NodeBase_i (%d, %d)::destruct", this, (StaticNode*)this);
	//LOG_D (("%s[%d] (%d, %s)", GDS_CURRENT_FUNCTION, (StaticNode*)this, m_server_point, m_name->get_buffer()));	
	//REMOVE_OBJECT_WATCHER
	GCL::StaticNode_var first_child = this->first_child ();
	for (GCL::StaticNode* child = first_child.ptr (); child; GCL::StaticNode::shift_next (child)) {
		child->parent_is_dead ();
	}
	//#UC END# *45F7D7F503C8_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from NodeBase
// аналогично add_last_childs но для одной ноды (как-либо полученной например, через
// create_new_node или напрямую из дерева, если это нода из дерева то будет сделана копия)
void NodeBase_i::add_last_child (NodeBase* node) /*throw (ConstantModify)*/ {
	//#UC START# *45EEB9590211_45F7D7F503C8*
	if (!node) {
		return;
	}

	CHECK_AND_LOCK_TREE (throw ConstantModify ();)

	this->paste_node (GTree::PT_AS_LAST_CHILD, dynamic_cast<DefaultNodeBase*>(node));
	//#UC END# *45EEB9590211_45F7D7F503C8*
}

// implemented method from NodeBase
// вставляет ноды из контейнера в конец списка детей - на самом деле если есть сортировка то
// позиции вставки могут стать другими, но ОБЯЗАТЕЛЬНО в указанном паранте
void NodeBase_i::add_last_childs (NodesClipboard* nodes) {
	//#UC START# *45EEB959020F_45F7D7F503C8*
	if (!nodes) {
		return;
	}
	
	CHECK_AND_LOCK_TREE (throw ConstantModify ();)

	this->paste_nodes (GTree::PT_AS_LAST_CHILD, dynamic_cast<NodesClipboard_i*>(nodes)->node_holder());
	//#UC END# *45EEB959020F_45F7D7F503C8*
}

// implemented method from NodeBase
void NodeBase_i::add_notifier (NodeNotifier* notifier) {
	//#UC START# *45EEB95901C7_45F7D7F503C8*
	CHECK_AND_LOCK_TREE (return;)

	DefaultNodeBase::add_notifier (notifier);
	//#UC END# *45EEB95901C7_45F7D7F503C8*
}

// implemented method from NodeBase
// аналогично add_prev_siblings но для одной ноды
void NodeBase_i::add_prev_sibling (NodeBase* node) /*throw (ConstantModify)*/ {
	//#UC START# *45EEB9590215_45F7D7F503C8*
	if (!node) {
		return;
	}
	
	CHECK_AND_LOCK_TREE (throw ConstantModify ();)

	this->paste_node (GTree::PT_AS_PREV_SIBLING, dynamic_cast<DefaultNodeBase*>(node));
	//#UC END# *45EEB9590215_45F7D7F503C8*
}

// implemented method from NodeBase
// аналогично add_last_childs, но ноды вставляется перед указанной как соседи, соответственно
// КОНСТАНТНЫМ будет парент текущей ноды
void NodeBase_i::add_prev_siblings (NodesClipboard* nodes) /*throw (ConstantModify)*/ {
	//#UC START# *45EEB9590213_45F7D7F503C8*
	if (!nodes) {
		return;
	}

	CHECK_AND_LOCK_TREE (throw ConstantModify ();)

	this->paste_nodes(GTree::PT_AS_PREV_SIBLING, dynamic_cast<NodesClipboard_i*>(nodes)->node_holder());
	//#UC END# *45EEB9590213_45F7D7F503C8*
}

// implemented method from NodeBase
// Пользовательское название ноды
const GCI::IO::String& NodeBase_i::get_caption () const {
	//#UC START# *45EEB9590222_45F7D7F503C8_GET*
	GCI::IO::String_cvar name (this->get_name ());
	return *name.ptr ();
	//#UC END# *45EEB9590222_45F7D7F503C8_GET*
}

GCI::IO::String& NodeBase_i::get_caption () {
	return const_cast<GCI::IO::String&>(((const NodeBase_i*)this)->get_caption ());
}

// implemented method from NodeBase
long NodeBase_i::get_child_count () const {
	//#UC START# *45EEB9590227_45F7D7F503C8_GET*
	CHECK_AND_LOCK_TREE (return 0;)
	return this->children_count ();
	//#UC END# *45EEB9590227_45F7D7F503C8_GET*
}

// implemented method from NodeBase
// закрывает транзакцию, и если это больше нет "верхних" открытых транзакций - сохраняет все
// изменения сделанные на ноде (отправляет данные на сервер)
void NodeBase_i::commit_change_transaction () {
	//#UC START# *45EEB9590219_45F7D7F503C8*
	this->get_current_transaction()->close ();
	//#UC END# *45EEB9590219_45F7D7F503C8*
}

// implemented method from NodeBase
// копирует ноды по заданному флагу и возвращает их в виде контейнера для последующей вставки в
// любое другое дерево.ВРЕМЕННО перенесен с каталога на ноду!!!
NodesClipboard* NodeBase_i::copy_nodes (FlagMask mask) {
	//#UC START# *45EEB959020C_45F7D7F503C8*
	CHECK_AND_LOCK_TREE (return 0;)

	Core::Var<NodeIterator_i> it (Core::TypeTraits<NodeIterator_i>::Factory::make (this, mask));
	GTree::CompactSelectorList_var sel = it->make_compact_selectors ();
	
	if (sel->length()) {
		GTree::Tree_var st = this->owner_tree ()->get_server_tree ();
		GTree::NodeHolder_var nh = st->copy_nodes_compact (sel);

		return NodesClipboardFactory::make (nh.in ());
	} else {
		return 0;
	}
	//#UC END# *45EEB959020C_45F7D7F503C8*
}

// implemented method from NodeBase
// Расширенная версия метода create_view. (покачто вью всегда создается от рута)
NodeBase* NodeBase_i::create_view_ex (
	const FilterList& filter
	, FlagMask shared_flags
	, const NodeBase* sync_node
	, VisibleIndex& sync_index
	, unsigned long levels
	, bool unfiltered
	, bool auto_open
	, bool truncate_this_view
) {
	//#UC START# *45EEB95901C9_45F7D7F503C8*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (shared_flags = %d, levels = %d, unfiltered = %d, auto_open = %d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), shared_flags, levels, unfiltered, auto_open));
	
	CHECK_AND_LOCK_TREE (return 0;)
	
	return dynamic_cast<NodeBase*>( // this is always view 
		DefaultNodeBase::create_view_ex (
			filter
			, shared_flags
			, dynamic_cast<DefaultNodeBase*>(const_cast <NodeBase*> (sync_node))
			, sync_index
			, levels
			, unfiltered
			, auto_open
			, truncate_this_view
		)
	);	
	//#UC END# *45EEB95901C9_45F7D7F503C8*
}

// implemented method from NodeBase
// удаляет текущую ноду
void NodeBase_i::delete_node () {
	//#UC START# *45EEB959020B_45F7D7F503C8*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] ()", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));
	CHECK_AND_LOCK_TREE (return;)

	GTree::SelectorList nodes;
	nodes.length (1);

	nodes[0].child_pointer = this->get_server_pointer ();
	nodes[0].parent_pointer = (m_parent) ? dynamic_cast<DefaultNodeBase*>(m_parent)->get_server_pointer () : GTree::ROOT_POINT;
	
	GTree::Tree_var st = this->owner_tree ()->get_server_tree ();
	try {
		st->delete_nodes (nodes);
	} catch (GTree::InvalidPointer& ) {
		LOG_W (("Invalid argument for GTree::delete_nodes"));
	}
	//#UC END# *45EEB959020B_45F7D7F503C8*
}

// implemented method from NodeBase
// удаляет все ноды по заданному флагу. ВРЕМЕННО перенесен с каталога на ноду!!!
void NodeBase_i::delete_nodes (FlagMask mask) /*throw (ConstantModify)*/ {
	//#UC START# *45EEB9590209_45F7D7F503C8*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), mask));
	CHECK_AND_LOCK_TREE (return;)

	Core::Var<NodeIterator_i> it (Core::TypeTraits<NodeIterator_i>::Factory::make (this, mask));	
	GTree::CompactSelectorList_var sel = it->make_compact_selectors ();
	
	if (sel->length()) {
		GTree::Tree_var st = this->owner_tree ()->get_server_tree ();
		try {
			st->delete_nodes_compact (sel);
		} catch (GTree::InvalidPointer& ) {
			LOG_W (("Invalid argument for GTree::delete_nodes"));
		}
	}
	//#UC END# *45EEB9590209_45F7D7F503C8*
}

// implemented method from NodeBase
const EntityBase* NodeBase_i::get_entity () const
	/*throw (NoEntity)*/
{
	//#UC START# *45F65BEA00DA_45F7D7F503C8_GET*
	throw NoEntity();
	//#UC END# *45F65BEA00DA_45F7D7F503C8_GET*
}

EntityBase* NodeBase_i::get_entity ()
	/*throw (NoEntity)*/
{
	return const_cast<EntityBase*>(((const NodeBase_i*)this)->get_entity ());
}

void NodeBase_i::set_entity (EntityBase* entity) {
	//#UC START# *45F65BEA00DA_45F7D7F503C8_SET*
	#pragma message("TODO: NodeBase_i::set_entity")
	//#UC END# *45F65BEA00DA_45F7D7F503C8_SET*
}

// implemented method from NodeBase
// устанавливает и снимает флаг раскрытия всех нод в дереве
void NodeBase_i::expand_all (bool expand) {
	//#UC START# *45EEB9590220_45F7D7F503C8*
	DefaultNodeBase::expand_all_nodes (expand);
	//#UC END# *45EEB9590220_45F7D7F503C8*
}

// implemented method from NodeBase
// Поиск в дереве по условию, заданному в фильтре. В случае успеха возвращает итератор первого
// вхождения, иначе пустой итератор (is_good!=true).
FindIterator* NodeBase_i::find (const FilterList& filter, const NodePosition& find_from) const {
	//#UC START# *45EEB959021C_45F7D7F503C8*
	CHECK_AND_LOCK_TREE (return 0;)

	return DefaultNodeBase::find (filter, find_from);
	//#UC END# *45EEB959021C_45F7D7F503C8*
}

// implemented method from NodeBase
// ищет в текущем дереву ноду равную переданной
NodeBase* NodeBase_i::find_node (const NodeBase* node_to_find) const {
	//#UC START# *45EEB95901D2_45F7D7F503C8*
	CHECK_AND_LOCK_TREE (return 0;)

	return dynamic_cast<NodeBase_i*> (DefaultNodeBase::find_node_by_interface (node_to_find));
	//#UC END# *45EEB95901D2_45F7D7F503C8*
}

// implemented method from NodeBase
// Получение индексного пути ноды. Первый индекс в пути сам узел node_to_find
NodeIndexPath* NodeBase_i::find_node_path (NodeBase* node_to_find) const {
	//#UC START# *45EEB95901D4_45F7D7F503C8*
	CHECK_AND_LOCK_TREE (return 0;)

	return DefaultNodeBase::find_node_path (node_to_find);
	//#UC END# *45EEB95901D4_45F7D7F503C8*
}

// implemented method from NodeBase
const NodeBase* NodeBase_i::get_first_child () const {
	//#UC START# *45FE5E3000DA_45F7D7F503C8_GET*
	//SLOG_SHIFT
	//SLOG_D (("%s [0x%X, %d]", GDS_CURRENT_FUNCTION, this->idptr (), this->get_server_pointer()));
	CHECK_AND_LOCK_TREE (return 0;)

	NodeBase_var first_child = dynamic_cast<NodeBase_i*>(DefaultNodeBase::get_real_interface (DefaultNodeBase::first_child()));
	const_cast<TreeBase*> (this->owner_tree ())->flush_counter_delta();
	return first_child._retn ();
	//#UC END# *45FE5E3000DA_45F7D7F503C8_GET*
}

NodeBase* NodeBase_i::get_first_child () {
	return const_cast<NodeBase*>(((const NodeBase_i*)this)->get_first_child ());
}

// implemented method from NodeBase
// Возвращает абс. индекс для ноды
VisibleIndex NodeBase_i::get_abs_index () const /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901E6_45F7D7F503C8*
	return DefaultNodeBase::get_abs_index ();
	//#UC END# *45EEB95901E6_45F7D7F503C8*
}

// implemented method from NodeBase
LayerIdList* NodeBase_i::get_available_layers () const {
	//#UC START# *46236D06007D_45F7D7F503C8*
	CHECK_AND_LOCK_TREE (return 0;)
	Core::Aptr <LayerIdList> list (new LayerIdList);
	DefaultNodeBase::get_available_layers (*list.ptr ());
	return list.forget ();
	//#UC END# *46236D06007D_45F7D7F503C8*
}

// implemented method from NodeBase
// возвращает ноду-соседа (т.е. "брата" текущей) по индексу
NodeBase* NodeBase_i::get_by_sibbling_index (VisibleIndex ind) {
	//#UC START# *45EEB95901D6_45F7D7F503C8*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), ind));
	CHECK_AND_LOCK_TREE (return 0;)

	FlagNodeBase* ret = this;
	GCL::StaticNode_var for_constructed;

	//VisibleIndex saved_ind = ind; // for LOG only

	if (ind > 0) {
		while (ind && ret) {
			ret = ret->next_one_level (ind, for_constructed);
		}
	} else {
		while (ind && ret) {
			ret = ret->prev_one_level (ind, for_constructed);
		}
	}
	if (!ret) {
		return 0;
	} else {
		if (ret == for_constructed.ptr() && !dynamic_cast<FlagNodeStub*> (ret)) {
			for_constructed.forget();
		}
		return dynamic_cast<NodeBase_i*>(DefaultNodeBase::get_real_interface (Core::IObject::_duplicate(ret)));
	}
	//m_owner_tree->flush_counter_delta(); // - ???? why its commented???

	//SLOG_D ((
	//	"return %s [%d,%d] = [%d,%d]"
	//	, GDS_CURRENT_FUNCTION
	//	, (StaticNode*)this
	//	, this->get_server_pointer()
	//	, out_node_base ? dynamic_cast<StaticNode*>(out_node_base) : 0
	//	, out_node_base ? dynamic_cast<NodeBase*>(out_node_base)->get_server_pointer() : -1
	//));
	//#UC END# *45EEB95901D6_45F7D7F503C8*
}

// implemented method from NodeBase
// возвращает ноду по видемому индексу относительно текущей
NodeBase* NodeBase_i::get_by_visible_index (VisibleIndex ind) {
	//#UC START# *45EEB95901D8_45F7D7F503C8*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), ind));

	CHECK_AND_LOCK_TREE (return 0;)
	{
		FlagNodeBase* ret = this;
		GCL::StaticNode_var for_constructed;

		if (ind > 0) {
			while (ind && ret) {
				ret = ret->next_visible (ind, for_constructed);
			}
		} else {
			while (ind && ret) {
				ret = ret->prev_visible (ind, for_constructed);
			}
		}
		
		NodeBase* result (0);
		
		if (ret) {
			GCL::StaticNode* node_for_compare = ret;
			if (node_for_compare == for_constructed.ptr () && !dynamic_cast<FlagNodeStub*> (ret)) {
				for_constructed.forget ();
			}

			result = dynamic_cast<NodeBase_i*> (DefaultNodeBase::get_real_interface (Core::IObject::_duplicate (ret)));

			// если эта проверка прошла, значит в for_constructed лежит указатель на ноду
			// уже возвращёную в пул. См. [$128293011]; почему-то сюда не внесли правки аналогичные [$96481592]
			// для NodeDelegate.cpp (что-то может разломаться ?)
			if (node_for_compare == for_constructed.ptr () && !dynamic_cast<FlagNodeStub*> (ret)) {
				for_constructed.inout () = 0;
			}
			
		}
		
		this->owner_tree ()->flush_counter_delta ();
		return result;
	}
	
	//SLOG_D (("return %s [%d,%d] = [%d,%d]"
	//	, GDS_CURRENT_FUNCTION
	//	, (StaticNode*)this
	//	, this->get_server_pointer()
	//	, out_node_base ? dynamic_cast<StaticNode*>(out_node_base) : 0
	//	, out_node_base ? dynamic_cast<NodeBase*>(out_node_base)->get_server_pointer() : -1
	//));
	//#UC END# *45EEB95901D8_45F7D7F503C8*
}

// implemented method from NodeBase
// Возвращает путь к ноде по её абс. индексу
NodeIndexPath* NodeBase_i::get_child_path_by_abs_index (VisibleIndex index) const /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901E7_45F7D7F503C8*
	return DefaultNodeBase::get_child_path_by_abs_index (index);
	//#UC END# *45EEB95901E7_45F7D7F503C8*
}

// implemented method from NodeBase
NodeIndexPath* NodeBase_i::get_first_fit (const FilterList& filter) const {
	//#UC START# *45EEB95901DA_45F7D7F503C8*
	CHECK_AND_LOCK_TREE (return 0;)

	return DefaultNodeBase::get_first_fit (filter);
	//#UC END# *45EEB95901DA_45F7D7F503C8*
}

// implemented method from NodeBase
unsigned long NodeBase_i::get_first_level_children_flag_count (FlagMask flag) const {
	//#UC START# *4677A5180213_45F7D7F503C8*
	return DefaultNodeBase::get_first_level_children_flag_count (flag);
	//#UC END# *4677A5180213_45F7D7F503C8*
}

// implemented method from NodeBase
// возвращает кол-во зхаданных флагов в текущем поддереве
unsigned long NodeBase_i::get_flag_count (FlagMask flag) const {
	//#UC START# *45EEB95901DC_45F7D7F503C8*
	CHECK_AND_LOCK_TREE (return 0;)
	return DefaultNodeBase::get_flag_count(flag);
	//#UC END# *45EEB95901DC_45F7D7F503C8*
}

// implemented method from NodeBase
NodeBase* NodeBase_i::get_frozen_node () const {
	//#UC START# *4624DEED008C_45F7D7F503C8*
	return Core::TypeTraits<FrozenNode_i>::Factory::make (this);	
	//#UC END# *4624DEED008C_45F7D7F503C8*
}

// implemented method from NodeBase
// Возвращает порядковый номер узла относительно родителя (начиная с 1)
VisibleIndex NodeBase_i::get_index_from_parent () const {
	//#UC START# *45EEB95901E5_45F7D7F503C8*
	return DefaultNodeBase::get_index_from_parent ();
	//#UC END# *45EEB95901E5_45F7D7F503C8*
}

// implemented method from NodeBase
// Дублирует с CatalogBase
NodeBase* NodeBase_i::get_node_by_path (const NodeIndexPath& path) const /*throw (NotFound)*/ {
	//#UC START# *45EEB959021A_45F7D7F503C8*
	return DefaultNodeBase::get_node_by_path (path);
	//#UC END# *45EEB959021A_45F7D7F503C8*
}

// implemented method from NodeBase
// Получение идентификатора ноды. Обычно возвращает пойнтер, но для документа value->id (), т.е. не
// уникален.
NodeId NodeBase_i::get_node_id () const {
	//#UC START# *45EEB95901DE_45F7D7F503C8*
	return this->get_server_pointer ();
	//#UC END# *45EEB95901DE_45F7D7F503C8*
}

// implemented method from NodeBase
NodeBase* NodeBase_i::get_unfiltered_node () const {
	//#UC START# *4625D15D0138_45F7D7F503C8*
	return const_cast<NodeBase_i*> (Core::IObject::_duplicate (this));
	//#UC END# *4625D15D0138_45F7D7F503C8*
}

// implemented method from NodeBase
// возвращает разницу видимых индексов двух нод (может автоматически развернуть необходимые уровни)
VisibleIndex NodeBase_i::get_visible_delta (const NodeBase* node) const /*throw (NotFound)*/ {
	//#UC START# *45EEB95901E1_45F7D7F503C8*
	//SLOG_SHIFT
	//SLOG_D ((
	//	"%s [%d,%d] ([%d,%d])"
	//	, GDS_CURRENT_FUNCTION
	//	, (StaticNode*)this
	//	, this->get_server_pointer()
	//	, dynamic_cast<StaticNode*>(node)
	//	, dynamic_cast<NodeBase*>(node)->get_server_pointer()
	//));

	CHECK_AND_LOCK_TREE (throw NotFound ();)

	VisibleIndex ret;
	if (this->owner_tree ()) {		
		const DefaultNodeBase* nb = dynamic_cast<const DefaultNodeBase*> (node);
		if (nb) {		
			ret = DefaultNodeBase::get_visible_delta (const_cast<DefaultNodeBase*> (nb));
		} else {
			const FrozenNode_i* fn = dynamic_cast<const FrozenNode_i*>(node);
			if (fn) {
				GTree::NodePath_var path = fn->get_server_path (this->server_data_version ());
				ret = DefaultNodeBase::get_visible_delta (path.in ());
			} else {
				throw NotFound();
			}
		}	
		const_cast<TreeBase*> (this->owner_tree ())->flush_counter_delta();
	} else {
		throw NotFound();
	}

	//SLOG_D (("return %s [%d,%d] = %d", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), ret));

	return ret;
	//#UC END# *45EEB95901E1_45F7D7F503C8*
}

// implemented method from NodeBase
VisibleIndex NodeBase_i::get_visible_delta_by_entity (const EntityBase* entity) const /*throw (NotFound)*/ {
	//#UC START# *45EEB95901E3_45F7D7F503C8*
	CHECK_AND_LOCK_TREE (throw NotFound ();)

	return DefaultNodeBase::get_visible_delta (entity);
	//#UC END# *45EEB95901E3_45F7D7F503C8*
}

// implemented method from NodeBase
// признакк есть ли дети
bool NodeBase_i::has_children () const {
	//#UC START# *45EEB95901EA_45F7D7F503C8*
	//Core::GDS::StopWatchEx sw ("has_child", "NodeBase_i (%d)::has_child", (StaticNode*)this);

	CHECK_AND_LOCK_TREE (return false;)

	return DefaultNodeBase::has_children();
	//#UC END# *45EEB95901EA_45F7D7F503C8*
}

// implemented method from NodeBase
// признак взведен ли у детей указанный флаг
bool NodeBase_i::has_children_flag (FlagMask flag) const {
	//#UC START# *45EEB95901EB_45F7D7F503C8*
	//Core::GDS::StopWatchEx sw ("has_children_flag", "NodeBase_i (%d)::has_children_flag", (StaticNode*)this);

	CHECK_AND_LOCK_TREE (return false;)

	return DefaultNodeBase::has_children_flag(flag);
	//#UC END# *45EEB95901EB_45F7D7F503C8*
}

// implemented method from NodeBase
// признак того что нода соджержит отфильтрованных детей
bool NodeBase_i::has_filtered_children () const {
	//#UC START# *45EEB95901ED_45F7D7F503C8*
	return false;
	//#UC END# *45EEB95901ED_45F7D7F503C8*
}

// implemented method from NodeBase
// признак взведен ли указанный флаг
bool NodeBase_i::has_flag (FlagMask flag) const {
	//#UC START# *45EEB95901EE_45F7D7F503C8*
	//Core::GDS::StopWatchEx sw ("get_flag", "NodeBase_i (%d)::get_flag", (StaticNode*)this);		
	return DefaultNodeBase::has_flag(flag);	
	//#UC END# *45EEB95901EE_45F7D7F503C8*
}

// implemented method from NodeBase
// признак взведен ли у родителей указанный флаг
bool NodeBase_i::has_parent_flag (FlagMask flag) const {
	//#UC START# *45EEB95901F0_45F7D7F503C8*
	//Core::GDS::StopWatchEx sw ("has_parent_flag", "NodeBase_i (%d)::has_parent_flag", (StaticNode*)this);
	CHECK_AND_LOCK_TREE (return 0;)
	return DefaultNodeBase::has_parent_flag(flag);
	//#UC END# *45EEB95901F0_45F7D7F503C8*
}

// implemented method from NodeBase
// возвращает true, если установлен флаг раскрытия всех нод
bool NodeBase_i::get_is_expanded () const {
	//#UC START# *45EEB9590228_45F7D7F503C8_GET*
	return DefaultNodeBase::is_all_expanded ();
	//#UC END# *45EEB9590228_45F7D7F503C8_GET*
}

// implemented method from NodeBase
// признак первый ли это ребенок
bool NodeBase_i::is_first () const {
	//#UC START# *45EEB95901F2_45F7D7F503C8*
	//Core::GDS::StopWatchEx sw ("is_first", "NodeBase_i (%d)::is_first", (StaticNode*)this);
	CHECK_AND_LOCK_TREE (return true;)

	return DefaultNodeBase::is_first();
	//#UC END# *45EEB95901F2_45F7D7F503C8*
}

// implemented method from NodeBase
// возвращает true если переданная нода (it) выше текущей
bool NodeBase_i::is_it_higher (NodeBase* it) const {
	//#UC START# *45EEB95901F3_45F7D7F503C8*
	CHECK_AND_LOCK_TREE (return false;)

	return DefaultNodeBase::is_it_higher (dynamic_cast<const StaticNode*>(it));
	//#UC END# *45EEB95901F3_45F7D7F503C8*
}

// implemented method from NodeBase
// признак последний ли это ребенок
bool NodeBase_i::is_last () const {
	//#UC START# *45EEB95901F5_45F7D7F503C8*
	//Core::GDS::StopWatchEx sw ("is_last", "NodeBase_i (%d)::is_last", (StaticNode*)this);
	CHECK_AND_LOCK_TREE (return true;)

	return DefaultNodeBase::is_last();
	//#UC END# *45EEB95901F5_45F7D7F503C8*
}

// implemented method from NodeBase
bool NodeBase_i::is_relevance_search_supported () const {
	//#UC START# *45EEB959021F_45F7D7F503C8*
	return DefaultNodeBase::is_relevance_search_supported ();
	//#UC END# *45EEB959021F_45F7D7F503C8*
}

// implemented method from NodeBase
// проверяет на равенство две ноды
bool NodeBase_i::is_same_node (NodeBase* node) const {
	//#UC START# *45EEB95901F6_45F7D7F503C8*
	const NodeDelegate* nd = dynamic_cast<const NodeDelegate*>(node);
	if (nd) {
		//return nd->is_equal (this);
		return nd->is_same_node (const_cast<NodeBase_i*> (this));
	}
	if (dynamic_cast<const FrozenNode_i*>(node)) {
		return node->is_same_node (const_cast<NodeBase_i*> (this));
	}
	return const_cast <RealNodeBase*> (dynamic_cast <const RealNodeBase*> (this))->is_equal (dynamic_cast<const StaticNode*> (node));
	//#UC END# *45EEB95901F6_45F7D7F503C8*
}

// implemented method from NodeBase
NodeIterator* NodeBase_i::iterate_all_nodes (FlagMask with_flag) {
	//#UC START# *473D89660266_45F7D7F503C8*
	return Core::TypeTraits<AllNodeIterator_i>::Factory::make (this, with_flag);
	//#UC END# *473D89660266_45F7D7F503C8*
}

// implemented method from NodeBase
// возвращает сквозной итератор по нодам с указанным флагом
NodeIterator* NodeBase_i::iterate_nodes (FlagMask with_flag) {
	//#UC START# *45EEB95901F8_45F7D7F503C8*
	return Core::TypeTraits<NodeIterator_i>::Factory::make (this, with_flag);
	//#UC END# *45EEB95901F8_45F7D7F503C8*
}

// implemented method from NodeBase
// уровень ноды в дереве
long NodeBase_i::get_level () const {
	//#UC START# *45EEB9590223_45F7D7F503C8_GET*
	//Core::GDS::StopWatchEx sw ("get_level", "NodeBase_i (%d)::get_level", (StaticNode*)this);
	return DefaultNodeBase::level();
	//#UC END# *45EEB9590223_45F7D7F503C8_GET*
}

// implemented method from NodeBase
void NodeBase_i::make_visible () {
	//#UC START# *45EEB95901FA_45F7D7F503C8*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));
	CHECK_AND_LOCK_TREE (return;)

	DefaultNodeBase::make_visible ();
	//#UC END# *45EEB95901FA_45F7D7F503C8*
}

// implemented method from NodeBase
const NodeBase* NodeBase_i::get_next () const {
	//#UC START# *45FE5E9C0109_45F7D7F503C8_GET*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));
	CHECK_AND_LOCK_TREE (return 0;)

	NodeBase_var next = dynamic_cast<NodeBase_i*>(DefaultNodeBase::get_real_interface (DefaultNodeBase::next()));
	const_cast<TreeBase*>(this->owner_tree ())->flush_counter_delta ();
	return next._retn ();
	//#UC END# *45FE5E9C0109_45F7D7F503C8_GET*
}

NodeBase* NodeBase_i::get_next () {
	return const_cast<NodeBase*>(((const NodeBase_i*)this)->get_next ());
}

// implemented method from NodeBase
const NodeBase* NodeBase_i::get_parent () const {
	//#UC START# *45FE5ECB0261_45F7D7F503C8_GET*
	//Core::GDS::StopWatchEx sw ("get_parent", "NodeBase_i (%d)::get_parent", (StaticNode*)this);
	CHECK_AND_LOCK_TREE (return 0;)

	return dynamic_cast<const NodeBase_i*> (DefaultNodeBase::parent ());	
	//#UC END# *45FE5ECB0261_45F7D7F503C8_GET*
}

NodeBase* NodeBase_i::get_parent () {
	return const_cast<NodeBase*>(((const NodeBase_i*)this)->get_parent ());
}

// implemented method from NodeBase
const NodeBase* NodeBase_i::get_prev () const {
	//#UC START# *45FE5E5902FD_45F7D7F503C8_GET*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));
	CHECK_AND_LOCK_TREE (return 0;)

	NodeBase_var prev = dynamic_cast<NodeBase_i*> (DefaultNodeBase::get_real_interface (DefaultNodeBase::prev ()));
	const_cast<TreeBase*> (this->owner_tree ())->flush_counter_delta ();
	return prev._retn ();
	//#UC END# *45FE5E5902FD_45F7D7F503C8_GET*
}

NodeBase* NodeBase_i::get_prev () {
	return const_cast<NodeBase*>(((const NodeBase_i*)this)->get_prev ());
}

// implemented method from NodeBase
void NodeBase_i::remove_notifier (NodeNotifier* notifier) {
	//#UC START# *45EEB95901FB_45F7D7F503C8*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), notifier));
	CHECK_AND_LOCK_TREE (return;)
	DefaultNodeBase::remove_notifier(notifier);
	//#UC END# *45EEB95901FB_45F7D7F503C8*
}

// implemented method from NodeBase
// сбрасывает текущщую транзакцию (вместе со всеми вложенными),  сбрасывает все изменения
// (перечитывает с сервера или внутреннего буффера)
void NodeBase_i::rollback_change_transaction () {
	//#UC START# *45EEB9590218_45F7D7F503C8*
	this->delete_current_transaction ();
	//#UC END# *45EEB9590218_45F7D7F503C8*
}

// implemented method from NodeBase
// устанавливает у всего поддерева (КРОМЕ самой ноды на который была вызвана операция) указанный
// флаг (сейчас работает всегда от рута, и иногда глючит именно установка, сброс работает корректно)
void NodeBase_i::set_all_flag (FlagMask flag, bool value) {
	//#UC START# *45EEB95901FD_45F7D7F503C8*
	//SLOG_SHIFT
	//SLOG_D (("%s[%d,%d] (%d,%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), flag, value ? 1 : 0));
	CHECK_AND_LOCK_TREE (return;)

	DefaultNodeBase::set_all_flag(flag, value, false);
	this->owner_tree ()->flush_counter_delta();
	//#UC END# *45EEB95901FD_45F7D7F503C8*
}

// implemented method from NodeBase
void NodeBase_i::set_all_flag_except_first_children_of_root_children (FlagMask flag, bool value) {
	//#UC START# *51EFC4100162_45F7D7F503C8*
	//SLOG_SHIFT
	//SLOG_D (("%s[%d,%d] (%d,%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), flag, value ? 1 : 0));
	CHECK_AND_LOCK_TREE (return;)

	DefaultNodeBase::set_all_flag_except_first_children_of_root_children(flag, value, false);
	this->owner_tree ()->flush_counter_delta();
	//#UC END# *51EFC4100162_45F7D7F503C8*
}

// implemented method from NodeBase
// взводит указанный флаг
void NodeBase_i::set_flag (FlagMask flag, bool value) {
	//#UC START# *45EEB9590200_45F7D7F503C8*
	//SLOG_SHIFT
	//SLOG_D (("%s [0x%X,%d] (%d,%d)", GDS_CURRENT_FUNCTION, this->idptr (), this->get_server_pointer(), flag, value ? 1 : 0));

	CHECK_AND_LOCK_TREE (return;)

	DefaultNodeBase::set_flag(flag, value, false);
	if (this->owner_tree ()) {
		this->owner_tree ()->flush_counter_delta ();
	}
	//#UC END# *45EEB9590200_45F7D7F503C8*
}

// implemented method from NodeBase
// Изменить идентификатор ноды. Обычно ничего не делает, но для документа изменяет value->id ().
void NodeBase_i::set_node_id (NodeId id) {
	//#UC START# *45EEB95901DF_45F7D7F503C8*
	//#UC END# *45EEB95901DF_45F7D7F503C8*
}

// implemented method from NodeBase
// взводит указанный флаг на промежутке
void NodeBase_i::set_range_flag (
	VisibleIndex offset_from
	, VisibleIndex offset_to
	, FlagMask flag
	, bool value
	, bool clean_other
) {
	//#UC START# *45EEB9590203_45F7D7F503C8*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d,%d,%d,%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), offset_from, offset_to, flag, value ? 1 : 0));
	
	CHECK_AND_LOCK_TREE (return;)
	
	DefaultNodeBase::set_range_flag (offset_from, offset_to, flag, value, clean_other, false);
	this->owner_tree ()->flush_counter_delta ();
	//#UC END# *45EEB9590203_45F7D7F503C8*
}

// implemented method from NodeBase
void NodeBase_i::set_range_flag_except_first_children_of_root_children (
	VisibleIndex offset_from
	, VisibleIndex offset_to
	, FlagMask flag
	, bool value
	, bool clean_other
) {
	//#UC START# *51EFD26E03DF_45F7D7F503C8*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d,%d,%d,%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), offset_from, offset_to, flag, value ? 1 : 0));
	
	CHECK_AND_LOCK_TREE (return;)
	
	DefaultNodeBase::set_range_flag_except_first_children_of_root_children (offset_from, offset_to, flag, value, clean_other, false);
	this->owner_tree ()->flush_counter_delta ();
	//#UC END# *51EFD26E03DF_45F7D7F503C8*
}

// implemented method from NodeBase
// указывает на начало транзакции изменения данных ноды. Транзакции могут быть вложенными
void NodeBase_i::start_change_transaction () {
	//#UC START# *45EEB9590217_45F7D7F503C8*
	this->get_current_transaction()->open ();
	//#UC END# *45EEB9590217_45F7D7F503C8*
}

// implemented method from NodeBase
// Пользовательский тип ноды. Может определять тип связанной сущности, или просто использоваться
// для диффиренцации отображения
NodeType NodeBase_i::get_type () const {
	//#UC START# *45EEB9590224_45F7D7F503C8_GET*
	return NT_UNKNOWN;
	//#UC END# *45EEB9590224_45F7D7F503C8_GET*
}

void NodeBase_i::set_type (NodeType type)
	/*throw (ConstantModify)*/
{
	//#UC START# *45EEB9590224_45F7D7F503C8_SET*
	throw ConstantModify ();	
	//#UC END# *45EEB9590224_45F7D7F503C8_SET*
}

// implemented method from SettingEntity
// Восстанавливает "ссылку" из настроек свзанную с данным ключем и данным типом (классом, группой)
// объеков.
SettingEntity* NodeBase_i::load_from_setting (PropertyID_const id) const {
	//#UC START# *45EECD5D02F1_45F7D7F503C8*
	SettingsManager_var settings = SettingsManagerFactory::make ();
	
	std::string set_id = this->get_settings_root_id ();
	set_id += id;

	GTree::NodePointer serv_point;
	long serv_point_long;

	// shit!!! PropertyStringID == char*; const PropertyStringID == char * const :(
	if (settings->get_long (const_cast<char*>(set_id.data()), serv_point_long)) {
		serv_point = serv_point_long;
		return dynamic_cast<NodeBase_i*> (DefaultNodeBase::find_node(serv_point));
	}
	return 0;
	//#UC END# *45EECD5D02F1_45F7D7F503C8*
}

// implemented method from SettingEntity
// Сохраняет "ссылку" на данный экземпляр в настройках, связывая ее с переданным строковым ключем.
// Тип ссылки зависит зависит от конкретного класса реализующего джанный интерфейс.
void NodeBase_i::save_in_setting (PropertyID_const id) const {
	//#UC START# *45EECD5D02EF_45F7D7F503C8*
	SettingsManager_var settings = SettingsManagerFactory::make ();
	
	std::string set_id = this->get_settings_root_id ();
	set_id += id;

	// shit!!! PropertyStringID == char*; const PropertyStringID == char * const :(
	settings->set_long (const_cast<char*>(set_id.data()), this->get_server_pointer());
	//#UC END# *45EECD5D02EF_45F7D7F503C8*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

