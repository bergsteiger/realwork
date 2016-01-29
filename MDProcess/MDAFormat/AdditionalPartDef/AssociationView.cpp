////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/AssociationView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::AssociationView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AssociationView.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const AssociationView& item) {
	out_stream << "association_view" << std::endl;
	if (item.get_conent ().is_nil () == false) {
		out_stream << *item.get_conent () << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const Core::Box<ViewContent>& AssociationView::conent () const {
	//#UC START# *48ABFDCE01CF_GET_ACCESSOR*
	return m_conent;
	//#UC END# *48ABFDCE01CF_GET_ACCESSOR*
}

void AssociationView::conent (const Core::Box<ViewContent>& conent) {
	//#UC START# *48ABFDCE01CF_SET_ACCESSOR*
	m_conent = conent;
	//#UC END# *48ABFDCE01CF_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

