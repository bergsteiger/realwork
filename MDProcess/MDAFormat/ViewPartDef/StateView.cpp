////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/StateView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::StateView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/StateView.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const StateView& item) {
	out_stream << "state_view" << std::endl;
	out_stream << item.get_number () << std::endl;
	out_stream << "\"" << item.get_guid () << "\"" << " {" << std::endl;
	out_stream << "center_x = " << item.get_center_x () << " ;" << std::endl;
	out_stream << "center_y = " << item.get_center_y () << " ;" << std::endl;
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
int StateView::get_number () const {
	//#UC START# *4891578200B8_GET_ACCESSOR*
	return m_number;
	//#UC END# *4891578200B8_GET_ACCESSOR*
}

void StateView::set_number (int number) {
	//#UC START# *4891578200B8_SET_ACCESSOR*
	m_number = number;
	//#UC END# *4891578200B8_SET_ACCESSOR*
}

const std::string& StateView::get_guid () const {
	//#UC START# *4891578C0332_GET_ACCESSOR*
	return m_guid;
	//#UC END# *4891578C0332_GET_ACCESSOR*
}

void StateView::set_guid (const std::string& guid) {
	//#UC START# *4891578C0332_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *4891578C0332_SET_ACCESSOR*
}

int StateView::get_center_x () const {
	//#UC START# *4891579900EA_GET_ACCESSOR*
	return m_center_x;
	//#UC END# *4891579900EA_GET_ACCESSOR*
}

void StateView::set_center_x (int center_x) {
	//#UC START# *4891579900EA_SET_ACCESSOR*
	m_center_x = center_x;
	//#UC END# *4891579900EA_SET_ACCESSOR*
}

int StateView::get_center_y () const {
	//#UC START# *489157B50013_GET_ACCESSOR*
	return m_center_y;
	//#UC END# *489157B50013_GET_ACCESSOR*
}

void StateView::set_center_y (int center_y) {
	//#UC START# *489157B50013_SET_ACCESSOR*
	m_center_y = center_y;
	//#UC END# *489157B50013_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

