////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/ViewPartDef/Point.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::Point
//
// ���� ��� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_POINT_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_POINT_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// ���� ��� ������������
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
