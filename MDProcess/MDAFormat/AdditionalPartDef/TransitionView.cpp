////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/TransitionView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::TransitionView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/TransitionView.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const TransitionView& item) {
	out_stream << "transition_view" << std::endl;
	out_stream << item.get_number () << std::endl;
	out_stream << "=> " << "\"" << item.get_guid () << "\"" << std::endl;
	if (item.get_content ().is_nil () == false) {
		out_stream << *item.get_content () << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
unsigned int TransitionView::get_number () const {
	//#UC START# *48ABFEBF01B8_GET_ACCESSOR*
	return m_number;
	//#UC END# *48ABFEBF01B8_GET_ACCESSOR*
}

void TransitionView::set_number (unsigned int number) {
	//#UC START# *48ABFEBF01B8_SET_ACCESSOR*
	m_number = number;
	//#UC END# *48ABFEBF01B8_SET_ACCESSOR*
}

const std::string& TransitionView::get_guid () const {
	//#UC START# *48ABFEC8031F_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48ABFEC8031F_GET_ACCESSOR*
}

void TransitionView::set_guid (const std::string& guid) {
	//#UC START# *48ABFEC8031F_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48ABFEC8031F_SET_ACCESSOR*
}

const Core::Box<TransitionViewContent>& TransitionView::content () const {
	//#UC START# *48ABFEE600FB_GET_ACCESSOR*
	return m_content;
	//#UC END# *48ABFEE600FB_GET_ACCESSOR*
}

void TransitionView::content (const Core::Box<TransitionViewContent>& content) {
	//#UC START# *48ABFEE600FB_SET_ACCESSOR*
	m_content = content;
	//#UC END# *48ABFEE600FB_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

