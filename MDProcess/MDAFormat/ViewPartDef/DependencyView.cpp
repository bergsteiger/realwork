////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/DependencyView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::DependencyView
//
// Вью для связи - зависимости
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/DependencyView.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const DependencyView& item) {
	out_stream << "dependency_view" << std::endl;
	out_stream << item.get_number () << std::endl;
	out_stream << "\"" << item.get_guid () << "\"" << " {" << std::endl;
	out_stream << item.get_client () << " ;" << std::endl;
	out_stream << item.get_supplier () << " ;" << std::endl;
	if (item.points ().empty () == false) {
		PointList::const_iterator it = item.get_points ().begin ();
		PointList::const_iterator it_end = item.get_points ().end ();
		out_stream << "points = ";
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
			if (std::distance (it, it_end) > 1) {
				out_stream << ", ";
			}
		}
		out_stream << " ;" << std::endl;
	}
	if (item.get_stereotype_view ().is_nil () == false) {
		out_stream << *item.get_stereotype_view () << std::endl;
	}
	out_stream << "} ;" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
int DependencyView::get_number () const {
	//#UC START# *48BBC98101A9_GET_ACCESSOR*
	return m_number;
	//#UC END# *48BBC98101A9_GET_ACCESSOR*
}

void DependencyView::set_number (int number) {
	//#UC START# *48BBC98101A9_SET_ACCESSOR*
	m_number = number;
	//#UC END# *48BBC98101A9_SET_ACCESSOR*
}

const std::string& DependencyView::get_guid () const {
	//#UC START# *48BBC99201FD_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48BBC99201FD_GET_ACCESSOR*
}

void DependencyView::set_guid (const std::string& guid) {
	//#UC START# *48BBC99201FD_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48BBC99201FD_SET_ACCESSOR*
}

int DependencyView::get_client () const {
	//#UC START# *48BBC9DD0194_GET_ACCESSOR*
	return m_client;
	//#UC END# *48BBC9DD0194_GET_ACCESSOR*
}

void DependencyView::set_client (int client) {
	//#UC START# *48BBC9DD0194_SET_ACCESSOR*
	m_client = client;
	//#UC END# *48BBC9DD0194_SET_ACCESSOR*
}

int DependencyView::get_supplier () const {
	//#UC START# *48BBCA040367_GET_ACCESSOR*
	return m_supplier;
	//#UC END# *48BBCA040367_GET_ACCESSOR*
}

void DependencyView::set_supplier (int supplier) {
	//#UC START# *48BBCA040367_SET_ACCESSOR*
	m_supplier = supplier;
	//#UC END# *48BBCA040367_SET_ACCESSOR*
}

const PointList& DependencyView::get_points () const {
	//#UC START# *48BBCA1300C9_GET_ACCESSOR*
	return m_points;
	//#UC END# *48BBCA1300C9_GET_ACCESSOR*
}

void DependencyView::set_points (const PointList& points) {
	//#UC START# *48BBCA1300C9_SET_ACCESSOR*
	m_points = points;
	//#UC END# *48BBCA1300C9_SET_ACCESSOR*
}

const Core::Box<StereotypeView>& DependencyView::stereotype_view () const {
	//#UC START# *48BBCA3C0393_GET_ACCESSOR*
	return m_stereotype_view;
	//#UC END# *48BBCA3C0393_GET_ACCESSOR*
}

void DependencyView::stereotype_view (const Core::Box<StereotypeView>& stereotype_view) {
	//#UC START# *48BBCA3C0393_SET_ACCESSOR*
	m_stereotype_view = stereotype_view;
	//#UC END# *48BBCA3C0393_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

