////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/PackageView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::PackageView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/PackageView.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const PackageView& item) {
	out_stream << "package_view" << std::endl;
	out_stream << item.get_number () << std::endl;
	out_stream << "\"" << item.get_guid () << "\"" << " {" << std::endl;
	out_stream << "center_x = " << item.get_center_x () << " ;" << std::endl;
	out_stream << "center_y = " << item.get_center_y () << " ;" << std::endl;
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
int PackageView::get_number () const {
	//#UC START# *489161600299_GET_ACCESSOR*
	return m_number;
	//#UC END# *489161600299_GET_ACCESSOR*
}

void PackageView::set_number (int number) {
	//#UC START# *489161600299_SET_ACCESSOR*
	m_number = number;
	//#UC END# *489161600299_SET_ACCESSOR*
}

const std::string& PackageView::get_guid () const {
	//#UC START# *4891618A0312_GET_ACCESSOR*
	return m_guid;
	//#UC END# *4891618A0312_GET_ACCESSOR*
}

void PackageView::set_guid (const std::string& guid) {
	//#UC START# *4891618A0312_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *4891618A0312_SET_ACCESSOR*
}

int PackageView::get_center_x () const {
	//#UC START# *4891618F014E_GET_ACCESSOR*
	return m_center_x;
	//#UC END# *4891618F014E_GET_ACCESSOR*
}

void PackageView::set_center_x (int center_x) {
	//#UC START# *4891618F014E_SET_ACCESSOR*
	m_center_x = center_x;
	//#UC END# *4891618F014E_SET_ACCESSOR*
}

int PackageView::get_center_y () const {
	//#UC START# *4891618F0362_GET_ACCESSOR*
	return m_center_y;
	//#UC END# *4891618F0362_GET_ACCESSOR*
}

void PackageView::set_center_y (int center_y) {
	//#UC START# *4891618F0362_SET_ACCESSOR*
	m_center_y = center_y;
	//#UC END# *4891618F0362_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

