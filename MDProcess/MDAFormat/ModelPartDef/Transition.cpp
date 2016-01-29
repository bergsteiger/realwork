////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/Transition.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::Transition
//
// переход
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/Transition.h"


namespace MDAFormat {
namespace ModelPartDef {

// init ctor
Transition::Transition ()
	: m_stereotype("")
m_stereotype("")
, m_stereotype("")
, m_stereotype("")
, m_stereotype("")
{
	//#UC START# *48ABA0D70183_DEF_INIT_CTOR*
	//#UC END# *48ABA0D70183_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const Transition& item) {
	if (item.get_stereotype () != "") {
		out_stream << "<<" << item.get_stereotype () << ">>" << std::endl;
	}
	out_stream << "transition to" << std::endl;
	out_stream << item.get_target_name () << " {" << std::endl;
	if (item.get_condition () != "") {
		out_stream << "condition " << "\"" << item.get_condition () << "\"" << " ;" << std::endl;
	}
	if (item.get_guard () != "") {
		out_stream << "guard " << "\"" << item.get_guard () << "\"" << " ;" << std::endl;
	}
	if (item.get_action () != "") {
		out_stream << "action " << "\"" << item.get_action () << "\"" << " ;" << std::endl;
	}
	if (item.get_event () != "") {
		out_stream << "event " << "\"" << item.get_event () << "\"" << " ;" << std::endl;
	}
	out_stream << "} ;" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& Transition::get_stereotype () const {
	//#UC START# *48ABA100035B_GET_ACCESSOR*
	return m_stereotype;
	//#UC END# *48ABA100035B_GET_ACCESSOR*
}

void Transition::set_stereotype (const std::string& stereotype) {
	//#UC START# *48ABA100035B_SET_ACCESSOR*
	m_stereotype = stereotype;
	//#UC END# *48ABA100035B_SET_ACCESSOR*
}

const std::string& Transition::get_target_name () const {
	//#UC START# *48ABA12A02D1_GET_ACCESSOR*
	return m_target_name;
	//#UC END# *48ABA12A02D1_GET_ACCESSOR*
}

void Transition::set_target_name (const std::string& target_name) {
	//#UC START# *48ABA12A02D1_SET_ACCESSOR*
	m_target_name = target_name;
	//#UC END# *48ABA12A02D1_SET_ACCESSOR*
}

const std::string& Transition::get_condition () const {
	//#UC START# *48ABA149022E_GET_ACCESSOR*
	return m_condition;
	//#UC END# *48ABA149022E_GET_ACCESSOR*
}

void Transition::set_condition (const std::string& condition) {
	//#UC START# *48ABA149022E_SET_ACCESSOR*
	m_condition = condition;
	//#UC END# *48ABA149022E_SET_ACCESSOR*
}

const std::string& Transition::get_guard () const {
	//#UC START# *48ABA165038E_GET_ACCESSOR*
	return m_guard;
	//#UC END# *48ABA165038E_GET_ACCESSOR*
}

void Transition::set_guard (const std::string& guard) {
	//#UC START# *48ABA165038E_SET_ACCESSOR*
	m_guard = guard;
	//#UC END# *48ABA165038E_SET_ACCESSOR*
}

const std::string& Transition::get_action () const {
	//#UC START# *48ABA1810009_GET_ACCESSOR*
	return m_action;
	//#UC END# *48ABA1810009_GET_ACCESSOR*
}

void Transition::set_action (const std::string& action) {
	//#UC START# *48ABA1810009_SET_ACCESSOR*
	m_action = action;
	//#UC END# *48ABA1810009_SET_ACCESSOR*
}

const std::string& Transition::get_event () const {
	//#UC START# *48ABA19D01ED_GET_ACCESSOR*
	return m_event;
	//#UC END# *48ABA19D01ED_GET_ACCESSOR*
}

void Transition::set_event (const std::string& event) {
	//#UC START# *48ABA19D01ED_SET_ACCESSOR*
	m_event = event;
	//#UC END# *48ABA19D01ED_SET_ACCESSOR*
}



} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

