////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/InheritView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::InheritView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/InheritView.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const InheritView& item) {
	out_stream << "inherit_view" << std::endl;
	out_stream << item.get_number () << " {" << std::endl;
	out_stream << "client " << item.get_client () << " ;" << std::endl;
	out_stream << "supplier " << item.get_supplier () << " ;" << std::endl;
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
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
int InheritView::get_number () const {
	//#UC START# *48914B1A010C_GET_ACCESSOR*
	return m_number;
	//#UC END# *48914B1A010C_GET_ACCESSOR*
}

void InheritView::set_number (int number) {
	//#UC START# *48914B1A010C_SET_ACCESSOR*
	m_number = number;
	//#UC END# *48914B1A010C_SET_ACCESSOR*
}

int InheritView::get_client () const {
	//#UC START# *48914B30032D_GET_ACCESSOR*
	return m_client;
	//#UC END# *48914B30032D_GET_ACCESSOR*
}

void InheritView::set_client (int client) {
	//#UC START# *48914B30032D_SET_ACCESSOR*
	m_client = client;
	//#UC END# *48914B30032D_SET_ACCESSOR*
}

int InheritView::get_supplier () const {
	//#UC START# *48914B42030B_GET_ACCESSOR*
	return m_supplier;
	//#UC END# *48914B42030B_GET_ACCESSOR*
}

void InheritView::set_supplier (int supplier) {
	//#UC START# *48914B42030B_SET_ACCESSOR*
	m_supplier = supplier;
	//#UC END# *48914B42030B_SET_ACCESSOR*
}

const PointList& InheritView::get_points () const {
	//#UC START# *48914BB30237_GET_ACCESSOR*
	return m_points;
	//#UC END# *48914BB30237_GET_ACCESSOR*
}

void InheritView::set_points (const PointList& points) {
	//#UC START# *48914BB30237_SET_ACCESSOR*
	m_points = points;
	//#UC END# *48914BB30237_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

