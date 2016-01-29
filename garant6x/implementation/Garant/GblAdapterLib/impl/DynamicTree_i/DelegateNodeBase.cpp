////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::DelegateNodeBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeBase.h"
// by <<friend>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeBase.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DelegateNodeBase::DelegateNodeBase (TreeBase* owner_tree)
//#UC START# *45FA90EF02AF_BASE_INIT*
	: DefaultNodeBase (owner_tree), m_has_filtered_children (false)
//#UC END# *45FA90EF02AF_BASE_INIT*
{
	//#UC START# *45FA90EF02AF_BODY*
	//#UC END# *45FA90EF02AF_BODY*
}

DelegateNodeBase::~DelegateNodeBase () {
	//#UC START# *45F6C139000F_DESTR_BODY*
	//#UC END# *45F6C139000F_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

RealNodeBase* DelegateNodeBase::cached_master_node () {
	//#UC START# *47D6B83A00BD*
	return m_master_node.in ();
	//#UC END# *47D6B83A00BD*
}

const RealNodeBase* DelegateNodeBase::cached_master_node () const {
	//#UC START# *47D6BE690392*
	return m_master_node.in ();
	//#UC END# *47D6BE690392*
}

void DelegateNodeBase::draw_node (unsigned int level, unsigned int index) const {
	//#UC START# *45FAC1A40222*
	char buf [1024];
	
	unsigned i=0;
	for(; i < level; i++) {
		sprintf (buf+i, "\t");
	}
	sprintf (buf+i, "%d: DelegateNode [0x%X, %d]", index, this->idptr (), this->get_server_pointer());
	LOG_D ((buf));
	//#UC END# *45FAC1A40222*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

void DelegateNodeBase::set_master_node (RealNodeBase* master_node) {
	//#UC START# *47D6BA2603CF_SET_ACCESSOR*
	m_master_node = const_cast<RealNodeBase*> (master_node);
	//#UC END# *47D6BA2603CF_SET_ACCESSOR*
}

bool DelegateNodeBase::get_has_filtered_children () const {
	//#UC START# *45FAC21A0148_GET_ACCESSOR*
	return m_has_filtered_children;
	//#UC END# *45FAC21A0148_GET_ACCESSOR*
}

void DelegateNodeBase::set_has_filtered_children (bool has_filtered_children) {
	//#UC START# *45FAC21A0148_SET_ACCESSOR*
	m_has_filtered_children = has_filtered_children;
	//#UC END# *45FAC21A0148_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DefaultNodeBase
bool DelegateNodeBase::apply_change_delta (GTree::ChangeDelta& delta) {
	//#UC START# *45F95B9A0000_45F6C139000F*
	GDS_ASSERT (false);
	return false;
	//#UC END# *45F95B9A0000_45F6C139000F*
}

// implemented method from DefaultNodeBase
GTree::NodePointer DelegateNodeBase::get_server_pointer () const {
	//#UC START# *45F94B820290_45F6C139000F*
	return m_master_node->get_server_pointer ();
	//#UC END# *45F94B820290_45F6C139000F*
}

// implemented method from DefaultNodeBase
const char* DelegateNodeBase::node_name () const {
	//#UC START# *45F94D570138_45F6C139000F*
	return m_master_node->node_name ();
	//#UC END# *45F94D570138_45F6C139000F*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from DefaultNodeBase
unsigned long DelegateNodeBase::get_first_level_children_flag_count (FlagMask flag) const {
	//#UC START# *4677A98A0290_45F6C139000F*
	if (this->owner_tree ()->is_mode (flag)) {
		return m_master_node.ptr () ? m_master_node->get_first_level_children_flag_count (flag) : 0;
	} else {
		return DefaultNodeBase::get_first_level_children_flag_count (flag);
	}
	//#UC END# *4677A98A0290_45F6C139000F*
}

// overloaded method from DefaultNodeBase
unsigned long DelegateNodeBase::get_flag_count (FlagMask flag) const {
	//#UC START# *45F9522101A5_45F6C139000F*
	if (this->owner_tree ()->is_mode(flag)) {
		return m_master_node.ptr () ? m_master_node->get_flag_count(flag) : 0;
	} else {
		return DefaultNodeBase::get_flag_count(flag);
	}
	//#UC END# *45F9522101A5_45F6C139000F*
}

// overloaded method from DefaultNodeBase
bool DelegateNodeBase::has_children_flag (FlagMask flag) const {
	//#UC START# *45FA5936035B_45F6C139000F*
	if (this->owner_tree ()->is_mode (flag)) {
		return m_master_node.ptr() ? m_master_node->has_children_flag(flag) : false;
	} else {
		return DefaultNodeBase::has_children_flag(flag);
	}
	//#UC END# *45FA5936035B_45F6C139000F*
}

// overloaded method from DefaultNodeBase
bool DelegateNodeBase::has_parent_flag (FlagMask flag) const {
	//#UC START# *45F951DC0242_45F6C139000F*
	if (this->owner_tree ()->is_mode(flag)) {
		return m_master_node.ptr() ? m_master_node->has_parent_flag(flag) : false;
	} else {
		return DefaultNodeBase::has_parent_flag(flag);
	}
	//#UC END# *45F951DC0242_45F6C139000F*
}

// overloaded method from FlagNodeBase
FlagMask DelegateNodeBase::get_flags () const {
	//#UC START# *45F8124B0138_45F6C139000F*
	return (FlagNodeBase::get_flags() & (~this->owner_tree ()->get_shared_mode ())) | (m_master_node.ptr() ? m_master_node->get_flags() & this->owner_tree ()->get_shared_mode() : 0);
	//#UC END# *45F8124B0138_45F6C139000F*
}

// overloaded method from FlagNodeBase
bool DelegateNodeBase::has_flag (FlagMask flag) const {
	//#UC START# *45F9305601F4_45F6C139000F*
	if (this->owner_tree ()->is_mode(flag)) {
		return m_master_node.ptr () ? m_master_node->has_flag(flag) : false;
	} else {
		return DefaultNodeBase::has_flag(flag);
	}		
	//#UC END# *45F9305601F4_45F6C139000F*
}

// overloaded method from FlagNodeBase
void DelegateNodeBase::set_all_flag (FlagMask flag, bool value, bool with_notify) {
	//#UC START# *45F80922032C_45F6C139000F*
	if (this->owner_tree ()->is_mode (flag)) {
		if (flag == FM_OPEN) {
			DefaultNodeBase::set_all_flag (flag, value, false);
		}
		if (m_master_node.ptr ()) {
			m_master_node->set_all_flag (flag, value, with_notify);
		}
	} else {
		DefaultNodeBase::set_all_flag (flag, value, with_notify);
	}
	//#UC END# *45F80922032C_45F6C139000F*
}

// overloaded method from FlagNodeBase
bool DelegateNodeBase::set_flag (FlagMask flag, bool value, bool with_notify) {
	//#UC START# *45F8123602DE_45F6C139000F*
	/*if (
		(flag & FM_USER_FLAG_MASK) 
		&& this->has_children()
		&& !_m_master_node.is_nil()
		&& this->children_count() != _m_master_node->children_count()
		&& !this->has_children_flag(flag)
	) {
		bool ret = false;
		for (StaticNode_var cp = this->first_child(); !cp.is_nil(); cp = cp->next()) {
			StaticNodeStubBase* snsb = dynamic_cast<StaticNodeStubBase*>(cp.ptr());
			FlagNodeBase* vb;
			if (snsb) {
				vb = dynamic_cast<FlagNodeBase*>(snsb->transform_to_real_node());
			} else {
				vb = dynamic_cast<FlagNodeBase*>(cp.ptr());
			}
			if (vb) {
				ret |= vb->set_flag (flag, value, with_notify);
			}
		}
		if (value) {
			NodeBase::set_flag(flag, false, false);
		}
		return ret;
	} else */
	if (this->owner_tree ()->is_mode (flag)) {
		if (flag == FM_OPEN) {
			DefaultNodeBase::set_flag (flag, value, false);
		}
		return m_master_node.ptr () ? m_master_node->set_flag (flag, value, with_notify) : false;
	} else {
		return DefaultNodeBase::set_flag (flag, value, with_notify);
	}
	//#UC END# *45F8123602DE_45F6C139000F*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

