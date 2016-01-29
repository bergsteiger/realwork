////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/Parameter.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Parameter
//
// описание параметра (операции или шаблонного параметра)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Parameter.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const Parameter& item) {
	out_stream << "parameter" << std::endl;
	out_stream << item.get_name () << std::endl;
	out_stream << "=> " << "\"" << item.get_guid () << "\"" << std::endl;
	if (item.get_content ().is_nil () == false) {
		out_stream << *item.get_content () << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& Parameter::get_name () const {
	//#UC START# *48ABF73D01A1_GET_ACCESSOR*
	return m_name;
	//#UC END# *48ABF73D01A1_GET_ACCESSOR*
}

void Parameter::set_name (const std::string& name) {
	//#UC START# *48ABF73D01A1_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48ABF73D01A1_SET_ACCESSOR*
}

const std::string& Parameter::get_guid () const {
	//#UC START# *48ABF76C0188_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48ABF76C0188_GET_ACCESSOR*
}

void Parameter::set_guid (const std::string& guid) {
	//#UC START# *48ABF76C0188_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48ABF76C0188_SET_ACCESSOR*
}

const Core::Box<ParameterContent>& Parameter::content () const {
	//#UC START# *48ABF7830178_GET_ACCESSOR*
	return m_content;
	//#UC END# *48ABF7830178_GET_ACCESSOR*
}

void Parameter::content (const Core::Box<ParameterContent>& content) {
	//#UC START# *48ABF7830178_SET_ACCESSOR*
	m_content = content;
	//#UC END# *48ABF7830178_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

