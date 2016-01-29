////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/Point.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::Point
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_POINT_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_POINT_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// пока нет документации
class Point {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	int get_x () const;

	void set_x (int x);

	int get_y () const;

	void set_y (int y);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	int m_x;

	int m_y;


}; //class Point

std::ostream& operator << (std::ostream& out_stream, const Point& item);
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_POINT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
