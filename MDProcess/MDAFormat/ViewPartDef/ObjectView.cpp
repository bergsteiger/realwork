////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/ObjectView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::ObjectView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/ObjectView.h"


namespace MDAFormat {
namespace ViewPartDef {

// init ctor
ObjectView::ObjectView () : m_name("") {
	//#UC START# *48915253009F_DEF_INIT_CTOR*
	//#UC END# *48915253009F_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const ObjectView& item) {
	out_stream << "object_view" << std::endl;
	out_stream << item.get_number () << std::endl;
	out_stream << "\"" << item.get_guid () << "\"" << " {" << std::endl;
	out_stream << "center_x = " << item.get_center_x () << " ;" << std::endl;
	out_stream << "center_y = " << item.get_center_y () << " ;" << std::endl;
	if (item.get_name () != "") {
		out_stream << "name = " << "\"" << item.get_name () << "\"" << " ;" << std::endl;
	}
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
int ObjectView::get_number () const {
	//#UC START# *4891526E0334_GET_ACCESSOR*
	return m_number;
	//#UC END# *4891526E0334_GET_ACCESSOR*
}

void ObjectView::set_number (int number) {
	//#UC START# *4891526E0334_SET_ACCESSOR*
	m_number = number;
	//#UC END# *4891526E0334_SET_ACCESSOR*
}

const std::string& ObjectView::get_guid () const {
	//#UC START# *4891527C03CF_GET_ACCESSOR*
	return m_guid;
	//#UC END# *4891527C03CF_GET_ACCESSOR*
}

void ObjectView::set_guid (const std::string& guid) {
	//#UC START# *4891527C03CF_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *4891527C03CF_SET_ACCESSOR*
}

int ObjectView::get_center_x () const {
	//#UC START# *4891528C0293_GET_ACCESSOR*
	return m_center_x;
	//#UC END# *4891528C0293_GET_ACCESSOR*
}

void ObjectView::set_center_x (int center_x) {
	//#UC START# *4891528C0293_SET_ACCESSOR*
	m_center_x = center_x;
	//#UC END# *4891528C0293_SET_ACCESSOR*
}

int ObjectView::get_center_y () const {
	//#UC START# *489152B503C0_GET_ACCESSOR*
	return m_center_y;
	//#UC END# *489152B503C0_GET_ACCESSOR*
}

void ObjectView::set_center_y (int center_y) {
	//#UC START# *489152B503C0_SET_ACCESSOR*
	m_center_y = center_y;
	//#UC END# *489152B503C0_SET_ACCESSOR*
}

const std::string& ObjectView::get_name () const {
	//#UC START# *48915CA60158_GET_ACCESSOR*
	return m_name;
	//#UC END# *48915CA60158_GET_ACCESSOR*
}

void ObjectView::set_name (const std::string& name) {
	//#UC START# *48915CA60158_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48915CA60158_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

