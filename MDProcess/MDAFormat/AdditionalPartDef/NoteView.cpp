////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/NoteView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::NoteView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/NoteView.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const NoteView& item) {
	out_stream << "note_view" << std::endl;
	if (item.get_conent ().is_nil () == false) {
		out_stream << *item.get_conent () << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const Core::Box<ViewContent>& NoteView::conent () const {
	//#UC START# *48ABFDD603E0_GET_ACCESSOR*
	return m_conent;
	//#UC END# *48ABFDD603E0_GET_ACCESSOR*
}

void NoteView::conent (const Core::Box<ViewContent>& conent) {
	//#UC START# *48ABFDD603E0_SET_ACCESSOR*
	m_conent = conent;
	//#UC END# *48ABFDD603E0_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

