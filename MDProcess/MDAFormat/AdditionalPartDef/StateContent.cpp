////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/StateContent.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::StateContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateContent.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const StateContent& item) {
	if (item.properties ().empty () == false) {
		PropertyList::const_iterator it = item.get_properties ().begin ();
		PropertyList::const_iterator it_end = item.get_properties ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.transitions ().empty () == false) {
		TransitionList::const_iterator it = item.get_transitions ().begin ();
		TransitionList::const_iterator it_end = item.get_transitions ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.actions ().empty () == false) {
		StateActionList::const_iterator it = item.get_actions ().begin ();
		StateActionList::const_iterator it_end = item.get_actions ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}

	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const PropertyList& StateContent::get_properties () const {
	//#UC START# *48BBCE030089_GET_ACCESSOR*
	return m_properties;
	//#UC END# *48BBCE030089_GET_ACCESSOR*
}

void StateContent::set_properties (const PropertyList& properties) {
	//#UC START# *48BBCE030089_SET_ACCESSOR*
	m_properties = properties;
	//#UC END# *48BBCE030089_SET_ACCESSOR*
}

const TransitionList& StateContent::get_transitions () const {
	//#UC START# *48BBCE0A022F_GET_ACCESSOR*
	return m_transitions;
	//#UC END# *48BBCE0A022F_GET_ACCESSOR*
}

void StateContent::set_transitions (const TransitionList& transitions) {
	//#UC START# *48BBCE0A022F_SET_ACCESSOR*
	m_transitions = transitions;
	//#UC END# *48BBCE0A022F_SET_ACCESSOR*
}

const StateActionList& StateContent::get_actions () const {
	//#UC START# *48BBCE2903BF_GET_ACCESSOR*
	return m_actions;
	//#UC END# *48BBCE2903BF_GET_ACCESSOR*
}

void StateContent::set_actions (const StateActionList& actions) {
	//#UC START# *48BBCE2903BF_SET_ACCESSOR*
	m_actions = actions;
	//#UC END# *48BBCE2903BF_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

