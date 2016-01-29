////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/NoteView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::NoteView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/NoteView.h"


namespace MDAFormat {
namespace ViewPartDef {

// init ctor
NoteView::NoteView () : m_text("") {
	//#UC START# *489060080393_DEF_INIT_CTOR*
	//#UC END# *489060080393_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const NoteView& item) {
	out_stream << "note_view" << std::endl;
	out_stream << item.get_number () << std::endl;
	out_stream << item.get_associated_view_number () << " {" << std::endl;
	out_stream << "center_x = " << item.get_center_x () << " ;" << std::endl;
	out_stream << "center_y = " << item.get_center_y () << " ;" << std::endl;
	if (item.get_text () != "") {
		out_stream << "text = " << "\"" << item.get_text () << "\"" << " ;" << std::endl;
	}
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
int NoteView::get_number () const {
	//#UC START# *4890609900A2_GET_ACCESSOR*
	return m_number;
	//#UC END# *4890609900A2_GET_ACCESSOR*
}

void NoteView::set_number (int number) {
	//#UC START# *4890609900A2_SET_ACCESSOR*
	m_number = number;
	//#UC END# *4890609900A2_SET_ACCESSOR*
}

int NoteView::get_associated_view_number () const {
	//#UC START# *489060AD02C2_GET_ACCESSOR*
	return m_associated_view_number;
	//#UC END# *489060AD02C2_GET_ACCESSOR*
}

void NoteView::set_associated_view_number (int associated_view_number) {
	//#UC START# *489060AD02C2_SET_ACCESSOR*
	m_associated_view_number = associated_view_number;
	//#UC END# *489060AD02C2_SET_ACCESSOR*
}

int NoteView::get_center_x () const {
	//#UC START# *489060E001BD_GET_ACCESSOR*
	return m_center_x;
	//#UC END# *489060E001BD_GET_ACCESSOR*
}

void NoteView::set_center_x (int center_x) {
	//#UC START# *489060E001BD_SET_ACCESSOR*
	m_center_x = center_x;
	//#UC END# *489060E001BD_SET_ACCESSOR*
}

int NoteView::get_center_y () const {
	//#UC START# *489060F901B8_GET_ACCESSOR*
	return m_center_y;
	//#UC END# *489060F901B8_GET_ACCESSOR*
}

void NoteView::set_center_y (int center_y) {
	//#UC START# *489060F901B8_SET_ACCESSOR*
	m_center_y = center_y;
	//#UC END# *489060F901B8_SET_ACCESSOR*
}

const std::string& NoteView::get_text () const {
	//#UC START# *4890613401CB_GET_ACCESSOR*
	return m_text;
	//#UC END# *4890613401CB_GET_ACCESSOR*
}

void NoteView::set_text (const std::string& text) {
	//#UC START# *4890613401CB_SET_ACCESSOR*
	m_text = text;
	//#UC END# *4890613401CB_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

