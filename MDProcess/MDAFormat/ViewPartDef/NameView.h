////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/ViewPartDef/NameView.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::NameView
//
// ���� ��� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_NAMEVIEW_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_NAMEVIEW_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// ���� ��� ������������
class NameView {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	int get_center_x () const;

	void set_center_x (int center_x);

	int get_center_y () const;

	void set_center_y (int center_y);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	int m_center_x;

	int m_center_y;


}; //class NameView

std::ostream& operator << (std::ostream& out_stream, const NameView& item);
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_NAMEVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
