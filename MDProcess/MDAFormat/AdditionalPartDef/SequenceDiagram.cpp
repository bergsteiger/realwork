////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/SequenceDiagram.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::SequenceDiagram
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SequenceDiagram.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const SequenceDiagram& item) {
	out_stream << "sequence_diagram" << std::endl;
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
const std::string& SequenceDiagram::get_name () const {
	//#UC START# *48AC079C0314_GET_ACCESSOR*
	return m_name;
	//#UC END# *48AC079C0314_GET_ACCESSOR*
}

void SequenceDiagram::set_name (const std::string& name) {
	//#UC START# *48AC079C0314_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48AC079C0314_SET_ACCESSOR*
}

const std::string& SequenceDiagram::get_guid () const {
	//#UC START# *48AC07A5021C_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48AC07A5021C_GET_ACCESSOR*
}

void SequenceDiagram::set_guid (const std::string& guid) {
	//#UC START# *48AC07A5021C_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48AC07A5021C_SET_ACCESSOR*
}

const Core::Box<SequenceDiagramContent>& SequenceDiagram::content () const {
	//#UC START# *48AC07B30145_GET_ACCESSOR*
	return m_content;
	//#UC END# *48AC07B30145_GET_ACCESSOR*
}

void SequenceDiagram::content (const Core::Box<SequenceDiagramContent>& content) {
	//#UC START# *48AC07B30145_SET_ACCESSOR*
	m_content = content;
	//#UC END# *48AC07B30145_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

