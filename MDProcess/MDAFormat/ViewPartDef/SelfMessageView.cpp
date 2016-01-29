////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/SelfMessageView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::SelfMessageView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/SelfMessageView.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const SelfMessageView& item) {
	out_stream << "self_message_view" << std::endl;
	out_stream << item.get_number () << std::endl;
	out_stream << "\"" << item.get_guid () << "\"" << " {" << std::endl;
	out_stream << "start_y = " << item.get_start_y () << " ;" << std::endl;
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
int SelfMessageView::get_number () const {
	//#UC START# *4891554B00CC_GET_ACCESSOR*
	return m_number;
	//#UC END# *4891554B00CC_GET_ACCESSOR*
}

void SelfMessageView::set_number (int number) {
	//#UC START# *4891554B00CC_SET_ACCESSOR*
	m_number = number;
	//#UC END# *4891554B00CC_SET_ACCESSOR*
}

const std::string& SelfMessageView::get_guid () const {
	//#UC START# *4891555B0382_GET_ACCESSOR*
	return m_guid;
	//#UC END# *4891555B0382_GET_ACCESSOR*
}

void SelfMessageView::set_guid (const std::string& guid) {
	//#UC START# *4891555B0382_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *4891555B0382_SET_ACCESSOR*
}

int SelfMessageView::get_start_y () const {
	//#UC START# *4891556B0053_GET_ACCESSOR*
	return m_start_y;
	//#UC END# *4891556B0053_GET_ACCESSOR*
}

void SelfMessageView::set_start_y (int start_y) {
	//#UC START# *4891556B0053_SET_ACCESSOR*
	m_start_y = start_y;
	//#UC END# *4891556B0053_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

