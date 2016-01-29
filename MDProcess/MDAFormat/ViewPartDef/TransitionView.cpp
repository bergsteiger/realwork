////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/TransitionView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::TransitionView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/TransitionView.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const TransitionView& item) {
	out_stream << "transition_view" << std::endl;
	out_stream << item.get_number () << std::endl;
	out_stream << "\"" << item.get_guid () << "\"" << " {" << std::endl;
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
	if (item.get_param_view ().is_nil () == false) {
		out_stream << *item.get_param_view () << std::endl;
	}
	if (item.get_stereotype_view ().is_nil () == false) {
		out_stream << *item.get_stereotype_view () << std::endl;
	}
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
int TransitionView::get_number () const {
	//#UC START# *489158FF01FD_GET_ACCESSOR*
	return m_number;
	//#UC END# *489158FF01FD_GET_ACCESSOR*
}

void TransitionView::set_number (int number) {
	//#UC START# *489158FF01FD_SET_ACCESSOR*
	m_number = number;
	//#UC END# *489158FF01FD_SET_ACCESSOR*
}

const std::string& TransitionView::get_guid () const {
	//#UC START# *489159120027_GET_ACCESSOR*
	return m_guid;
	//#UC END# *489159120027_GET_ACCESSOR*
}

void TransitionView::set_guid (const std::string& guid) {
	//#UC START# *489159120027_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *489159120027_SET_ACCESSOR*
}

int TransitionView::get_client () const {
	//#UC START# *4891591D01B5_GET_ACCESSOR*
	return m_client;
	//#UC END# *4891591D01B5_GET_ACCESSOR*
}

void TransitionView::set_client (int client) {
	//#UC START# *4891591D01B5_SET_ACCESSOR*
	m_client = client;
	//#UC END# *4891591D01B5_SET_ACCESSOR*
}

int TransitionView::get_supplier () const {
	//#UC START# *4891592F0045_GET_ACCESSOR*
	return m_supplier;
	//#UC END# *4891592F0045_GET_ACCESSOR*
}

void TransitionView::set_supplier (int supplier) {
	//#UC START# *4891592F0045_SET_ACCESSOR*
	m_supplier = supplier;
	//#UC END# *4891592F0045_SET_ACCESSOR*
}

const PointList& TransitionView::get_points () const {
	//#UC START# *4891594500EF_GET_ACCESSOR*
	return m_points;
	//#UC END# *4891594500EF_GET_ACCESSOR*
}

void TransitionView::set_points (const PointList& points) {
	//#UC START# *4891594500EF_SET_ACCESSOR*
	m_points = points;
	//#UC END# *4891594500EF_SET_ACCESSOR*
}

const Core::Box<ParamView>& TransitionView::param_view () const {
	//#UC START# *4891596000F2_GET_ACCESSOR*
	return m_param_view;
	//#UC END# *4891596000F2_GET_ACCESSOR*
}

void TransitionView::param_view (const Core::Box<ParamView>& param_view) {
	//#UC START# *4891596000F2_SET_ACCESSOR*
	m_param_view = param_view;
	//#UC END# *4891596000F2_SET_ACCESSOR*
}

const Core::Box<StereotypeView>& TransitionView::stereotype_view () const {
	//#UC START# *4891597A0091_GET_ACCESSOR*
	return m_stereotype_view;
	//#UC END# *4891597A0091_GET_ACCESSOR*
}

void TransitionView::stereotype_view (const Core::Box<StereotypeView>& stereotype_view) {
	//#UC START# *4891597A0091_SET_ACCESSOR*
	m_stereotype_view = stereotype_view;
	//#UC END# *4891597A0091_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

