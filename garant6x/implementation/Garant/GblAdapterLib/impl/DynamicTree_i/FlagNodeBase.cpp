////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FlagNodeBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::FlagNodeBase
//
// нода с флагами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FlagNodeBase.h"
// by <<uses>> dependencies
#include "shared/GCL/data/StaticNodeStubBase.h"

//#UC START# *45F52C0602BF_CUSTOM_INCLUDES*
//#UC END# *45F52C0602BF_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45F52C0602BF*
//#UC END# *45F52C0602BF*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FlagNodeBase::FlagNodeBase ()
//#UC START# *45F803B0000F_BASE_INIT*
	: m_flags (0)
//#UC END# *45F803B0000F_BASE_INIT*
{
	//#UC START# *45F803B0000F_BODY*
	//LOG_D (("%s 0x%X", GDS_CURRENT_FUNCTION, this->idptr ()));
	//#UC END# *45F803B0000F_BODY*
}

FlagNodeBase::~FlagNodeBase () {
	//#UC START# *45F52C0602BF_DESTR_BODY*
	//LOG_D (("%s 0x%X", GDS_CURRENT_FUNCTION, this->idptr ()));
	//#UC END# *45F52C0602BF_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// // TODO: hide in cache
size_t FlagNodeBase::all_visible_children_count () const {
	//#UC START# *45F907DE033C*
	unsigned long ret = 0;

	for (GCL::StaticNode* cp = m_last_child; cp; GCL::StaticNode::shift_prev(cp)) {
		const GCL::StaticNodeStubBase* snsb = dynamic_cast<const GCL::StaticNodeStubBase*>(cp);
		if (snsb) {
			long stub_count = snsb->stub_count();
			ret += abs(stub_count);
			if (stub_count != 1 && snsb->has_pair()) {
				ret++;
				GCL::StaticNode::shift_prev(cp);
			}
		} else {
			ret++;
			const FlagNodeBase* nb = dynamic_cast<const FlagNodeBase*>(cp);
			GDS_ASSERT (nb);
			if (nb->has_flag(FM_OPEN)) {
				ret += nb->all_visible_children_count ();
			}
		}
	}

	return ret;
	//#UC END# *45F907DE033C*
}

FlagMask FlagNodeBase::get_flags () const {
	//#UC START# *45F8124B0138*
	return m_flags;
	//#UC END# *45F8124B0138*
}

GCL::StaticNode* FlagNodeBase::get_my_parent () const {
	//#UC START# *45F8049F0128*
	return m_parent;
	//#UC END# *45F8049F0128*
}

FlagNodeBase* FlagNodeBase::get_node_by_visible_index (VisibleIndex index) {
	//#UC START# *45F8151D02CE*
	//LOG_D (("%s (ind=%d)", GDS_CURRENT_FUNCTION, ind));
	FlagNodeBase* ret = this;
	GCL::StaticNode_var for_constructed;

	if (index > 0) {
		while (index && ret) {
			ret = ret->next_visible (index, for_constructed, false);	
			GDS_ASSERT (index >= 0);
		}
	} else {
		while (index && ret) {
			ret = ret->prev_visible (index, for_constructed, false);
			GDS_ASSERT (index <= 0);
		}
	}
	
	return ret;
	//#UC END# *45F8151D02CE*
}

bool FlagNodeBase::has_flag (FlagMask flag) const {
	//#UC START# *45F9305601F4*
	return (m_flags & flag) == flag;
	//#UC END# *45F9305601F4*
}

bool FlagNodeBase::is_visible () const {
	//#UC START# *45F8145B0203*
	const GCL::StaticNode* node = this;
	const FlagNodeBase* fnb = dynamic_cast<const FlagNodeBase*>(node);
	while (fnb) {
		if (!fnb->has_flag (FM_OPEN)) {
			return false;
		}
		fnb = dynamic_cast<const FlagNodeBase*>(GCL::StaticNode::shift_up(node));
	}
	return true;
	//#UC END# *45F8145B0203*
}

void FlagNodeBase::make_visible () {
	//#UC START# *45F812D20290*
	GCL::StaticNode* node = this;
	FlagNodeBase* fnb;
	while (fnb = dynamic_cast<FlagNodeBase*>(GCL::StaticNode::shift_up(node))) {
		if (!fnb->has_flag (FM_OPEN) && !fnb->set_flag (FM_OPEN, true, false)) {
			return;
		}
	}
	//#UC END# *45F812D20290*
}

FlagNodeBase* FlagNodeBase::next_one_level (long& shift_counter, GCL::StaticNode_var& for_constructed) const {
	//#UC START# *45F90792004E*
	shift_counter--;
	return dynamic_cast<FlagNodeBase*>(const_cast<GCL::StaticNode*>(m_next.ptr()));
	//#UC END# *45F90792004E*
}

FlagNodeBase* FlagNodeBase::next_visible (
	long& shift_counter
	, GCL::StaticNode_var& for_constructed
	, bool skip_stub
) const {
	//#UC START# *45F81F0B02BF*
	if (this->has_flag (FM_OPEN) && m_last_child) {
		shift_counter--;
		return const_cast<FlagNodeBase*>(dynamic_cast<const FlagNodeBase*>(m_first_child.ptr()));
	} 
	return this->plane_next_back(shift_counter, for_constructed, skip_stub);
	//#UC END# *45F81F0B02BF*
}

FlagNodeBase* FlagNodeBase::next_with_flag (FlagMask flag, bool skip_stub) const {
	//#UC START# *45F815330251*
	long shift_counter = 1;
	GCL::StaticNode_var for_constructed;
	FlagNodeBase* ret = plane_next (shift_counter, for_constructed, skip_stub);

	while (ret && !ret->has_flag(flag)) {
		GCL::StaticNodeStubBase* snsb = dynamic_cast<GCL::StaticNodeStubBase*> (ret);
		if (snsb) {
			shift_counter = snsb->stub_count();
			if (shift_counter > 0) {
				shift_counter -= snsb->stub_ind();
			} else {
				shift_counter = 1;
			}
		}
		ret = ret->plane_next (shift_counter, for_constructed, skip_stub);
	}

	return Core::IObject::_duplicate (ret);
	//#UC END# *45F815330251*
}

FlagNodeBase* FlagNodeBase::plane_next (
	long& shift_counter
	, GCL::StaticNode_var& for_constructed
	, bool skip_stub
) const {
	//#UC START# *45F81F6B01C5*
	if (m_last_child) {
		FlagNodeBase* ppp = const_cast<FlagNodeBase*>(dynamic_cast<const FlagNodeBase*>(m_first_child.ptr()));
		if (ppp) {
			GCL::StaticNode_var prev = ppp->prev ();
			GCL::StaticNode_var next = ppp->next ();
			GCL::StaticNode_var parent = ppp->parent ();
			GDS_ASSERT (prev.ptr () || next.ptr () || parent.ptr ());
		}
		return ppp;
	} 
	
	FlagNodeBase* ppp = this->plane_next_back(shift_counter, for_constructed, skip_stub);
	if (ppp) {
		GCL::StaticNode_var prev = ppp->prev ();
		GCL::StaticNode_var next = ppp->next ();
		GCL::StaticNode_var parent = ppp->parent ();
		GDS_ASSERT (prev.ptr () || next.ptr () || parent.ptr ());
	}
	return ppp;
	//#UC END# *45F81F6B01C5*
}

FlagNodeBase* FlagNodeBase::plane_next_back (
	long& shift_counter
	, GCL::StaticNode_var& for_constructed
	, bool skip_stub
) const {
	//#UC START# *45F9071F035B*
	if (m_next.ptr()) {
		shift_counter--; // if we go from StaticNodeStub shift_counter may be 0 !!! 
		return const_cast<FlagNodeBase*>(dynamic_cast<const FlagNodeBase*>(m_next.ptr()));
	} else {
		if (m_parent) {
			FlagNodeBase* node_base = const_cast<FlagNodeBase*>(dynamic_cast<const FlagNodeBase*>(m_parent));
			return node_base->plane_next_back(shift_counter, for_constructed, skip_stub);
		} else {
			shift_counter--;
			return 0;
		}
	}
	//#UC END# *45F9071F035B*
}

FlagNodeBase* FlagNodeBase::prev_one_level (long& shift_counter, GCL::StaticNode_var& for_constructed) const {
	//#UC START# *45F907B000EA*
	shift_counter++;
	return dynamic_cast<FlagNodeBase*>(m_prev);
	//#UC END# *45F907B000EA*
}

FlagNodeBase* FlagNodeBase::prev_visible (
	long& shift_counter
	, GCL::StaticNode_var& for_constructed
	, bool skip_stub
) const {
	//#UC START# *45F9074B034B*
	//LOG_D (("%s (shift_counter=%d)", GDS_CURRENT_FUNCTION, shift_counter));
	if (m_prev) {
		FlagNodeBase* node_base = dynamic_cast<FlagNodeBase*>(m_prev);
		return node_base ? node_base->prev_visible_stop(shift_counter, for_constructed, skip_stub) : 0;
	} else {
		shift_counter++;	
		return m_parent ? const_cast<FlagNodeBase*>(dynamic_cast<const FlagNodeBase*>(m_parent)) : 0;
	}		
	//#UC END# *45F9074B034B*
}

FlagNodeBase* FlagNodeBase::prev_visible_stop (
	long& shift_counter
	, GCL::StaticNode_var& for_constructed
	, bool skip_stub
) {
	//#UC START# *45F9077A003E*
	if (this->has_flag(FM_OPEN) && m_last_child) {
		FlagNodeBase* node_base = dynamic_cast<FlagNodeBase*>(m_last_child);
		return node_base->prev_visible_stop(shift_counter, for_constructed, skip_stub);
	} else {
		shift_counter++;
		return this;
	}
	//#UC END# *45F9077A003E*
}

bool FlagNodeBase::set_flag (FlagMask flag, bool value, bool with_notify) {
	//#UC START# *45F8123602DE*
	//SLOG_SHIFT
	//SLOG_D (("%s[0x%X,?] (%d,%d)", GDS_CURRENT_FUNCTION, (StaticNode*)this, flag, value));

	if (value) {
		if (!has_flag (flag)) {
			m_flags |= flag;
			return true;
		}
	} else {
		if (has_flag (flag)) {
			m_flags &= ~flag;
			return true;
		}
	}
	return false;
	//#UC END# *45F8123602DE*
}

void FlagNodeBase::set_my_parent (GCL::StaticNode* parent) {
	//#UC START# *45F8046500FA*
	// uncomment it after revove HACK (Everest Redactor)
	//GDS_ASSERT (!m_parent); // only for newly created node
	m_parent = parent;
	//#UC END# *45F8046500FA*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

void FlagNodeBase::set_flags (FlagMask flags) {
	//#UC START# *45F80BA20280_SET_ACCESSOR*
	m_flags = flags;
	//#UC END# *45F80BA20280_SET_ACCESSOR*
}


} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

