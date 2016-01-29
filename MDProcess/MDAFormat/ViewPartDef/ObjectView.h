////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/ViewPartDef/ObjectView.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::ObjectView
//
// ���� ��� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_OBJECTVIEW_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_OBJECTVIEW_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// ���� ��� ������������
class ObjectView {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	ObjectView ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	int get_number () const;

	void set_number (int number);

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	int get_center_x () const;

	void set_center_x (int center_x);

	int get_center_y () const;

	void set_center_y (int center_y);

	const std::string& get_name () const;

	void set_name (const std::string& name);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	int m_number;

	std::string m_guid;

	int m_center_x;

	int m_center_y;

	std::string m_name;


}; //class ObjectView

std::ostream& operator << (std::ostream& out_stream, const ObjectView& item);
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_OBJECTVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
