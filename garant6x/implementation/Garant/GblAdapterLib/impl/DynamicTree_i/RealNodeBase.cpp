////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::RealNodeBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeBase.h"
// by <<friend>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeBase.h"

//#UC START# *45F7D8410157_CUSTOM_INCLUDES*
//#UC END# *45F7D8410157_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45F7D8410157*
//#UC END# *45F7D8410157*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RealNodeBase::RealNodeBase ()
//#UC START# *45FFF0060399_BASE_INIT*
: DefaultNodeBase (0), m_server_point (GTree::ROOT_PARENT_POINT)
//#UC END# *45FFF0060399_BASE_INIT*
{
	//#UC START# *45FFF0060399_BODY*
	//#UC END# *45FFF0060399_BODY*
}

RealNodeBase::RealNodeBase (TreeBase* owner_tree, const GTree::Node& snode)
//#UC START# *45FFF06B0157_BASE_INIT*
	: DefaultNodeBase (owner_tree)
	, m_server_point (snode.pointer)
	, m_name (GCI::IO::StringFactory::create (snode.name.data.in(), snode.name.enc))
//#UC END# *45FFF06B0157_BASE_INIT*
{
	//#UC START# *45FFF06B0157_BODY*
	//#UC END# *45FFF06B0157_BODY*
}

RealNodeBase::~RealNodeBase () {
	//#UC START# *45F7D8410157_DESTR_BODY*
	//#UC END# *45F7D8410157_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void RealNodeBase::apply_transaction () {
	//#UC START# *45FFE2AF035B*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] trans=%d", GDS_CURRENT_FUNCTION, (StaticNode*)this, m_server_point, m_current_transaction));
	if (m_current_transaction. in ()) {
		const GTree::ChangeNodeData& data = m_current_transaction->transaction_data ();
		if (data.change_mask & GTree::CMC_NAME_CHANGED) {
			m_name = GCI::IO::StringFactory::create (data.name.data.in (), data.name.enc);
		}

		if (data.change_mask & GTree::CMC_VALUE_CHANGED) {
			this->change_node_value (data.value);
		}

		if (data.change_mask & GTree::CMC_ENTITY_CHANGED) {
			this->change_node_entity (data.entity);
		}
	}
	//#UC END# *45FFE2AF035B*
}

void RealNodeBase::change_node_entity (const GTree::NodeEntity& entity) {
	//#UC START# *45FFE2FB038A*
	//#UC END# *45FFE2FB038A*
}

void RealNodeBase::change_node_value (const GTree::NodeValueData& value) {
	//#UC START# *45FFE2BC03A9*
	//#UC END# *45FFE2BC03A9*
}

void RealNodeBase::commit_and_remove_transaction () {
	//#UC START# *45FFE12C031C*
	//SLOG_SHIFT	

	if (m_server_point != GTree::ROOT_PARENT_POINT) {
		//SLOG_D (("%s [%d,%d] trans=%d", GDS_CURRENT_FUNCTION, (StaticNode*)this, m_server_point, m_current_transaction));
		
		GTree::Tree_var st = this->owner_tree ()->get_server_tree ();
		GTree::NodeSelector sel;
		sel.parent_pointer = dynamic_cast<DefaultNodeBase*>(m_parent)->get_server_pointer();
		sel.child_pointer = this->get_server_pointer();

		while (true) {
			if (!this->owner_tree ()) {
				break;
			}
			try {
				st->change_node (sel, m_current_transaction->transaction_data());
				break;
			} catch (::TimeStampSync::InvalidTimeStamp& stump_ex) {
				//SLOG_SHIFT
				//SLOG_D (("%s: catching InvalidTimeStamp (stump_ex.catch_action = %d)", GDS_CURRENT_FUNCTION, stump_ex.catch_action));
				if (stump_ex.catch_action != ::TimeStampSync::CA_RETRY) {
					throw;
				}
				TreeBase_var saved_owner_tree = TreeBase::_duplicate(this->owner_tree ());
				this->owner_tree ()->get_change_mutex()->release();
				TimeStampSync::TimeStampObjectManager::instance()->wait_for_changes (stump_ex.needed_ts);
				saved_owner_tree->get_change_mutex()->acquire();
				//SLOG_D (("%s: retry GTree::change_node", GDS_CURRENT_FUNCTION));
			}
		}
		
		m_current_transaction = 0;
	} else {
		//SLOG_D (("%s [%d,%d] trans=%d - SKIP by new created", GDS_CURRENT_FUNCTION, (StaticNode*)this, m_server_point, m_current_transaction));
		//this is new created node - keep transaction data
	}	
	//#UC END# *45FFE12C031C*
}

