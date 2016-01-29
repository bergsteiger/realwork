////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/AssociationView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::AssociationView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/AssociationView.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const AssociationView& item) {
	out_stream << "association_view" << std::endl;
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
	if (item.get_name_view ().is_nil () == false) {
		out_stream << *item.get_name_view () << std::endl;
	}
	if (item.get_stereotype_view ().is_nil () == false) {
		out_stream << *item.get_stereotype_view () << std::endl;
	}
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
int AssociationView::get_number () const {
	//#UC START# *48914E8F0317_GET_ACCESSOR*
	return m_number;
	//#UC END# *48914E8F0317_GET_ACCESSOR*
}

void AssociationView::set_number (int number) {
	//#UC START# *48914E8F0317_SET_ACCESSOR*
	m_number = number;
	//#UC END# *48914E8F0317_SET_ACCESSOR*
}

const std::string& AssociationView::get_guid () const {
	//#UC START# *48914EDA038D_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48914EDA038D_GET_ACCESSOR*
}

void AssociationView::set_guid (const std::string& guid) {
	//#UC START# *48914EDA038D_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48914EDA038D_SET_ACCESSOR*
}

int AssociationView::get_client () const {
	//#UC START# *48914EF00172_GET_ACCESSOR*
	return m_client;
	//#UC END# *48914EF00172_GET_ACCESSOR*
}

void AssociationView::set_client (int client) {
	//#UC START# *48914EF00172_SET_ACCESSOR*
	m_client = client;
	//#UC END# *48914EF00172_SET_ACCESSOR*
}

int AssociationView::get_supplier () const {
	//#UC START# *48914F0A0255_GET_ACCESSOR*
	return m_supplier;
	//#UC END# *48914F0A0255_GET_ACCESSOR*
}

void AssociationView::set_supplier (int supplier) {
	//#UC START# *48914F0A0255_SET_ACCESSOR*
	m_supplier = supplier;
	//#UC END# *48914F0A0255_SET_ACCESSOR*
}

const PointList& AssociationView::get_points () const {
	//#UC START# *48914F2B03B5_GET_ACCESSOR*
	return m_points;
	//#UC END# *48914F2B03B5_GET_ACCESSOR*
}

void AssociationView::set_points (const PointList& points) {
	//#UC START# *48914F2B03B5_SET_ACCESSOR*
	m_points = points;
	//#UC END# *48914F2B03B5_SET_ACCESSOR*
}

const Core::Box<NameView>& AssociationView::name_view () const {
	//#UC START# *48914F5803DA_GET_ACCESSOR*
	return m_name_view;
	//#UC END# *48914F5803DA_GET_ACCESSOR*
}

void AssociationView::name_view (const Core::Box<NameView>& name_view) {
	//#UC START# *48914F5803DA_SET_ACCESSOR*
	m_name_view = name_view;
	//#UC END# *48914F5803DA_SET_ACCESSOR*
}

const Core::Box<StereotypeView>& AssociationView::stereotype_view () const {
	//#UC START# *48914F7203AB_GET_ACCESSOR*
	return m_stereotype_view;
	//#UC END# *48914F7203AB_GET_ACCESSOR*
}

void AssociationView::stereotype_view (const Core::Box<StereotypeView>& stereotype_view) {
	//#UC START# *48914F7203AB_SET_ACCESSOR*
	m_stereotype_view = stereotype_view;
	//#UC END# *48914F7203AB_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

