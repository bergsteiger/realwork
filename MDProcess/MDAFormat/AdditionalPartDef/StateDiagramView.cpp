////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/StateDiagramView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::StateDiagramView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateDiagramView.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const StateDiagramView& item) {
	out_stream << "state_diagram_view" << std::endl;
	if (item.get_conent ().is_nil () == false) {
		out_stream << *item.get_conent () << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const Core::Box<ViewContent>& StateDiagramView::conent () const {
	//#UC START# *48AD62C6004C_GET_ACCESSOR*
	return m_conent;
	//#UC END# *48AD62C6004C_GET_ACCESSOR*
}

void StateDiagramView::conent (const Core::Box<ViewContent>& conent) {
	//#UC START# *48AD62C6004C_SET_ACCESSOR*
	m_conent = conent;
	//#UC END# *48AD62C6004C_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

