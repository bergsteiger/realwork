////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/Point.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::Point
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/Point.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const Point& item) {
	out_stream << "(" << std::endl;
	out_stream << item.get_x () << " ," << std::endl;
	out_stream << item.get_y () << std::endl;
	out_stream << ")" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
int Point::get_x () const {
	//#UC START# *48914B8101B1_GET_ACCESSOR*
	return m_x;
	//#UC END# *48914B8101B1_GET_ACCESSOR*
}

void Point::set_x (int x) {
	//#UC START# *48914B8101B1_SET_ACCESSOR*
	m_x = x;
	//#UC END# *48914B8101B1_SET_ACCESSOR*
}

int Point::get_y () const {
	//#UC START# *48914B900382_GET_ACCESSOR*
	return m_y;
	//#UC END# *48914B900382_GET_ACCESSOR*
}

void Point::set_y (int y) {
	//#UC START# *48914B900382_SET_ACCESSOR*
	m_y = y;
	//#UC END# *48914B900382_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

