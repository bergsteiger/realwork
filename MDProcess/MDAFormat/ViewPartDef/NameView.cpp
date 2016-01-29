////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/NameView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::NameView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/NameView.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const NameView& item) {
	out_stream << "name_view {" << std::endl;
	out_stream << "center_x = " << item.get_center_x () << " ;" << std::endl;
	out_stream << "center_y = " << item.get_center_y () << " ;" << std::endl;
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
int NameView::get_center_x () const {
	//#UC START# *48914CF202C5_GET_ACCESSOR*
	return m_center_x;
	//#UC END# *48914CF202C5_GET_ACCESSOR*
}

void NameView::set_center_x (int center_x) {
	//#UC START# *48914CF202C5_SET_ACCESSOR*
	m_center_x = center_x;
	//#UC END# *48914CF202C5_SET_ACCESSOR*
}

int NameView::get_center_y () const {
	//#UC START# *48914D05028B_GET_ACCESSOR*
	return m_center_y;
	//#UC END# *48914D05028B_GET_ACCESSOR*
}

void NameView::set_center_y (int center_y) {
	//#UC START# *48914D05028B_SET_ACCESSOR*
	m_center_y = center_y;
	//#UC END# *48914D05028B_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

