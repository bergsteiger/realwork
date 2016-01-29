////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DefaultNodeBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::DefaultNodeBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DefaultNodeBase.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/ServerAdapterConverters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FrozenNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FrozenNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ViewBase.h"
// by <<friend>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeBase.h"

//#UC START# *45F7ECA8034B_CUSTOM_INCLUDES*
// гнусный хак, нужно перенести логику на ноду дерева
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i.h"
//#UC END# *45F7ECA8034B_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45F7ECA8034B*
//#UC END# *45F7ECA8034B*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

void DefaultNodeBase::srv_path_to_adapter (GTree::NodeIndexPath* index_path, NodeIndexPath& adap_path) {
	//#UC START# *45F945FC02DE*
	adap_path.clear ();
	const CORBA::ULong len = index_path->length ();
	adap_path.reserve (len);
	for (CORBA::ULong i = 0; i < len; ++i) {
		adap_path.push_back (index_path->operator [] (i));
	}
	//#UC END# *45F945FC02DE*
}

GTree::NodeIndexPath* DefaultNodeBase::adapter_path_to_srv (const NodeIndexPath& adapter_index_path) {
	//#UC START# *45F9466C003E*
	const long len = adapter_index_path.size ();
	GTree::NodeIndexPath_var ip = new GTree::NodeIndexPath;
	ip->length (len);
	for (long i = 0; i < len; ++i) {
		ip [i] = adapter_index_path[i];
	}
	return ip._retn ();
	//#UC END# *45F9466C003E*
}

void DefaultNodeBase::index_path_to_node_path (const NodeIndexPath& path, GTree::NodePath& node_path, long l) {
	//#UC START# *45FA6B180148*
	const long len = path.size () - l;
	GTree::NodeIndexPath_var ip = new GTree::NodeIndexPath;
	ip->length (len);
	for (long i = 0; i < len; ++i) {
		ip [i] = path[i + l];
	}
	node_path.index_path (ip.in ());
	//#UC END# *45FA6B180148*
}

void DefaultNodeBase::print_path (const DefaultNodeBase* node_to_find, const NodeIndexPath& path) {
	//#UC START# *45FA6BAB0109*
	LOG_D (("/////////////////////////////////////////////////////"));
	const char* name = node_to_find->node_name ();

	const long len = path.size ();
	LOG_D (("print_path for node '%s'. path len is %d.", name, len));
	DefaultNodeBase_cvar nb = DefaultNodeBase::_duplicate (node_to_find);
	for (long i = 0; i < len; ++i) {
		GTree::NodePath node_path;
		index_path_to_node_path (path, node_path, i);
		nb = node_to_find->find_node_by_path (node_path);
		if (nb.in ()) {
			LOG_D (("index %d is %d (%s)", i, path[i], nb->node_name ()));
		} else {
			LOG_D (("index %d is %d (UNKNOWN name)", i, path[i]));
			break;
		}
	}
	LOG_D (("/////////////////////////////////////////////////////"));
	//#UC END# *45FA6BAB0109*
}

void DefaultNodeBase::server_layers_id_list_to_adapter (const GTree::Layers& srv, LayerIdList& adap) {
	//#UC START# *45FA84E40213*
	const size_t len = srv.length ();
	adap.clear ();
	adap.resize (len);
	for (size_t i = 0; i < len; i++) {
		adap[i] = srv[i];
	}
	//#UC END# *45FA84E40213*
}