void RealNodeBase::delete_current_transaction () {
	//#UC START# *45FFE11C0261*
	m_current_transaction = 0;
	//#UC END# *45FFE11C0261*
}

void RealNodeBase::draw_node (unsigned int level, unsigned int index) const {
	//#UC START# *45FFE07E034B*
	char buf [1024];
	
	unsigned i=0;
	for(; i < level; i++) {
		sprintf (buf+i, "\t");
	}
	sprintf (buf+i, "%d: RealNodeBase [0x%X, %d] flags: %d", index, this->idptr (), m_server_point, this->get_flags ());
	LOG_D ((buf));
	//#UC END# *45FFE07E034B*
}

void RealNodeBase::fill_entity (const GTree::NodeEntity& entity) {
	//#UC START# *45FFDF540213*
	//#UC END# *45FFDF540213*
}

void RealNodeBase::fill_value (GTree::NodeValueData& value) {
	//#UC START# *45FFDF2B03B9*
	//#UC END# *45FFDF2B03B9*
}

RealNodeBase::NodeChangeTransaction* RealNodeBase::get_current_transaction () {
	//#UC START# *45FFE0FD030D*
	if (m_current_transaction.is_nil()) {
		m_current_transaction = new NodeChangeTransaction (this);
	}
	return m_current_transaction.ptr();
	//#UC END# *45FFE0FD030D*
}

void RealNodeBase::init (TreeBase* owner_tree) {
	//#UC START# *45FFDF6E005D*
	GDS_ASSERT (!this->owner_tree ());
	this->set_owner_tree (owner_tree);
	//#UC END# *45FFDF6E005D*
}

void RealNodeBase::init_inserted (TreeBase* owner, const GTree::CreateData& data) {
	//#UC START# *45FFDFBA003E*
	GDS_ASSERT (owner == this->owner_tree ());

	m_server_point = data.new_node_pointer;
	m_name = GCI::IO::StringFactory::create (data.changed_data.name.data.in (), data.changed_data.name.enc);
	this->change_node_value (data.changed_data.value);
	this->change_node_entity (data.changed_data.entity);
	//#UC END# *45FFDFBA003E*
}

bool RealNodeBase::is_equal (const GCL::StaticNode* e) {
	//#UC START# *45FFE0D503D8*
	if (!e || !this->owner_tree () ) {
		return false;
	}
	
	const RealNodeBase* e_rnb = dynamic_cast<const RealNodeBase*>(e);
	
	if (!e_rnb || !e_rnb->owner_tree ()) {
		return false;
	}
		
	return (this->owner_tree () == e_rnb->owner_tree ()) ? DefaultNodeBase::is_equal (e) : false;
	//#UC END# *45FFE0D503D8*
}

void RealNodeBase::paste_node (GTree::PositionType ptype, DefaultNodeBase* node) {
	//#UC START# *45FFE20201C5*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d] (%d:%d), ct=%d", GDS_CURRENT_FUNCTION, (StaticNode*)this, this->m_server_point, (StaticNode*)node, node->get_server_pointer(), m_current_transaction));
	RealNodeBase* rnode = dynamic_cast<RealNodeBase*> (node);
	
	if (!rnode) {
		DelegateNodeBase* dnb = dynamic_cast<DelegateNodeBase*> (node);
		GDS_ASSERT (dnb);
		rnode = dnb->cached_master_node ();
	}

	GDS_ASSERT (rnode);

	if (rnode->m_server_point == GTree::ROOT_PARENT_POINT) {
		if (ptype == GTree::PT_AS_PREV_SIBLING) {
			rnode->m_parent = m_parent;
		} else {
			rnode->m_parent = this;
		}
	}

	bool associated = false;
	GTree::NewNodeData nnd;
	if (rnode->owner_tree ()) {
		GTree::NewNodeUID uid = this->owner_tree ()->find_created_uid (rnode);
		if (uid) {			
			nnd.name.data = CORBA::string_dup(rnode->get_current_transaction()->transaction_data().name.data);
			nnd.name.enc = rnode->get_current_transaction()->transaction_data().name.enc;

			nnd.value = rnode->get_current_transaction()->transaction_data().value;
			nnd.entity = rnode->get_current_transaction()->transaction_data().entity;
			nnd.new_uid = uid;

			//rnode->delete_current_transaction ();
		} else {
			//copy from existed node
			GDS_ASSERT (false); // not implemented yet
		}
	} else {
		GTree::NewNodeUID uid = this->owner_tree ()->associate_node_with_uid(rnode);
		associated = true;
		
		if (!rnode->m_name.is_nil ()) {
			nnd.name.data = CORBA::string_dup (rnode->m_name->get_data ());
			nnd.name.enc = rnode->m_name->get_code_page ();
		} else {
			GDS_ASSERT ((!"RealNodeBase::paste_node: rnode->m_owner_tree != 0 but rnode->m_name.is_nil ()"));
		}

		rnode->fill_value (nnd.value);
		rnode->fill_entity (nnd.entity);

		nnd.new_uid = uid;
	}

	GTree::NodePath_var node_path = this->get_server_path ();
	GTree::Tree_var st = this->owner_tree ()->get_server_tree ();
	try {
		st->add_new_node (node_path->pointer_path (), ptype, nnd);
	} catch (...) {
		if (associated) {
			this->owner_tree ()->disassociate_node_with_uid(rnode);
		}
		throw;
	}

	rnode->delete_current_transaction ();
	//#UC END# *45FFE20201C5*
}

