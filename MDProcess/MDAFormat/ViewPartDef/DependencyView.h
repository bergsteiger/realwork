////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/ViewPartDef/DependencyView.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::DependencyView
//
// ��� ��� ����� - �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_DEPENDENCYVIEW_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_DEPENDENCYVIEW_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/Point.h"
#include "MDProcess/MDAFormat/ViewPartDef/StereotypeView.h"
#include "MDProcess/MDAFormat/ViewPartDef/ViewPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ViewPartDef {

// ��� ��� ����� - �����������
class DependencyView {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	int get_number () const;

	void set_number (int number);

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	int get_client () const;

	void set_client (int client);

	int get_supplier () const;

	void set_supplier (int supplier);

	const PointList& get_points () const;

	void set_points (const PointList& points);

	const Core::Box<StereotypeView>& stereotype_view () const;

	void stereotype_view (const Core::Box<StereotypeView>& stereotype_view);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// ���������� ����� ���
	int m_number;

	// ���� �������� �����, ��������������� ���
	std::string m_guid;

	int m_client;

	int m_supplier;

	PointList m_points;

	Core::Box<StereotypeView> m_stereotype_view;


}; //class DependencyView

std::ostream& operator << (std::ostream& out_stream, const DependencyView& item);
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_DEPENDENCYVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
