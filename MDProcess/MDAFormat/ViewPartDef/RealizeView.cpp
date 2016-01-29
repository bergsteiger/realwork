////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/RealizeView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::RealizeView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/RealizeView.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const RealizeView& item) {
	out_stream << "realize_view" << std::endl;
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
int RealizeView::get_number () const {
	//#UC START# *48914FEC02FD_GET_ACCESSOR*
	return m_number;
	//#UC END# *48914FEC02FD_GET_ACCESSOR*
}

void RealizeView::set_number (int number) {
	//#UC START# *48914FEC02FD_SET_ACCESSOR*
	m_number = number;
	//#UC END# *48914FEC02FD_SET_ACCESSOR*
}

int RealizeView::get_client () const {
	//#UC START# *48914FF80324_GET_ACCESSOR*
	return m_client;
	//#UC END# *48914FF80324_GET_ACCESSOR*
}

void RealizeView::set_client (int client) {
	//#UC START# *48914FF80324_SET_ACCESSOR*
	m_client = client;
	//#UC END# *48914FF80324_SET_ACCESSOR*
}

int RealizeView::get_supplier () const {
	//#UC START# *4891500603A9_GET_ACCESSOR*
	return m_supplier;
	//#UC END# *4891500603A9_GET_ACCESSOR*
}

void RealizeView::set_supplier (int supplier) {
	//#UC START# *4891500603A9_SET_ACCESSOR*
	m_supplier = supplier;
	//#UC END# *4891500603A9_SET_ACCESSOR*
}

const PointList& RealizeView::get_points () const {
	//#UC START# *4891502E01F1_GET_ACCESSOR*
	return m_points;
	//#UC END# *4891502E01F1_GET_ACCESSOR*
}

void RealizeView::set_points (const PointList& points) {
	//#UC START# *4891502E01F1_SET_ACCESSOR*
	m_points = points;
	//#UC END# *4891502E01F1_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

