////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/SequenceDiagramView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::SequenceDiagramView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SequenceDiagramView.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const SequenceDiagramView& item) {
	out_stream << "sequence_diagram_view" << std::endl;
	if (item.get_conent ().is_nil () == false) {
		out_stream << *item.get_conent () << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const Core::Box<ViewContent>& SequenceDiagramView::conent () const {
	//#UC START# *48AD62C10097_GET_ACCESSOR*
	return m_conent;
	//#UC END# *48AD62C10097_GET_ACCESSOR*
}

void SequenceDiagramView::conent (const Core::Box<ViewContent>& conent) {
	//#UC START# *48AD62C10097_SET_ACCESSOR*
	m_conent = conent;
	//#UC END# *48AD62C10097_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

