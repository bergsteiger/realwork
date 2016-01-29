////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/Class.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Class
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Class.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const Class& item) {
	out_stream << "class" << std::endl;
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
const std::string& Class::get_name () const {
	//#UC START# *48AC09440360_GET_ACCESSOR*
	return m_name;
	//#UC END# *48AC09440360_GET_ACCESSOR*
}

void Class::set_name (const std::string& name) {
	//#UC START# *48AC09440360_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48AC09440360_SET_ACCESSOR*
}

const std::string& Class::get_guid () const {
	//#UC START# *48AC094C026B_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48AC094C026B_GET_ACCESSOR*
}

void Class::set_guid (const std::string& guid) {
	//#UC START# *48AC094C026B_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48AC094C026B_SET_ACCESSOR*
}

const Core::Box<ClassContent>& Class::content () const {
	//#UC START# *48AC096503A1_GET_ACCESSOR*
	return m_content;
	//#UC END# *48AC096503A1_GET_ACCESSOR*
}

void Class::content (const Core::Box<ClassContent>& content) {
	//#UC START# *48AC096503A1_SET_ACCESSOR*
	m_content = content;
	//#UC END# *48AC096503A1_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

