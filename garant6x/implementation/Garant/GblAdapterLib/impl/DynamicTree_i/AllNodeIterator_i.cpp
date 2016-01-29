////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/AllNodeIterator_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::AllNodeIterator_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/AllNodeIterator_i.h"

//#UC START# *473D8B540129_CUSTOM_INCLUDES*
//#UC END# *473D8B540129_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *473D8B540129*
//#UC END# *473D8B540129*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AllNodeIterator_i::AllNodeIterator_i (DefaultNodeBase* from_node, FlagMask with_flag)
//#UC START# *473D8EEC010F_BASE_INIT*
	: m_cur_node (Core::IObject::_duplicate(from_node))
	, m_with_flags (with_flag)
//#UC END# *473D8EEC010F_BASE_INIT*
{
	//#UC START# *473D8EEC010F_BODY*
	//#UC END# *473D8EEC010F_BODY*
}

AllNodeIterator_i::~AllNodeIterator_i () {
	//#UC START# *473D8B540129_DESTR_BODY*
	//#UC END# *473D8B540129_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from NodeIterator
const NodeBase* AllNodeIterator_i::get_next () const {
	//#UC START# *45FFB3E000FA_473D8B540129_GET*
	if (!m_cur_node.is_nil ()) {
		m_cur_node = m_cur_node->next_with_flag (m_with_flags);
	}

	if (dynamic_cast<FlagNodeStub*> (m_cur_node.ptr ())) {
		m_cur_node = FlagNodeBase::_duplicate (
			dynamic_cast<FlagNodeBase*> (
				dynamic_cast<FlagNodeStub*> (m_cur_node.ptr ())->transform_to_real_node ()
			)
		);
	}

	return dynamic_cast<NodeBase*> (m_cur_node._sretn ());
	//#UC END# *45FFB3E000FA_473D8B540129_GET*
}

NodeBase* AllNodeIterator_i::get_next () {
	return const_cast<NodeBase*>(((const AllNodeIterator_i*)this)->get_next ());
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

