////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ViewBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::ViewBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ViewBase.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeRoot.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeRoot_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
// by <<friend>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeBase.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ViewBase::ViewBase ()
//#UC START# *46025BAC02FD_BASE_INIT*
: m_mode (FM_SHARED_NONE)
//#UC END# *46025BAC02FD_BASE_INIT*
{
	//#UC START# *46025BAC02FD_BODY*
	//LOG_D (("%s [%d]", GDS_CURRENT_FUNCTION, (TreeBase*)this));
	//#UC END# *46025BAC02FD_BODY*
}

ViewBase::~ViewBase () {
	//#UC START# *45F57B6C0128_DESTR_BODY*
	try {
		GTree::Tree_var sview = this->get_server_tree (); // 'sview' - это может быть не view, а tree
		if (!CORBA::is_nil (sview)) {
			//LOG_D (("%s [%d] - remove_reference", GDS_CURRENT_FUNCTION, this));

			// {{{ [xxx], зачем см. TreeBase::create_view, почему см. 'TODO' в ViewBase::init
			GTree::TreeView_var view = GTree::TreeView::_narrow (sview);
			if (CORBA::is_nil (view)) {
				return; // не view, не надо звать release_object 
			}
			// }}}
			ApplicationHelper::instance ()->get_cached_life_cycle_manager ()->release_object (sview.in ());
		}
	} catch (CORBA::TRANSIENT&) {
		// do nothing, `CORBA::TRANSIENT` exception ignored
	} catch (...) {
		GDS_ASSERT ((false, "Unknown exception catched"));
	}
	//#UC END# *45F57B6C0128_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

GCL::StaticNode* ViewBase::build_node (const GTree::ViewNode& snode, FlagNodeBase* current_stub) {
	//#UC START# *46272A80037A*
	//SLOG_SHIFT

	GCL::StaticNode_var mn = m_parent_tree_root->owner_tree ()->build_node (snode.master_node, current_stub, snode.master_index);
	RealNodeBase* master_node = dynamic_cast<RealNodeBase*>(mn.ptr());
	if (!master_node) {
		GDS_ASSERT (master_node);
		return 0;
	}
	
	Core::Var<DelegateNodeBase> ret;
	
	ret = dynamic_cast<DelegateNodeBase*> (this->alloc_new_node (snode.master_node));	
	GDS_ASSERT (ret.ptr());

	bool skip_childs = false;
	if (m_maximum_levels_restriction) {
		if (master_node->level() >= m_maximum_levels_restriction) {
			skip_childs = true;
		}
	}

	if (!skip_childs && snode.view_children_count) {
		//SLOG_D (("%s [%d]: [%d,%d]: insert stubs children (%d)", GDS_CURRENT_FUNCTION, this, (StaticNode*)ret, snode.master_node.pointer, snode.view_children_count));
		if (m_all_expanded) {
			if (current_stub) {
				current_stub->has_flag (FM_SELECTION)
					? FlagNodeStub::make_as_back_child (ret.ptr (), snode.view_children_count, this, FlagMaskStubPostProcess (FM_SELECTION, true))
					: FlagNodeStub::make_as_back_child (ret.ptr (), snode.view_children_count, this, GCL::NullStubPostProcess ())
				;
			}
		} else {
			FlagNodeStub::make_as_back_child (ret.in (), snode.view_children_count, this, GCL::NullStubPostProcess ());
		}
	}

	//apply flags
	this->apply_flags (master_node, dynamic_cast<FlagNodeBase*>(ret.ptr()), m_mode);

	ret->set_master_node (Core::IObject::_duplicate(master_node));
	//LOG_D ((
	//	"%s [%d] - apply masert node (%d, %s) to delegate (%d)"
	//	, GDS_CURRENT_FUNCTION
	//	, this
	//	, (StaticNode*)master_node
	//	, master_node->node_name()
	//	, (StaticNode*)ret
	//));

	if (current_stub) {
		this->apply_flags (
			dynamic_cast<FlagNodeBase*>(current_stub)
			, dynamic_cast<FlagNodeBase*>(ret.ptr())
			, (~m_mode)
		);
	}
	
	if (snode.flags & GTree::VNF_HAS_FILTERED_CHILDREN) {
		ret->set_has_filtered_children (true);
		if (!skip_childs && m_auto_open) {
			if (current_stub) {
				current_stub->make_visible ();
			}
			ret->DelegateNodeBase::set_flag (FM_OPEN, true, false);
		}
	} else if (m_all_expanded && snode.view_children_count) {
	  if (current_stub) {
	    current_stub->make_visible ();
	  }
	  ret->DelegateNodeBase::set_flag (FM_OPEN, true, false);
	}

	return ret._retn();
	//#UC END# *46272A80037A*
}

void ViewBase::init (
	FlagMask mode
	, unsigned int levels
	, bool auto_open
	, const TreeBase* parent_tree
	, GTree::Tree* server_tree
) {
	//#UC START# *46025D6F0000*
	// TODO: server_tree должен быть не GTree::Tree, а GTree::TreeView, тогда не пришлось бы затачивать в деструкторе
	m_maximum_levels_restriction = levels;
	m_auto_open = auto_open;
	m_mode = mode;
	m_parent_tree_root = dynamic_cast<DefaultNodeBase*> (parent_tree->root ());
	
	this->set_active_changeble (parent_tree->get_active_changeble ());
	this->apply_server_tree (server_tree);

	for (NodeFlagMap::const_iterator it = parent_tree->get_flags_map ().begin (); it != parent_tree->get_flags_map ().end (); ++it) {
		m_flags_map [it->first];
	}
	//#UC END# *46025D6F0000*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

bool ViewBase::get_auto_open () const {
	//#UC START# *46025CBB01B5_GET_ACCESSOR*
	return m_auto_open;
	//#UC END# *46025CBB01B5_GET_ACCESSOR*
}

unsigned int ViewBase::get_maximum_levels_restriction () const {
	//#UC START# *46025C9E01D4_GET_ACCESSOR*
	return m_maximum_levels_restriction;
	//#UC END# *46025C9E01D4_GET_ACCESSOR*
}

FlagMask ViewBase::get_mode () const {
	//#UC START# *46025C6602BF_GET_ACCESSOR*
	return m_mode;
	//#UC END# *46025C6602BF_GET_ACCESSOR*
}

const DefaultNodeBase* ViewBase::get_parent_tree_root () const {
	//#UC START# *46025C860251_GET_ACCESSOR*
	return m_parent_tree_root._sretn ();
	//#UC END# *46025C860251_GET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from TreeBase
Core::Mutex* ViewBase::get_change_mutex () {
	//#UC START# *460139CE02BF_45F57B6C0128*
	if (!m_parent_tree_root->owner_tree ()) {
		throw InvalidOwnerTree ();
	}
	return m_parent_tree_root->owner_tree ()->get_change_mutex();
	//#UC END# *460139CE02BF_45F57B6C0128*
}

// implemented method from TreeBase
const std::string& ViewBase::get_tree_name () const {
	//#UC START# *4948E2B2038D_45F57B6C0128_GET*
	return master_tree()->get_tree_name();
	//#UC END# *4948E2B2038D_45F57B6C0128_GET*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from TreeBase
void ViewBase::expand_all (bool expand) {
	//#UC START# *460127560261_45F57B6C0128*
	if (!expand) {
		m_auto_open = false;
	}
	TreeBase::expand_all (expand);
	//#UC END# *460127560261_45F57B6C0128*
}

// overloaded method from TreeBase
FlagMask ViewBase::get_shared_mode () const {
	//#UC START# *4601240A033C_45F57B6C0128*
	return m_mode;
	//#UC END# *4601240A033C_45F57B6C0128*
}

// overloaded method from TreeBase
bool ViewBase::is_mode (FlagMask shared_flags) const {
	//#UC START# *4601221600DA_45F57B6C0128*
	return (m_mode & shared_flags) != 0;
	//#UC END# *4601221600DA_45F57B6C0128*
}

// overloaded method from TreeBase
GCL::StaticNode* ViewBase::load_nodes_from_server (
	GTree::NodePointer parent_point
	, GTree::NodePointer child_point
	, long from
	, unsigned long in_block_position
	, GCL::StaticNodeStubBase* current_stub
) /*throw (
	TreeBase::InvalidOwnerTree
)*/ {
	//#UC START# *46012392006D_45F57B6C0128*
	//SLOG_SHIFT
	//SLOG_D (("%s (parent_point=%d, child_point=%d, from=%d, in_block_position=%d", GDS_CURRENT_FUNCTION, parent_point, child_point, from, in_block_position));
	
	GTree::ViewNodeList_var nl;
	{
		//Core::GDS::StopWatchEx sw (this->get_tree_name (), "ViewBase::get_branch for %s", this->get_tree_name ());
		GTree::NodeSelector sel;
		sel.parent_pointer = parent_point;
		sel.child_pointer = child_point;
		nl = m_server_tree->get_view_branch (sel, from, this->get_load_block_half_size () * 2);
		GDS_ASSERT (nl.ptr ());
		if (!nl->length ()) {
			throw TreeBase::EmptyBranch ();
		}
	}

	{
		//LOG_D (("m_server_tree->get_branch (parent_point=%d, child_point=%d, from=%d, count=%d", parent_point, child_point, from, this->get_load_block_half_size ()*2));
		//LOG_D ((
		//	"buffer is: 0=%d, in_block_position-1=%d, in_block_position=%d, in_block_position+1=%d"
		//	, (*nl)[0].master_node.pointer
		//	, in_block_position > 0 ? (*nl)[in_block_position - 1].master_node.pointer : -1
		//	, (*nl)[in_block_position].master_node.pointer
		//	, in_block_position < nl->length () - 1 ? (*nl)[in_block_position + 1].master_node.pointer : -1
		//));
		//LOG_D (("in_block_position=%d", in_block_position));
	}

	GCL::StaticNode_var real_node;

	if (current_stub) {
		// transform prev
		GCL::StaticNodeStubBase* stub_to_correct = current_stub;
		GCL::StaticNode_var sn_sibling = current_stub->prev();
		GCL::StaticNodeStubBase* stub = dynamic_cast<GCL::StaticNodeStubBase*> (sn_sibling.ptr());

		unsigned i = 0; // GARANT_FORSCOPING
		for (i = 0; i < in_block_position && stub; i++) {
			//LOG_D ((
			//	"call transform_to_real_node for prev (ind in buf=%d, ponter=%d)"
			//	, in_block_position - i - 1
			//	, (*nl)[in_block_position - i - 1].master_node.pointer
			//));
			
			int x = in_block_position - i - 1;
			GDS_ASSERT (0 <= x && static_cast<unsigned> (x) < nl->length ());
			
			real_node = this->build_node (
				(*nl)[in_block_position - i - 1]
				, dynamic_cast<FlagNodeBase*>(current_stub)
			);
			stub->transform_to_real_node(
				real_node.in()
				, 0
				, stub_to_correct
			);
			stub_to_correct = 0;
			sn_sibling = stub->prev();
			stub = dynamic_cast<GCL::StaticNodeStubBase*> (sn_sibling.ptr());
		}

		// transform next
		stub_to_correct = current_stub;
		sn_sibling = current_stub->next();
		stub = dynamic_cast<GCL::StaticNodeStubBase*> (sn_sibling.ptr());

		for (i = in_block_position + 1; i < nl->length() && stub; i++) {
			real_node = this->build_node (
				(*nl)[i]
				, dynamic_cast<FlagNodeBase*>(current_stub)
			);
			stub->transform_to_real_node(
				real_node.in()
				, stub_to_correct
				, 0
			);
			stub_to_correct = 0;
			sn_sibling = stub->next();
			stub = dynamic_cast<GCL::StaticNodeStubBase*> (sn_sibling.ptr());
		}
	}

	return this->build_node (
		(*nl)[in_block_position]
		, dynamic_cast<FlagNodeBase*>(current_stub)
	);	
	//#UC END# *46012392006D_45F57B6C0128*
}

// overloaded method from TreeBase
const TreeBase* ViewBase::master_tree () const {
	//#UC START# *46012787038A_45F57B6C0128*
	return m_parent_tree_root->owner_tree ();
	//#UC END# *46012787038A_45F57B6C0128*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