void RealNodeBase::paste_nodes (GTree::PositionType ptype, GTree::NodeHolder* holder) const {
	//#UC START# *45FFE26E001F*
	GTree::NodePath_var node_path = this->get_server_path ();
	GTree::Tree_var st = this->owner_tree ()->get_server_tree ();
	try {
		st->paste_nodes (node_path->pointer_path (), ptype, holder);
	} catch (GTree::InvalidPointer& ) {
		LOG_W (("Invalid argument for GTree::paste_nodes"));
	}
	//#UC END# *45FFE26E001F*
}

void RealNodeBase::reset (const TreeBase* owner_tree) {
	//#UC START# *45FFDFAF0232*
	GDS_ASSERT (this->owner_tree () == owner_tree);
	this->set_owner_tree (0);
	//#UC END# *45FFDFAF0232*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const GCI::IO::String* RealNodeBase::get_name () const {
	//#UC START# *45FFE327036B_GET_ACCESSOR*
	return m_name._sretn ();
	//#UC END# *45FFE327036B_GET_ACCESSOR*
}

void RealNodeBase::set_name (GCI::IO::String* name) {
	//#UC START# *45FFE327036B_SET_ACCESSOR*
	m_name = const_cast<GCI::IO::String*> (name);
	//#UC END# *45FFE327036B_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DefaultNodeBase
bool RealNodeBase::apply_change_delta (GTree::ChangeDelta& delta) {
	//#UC START# *45F95B9A0000_45F7D8410157*
	//SLOG_SHIFT
	//SLOG_D (("%s [%d,%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this, m_server_point, m_current_transaction));
	const GTree::ChangeDataList& ch_node_list = delta.changed_nodes ();
	bool ret = false;
	for (CORBA::ULong i = 0; i < ch_node_list.length (); ++i) {
		const GTree::ChangeData& changed_node_data = ch_node_list [i];
		
		DefaultNodeBase_cvar node = this->find_loaded_node_by_path (const_cast<GTree::NodeIndexPath*>(&changed_node_data.node));
		
		if (!node.in ()) {
			continue;
		}

		ret = true;

		RealNodeBase* changed_node = const_cast<RealNodeBase*> (dynamic_cast <const RealNodeBase*> (node.in ()));
		GDS_ASSERT (changed_node);

		const GTree::ChangeNodeData& data = changed_node_data.changed_data;
		if (data.change_mask & GTree::CMC_NAME_CHANGED) {
			changed_node->m_name = GCI::IO::StringFactory::create (data.name.data.in (), data.name.enc);
		}

		if (data.change_mask & GTree::CMC_VALUE_CHANGED) {
			changed_node->change_node_value (data.value);
		}

		if (data.change_mask & GTree::CMC_ENTITY_CHANGED) {
			changed_node->change_node_entity (data.entity);
		}

		NodeIndexPath parent_path;
		DefaultNodeBase::srv_path_to_adapter (&((GTree::ChangeData) (changed_node_data)).node, parent_path);
		this->owner_tree ()->invalidate (parent_path);
	}
	return ret;
	//#UC END# *45F95B9A0000_45F7D8410157*
}

// implemented method from DefaultNodeBase
GTree::NodePointer RealNodeBase::get_server_pointer () const {
	//#UC START# *45F94B820290_45F7D8410157*
	return m_server_point;
	//#UC END# *45F94B820290_45F7D8410157*
}

// implemented method from DefaultNodeBase
const char* RealNodeBase::node_name () const {
	//#UC START# *45F94D570138_45F7D8410157*
	return this->m_name->get_data ();
	//#UC END# *45F94D570138_45F7D8410157*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

