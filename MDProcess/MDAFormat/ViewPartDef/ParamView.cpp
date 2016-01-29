////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/ParamView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::ParamView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/ParamView.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const ParamView& item) {
	out_stream << "param_view {" << std::endl;
	out_stream << "center_x = " << item.get_center_x () << " ;" << std::endl;
	out_stream << "center_y = " << item.get_center_y () << " ;" << std::endl;
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
int ParamView::get_center_x () const {
	//#UC START# *4891581E00A1_GET_ACCESSOR*
	return m_center_x;
	//#UC END# *4891581E00A1_GET_ACCESSOR*
}

void ParamView::set_center_x (int center_x) {
	//#UC START# *4891581E00A1_SET_ACCESSOR*
	m_center_x = center_x;
	//#UC END# *4891581E00A1_SET_ACCESSOR*
}

int ParamView::get_center_y () const {
	//#UC START# *4891582F0146_GET_ACCESSOR*
	return m_center_y;
	//#UC END# *4891582F0146_GET_ACCESSOR*
}

void ParamView::set_center_y (int center_y) {
	//#UC START# *4891582F0146_SET_ACCESSOR*
	m_center_y = center_y;
	//#UC END# *4891582F0146_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

