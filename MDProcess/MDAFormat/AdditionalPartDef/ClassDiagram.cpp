////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/ClassDiagram.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::ClassDiagram
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ClassDiagram.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const ClassDiagram& item) {
	out_stream << "class_diagram" << std::endl;
	out_stream << item.get_name () << std::endl;
	out_stream << "=> " << item.get_guid () << std::endl;
	if (item.get_content ().is_nil () == false) {
		out_stream << *item.get_content () << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& ClassDiagram::get_name () const {
	//#UC START# *48ABFB9F003E_GET_ACCESSOR*
	return m_name;
	//#UC END# *48ABFB9F003E_GET_ACCESSOR*
}

void ClassDiagram::set_name (const std::string& name) {
	//#UC START# *48ABFB9F003E_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48ABFB9F003E_SET_ACCESSOR*
}

const std::string& ClassDiagram::get_guid () const {
	//#UC START# *48ABFBAE0024_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48ABFBAE0024_GET_ACCESSOR*
}

void ClassDiagram::set_guid (const std::string& guid) {
	//#UC START# *48ABFBAE0024_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48ABFBAE0024_SET_ACCESSOR*
}

const Core::Box<ClassDiagramContent>& ClassDiagram::content () const {
	//#UC START# *48ABFC27011A_GET_ACCESSOR*
	return m_content;
	//#UC END# *48ABFC27011A_GET_ACCESSOR*
}

void ClassDiagram::content (const Core::Box<ClassDiagramContent>& content) {
	//#UC START# *48ABFC27011A_SET_ACCESSOR*
	m_content = content;
	//#UC END# *48ABFC27011A_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

