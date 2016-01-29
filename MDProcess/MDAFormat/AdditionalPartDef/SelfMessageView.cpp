////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/SelfMessageView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::SelfMessageView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SelfMessageView.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const SelfMessageView& item) {
	out_stream << "self_message_view" << std::endl;
	if (item.get_content ().is_nil () == false) {
		out_stream << *item.get_content () << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const Core::Box<ViewContent>& SelfMessageView::content () const {
	//#UC START# *48AC0830009C_GET_ACCESSOR*
	return m_content;
	//#UC END# *48AC0830009C_GET_ACCESSOR*
}

void SelfMessageView::content (const Core::Box<ViewContent>& content) {
	//#UC START# *48AC0830009C_SET_ACCESSOR*
	m_content = content;
	//#UC END# *48AC0830009C_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

