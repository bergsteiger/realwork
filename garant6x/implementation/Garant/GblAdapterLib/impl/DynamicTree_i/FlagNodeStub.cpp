////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FlagNodeStub.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::FlagNodeStub
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FlagNodeStub.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"

//#UC START# *45F6CDFF01C5_CUSTOM_INCLUDES*
//#UC END# *45F6CDFF01C5_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45F6CDFF01C5*
void FlagNodeStub::init (const SharedData_box& data, long ind, const StaticNode* master) {
	GCL::StaticNodeStub<FlagNodeStub>::init(data, ind, master);
	if (master) {
		const FlagNodeBase* vb = dynamic_cast<const FlagNodeBase*> (master);
		GDS_ASSERT (vb);
//#pragma GDS_MESSAGE ("this need to set_all and set_range flags, but makes error in shared view mode")
		this->set_flags (vb->get_flags ());
	} else {
		this->set_flags (0);
	}

	//LOG_D (("create Stub with flags = %d", m_flags));
}

#pragma GDS_MESSAGE ("TODO: refactoring of next-prev functions")
//#UC END# *45F6CDFF01C5*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FlagNodeStub::FlagNodeStub ()
//#UC START# *45FEA1AE0232_BASE_INIT*
//#UC END# *45FEA1AE0232_BASE_INIT*
{
	//#UC START# *45FEA1AE0232_BODY*
	//LOG_D (("%s[%d]", GDS_CURRENT_FUNCTION, (StaticNode*)this));
	//ADD_OBJECT_WATCHER
	//#UC END# *45FEA1AE0232_BODY*
}

