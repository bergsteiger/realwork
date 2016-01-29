////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/StateDiagram.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::StateDiagram
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateDiagram.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const StateDiagram& item) {
	out_stream << "state_diagram" << std::endl;
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
const std::string& StateDiagram::get_name () const {
	//#UC START# *48ABFFBC00F9_GET_ACCESSOR*
	return m_name;
	//#UC END# *48ABFFBC00F9_GET_ACCESSOR*
}

void StateDiagram::set_name (const std::string& name) {
	//#UC START# *48ABFFBC00F9_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48ABFFBC00F9_SET_ACCESSOR*
}

const std::string& StateDiagram::get_guid () const {
	//#UC START# *48ABFFCB00C0_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48ABFFCB00C0_GET_ACCESSOR*
}

void StateDiagram::set_guid (const std::string& guid) {
	//#UC START# *48ABFFCB00C0_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48ABFFCB00C0_SET_ACCESSOR*
}

const Core::Box<StateDiagramContent>& StateDiagram::content () const {
	//#UC START# *48ABFFE5015A_GET_ACCESSOR*
	return m_content;
	//#UC END# *48ABFFE5015A_GET_ACCESSOR*
}

void StateDiagram::content (const Core::Box<StateDiagramContent>& content) {
	//#UC START# *48ABFFE5015A_SET_ACCESSOR*
	m_content = content;
	//#UC END# *48ABFFE5015A_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

