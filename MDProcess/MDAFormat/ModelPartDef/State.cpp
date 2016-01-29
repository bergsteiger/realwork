////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/State.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::State
//
// элемент-состояние
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/State.h"


namespace MDAFormat {
namespace ModelPartDef {

// init ctor
State::State () : m_type(ST_NORMAL) {
	//#UC START# *48AB9F1F001C_DEF_INIT_CTOR*
	//#UC END# *48AB9F1F001C_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const State& item) {
	switch (item.get_type ()) {
		case ST_NORMAL: out_stream << "normal" << std::endl;
			break;
		case ST_FINAL: out_stream << "final" << std::endl;
			break;
		case ST_START: out_stream << "start" << std::endl;
			break;
		default: GDS_ASSERT_MSG(0,("Wrong enum value for type attr"));
	}
	out_stream << "state" << std::endl;
	out_stream << item.get_name () << " {" << std::endl;
	if (item.actions ().empty () == false) {
		StateActionList::const_iterator it = item.get_actions ().begin ();
		StateActionList::const_iterator it_end = item.get_actions ().end ();
		
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
	out_stream << "} ;" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const StateType& State::get_type () const {
	//#UC START# *48AB9F9701CF_GET_ACCESSOR*
	return m_type;
	//#UC END# *48AB9F9701CF_GET_ACCESSOR*
}

void State::set_type (const StateType& type) {
	//#UC START# *48AB9F9701CF_SET_ACCESSOR*
	m_type = type;
	//#UC END# *48AB9F9701CF_SET_ACCESSOR*
}

const std::string& State::get_name () const {
	//#UC START# *48AB9FD9021A_GET_ACCESSOR*
	return m_name;
	//#UC END# *48AB9FD9021A_GET_ACCESSOR*
}

void State::set_name (const std::string& name) {
	//#UC START# *48AB9FD9021A_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48AB9FD9021A_SET_ACCESSOR*
}

const StateActionList& State::get_actions () const {
	//#UC START# *48ABA1DB01F4_GET_ACCESSOR*
	return m_actions;
	//#UC END# *48ABA1DB01F4_GET_ACCESSOR*
}

void State::set_actions (const StateActionList& actions) {
	//#UC START# *48ABA1DB01F4_SET_ACCESSOR*
	m_actions = actions;
	//#UC END# *48ABA1DB01F4_SET_ACCESSOR*
}

const TransitionList& State::get_transitions () const {
	//#UC START# *48ABA1F5036E_GET_ACCESSOR*
	return m_transitions;
	//#UC END# *48ABA1F5036E_GET_ACCESSOR*
}

void State::set_transitions (const TransitionList& transitions) {
	//#UC START# *48ABA1F5036E_SET_ACCESSOR*
	m_transitions = transitions;
	//#UC END# *48ABA1F5036E_SET_ACCESSOR*
}



} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