FlagNodeStub::~FlagNodeStub () {
	//#UC START# *45F6CDFF01C5_DESTR_BODY*
	//Core::GDS::StopWatchEx sw ("~FlagNodeStub", "FlagNodeStub (%d)::~FlagNodeStub", m_ind);
	//LOG_D (("%s[%d]", GDS_CURRENT_FUNCTION, this));
	//REMOVE_OBJECT_WATCHER
	//#UC END# *45F6CDFF01C5_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

GCL::StaticNode* FlagNodeStub::remove_me_and_siblings (unsigned long& count) {
	//#UC START# *45FEA0EB005D*
	m_data->mng->pre_remove (this, count);
	return GCL::StaticNodeStub<FlagNodeStub>::remove_me_and_siblings (count);
	//#UC END# *45FEA0EB005D*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from FlagNodeBase
// возвращает количество взведённых (изменённых?) флагов.
size_t FlagNodeStub::internal_set_all_flag (FlagMask flag, bool value, bool children_only) {
	//#UC START# *45F810730290_45F6CDFF01C5*
	return children_only ? 0 : (this->set_flag (flag, value, false) ? 1 : 0);
	//#UC END# *45F810730290_45F6CDFF01C5*
}

// implemented method from FlagNodeBase
size_t FlagNodeStub::internal_set_all_flag_except_first_children_of_root_children (
	FlagMask flag
	, bool value
	, bool children_only
) {
	//#UC START# *51EFC7130001_45F6CDFF01C5*
	if (this->is_first_child_of_child_of_root ()) {
		return 0;
	}

	return children_only ? 0 : (this->set_flag (flag, value, false) ? 1 : 0);
	//#UC END# *51EFC7130001_45F6CDFF01C5*
}

// implemented method from FlagNodeBase
void FlagNodeStub::set_all_flag (FlagMask flag, bool value, bool with_notify) {
	//#UC START# *45F80922032C_45F6CDFF01C5*
	GDS_ASSERT (false);
	//#UC END# *45F80922032C_45F6CDFF01C5*
}

// implemented method from FlagNodeBase
void FlagNodeStub::set_all_flag_except_first_children_of_root_children (FlagMask flag, bool value, bool with_notify) {
	//#UC START# *51EFC6D0015B_45F6CDFF01C5*
	GDS_ASSERT (false);
	//#UC END# *51EFC6D0015B_45F6CDFF01C5*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from FlagNodeBase
FlagNodeBase* FlagNodeStub::next_one_level (long& shift_counter, GCL::StaticNode_var& for_constructed) const {
	//#UC START# *45F90792004E_45F6CDFF01C5*
	if (m_data->stub_count > 0) {
		if (shift_counter >= m_data->stub_count - m_ind) {
			shift_counter -= (m_data->stub_count - m_ind);

			GDS_ASSERT (shift_counter >= 0);

			return const_cast<FlagNodeBase*>(dynamic_cast<const FlagNodeBase*>(m_next.ptr()));
		} else {
			long ind = shift_counter;
			shift_counter = 0;
			
			for_constructed = this->get_at (ind);
			return dynamic_cast<FlagNodeBase*>(for_constructed.ptr());
		}
	} else {
		if (shift_counter >= -(m_ind)) {
			shift_counter += m_ind;			
			shift_counter--;

			return const_cast<FlagNodeBase*>(dynamic_cast<const FlagNodeBase*>(m_next.ptr()));
		} else {
			long ind = shift_counter;
			shift_counter = 0;
			
			for_constructed = this->get_at (ind);
			return dynamic_cast<FlagNodeBase*>(for_constructed.ptr());
		}
	}
	//#UC END# *45F90792004E_45F6CDFF01C5*
}

// overloaded method from FlagNodeBase
FlagNodeBase* FlagNodeStub::next_visible (
	long& shift_counter
	, GCL::StaticNode_var& for_constructed
	, bool skip_stub
) const {
	//#UC START# *45F81F0B02BF_45F6CDFF01C5*
	if (skip_stub) {
		return FlagNodeBase::next_visible (shift_counter, for_constructed, true);
	} else {
		return this->plane_next_back(shift_counter, for_constructed, false);
	}
	//#UC END# *45F81F0B02BF_45F6CDFF01C5*
}

// overloaded method from FlagNodeBase
FlagNodeBase* FlagNodeStub::plane_next (
	long& shift_counter
	, GCL::StaticNode_var& for_constructed
	, bool skip_stub
) const {
	//#UC START# *45F81F6B01C5_45F6CDFF01C5*
	if (skip_stub) {
		return FlagNodeBase::plane_next (shift_counter, for_constructed, true);
	} else {
		return this->plane_next_back(shift_counter, for_constructed, false);
	}
	//#UC END# *45F81F6B01C5_45F6CDFF01C5*
}

// overloaded method from FlagNodeBase
FlagNodeBase* FlagNodeStub::plane_next_back (
	long& shift_counter
	, GCL::StaticNode_var& for_constructed
	, bool skip_stub
) const {
	//#UC START# *45F9071F035B_45F6CDFF01C5*
	if (skip_stub) {
		return FlagNodeBase::plane_next_back (shift_counter, for_constructed, true);
	} else {
		if (m_data->stub_count > 0) {
			if (shift_counter >= m_data->stub_count - m_ind) {
				shift_counter -= (m_data->stub_count - m_ind - 1);

				GDS_ASSERT (shift_counter > 0);
				
				if (m_next.ptr()) {
					shift_counter--;
					return const_cast<FlagNodeBase*>(dynamic_cast<const FlagNodeBase*>(m_next.ptr()));
				} 
				
				if (m_parent) {				
					FlagNodeBase* node_base = dynamic_cast<FlagNodeBase*>(m_parent);
					return node_base->plane_next_back(shift_counter, for_constructed, false);
				} else {
					shift_counter--;
					return 0;
				}
			} else {
				long ind = shift_counter;
				shift_counter = 0;
				
				for_constructed = this->get_at (ind);
				return dynamic_cast<FlagNodeBase*>(for_constructed.ptr());
			}
		} else {
			if (shift_counter >= -(m_ind)) {
				shift_counter += m_ind;
				
				if (m_next.ptr()) {
					shift_counter--;
					return const_cast<FlagNodeBase*>(dynamic_cast<const FlagNodeBase*>(m_next.ptr()));
				} 
				
				if (m_parent) {
					FlagNodeBase* node_base = dynamic_cast<FlagNodeBase*>(m_parent);
					return node_base->plane_next_back(shift_counter, for_constructed, false);
				} else {
					shift_counter--;
					return 0;
				}
			} else {
				long ind = shift_counter;
				shift_counter = 0;
				
				for_constructed = this->get_at (ind);
				return dynamic_cast<FlagNodeBase*>(for_constructed.ptr());
			}
		}
	}
	//#UC END# *45F9071F035B_45F6CDFF01C5*
}

// overloaded method from FlagNodeBase
FlagNodeBase* FlagNodeStub::prev_one_level (long& shift_counter, GCL::StaticNode_var& for_constructed) const {
	//#UC START# *45F907B000EA_45F6CDFF01C5*
	if (m_data->stub_count < 0) {
		if (shift_counter <= m_data->stub_count + m_ind) {
			shift_counter -= (m_data->stub_count + m_ind);

			GDS_ASSERT (shift_counter <= 0);

			return const_cast<FlagNodeBase*>(dynamic_cast<FlagNodeBase*>(m_prev));
		} else {
			long ind = shift_counter;
			shift_counter = 0;
			
			for_constructed = this->get_at (ind);
			return dynamic_cast<FlagNodeBase*>(for_constructed.ptr());
		}
	} else {
		if (shift_counter <= -(m_ind)) {
			shift_counter += m_ind;			
			shift_counter++;

			return const_cast<FlagNodeBase*>(dynamic_cast<FlagNodeBase* const>(m_prev));
		} else {
			long ind = shift_counter;
			shift_counter = 0;
			
			for_constructed = this->get_at (ind);
			return dynamic_cast<FlagNodeBase*>(for_constructed.ptr());
		}
	}
	//#UC END# *45F907B000EA_45F6CDFF01C5*
}

// overloaded method from FlagNodeBase
FlagNodeBase* FlagNodeStub::prev_visible (
	long& shift_counter
	, GCL::StaticNode_var& for_constructed
	, bool skip_stub
) const {
	//#UC START# *45F9074B034B_45F6CDFF01C5*
	//LOG_D (("%s (shift_counter=%d)", GDS_CURRENT_FUNCTION, shift_counter));
	if (skip_stub) {
		return FlagNodeBase::prev_visible (shift_counter, for_constructed, true);
	} else {		
		if (m_data->stub_count == -1 || m_data->stub_count > 0 && m_ind == 0) {
			return FlagNodeBase::prev_visible (shift_counter, for_constructed, false);
		} 
		
		if (m_data->stub_count > 0 || m_ind != 0) {
			GDS_ASSERT (false);
		}			

		if (shift_counter <= m_data->stub_count) {
			shift_counter -= (m_data->stub_count+1);
			return FlagNodeBase::prev_visible (shift_counter, for_constructed, false);
		} else {
			long ind = shift_counter;
			shift_counter = 0;
			
			for_constructed = this->get_at (ind);
			return dynamic_cast<FlagNodeBase*>(for_constructed.ptr());
		}
	}
	//#UC END# *45F9074B034B_45F6CDFF01C5*
}

// overloaded method from FlagNodeBase
FlagNodeBase* FlagNodeStub::prev_visible_stop (
	long& shift_counter
	, GCL::StaticNode_var& for_constructed
	, bool skip_stub
) {
	//#UC START# *45F9077A003E_45F6CDFF01C5*
	if (skip_stub) {
		return FlagNodeBase::prev_visible_stop (shift_counter, for_constructed, true);
	} else {		
		shift_counter++;
		return this;
	}
	//#UC END# *45F9077A003E_45F6CDFF01C5*
}

// overloaded method from FlagNodeBase
bool FlagNodeStub::set_flag (FlagMask flag, bool value, bool with_notify) {
	//#UC START# *45F8123602DE_45F6CDFF01C5*
	if (FlagNodeBase::set_flag (flag, value, with_notify)) {
		TreeBase* tree = dynamic_cast<TreeBase*> (m_data->mng);
		GDS_ASSERT (tree);
		//LOG_D (("%s[%d] ->call update_counters", GDS_CURRENT_FUNCTION, (StaticNode*)this));
		tree->update_counters (this, flag, value);
		return true;
	}
	return false;
	//#UC END# *45F8123602DE_45F6CDFF01C5*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

