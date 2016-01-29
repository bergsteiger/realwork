////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/SequenceDiagramView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::SequenceDiagramView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/SequenceDiagramView.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const SequenceDiagramView& item) {
	out_stream << "sequence_diagram_view" << std::endl;
	out_stream << item.get_number () << std::endl;
	out_stream << "\"" << item.get_guid () << "\"" << " {" << std::endl;
	out_stream << "center_x " << item.get_center_x () << " ;" << std::endl;
	out_stream << "center_y " << item.get_center_y () << " ;" << std::endl;
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
int SequenceDiagramView::get_number () const {
	//#UC START# *48915DAC035B_GET_ACCESSOR*
	return m_number;
	//#UC END# *48915DAC035B_GET_ACCESSOR*
}

void SequenceDiagramView::set_number (int number) {
	//#UC START# *48915DAC035B_SET_ACCESSOR*
	m_number = number;
	//#UC END# *48915DAC035B_SET_ACCESSOR*
}

const std::string& SequenceDiagramView::get_guid () const {
	//#UC START# *48915DB90115_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48915DB90115_GET_ACCESSOR*
}

void SequenceDiagramView::set_guid (const std::string& guid) {
	//#UC START# *48915DB90115_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48915DB90115_SET_ACCESSOR*
}

int SequenceDiagramView::get_center_x () const {
	//#UC START# *48915DD401FC_GET_ACCESSOR*
	return m_center_x;
	//#UC END# *48915DD401FC_GET_ACCESSOR*
}

void SequenceDiagramView::set_center_x (int center_x) {
	//#UC START# *48915DD401FC_SET_ACCESSOR*
	m_center_x = center_x;
	//#UC END# *48915DD401FC_SET_ACCESSOR*
}

int SequenceDiagramView::get_center_y () const {
	//#UC START# *48915DD70266_GET_ACCESSOR*
	return m_center_y;
	//#UC END# *48915DD70266_GET_ACCESSOR*
}

void SequenceDiagramView::set_center_y (int center_y) {
	//#UC START# *48915DD70266_SET_ACCESSOR*
	m_center_y = center_y;
	//#UC END# *48915DD70266_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

