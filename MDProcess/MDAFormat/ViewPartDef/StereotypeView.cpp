////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/StereotypeView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::StereotypeView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/StereotypeView.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const StereotypeView& item) {
	out_stream << "stereotype_view {" << std::endl;
	out_stream << "center_x = " << item.get_center_x () << " ;" << std::endl;
	out_stream << "center_y = " << item.get_center_y () << " ;" << std::endl;
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
int StereotypeView::get_center_x () const {
	//#UC START# *48914E010336_GET_ACCESSOR*
	return m_center_x;
	//#UC END# *48914E010336_GET_ACCESSOR*
}

void StereotypeView::set_center_x (int center_x) {
	//#UC START# *48914E010336_SET_ACCESSOR*
	m_center_x = center_x;
	//#UC END# *48914E010336_SET_ACCESSOR*
}

int StereotypeView::get_center_y () const {
	//#UC START# *48914E0E0194_GET_ACCESSOR*
	return m_center_y;
	//#UC END# *48914E0E0194_GET_ACCESSOR*
}

void StereotypeView::set_center_y (int center_y) {
	//#UC START# *48914E0E0194_SET_ACCESSOR*
	m_center_y = center_y;
	//#UC END# *48914E0E0194_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

