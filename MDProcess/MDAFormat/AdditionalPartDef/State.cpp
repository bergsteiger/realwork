////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/State.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::State
//
// состояние
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/State.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const State& item) {
	out_stream << "state" << std::endl;
	out_stream << item.get_name () << std::endl;
	out_stream << "=> " << "\"" << item.get_guid () << "\"" << std::endl;
	if (item.get_content ().is_nil () == false) {
		out_stream << "{ " << *item.get_content () << " }" << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& State::get_name () const {
	//#UC START# *48ACE86103D3_GET_ACCESSOR*
	return m_name;
	//#UC END# *48ACE86103D3_GET_ACCESSOR*
}

void State::set_name (const std::string& name) {
	//#UC START# *48ACE86103D3_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48ACE86103D3_SET_ACCESSOR*
}

const std::string& State::get_guid () const {
	//#UC START# *48ACE86D020C_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48ACE86D020C_GET_ACCESSOR*
}

void State::set_guid (const std::string& guid) {
	//#UC START# *48ACE86D020C_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48ACE86D020C_SET_ACCESSOR*
}

const Core::Box<StateContent>& State::content () const {
	//#UC START# *48BBCDE50295_GET_ACCESSOR*
	return m_content;
	//#UC END# *48BBCDE50295_GET_ACCESSOR*
}

void State::content (const Core::Box<StateContent>& content) {
	//#UC START# *48BBCDE50295_SET_ACCESSOR*
	m_content = content;
	//#UC END# *48BBCDE50295_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

