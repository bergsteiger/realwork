////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/Operation.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Operation
//
// описание операции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Operation.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const Operation& item) {
	out_stream << "operation" << std::endl;
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
const std::string& Operation::get_name () const {
	//#UC START# *48ABF7EB01A7_GET_ACCESSOR*
	return m_name;
	//#UC END# *48ABF7EB01A7_GET_ACCESSOR*
}

void Operation::set_name (const std::string& name) {
	//#UC START# *48ABF7EB01A7_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48ABF7EB01A7_SET_ACCESSOR*
}

const std::string& Operation::get_guid () const {
	//#UC START# *48ABF80D0350_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48ABF80D0350_GET_ACCESSOR*
}

void Operation::set_guid (const std::string& guid) {
	//#UC START# *48ABF80D0350_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48ABF80D0350_SET_ACCESSOR*
}

const Core::Box<OperationContent>& Operation::content () const {
	//#UC START# *48ABF8760355_GET_ACCESSOR*
	return m_content;
	//#UC END# *48ABF8760355_GET_ACCESSOR*
}

void Operation::content (const Core::Box<OperationContent>& content) {
	//#UC START# *48ABF8760355_SET_ACCESSOR*
	m_content = content;
	//#UC END# *48ABF8760355_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

