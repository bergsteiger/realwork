////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/MessageView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::MessageView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/MessageView.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const MessageView& item) {
	out_stream << "message_view" << std::endl;
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
int MessageView::get_number () const {
	//#UC START# *4891534202AC_GET_ACCESSOR*
	return m_number;
	//#UC END# *4891534202AC_GET_ACCESSOR*
}

void MessageView::set_number (int number) {
	//#UC START# *4891534202AC_SET_ACCESSOR*
	m_number = number;
	//#UC END# *4891534202AC_SET_ACCESSOR*
}

const std::string& MessageView::get_guid () const {
	//#UC START# *489153500072_GET_ACCESSOR*
	return m_guid;
	//#UC END# *489153500072_GET_ACCESSOR*
}

void MessageView::set_guid (const std::string& guid) {
	//#UC START# *489153500072_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *489153500072_SET_ACCESSOR*
}

int MessageView::get_client () const {
	//#UC START# *489153AB0341_GET_ACCESSOR*
	return m_client;
	//#UC END# *489153AB0341_GET_ACCESSOR*
}

void MessageView::set_client (int client) {
	//#UC START# *489153AB0341_SET_ACCESSOR*
	m_client = client;
	//#UC END# *489153AB0341_SET_ACCESSOR*
}

int MessageView::get_supplier () const {
	//#UC START# *4891541001CD_GET_ACCESSOR*
	return m_supplier;
	//#UC END# *4891541001CD_GET_ACCESSOR*
}

void MessageView::set_supplier (int supplier) {
	//#UC START# *4891541001CD_SET_ACCESSOR*
	m_supplier = supplier;
	//#UC END# *4891541001CD_SET_ACCESSOR*
}

int MessageView::get_start_y () const {
	//#UC START# *48915431031A_GET_ACCESSOR*
	return m_start_y;
	//#UC END# *48915431031A_GET_ACCESSOR*
}

void MessageView::set_start_y (int start_y) {
	//#UC START# *48915431031A_SET_ACCESSOR*
	m_start_y = start_y;
	//#UC END# *48915431031A_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

