////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/Transition.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Transition
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Transition.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const Transition& item) {
	out_stream << "transition to" << std::endl;
	out_stream << item.get_target_state_name () << std::endl;
	out_stream << "=> " << "\"" << item.get_guid () << "\"" << std::endl;
	if (item.get_content ().is_nil () == false) {
		out_stream << *item.get_content () << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& Transition::get_target_state_name () const {
	//#UC START# *48ACE9A400D3_GET_ACCESSOR*
	return m_target_state_name;
	//#UC END# *48ACE9A400D3_GET_ACCESSOR*
}

void Transition::set_target_state_name (const std::string& target_state_name) {
	//#UC START# *48ACE9A400D3_SET_ACCESSOR*
	m_target_state_name = target_state_name;
	//#UC END# *48ACE9A400D3_SET_ACCESSOR*
}

const std::string& Transition::get_guid () const {
	//#UC START# *48ACE9B401E3_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48ACE9B401E3_GET_ACCESSOR*
}

void Transition::set_guid (const std::string& guid) {
	//#UC START# *48ACE9B401E3_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48ACE9B401E3_SET_ACCESSOR*
}

const Core::Box<TransitionContent>& Transition::content () const {
	//#UC START# *48ACE9ED0077_GET_ACCESSOR*
	return m_content;
	//#UC END# *48ACE9ED0077_GET_ACCESSOR*
}

void Transition::content (const Core::Box<TransitionContent>& content) {
	//#UC START# *48ACE9ED0077_SET_ACCESSOR*
	m_content = content;
	//#UC END# *48ACE9ED0077_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