DefaultNodeBase* DefaultNodeBase::get_real_interface (const GCL::StaticNode* node_) {
	//#UC START# *45F94AF8031C*
	StaticNode* node = const_cast<StaticNode*> (node_);
	if (!node) {
		return 0;
	}
	DefaultNodeBase* ret = dynamic_cast<DefaultNodeBase*> (node);
	if (!ret) {
		FlagNodeStub* ns = dynamic_cast<FlagNodeStub*> (node);
		GDS_ASSERT (ns);
		
		try {
			ret = dynamic_cast<DefaultNodeBase*>(ns->transform_to_real_node ());
			ret->addref();
		} catch (GTree::InvalidPointer&) {
			ret = 0;
		}
				
		ns->release();
	}
	return ret;
	//#UC END# *45F94AF8031C*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DefaultNodeBase::DefaultNodeBase ()
//#UC START# *45F94B320109_BASE_INIT*
: m_children_flags (0), m_owner_tree (0)
//#UC END# *45F94B320109_BASE_INIT*
{
	//#UC START# *45F94B320109_BODY*
	//#UC END# *45F94B320109_BODY*
}

DefaultNodeBase::DefaultNodeBase (TreeBase* owner_tree)
//#UC START# *45F94B5D0399_BASE_INIT*
: m_children_flags (0), m_owner_tree (owner_tree) 
//#UC END# *45F94B5D0399_BASE_INIT*
{
	//#UC START# *45F94B5D0399_BODY*
	//LOG_D (("%s[0x%X]", GDS_CURRENT_FUNCTION, this->idptr ()));
	//#UC END# *45F94B5D0399_BODY*
}

DefaultNodeBase::~DefaultNodeBase () {
	//#UC START# *45F7ECA8034B_DESTR_BODY*
	//LOG_D (("%s[0x%X]", GDS_CURRENT_FUNCTION, this->idptr ()));
	//#UC END# *45F7ECA8034B_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void DefaultNodeBase::add_notifier (NodeNotifier* notifier) {
	//#UC START# *45F95547002E*
	if (m_owner_tree) {
		m_owner_tree->add_notifier(this, notifier);
	}
	//#UC END# *45F95547002E*
}

bool DefaultNodeBase::apply_delete_delta (GTree::DeleteDelta& delta) {
	//#UC START# *45F95BBD0271*
	//SLOG_SHIFT
	//SLOG_D ((
	//	"%s: delta->data().length() = %d; delta->data()[0].changed_nodes.length() = %d; delta->data()[0].changed_nodes[0].count = %d;"
	//	, GDS_CURRENT_FUNCTION
	//	, delta->data().length ()
	//	, delta->data()[0].changed_nodes.length ()
	//	, delta->data()[0].changed_nodes[0].count
	//));
	//StaticNode_var root = this->root(); 
	//root->print_tree ();
	bool ret = false;

	for (unsigned long k = 0; k < delta.data().length(); k++) {
		DefaultNodeBase_var parent = this->find_loaded_node_by_path (&delta.data()[k].parent);

		if (!parent.in ()) {
			continue;
		}

		//SLOG_D (("parent = "));
		//parent->draw_node(0,0);

		const GTree::DeltaInplaceDataList& changed_nodes = delta.data()[k].changed_nodes;
		NodeIndexPath parent_path;
		DefaultNodeBase::srv_path_to_adapter (&delta.data()[k].parent, parent_path);

		ret = ret || changed_nodes.length() > 0;
		for (unsigned long i = 0; i < changed_nodes.length(); i++) {
			GCL::StaticNode_var target;
			if (changed_nodes[i].left_child_index == GTree::IIP_BEFORE_LEFT_CHILD) {
				target = parent->first_child ();
			} else {
				target = parent->child_by_index (changed_nodes[i].left_child_index);
			}

			//SLOG_D (("target = "));
			//target->draw_node(0,0);

			long children_count_delta = -(long)changed_nodes[i].count;
			unsigned long count = changed_nodes[i].count;
			while (count) {
				GDS_ASSERT (target.ptr());
				if (dynamic_cast<FlagNodeBase*>(target.ptr())->has_flag (FM_OPEN)) {
					children_count_delta -= dynamic_cast<FlagNodeBase*>(target.ptr())->all_visible_children_count();
				}
				target = target->remove_me_and_siblings (count);
			}
						
			// here we need to correct flags maps and apply flags on created stubs			
			if (parent->has_flag(FM_OPEN) && parent->is_visible()) {
				m_owner_tree->change_children_count (VI_ALL_CHILDREN, children_count_delta, parent_path, changed_nodes[i].left_child_index);
			}
		}		
	}
	//root->print_tree ();
	return ret;
	//#UC END# *45F95BBD0271*
}

bool DefaultNodeBase::apply_insert_delta (GTree::InsertDelta& delta) {
	//#UC START# *45F95BAF02CE*
	//SLOG_SHIFT
	//SLOG_D (("NodeBase::apply_insert_delta: delta.data().length() = %d; delta.data()[0].changed_nodes.length() = %d; delta.data()[0].changed_nodes[0].count = %d;", delta.data().length(), delta.data()[0].changed_nodes.length(), delta.data()[0].changed_nodes[0].count));
	//GCL::StaticNode_var root = this->root(); 	
	//root->print_tree ();
	
	bool ret = false;
	GCL::StaticNode_var created_node;
	if (delta.for_created_node ()._d() == GTree::CNIT_CREATED) {
		created_node = m_owner_tree->apply_created_node (delta.for_created_node ().info());

		// if asserts not true - we need to implement additional logic to insert creted_node to right place
		GDS_ASSERT (delta.data().length() == 1);
		GDS_ASSERT (delta.data()[0].changed_nodes.length() == 1);
		GDS_ASSERT (delta.data()[0].changed_nodes[0].count == 1);
	}

	for (unsigned long k = 0; k < delta.data().length(); k++) {
		DefaultNodeBase_var parent = this->find_loaded_node_by_path (&delta.data()[k].parent);
	
		if (!parent.in ()) {
			//SLOG_D (("parent not fount - skip delta"));
			continue;
		}

		const GTree::DeltaInplaceDataList& changed_nodes = delta.data()[k].changed_nodes;
		NodeIndexPath parent_path;
		DefaultNodeBase::srv_path_to_adapter (&delta.data()[k].parent, parent_path);

		ret = ret || changed_nodes.length() > 0;
		for (unsigned long i = 0; i < changed_nodes.length(); i++) {
			if (changed_nodes[i].left_child_index == GTree::IIP_BEFORE_LEFT_CHILD) {
				//SLOG_D (("->FlagNodeStub::make_as_front_child index=%d m_owner_tree=%X", changed_nodes[i].left_child_index, m_owner_tree));
				if (created_node.ptr()) {
					parent->insert_front_child(created_node._retn());
				} else {
					FlagNodeStub::make_as_front_child (parent.ptr (), changed_nodes[i].count, m_owner_tree); //here we can optimize, aviod crete new stubs, insteed change counts of existed one
				}				
			} else {
				//SLOG_D (("->FlagNodeStub::make_as_next_sibling index=%d m_owner_tree=%X", changed_nodes[i].left_child_index, m_owner_tree));

				// с вью мы работать не умеем http://mdp.garant.ru/x/XI3FCw :
				// в отфильтрованное оглавление попадала нода-закладка и мы
				// падали, так как она была только на адаптерном дереве
				if (dynamic_cast <const NodeDelegate*> (parent.in ())) { 
					continue;
				}

				GCL::StaticNode_var target = parent->child_by_index(changed_nodes[i].left_child_index);
				
				GDS_ASSERT (!target.is_nil ());
				
				if (created_node.ptr()) {
					target->insert_next(created_node._retn());
				} else {
					FlagNodeStub::make_as_next_sibling (target.in (), changed_nodes[i].count, m_owner_tree); //here we can optimize, aviod crete new stubs, insteed change counts of existed one
				}
			}
			
			// here we need to correct flags maps and apply flags on created stubs
			if (parent->has_flag(FM_OPEN) && parent->is_visible()) {
				m_owner_tree->change_children_count (VI_ALL_CHILDREN, changed_nodes[i].count, parent_path, changed_nodes[i].left_child_index);
			}
		}
	}
	//root->print_tree ();
	return ret;
	//#UC END# *45F95BAF02CE*
}

bool DefaultNodeBase::apply_reset_delta (GTree::ResetDelta& delta) {
	//#UC START# *45F95B680232*
	unsigned int all_visible_children_count_before_reset = this->all_visible_children_count ();
	m_owner_tree->reset_by_root (delta.new_root_children_count());
	NodeIndexPath zero_path;
	m_owner_tree->change_children_count (
		VI_ALL_CHILDREN
		, delta.new_root_children_count() - all_visible_children_count_before_reset
		, zero_path
		, 0
	);
	// Как написано в документации:
	// нотификация о необходимости перерисовки. Должна вызываться после change_children_count (которые
	// можно группирвать) или самостоятельно при изменении дерева не связанном с кол-вом детей.
	// parent_path - путь к НОДЕ в которой произашли изменения
	// У нас почему то не вызывалась, но дерево списка тем менее перерисовывалось нормально
	// а вот другие деревья - не отрисовывались. Чудеса!!!
	m_owner_tree->invalidate (zero_path);
	return true;
	//#UC END# *45F95B680232*
}

void DefaultNodeBase::clean () {
	//#UC START# *45F95C64003E*
	for (StaticNode* cp = m_last_child; cp; cp = GCL::StaticNode::shift_prev(cp)) {
		if (DefaultNodeBase* nb = dynamic_cast<DefaultNodeBase*>(cp)) {
			nb->clean ();
		}
	}
	static_cast<GCL::StaticNodeMng*> (m_owner_tree)->pre_remove (this);
	m_owner_tree = 0;
	//#UC END# *45F95C64003E*
}

GCL::StaticNode* DefaultNodeBase::create_view_ex (
	const FilterList& filter
	, FlagMask shared_flags
	, const DefaultNodeBase* sync_node
	, VisibleIndex& sync_index
	, unsigned long levels
	, bool unfiltered
	, bool auto_open
	, bool truncate_this_view
) const {
	//#UC START# *45F94E980186*
	GTree::Query query;
	m_owner_tree->adapter_filters_to_server (const_cast<FilterList&> (filter), query);	
	
	GTree::NodePointer sync_node_pointer = sync_node ? sync_node->get_server_pointer() : 0;
	StaticNode* ret = m_owner_tree->create_view (
		this
		, query
		, shared_flags
		, sync_node_pointer
		, sync_index
		, levels
		, unfiltered
		, auto_open
		, truncate_this_view
	);
	return ret;
	//#UC END# *45F94E980186*
}

GTree::NodeEntity* DefaultNodeBase::entity () const /*throw (NoEntity)*/ {
	//#UC START# *45F95AAD0232*
	GTree::Tree_var tree = m_owner_tree->get_server_tree ();
	GDS_ASSERT (tree.ptr ());
	Core::Var<const DefaultNodeBase> parent = dynamic_cast<const DefaultNodeBase*> (this->parent());
	GDS_ASSERT (parent.ptr());
	GTree::NodeSelector sel;
	sel.parent_pointer = parent->get_server_pointer ();
	sel.child_pointer = this->get_server_pointer ();

	return tree->open_entity (sel);
	//#UC END# *45F95AAD0232*
}

void DefaultNodeBase::expand_all_nodes (bool expand) {
	//#UC START# *45F95CC40109*
	m_owner_tree->expand_all (expand);
	//#UC END# *45F95CC40109*
}

FindIterator* DefaultNodeBase::find (const FilterList& filter, const NodePosition& find_from) const {
	//#UC START# *45F95672034B*
	GTree::NodePosition srv_from;
	ServerAdapterConverters::convert (find_from, srv_from);
	GTree::FindIterator_var srv_iter (m_owner_tree->find (srv_from, const_cast<FilterList&> (filter)));
	return FindIteratorFactory::make (srv_iter._retn ());
	//#UC END# *45F95672034B*
}

DefaultNodeBase* DefaultNodeBase::find_loaded_node_by_path (
	GTree::NodeIndexPath* node_index_path
) const /*throw (
	GTree::InvalidPointer
)*/ {
	//#UC START# *45F94CBE030D*
	Core::Var <const GCL::StaticNode> root = this->root ();
	Core::Var <const GCL::StaticNode> s_node = root;
	const unsigned len = node_index_path->length ();
	if (len > 0) {
		for (unsigned i = len - 1; i > 0; --i) {
			if (!dynamic_cast<const DefaultNodeBase*> (s_node.in ())) {
				break;
			}
			s_node = s_node->child_by_index (node_index_path->operator [] (i - 1));
		}
	}
	return DefaultNodeBase::_duplicate (const_cast<DefaultNodeBase*> (dynamic_cast<const DefaultNodeBase*> (s_node.in ())));
	//#UC END# *45F94CBE030D*
}

DefaultNodeBase* DefaultNodeBase::find_node (GTree::NodePointer node_to_find) const {
	//#UC START# *45F9533D02AF*
	try {		
		GTree::NodeIndexPath_var index_path = m_owner_tree->pointer_to_index_path (node_to_find);
		GTree::NodePath_var node_path = new GTree::NodePath();
		node_path->index_path (index_path.in ());

		return this->find_node_by_path (node_path.in());
	} catch (GTree::InvalidPointer&) {
		return 0;
	}
	//#UC END# *45F9533D02AF*
}

DefaultNodeBase* DefaultNodeBase::find_node_by_interface (const NodeBase* node_to_find) const {
	//#UC START# *45F952A602DE*
	GTree::NodePath_var node_path;
	const DefaultNodeBase* nb = dynamic_cast<const DefaultNodeBase*>(node_to_find);
	if (nb) {
		node_path = nb->get_server_path ();
	} else {
		const FrozenNode_i* fn = dynamic_cast<const FrozenNode_i*>(node_to_find);
		if (fn) {
			node_path = fn->get_server_path (this->server_data_version ());
		}
	}

	return this->find_node_by_path (node_path.in());
	//#UC END# *45F952A602DE*
}

DefaultNodeBase* DefaultNodeBase::find_node_by_path (const GTree::NodePath& node_path) const {
	//#UC START# *45F94BE501E4*
	if (node_path._d() == GTree::PT_POINTER) {
		if (node_path.pointer_path()[0] == this->get_server_pointer()) {
			return IObject::_duplicate(const_cast<DefaultNodeBase*> (this));
		}
	}
	GTree::NodeIndexPath_var index_path = this->node_path_to_index_path (node_path);
	// Не нашли ноду в дереве
	if (index_path.ptr () == 0) {
		return 0;
	}
	return this->find_node_by_path (index_path.ptr ());
	//#UC END# *45F94BE501E4*
}

DefaultNodeBase* DefaultNodeBase::find_node_by_path (
	GTree::NodeIndexPath* node_index_path
) const /*throw (
	GTree::InvalidPointer
)*/ {
	//#UC START# *45F94C8E0109*
	Core::Var <const GCL::StaticNode> root = this->root ();
	Core::Var <const GCL::StaticNode> node = root;
	const unsigned len = node_index_path->length ();
	if (len > 0) {
		for (unsigned i = len - 1; i > 0; --i) {
			if (node.is_nil ()) {
				break;
			}
			node = node->child_by_index (node_index_path->operator  [] (i - 1));
		}
	}	
	return DefaultNodeBase::get_real_interface (GCL::StaticNode::_duplicate (node.in ()));
	//#UC END# *45F94C8E0109*
}

NodeIndexPath* DefaultNodeBase::find_node_path (NodeBase* node_to_find) const {
	//#UC START# *45F9535E0213*
	try {
		GTree::NodePointer pointer = GTree::ROOT_POINT;
		DefaultNodeBase* nb = dynamic_cast<DefaultNodeBase*>(node_to_find);
		GDS_ASSERT (nb);
		if (nb) {
			pointer = nb->get_server_pointer ();
		}
		GTree::NodeIndexPath_var index_path = m_owner_tree->pointer_to_index_path (pointer);
		NodeIndexPath* res = new NodeIndexPath ();
		this->srv_path_to_adapter (index_path.ptr (), *res);
//#ifdef _DEBUG
//		LOG_D (("%s++++++++++++++++++++++++++++", GDS_CURRENT_FUNCTION));
//		print_path (nb, res);
//		LOG_D (("-----------------------------------------------------"));
//#endif
		return res;
	} catch (GTree::InvalidPointer&) {
		return 0;
	}
	//#UC END# *45F9535E0213*
}

FlagNodeStub* DefaultNodeBase::find_stub_for_index (long& index) {
	//#UC START# *45F955BC034B*
	//SLOG_SHIFT
	//SLOG_D (("%s[%d,%d] (index=%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), index));
	unsigned long ind = index;
	GCL::StaticNode* node = m_owner_tree->find_cached_node (this, index);
	ind -= index;

	bool go_down = index >= 0;
	
	for (; node; go_down ? GCL::StaticNode::shift_next (node) : GCL::StaticNode::shift_prev (node)) {
		GCL::StaticNodeStubBase* ret = dynamic_cast<GCL::StaticNodeStubBase*>(node);
		if (ret) {
			long sc = ret->stub_count();
			if (sc > 0) {
				sc--;
			} else {
				sc++;
			}
			
			if (go_down && sc < 0 || !go_down && sc > 0) {
				sc = 0;
			} 

			if (go_down && index > sc || !go_down && index < sc) {
				index -= sc;
				ind += sc;
			} else {
				GCL::StaticNode* finded = ret;
				if (ret->stub_count() > 0) {
					GCL::StaticNode::shift_prev (finded);
					ind --;
				} else {
					GCL::StaticNode::shift_next (finded);
					ind ++;
				}
					
				m_owner_tree->cache_finded_node (this, ind, finded);

				return dynamic_cast<FlagNodeStub*>(ret);
			}
		} 
		
		if (!index) {
			break;
		}

		if (go_down) {
			index--;
			ind++;
		} else {
			index++;
			ind--;
		}
	}
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45F955BC034B*
}

VisibleIndex DefaultNodeBase::get_abs_index () const /*throw (CanNotFindData)*/ {
	//#UC START# *45F954900138*
	Core::GDS::StopWatch ("DefaultNodeBase::get_abs_index");

	GTree::Tree_var tree = m_owner_tree->get_server_tree ();
	return tree->get_abs_index (this->get_server_pointer ());
	//#UC END# *45F954900138*
}

void DefaultNodeBase::get_available_layers (LayerIdList& layers) const {
	//#UC START# *45F955DD0261*
	GTree::Layers_var server_layers = m_owner_tree->get_available_layers ();
	LayerIdList ret;
	this->server_layers_id_list_to_adapter (server_layers.in(), layers);
	//#UC END# *45F955DD0261*
}

NodeIndexPath* DefaultNodeBase::get_child_path_by_abs_index (VisibleIndex index) const /*throw (CanNotFindData)*/ {
	//#UC START# *45F954CB0128*
	Core::GDS::StopWatch ("DefaultNodeBase::get_child_path_by_abs_index");

	GTree::Tree_var tree = m_owner_tree->get_server_tree ();
	GTree::NodePath_var node_path = tree->get_path_by_abs_index (index);
	NodeIndexPath* adapter_index_path = new NodeIndexPath ();
	DefaultNodeBase::srv_path_to_adapter (&node_path->index_path (), *adapter_index_path);
	return adapter_index_path;
	//#UC END# *45F954CB0128*
}

NodeIndexPath* DefaultNodeBase::get_first_fit (const FilterList& filter) const {
	//#UC START# *45F95642009C*
	GTree::NodePath_var node_path = m_owner_tree->get_first_fit (this, const_cast<FilterList&> (filter));
	if (node_path) {
		GTree::NodeIndexPath_var index_path = this->node_path_to_index_path (node_path);
		NodeIndexPath* path = new NodeIndexPath ();
		DefaultNodeBase::srv_path_to_adapter (index_path.ptr (), *path);
		return path;
	} else {
		return 0;
	}

/*#ifdef _DEBUG
	LOG_D (("%s +++++++++++++++++++++++++++++", GDS_CURRENT_FUNCTION));
	print_path (this, out_node_index_path);
	LOG_D (("-----------------------------------------------"));
#endif*/
	//#UC END# *45F95642009C*
}

unsigned long DefaultNodeBase::get_first_level_children_flag_count (FlagMask flag) const {
	//#UC START# *4677A98A0290*
	Core::Var<const GCL::StaticNode> first_child = this->first_child ();

	long flag_count = 0;
	long flag_count_for_iterator = 0;
	bool positive_stub = false;

	for (
		const GCL::StaticNode* it = first_child.ptr ();
		it; 
		GCL::StaticNode::shift_next (it)
	) {
		const FlagNodeBase* flag_node = dynamic_cast<const FlagNodeBase*> (it);
		GDS_ASSERT (flag_node);
		if (flag_node->has_flag (flag)) {
			flag_count_for_iterator = const_cast<StaticNode*> (it)->get_nodes_count_for_me ();
			if (positive_stub) {
				if (flag_count_for_iterator < 0) {
					flag_count_for_iterator = 1;
				}
				positive_stub = false;
			}
			if (flag_count_for_iterator > 1) {
				positive_stub = true;
			}
			// осталась только отрицательная заглушка
			if (flag_count_for_iterator == -1) {
				flag_count_for_iterator = 1;
			}

			// к данному моменту flag_count_for_iterator не может быть отрицательным, так
			// как это означает, что в дереве только отрицательная заглушка со stub_count < -1
			GDS_ASSERT (flag_count_for_iterator >= 1);

			flag_count += flag_count_for_iterator;
		} else {
			positive_stub = false;
		}
	}			
	return flag_count;
	//#UC END# *4677A98A0290*
}

unsigned long DefaultNodeBase::get_flag_count (FlagMask flag) const {
	//#UC START# *45F9522101A5*
	return m_owner_tree->get_all_flags_count (this, flag);
	//#UC END# *45F9522101A5*
}

// TODO: упростить, выкинув этот метод
// ходить только к StaticNode-е
VisibleIndex DefaultNodeBase::get_index_from_parent () const {
	//#UC START# *45F9547101F4*
	return 1 + (m_prev ? m_prev->get_index_from_parent () : 0);
	//#UC END# *45F9547101F4*
}

// Дублирует с CatalogBase
NodeBase* DefaultNodeBase::get_node_by_path (const NodeIndexPath& path) const {
	//#UC START# *45F958030280*
	if (path.empty ()) {
		return 0;
	}	

//#ifdef _DEBUG
//		LOG_D (("{{{ %s %d", GDS_CURRENT_FUNCTION, (const StaticNode*) this));
//		GCL::StaticNode_cvar root = this->root (); 
//		root->print_tree ();
//
//		print_path (this, path);
//		LOG_D (("}}}"));
//#endif

	GTree::NodeIndexPath_var srv_path = DefaultNodeBase::adapter_path_to_srv (path);
	DefaultNodeBase_var result = this->find_node_by_path (srv_path.ptr ());

	if (result.is_nil ()) {
		throw NotFound ();
	}
	
	NodeBase* out_node_base = dynamic_cast <NodeBase*> (result._retn ());
	GDS_ASSERT (out_node_base);
	return out_node_base;
	//#UC END# *45F958030280*
}

GTree::NodePath* DefaultNodeBase::get_server_path (GTree::PathType path_type) const {
	//#UC START# *45F94DB201C5*
	const DelegateNodeBase* dnb = dynamic_cast <const DelegateNodeBase*> (this);
	if (dnb) {
		return dnb->cached_master_node ()->get_server_path (path_type);
	} else {
		GTree::NodePath_var ret = new GTree::NodePath ();
		if (path_type == GTree::PT_NAME) {
			GTree::NodeNamePath_var path = new GTree::NodeNamePath;		
			ret->name_path (path);
			const DefaultNodeBase* p = this;
			const unsigned n = this->get_parents_count ();
			ret->name_path ().length (n);
			for (unsigned i = 0; i < n; ++i) {
				if (p == 0) {
					LOG_E (("%s (GTree::PT_NAME): m_parent is 0", GDS_CURRENT_FUNCTION));
					break;
				}
				ret->name_path ()[i] = CORBA::string_dup (p->node_name ());
				p = dynamic_cast <const DefaultNodeBase*> (p->m_parent);
			}
		} else {
			GTree::NodePointerPath_var path = new GTree::NodePointerPath;
			ret->pointer_path (path);
			const DefaultNodeBase* p = this;
			const unsigned n = this->get_parents_count ();
			ret->pointer_path ().length (n);
			for (unsigned i = 0; i < n; ++i) {
				if (p == 0) {
					LOG_E (("%s (GTree::PT_POINTER): m_parent is 0", GDS_CURRENT_FUNCTION));
					break;
				}
				ret->pointer_path ()[i] = p->get_server_pointer ();
				p = dynamic_cast <const DefaultNodeBase*> (p->m_parent);
			}
		}
		return ret._retn ();
	}
	//#UC END# *45F94DB201C5*
}

const std::string DefaultNodeBase::get_settings_root_id () const {
	//#UC START# *45F94D3B0280*
	std::string ret = "GTree//";
	ret += this->get_tree_name ();
	ret += "//";
	return ret;
	//#UC END# *45F94D3B0280*
}

const char* DefaultNodeBase::get_tree_name () const {
	//#UC START# *45F94D1E004E*
	return this->m_owner_tree->get_tree_name().c_str ();
	//#UC END# *45F94D1E004E*
}

TreeBase* DefaultNodeBase::get_tree_owner () {
	//#UC START# *45F94E24035B*
	return m_owner_tree;                                // <-- это зачем два "одинаковых" метода ?
	//#UC END# *45F94E24035B*
}

VisibleIndex DefaultNodeBase::get_visible_delta (DefaultNodeBase* node) const {
	//#UC START# *45F953BF005D*
	if (!node || !node->m_owner_tree) {
		throw NotFound();
	}
	
	GTree::NodePointer point_to_find = node->get_server_pointer();
	if (this->get_server_pointer() == point_to_find) {
		return 0;
	}

	DefaultNodeBase* target_node = node;
	if (m_owner_tree != node->m_owner_tree) {
		bool need_load = false;
		if (dynamic_cast<const RealNodeBase*>(this)) {
			DelegateNodeBase* nd = const_cast <DelegateNodeBase*> (dynamic_cast<const DelegateNodeBase*> (node));
			if (nd) {
				target_node = const_cast <RealNodeBase*> (nd->cached_master_node ());
				if (!m_owner_tree->is_loaded_node(point_to_find)) {
					need_load = true;
				}
			}
		} else {
			need_load = true;
		}
		
		if (need_load) { // find in our view node from other view
			
			// getting node pointer path in our view
			GTree::NodePath_var path = node->get_server_path();
			
			// create this node in our view
			target_node = this->find_node_by_path (path.in());
			if (target_node) {
				target_node->release();
			} else {
				throw NotFound();
			}
		}
	}
	
	// open all parents
	target_node->make_visible();	

	GCL::StaticNode_var for_constructed;

	// in most common cases server Pointers is sorted
	bool look_up = false;
	if (this->get_server_pointer() > point_to_find) {
		look_up = true;
	}

	for (unsigned side = 0; side < 2; side++) {
		VisibleIndex ind = 0;
		const FlagNodeBase* fnb_node = this;
		
		while (fnb_node) {	
			long shift_count = 1;
			fnb_node = look_up 
				? fnb_node->prev_visible (shift_count, for_constructed, true) 
				: fnb_node->next_visible (shift_count, for_constructed, true);
			
			const FlagNodeStub* fns = dynamic_cast<const FlagNodeStub*>(fnb_node);

			if (fns) {
				long sc = fns->stub_count();
				if (look_up && sc < 0) {
					ind += -sc;
				} else if (!look_up && sc > 0) {
					ind += sc;
				} else {
					ind++;
				}
			} else {
				ind++;
				const DefaultNodeBase* nb = dynamic_cast<const DefaultNodeBase*>(fnb_node);
				if (!nb) {
					break;
				}
				if (nb->get_server_pointer() == point_to_find) {
					return look_up ? -ind : ind;
				}
			}
		}
		
		look_up = !look_up;
	}
	

	/*
	// first, look in neighborhood
	unsigned side;
	for (side = 0; side < 2; side++) {
		const FlagNodeBase* node = this;
		for (unsigned i = NEIGHBORHOOD_RADIUS; i > 0 && node; i--) {
			//node = look_up ? node->prev_with_flag (0) : node->next_with_flag (0);
			node = look_up ? node->prev_visible (i, for_constructed) : node->next_visible (i, for_constructed);
		
			if (i) {
				const NodeBase* nb = dynamic_cast<const NodeBase*>(node);
				GDS_ASSERT (nb);
				if (nb->get_server_pointer() == point_to_find) {
					return look_up ? -(NEIGHBORHOOD_RADIUS - i) : (NEIGHBORHOOD_RADIUS - i);
				}
			}
		}
		if (dynamic_cast<const NodeBase*>(node)) {
			
		}
		
		look_up = !look_up;
	}	
	
	// if not found look in whole tree
	look_up = !look_up;
	StaticNode_var root = this->root();

	for (side = 0; side < 2; side++) {
		unsigned i = NEIGHBORHOOD_RADIUS;
		const FlagNodeBase* node = look_up ? upper_node : down_node;
		while (node) {
			node = look_up ? node->prev_with_flag (0) : node->next_with_flag (0);
			if (node) {
				const NodeBase* nb = dynamic_cast<const NodeBase*>(node);
				GDS_ASSERT (nb);
				if (nb->get_server_pointer() == point_to_find) {
					return look_up ? -i : i;
				}
			}
			i++;
		}
		
		look_up = !look_up;
	}*/

	throw NotFound();
	//#UC END# *45F953BF005D*
}

VisibleIndex DefaultNodeBase::get_visible_delta (const GTree::NodePath& node_path) const {
	//#UC START# *45F95412037A*
	// create this node in our view
	return this->get_visible_delta (DefaultNodeBase_var (this->find_node_by_path (node_path)).in ());
	//#UC END# *45F95412037A*
}

VisibleIndex DefaultNodeBase::get_visible_delta (const EntityBase* entity) const {
	//#UC START# *45F9542B03D8*
	VisibleIndex ret;
	if (m_owner_tree) {
		const Document* document = dynamic_cast <const Document_i*> (entity); // NodeBase depended from Document :) 
		if (document) {
			GblPilot::DocumentLinkWithTree_var server_document = GblPilot::DocumentLinkWithTree::_narrow (document->get_server_doc ());
			GTree::NodePointerPath_var path = server_document->get_pointer_path ();
			GTree::NodePath_var node_path = new GTree::NodePath();
			node_path->pointer_path (path.in ());
			ret = DefaultNodeBase::get_visible_delta (node_path.in());
		} else {
			throw NotFound();
		}
		m_owner_tree->flush_counter_delta();
	} else {
		throw NotFound();
	}
	return ret;
	//#UC END# *45F9542B03D8*
}

VisibleIndex DefaultNodeBase::get_visible_index () const {
	//#UC START# *45F94E390000*
	GCL::StaticNode_var for_constructed;

	VisibleIndex ind = 0;
	const FlagNodeBase* fnb_node = this;
		
	while (fnb_node) {	
		long shift_count = 1;
		fnb_node = fnb_node->prev_visible (shift_count, for_constructed, true);
			
		const FlagNodeStub* fns = dynamic_cast<const FlagNodeStub*>(fnb_node);

		if (fns) {
			long sc = fns->stub_count();
			if (sc < 0) {
				ind += -sc;
			} else {
				ind++;
			}
		} else {
			ind++;			
		}
	}

	return ind - 1;
	//#UC END# *45F94E390000*
}

bool DefaultNodeBase::has_children_flag (FlagMask flag) const {
	//#UC START# *45FA5936035B*
	return (m_children_flags & flag) == flag;
	//#UC END# *45FA5936035B*
}

bool DefaultNodeBase::has_parent_flag (FlagMask flag) const {
	//#UC START# *45F951DC0242*
	for (const DefaultNodeBase* parent = dynamic_cast<const DefaultNodeBase*>(this->m_parent); parent; parent = dynamic_cast<const DefaultNodeBase*>(parent->m_parent)) {
		if (parent->has_flag (flag)) {
			return true;
		}
	}
	return false;
	//#UC END# *45F951DC0242*
}

void DefaultNodeBase::invalidate_children_count () const {
	//#UC START# *45F94E8A008C*
	m_owner_tree->invalidate_finded_node (this);
	GCL::StaticNode::invalidate_children_count ();
	//#UC END# *45F94E8A008C*
}

bool DefaultNodeBase::is_all_expanded () const {
	//#UC START# *45F95CBF002E*
	return m_owner_tree->is_all_expanded ();
	//#UC END# *45F95CBF002E*
}

bool DefaultNodeBase::is_relevance_search_supported () const {
	//#UC START# *45F957E701D4*
	return m_owner_tree->is_relevance_search_supported ();
	//#UC END# *45F957E701D4*
}

GTree::NodeIndexPath* DefaultNodeBase::node_path_to_index_path (const GTree::NodePath& path) const {
	//#UC START# *45F958740203*
	if (path._d() == GTree::PT_INDEX) {
		GTree::NodeIndexPath_var ip = path.index_path (); //deep copy
		return ip._retn ();
	} else if (path._d() == GTree::PT_NAME) {
		try {
			return this->m_owner_tree->name_path_to_index_path (path.name_path ());
		} catch (GTree::InvalidPointer&) {
		}
	} else {
		try {
			return this->m_owner_tree->pointer_path_to_index_path (path.pointer_path ());
		} catch (GTree::InvalidPointer&) {
		}
	}
	return 0;
	//#UC END# *45F958740203*
}

TreeBase* DefaultNodeBase::owner_tree () {
	//#UC START# *47D6C0A2017A*
	return m_owner_tree;
	//#UC END# *47D6C0A2017A*
}

const TreeBase* DefaultNodeBase::owner_tree () const {
	//#UC START# *47D6C239024C*
	return m_owner_tree;
	//#UC END# *47D6C239024C*
}

GCL::StaticNode* DefaultNodeBase::remove_me_and_siblings (unsigned long& count) {
	//#UC START# *45F95C3C035B*
	//SLOG_SHIFT
	//SLOG_D (("%s[%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer()));	
	this->clean ();
	return GCL::StaticNode::remove_me_and_siblings(count);
	//#UC END# *45F95C3C035B*
}

void DefaultNodeBase::remove_notifier (NodeNotifier* notifier) {
	//#UC START# *45F9555D01B5*
	if (m_owner_tree) {
		m_owner_tree->remove_notifier(this, notifier);
	}
	//#UC END# *45F9555D01B5*
}

GTree::TreeDataVersionID DefaultNodeBase::server_data_version () const {
	//#UC START# *45F94D760203*
	return this->m_owner_tree->server_data_version ();
	//#UC END# *45F94D760203*
}

void DefaultNodeBase::set_children_flag (FlagMask flag, bool value) {
	//#UC START# *45F9524B006D*
	//SLOG_SHIFT
	//SLOG_D (("%s[%d,%d] (flag=%d, value=%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), flag, value));
	
	if (value) {
		if (!has_children_flag (flag)) {
			m_children_flags |= flag;
		}
	} else {
		if (has_children_flag (flag)) {
			m_children_flags &= ~flag;
		}
	}
	//#UC END# *45F9524B006D*
}

bool DefaultNodeBase::set_range_flag (
	VisibleIndex from
	, VisibleIndex to
	, FlagMask flag
	, bool value
	, bool clean_other
	, bool with_notify
) {
	//#UC START# *45F94FF401C5*
	//SLOG_SHIFT
	//SLOG_D (("%s[%d,%d] (from=%d, to=%d, flag=%d, value=%d, clean_other)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), from, to, flag, value, clean_other));

	GDS_ASSERT (from <= to);

	bool is_view = false;
	if (dynamic_cast<ViewBase*>(m_owner_tree)) {
		is_view = true;
	}

	FlagNodeBase_var root = dynamic_cast<FlagNodeBase*>(this->root());
	unsigned long prev_count = m_owner_tree->get_all_flags_count (root.in(), flag);

	if (clean_other) { // TODO: need to optimize
		root->set_all_flag(flag, false, false);
	}

	FlagNodeBase* node = this;
	VisibleIndex next_advance;
	unsigned long set_count (0);
	unsigned long real_set_count (0);

	if ( (from > 0 && to > 0) || (from < 0 && to < 0)) {
		bool go_down = from > 0;
		next_advance = go_down ? from : to;
		set_count = to - from + 1;

		while (set_count) {
			node = node->get_node_by_visible_index (next_advance);
							
			GCL::StaticNodeStubBase* snsb = dynamic_cast<GCL::StaticNodeStubBase*>(node);

			next_advance = go_down ? 1 : -1;

			if (snsb) {
				//ses: код ниже заремлен по наводке Макса, потому-что не понятно зачем это здесь,
				//также для исправления ошибки 19363
				//if (!is_view) {
					next_advance = snsb->stub_count();
					if (go_down && next_advance < 0) {
						next_advance = 1;
					} else if (!go_down && next_advance > 0) {
						next_advance = -1;
					}
				//} else {
				//	StaticNode* sn = snsb->transform_to_real_node ();
				//	node = dynamic_cast<FlagNodeBase*> (sn);
				//}
			}

			if (node->set_flag (flag, value, with_notify)) {
				real_set_count += abs(next_advance);
			}
			set_count -= abs(next_advance);
		}

	} else {
		// set current
		if (node->set_flag (flag, value, with_notify)) {
			real_set_count ++;
		}

		// go up
		next_advance = -1;
		set_count = -from;

		while (set_count) {
			node = node->get_node_by_visible_index (next_advance);
			
			next_advance = -1;
			GCL::StaticNodeStubBase* snsb = dynamic_cast<GCL::StaticNodeStubBase*>(node);
			if (snsb) {
				//if (!is_view) {
					next_advance = snsb->stub_count();
					if (next_advance > 0) {
						next_advance = -1;
					}
				//} else {
				//	StaticNode* sn = snsb->transform_to_real_node();
				//	node = dynamic_cast<FlagNodeBase*>(sn);
				//}
			} 

			if (node->set_flag (flag, value, with_notify)) {
				real_set_count -= next_advance;
			}
			set_count += next_advance;
		}

		// go down		
		node = this;
		next_advance = 1;
		set_count = to;

		while (set_count) {
			node = node->get_node_by_visible_index (next_advance);

			next_advance = 1;
			GCL::StaticNodeStubBase* snsb = dynamic_cast<GCL::StaticNodeStubBase*>(node);
			if (snsb) {
				//if (!is_view) {
					next_advance = snsb->stub_count();
					if (next_advance < 0) {
						next_advance = 1;
					}
				//} else {
				//	StaticNode* sn = snsb->transform_to_real_node();
				//	node = dynamic_cast<FlagNodeBase*>(sn);
				//}
			}

			if (node->set_flag (flag, value, with_notify)) {
				real_set_count += next_advance;
			}
			set_count -= next_advance;
		}		
	}

	/*if (prev_count > to - from - real_set_count) {
		LOG_D (("need to clean old flags"));
		// need to clean old flags
	}*/

	return true /*?*/;
	//#UC END# *45F94FF401C5*
}

bool DefaultNodeBase::set_range_flag_except_first_children_of_root_children (
	VisibleIndex from
	, VisibleIndex to
	, FlagMask flag
	, bool value
	, bool clean_other
	, bool with_notify
) {
	//#UC START# *51EFD62F03D7*
	//SLOG_SHIFT
	//SLOG_D (("%s[%d,%d] (from=%d, to=%d, flag=%d, value=%d, clean_other)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), from, to, flag, value, clean_other));

	GDS_ASSERT (from <= to);

	bool is_view = false;
	if (dynamic_cast<ViewBase*>(m_owner_tree)) {
		is_view = true;
	}

	FlagNodeBase_var root = dynamic_cast<FlagNodeBase*>(this->root());
	unsigned long prev_count = m_owner_tree->get_all_flags_count (root.in(), flag);

	if (clean_other) { // TODO: need to optimize
		root->set_all_flag(flag, false, false);
	}

	FlagNodeBase* node = this;
	VisibleIndex next_advance;
	unsigned long set_count (0);
	unsigned long real_set_count (0);

	if ( (from > 0 && to > 0) || (from < 0 && to < 0)) {
		bool go_down = from > 0;
		next_advance = go_down ? from : to;
		set_count = to - from + 1;

		while (set_count) {
			node = node->get_node_by_visible_index (next_advance);
							
			GCL::StaticNodeStubBase* snsb = dynamic_cast<GCL::StaticNodeStubBase*>(node);

			next_advance = go_down ? 1 : -1;

			if (snsb) {
				//ses: код ниже заремлен по наводке Макса, потому-что не понятно зачем это здесь,
				//также для исправления ошибки 19363
				//if (!is_view) {
					next_advance = snsb->stub_count();
					if (go_down && next_advance < 0) {
						next_advance = 1;
					} else if (!go_down && next_advance > 0) {
						next_advance = -1;
					}
				//} else {
				//	StaticNode* sn = snsb->transform_to_real_node ();
				//	node = dynamic_cast<FlagNodeBase*> (sn);
				//}
			}

			if (!node->is_first_child_of_child_of_root () && node->set_flag (flag, value, with_notify)) {
				real_set_count += abs(next_advance);
			}
			set_count -= abs(next_advance);
		}

	} else {
		// set current
		if (!node->is_first_child_of_child_of_root () && node->set_flag (flag, value, with_notify)) {
			real_set_count ++;
		}

		// go up
		next_advance = -1;
		set_count = -from;

		while (set_count) {
			node = node->get_node_by_visible_index (next_advance);
			
			next_advance = -1;
			GCL::StaticNodeStubBase* snsb = dynamic_cast<GCL::StaticNodeStubBase*>(node);
			if (snsb) {
				//if (!is_view) {
					next_advance = snsb->stub_count();
					if (next_advance > 0) {
						next_advance = -1;
					}
				//} else {
				//	StaticNode* sn = snsb->transform_to_real_node();
				//	node = dynamic_cast<FlagNodeBase*>(sn);
				//}
			} 

			if (!node->is_first_child_of_child_of_root () && node->set_flag (flag, value, with_notify)) {
				real_set_count -= next_advance;
			}
			set_count += next_advance;
		}

		// go down		
		node = this;
		next_advance = 1;
		set_count = to;

		while (set_count) {
			node = node->get_node_by_visible_index (next_advance);

			next_advance = 1;
			GCL::StaticNodeStubBase* snsb = dynamic_cast<GCL::StaticNodeStubBase*>(node);
			if (snsb) {
				//if (!is_view) {
					next_advance = snsb->stub_count();
					if (next_advance < 0) {
						next_advance = 1;
					}
				//} else {
				//	StaticNode* sn = snsb->transform_to_real_node();
				//	node = dynamic_cast<FlagNodeBase*>(sn);
				//}
			}

			if (!node->is_first_child_of_child_of_root () && node->set_flag (flag, value, with_notify)) {
				real_set_count += next_advance;
			}
			set_count -= next_advance;
		}		
	}

	/*if (prev_count > to - from - real_set_count) {
		LOG_D (("need to clean old flags"));
		// need to clean old flags
	}*/

	return true /*?*/;
	//#UC END# *51EFD62F03D7*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

FlagMask DefaultNodeBase::get_children_flags () const {
	//#UC START# *45F95D2600AB_GET_ACCESSOR*
	return m_children_flags;
	//#UC END# *45F95D2600AB_GET_ACCESSOR*
}

void DefaultNodeBase::set_owner_tree (TreeBase* owner_tree) {
	//#UC START# *45F9675A000F_SET_ACCESSOR*
	m_owner_tree = const_cast<TreeBase*> (owner_tree);
	//#UC END# *45F9675A000F_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from FlagNodeBase
// возвращает количество взведённых (изменённых?) флагов.
size_t DefaultNodeBase::internal_set_all_flag (FlagMask flag, bool value, bool children_only) {
	//#UC START# *45F810730290_45F7ECA8034B*
	//SLOG_SHIFT
	//SLOG_D (("%s[%d,%d] (flag=%d, value=%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), flag, value));
	
	unsigned long ret = 0;
	
	unsigned long count_to_remove;
	if (!value) {
		count_to_remove = m_owner_tree->get_children_flags_count (this, flag);
	}

	if (value || count_to_remove) {
		if (flag == FM_OPEN || !value || this->has_flag (FM_OPEN)) {
			for (GCL::StaticNode* cp = m_last_child; cp; GCL::StaticNode::shift_prev(cp)) {
				FlagNodeBase* vb = dynamic_cast<FlagNodeBase*>(cp);
				if (vb) {
					ret += vb->internal_set_all_flag (flag, value, false);
				}

				if (!value && ret == count_to_remove) {
					break;
				}
			}
		}
	}

	if (!children_only) {
		if (this->set_flag (flag, value, false)) { // with out tree notification
			ret++;
		}
	}
	
	return ret;
	//#UC END# *45F810730290_45F7ECA8034B*
}

// implemented method from FlagNodeBase
size_t DefaultNodeBase::internal_set_all_flag_except_first_children_of_root_children (
	FlagMask flag
	, bool value
	, bool children_only
) {
	//#UC START# *51EFC7130001_45F7ECA8034B*
	//SLOG_SHIFT
	//SLOG_D (("%s[%d,%d] (flag=%d, value=%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), flag, value));
	
	unsigned long ret = 0;
	
	unsigned long count_to_remove;
	if (!value) {
		count_to_remove = m_owner_tree->get_children_flags_count (this, flag);
	}

	if (value || count_to_remove) {
		if (flag == FM_OPEN || !value || this->has_flag (FM_OPEN)) {
			for (GCL::StaticNode* cp = m_last_child; cp; GCL::StaticNode::shift_prev(cp)) {
				FlagNodeBase* vb = dynamic_cast<FlagNodeBase*>(cp);
				if (vb) {
					ret += vb->internal_set_all_flag_except_first_children_of_root_children (flag, value, false);
				}

				if (!value && ret == count_to_remove) {
					break;
				}
			}
		}
	}

	if (!children_only) {
		if (!this->is_first_child_of_child_of_root () && this->set_flag (flag, value, false)) { // with out tree notification
			ret++;
		}
	}
	
	return ret;
	//#UC END# *51EFC7130001_45F7ECA8034B*
}

// implemented method from FlagNodeBase
void DefaultNodeBase::set_all_flag (FlagMask flag, bool value, bool with_notify) {
	//#UC START# *45F80922032C_45F7ECA8034B*
	//SLOG_SHIFT
	//SLOG_D (("%s[%d,%d]::set_all_flag (%d,%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), flag, value));	

	// предварительно снимаем все установленные флаги (иначе ошибка при попытке выделить детей ноды на которой уже устанолен флаг)
	if (this->is_root() && value) {
		this->internal_set_all_flag (flag, false, false);
	}

	if (!value) { // optimized clear for single selection
		unsigned long count = m_owner_tree->get_all_flags_count (this, flag);

		/*if (!dynamic_cast<DelegateNodeBase*>(this)) {
			LOG_D (("Node_i          [%d]::set_all_flag (flag=%d, value=%d), count=%d", m_server_point, flag, value, count));
		} else {
			LOG_D (("DelegateNodeBase[%d]::set_all_flag (flag=%d, value=%d), count=%d", m_server_point, flag, value, count));
		}*/

		if (count == 0) {			
			return; // nothing to clean;
		}
		if (count == 1 && this->is_root()) {
			DefaultNodeBase* last_selected = m_owner_tree->get_last_selected(flag);
			if (last_selected && last_selected->has_flag(flag)) {
				if (last_selected != this) {
					last_selected->set_flag(flag, false, with_notify);
				}
				return;
			}
		}
	}
	
	this->internal_set_all_flag (flag, value, true);
	//#UC END# *45F80922032C_45F7ECA8034B*
}

// implemented method from FlagNodeBase
void DefaultNodeBase::set_all_flag_except_first_children_of_root_children (
	FlagMask flag
	, bool value
	, bool with_notify
) {
	//#UC START# *51EFC6D0015B_45F7ECA8034B*
	//SLOG_SHIFT
	//SLOG_D (("%s[%d,%d]::set_all_flag (%d,%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), flag, value));	

	// предварительно снимаем все установленные флаги (иначе ошибка при попытке выделить детей ноды на которой уже устанолен флаг)
	if (this->is_root() && value) {
		this->internal_set_all_flag (flag, false, false);
	}

	if (!value) { // optimized clear for single selection
		unsigned long count = m_owner_tree->get_all_flags_count (this, flag);

		/*if (!dynamic_cast<DelegateNodeBase*>(this)) {
			LOG_D (("Node_i          [%d]::set_all_flag (flag=%d, value=%d), count=%d", m_server_point, flag, value, count));
		} else {
			LOG_D (("DelegateNodeBase[%d]::set_all_flag (flag=%d, value=%d), count=%d", m_server_point, flag, value, count));
		}*/

		if (count == 0) {			
			return; // nothing to clean;
		}
		if (count == 1 && this->is_root()) {
			DefaultNodeBase* last_selected = m_owner_tree->get_last_selected(flag);
			if (last_selected && last_selected->has_flag(flag)) {
				if (last_selected != this) {
					last_selected->set_flag(flag, false, with_notify);
				}
				return;
			}
		}
	}
	
	this->internal_set_all_flag_except_first_children_of_root_children (flag, value, true);
	//#UC END# *51EFC6D0015B_45F7ECA8034B*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from FlagNodeBase
bool DefaultNodeBase::set_flag (FlagMask flag, bool value, bool with_notify) {
	//#UC START# *45F8123602DE_45F7ECA8034B*
	//SLOG_SHIFT
	//SLOG_D (("%s[%d,%d] (%d,%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->get_server_pointer(), flag, value));

	if (FlagNodeBase::set_flag(flag, value, with_notify)) {
		bool in_tree = true;
		if (flag == FM_OPEN && value && m_parent) { // look if i am not in tree = insert
			if (!m_parent->is_my_child(this)) { // maybe is_my_child need to be optimized (replased by flad on NodeBase)
				/*
				// looks like unused!!!!
				GDS_ASSERT (false);
				RealNodeBase* rnb = dynamic_cast <RealNodeBase*> (this);
				m_owner_tree->insert_in_tree (rnb);
				*/
				in_tree = false;
			}
		}

		if (with_notify || in_tree) {
			//LOG_D (("NodeBase[%d]::set_flag ->call update_counters", (StaticNode*)this));
			m_owner_tree->update_counters (this, flag, value);
		}
		return true;
	}
	return false;
	//#UC END# *45F8123602DE_45F7ECA8034B*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

