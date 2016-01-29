////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/StateDiagramView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::StateDiagramView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/StateDiagramView.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const StateDiagramView& item) {
	out_stream << "state_diagram_view" << std::endl;
	out_stream << item.get_number () << std::endl;
	out_stream << "\"" << item.get_guid () << "\"" << " {" << std::endl;
	out_stream << "center_x = " << item.get_center_x () << " ;" << std::endl;
	out_stream << "center_y = " << item.get_center_y () << " ;" << std::endl;
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
int StateDiagramView::get_number () const {
	//#UC START# *48915E300128_GET_ACCESSOR*
	return m_number;
	//#UC END# *48915E300128_GET_ACCESSOR*
}

void StateDiagramView::set_number (int number) {
	//#UC START# *48915E300128_SET_ACCESSOR*
	m_number = number;
	//#UC END# *48915E300128_SET_ACCESSOR*
}

const std::string& StateDiagramView::get_guid () const {
	//#UC START# *48915E3900C6_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48915E3900C6_GET_ACCESSOR*
}

void StateDiagramView::set_guid (const std::string& guid) {
	//#UC START# *48915E3900C6_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48915E3900C6_SET_ACCESSOR*
}

int StateDiagramView::get_center_x () const {
	//#UC START# *48915E3D02BD_GET_ACCESSOR*
	return m_center_x;
	//#UC END# *48915E3D02BD_GET_ACCESSOR*
}

void StateDiagramView::set_center_x (int center_x) {
	//#UC START# *48915E3D02BD_SET_ACCESSOR*
	m_center_x = center_x;
	//#UC END# *48915E3D02BD_SET_ACCESSOR*
}

int StateDiagramView::get_center_y () const {
	//#UC START# *48915E4303BE_GET_ACCESSOR*
	return m_center_y;
	//#UC END# *48915E4303BE_GET_ACCESSOR*
}

void StateDiagramView::set_center_y (int center_y) {
	//#UC START# *48915E4303BE_SET_ACCESSOR*
	m_center_y = center_y;
	//#UC END# *48915E4303BE_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

