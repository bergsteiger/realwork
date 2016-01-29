////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/ReturnMessageView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::ReturnMessageView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/ReturnMessageView.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const ReturnMessageView& item) {
	out_stream << "return_message_view" << std::endl;
	out_stream << item.get_number () << std::endl;
	out_stream << "\"" << item.get_guid () << "\"" << " {" << std::endl;
	out_stream << "client " << item.get_client () << " ;" << std::endl;
	out_stream << "supplier " << item.get_supplier () << " ;" << std::endl;
	out_stream << "start_y = " << item.get_start_y () << " ;" << std::endl;
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
int ReturnMessageView::get_number () const {
	//#UC START# *489155C80046_GET_ACCESSOR*
	return m_number;
	//#UC END# *489155C80046_GET_ACCESSOR*
}

void ReturnMessageView::set_number (int number) {
	//#UC START# *489155C80046_SET_ACCESSOR*
	m_number = number;
	//#UC END# *489155C80046_SET_ACCESSOR*
}

const std::string& ReturnMessageView::get_guid () const {
	//#UC START# *489155F9020A_GET_ACCESSOR*
	return m_guid;
	//#UC END# *489155F9020A_GET_ACCESSOR*
}

void ReturnMessageView::set_guid (const std::string& guid) {
	//#UC START# *489155F9020A_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *489155F9020A_SET_ACCESSOR*
}

int ReturnMessageView::get_client () const {
	//#UC START# *489156090399_GET_ACCESSOR*
	return m_client;
	//#UC END# *489156090399_GET_ACCESSOR*
}

void ReturnMessageView::set_client (int client) {
	//#UC START# *489156090399_SET_ACCESSOR*
	m_client = client;
	//#UC END# *489156090399_SET_ACCESSOR*
}

int ReturnMessageView::get_supplier () const {
	//#UC START# *489156400226_GET_ACCESSOR*
	return m_supplier;
	//#UC END# *489156400226_GET_ACCESSOR*
}

void ReturnMessageView::set_supplier (int supplier) {
	//#UC START# *489156400226_SET_ACCESSOR*
	m_supplier = supplier;
	//#UC END# *489156400226_SET_ACCESSOR*
}

int ReturnMessageView::get_start_y () const {
	//#UC START# *489156550385_GET_ACCESSOR*
	return m_start_y;
	//#UC END# *489156550385_GET_ACCESSOR*
}

void ReturnMessageView::set_start_y (int start_y) {
	//#UC START# *489156550385_SET_ACCESSOR*
	m_start_y = start_y;
	//#UC END# *489156550385_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

