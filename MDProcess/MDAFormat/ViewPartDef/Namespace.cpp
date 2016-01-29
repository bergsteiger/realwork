////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/Namespace.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::Namespace
//
// описание нэймспэйса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/Namespace.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const Namespace& item) {
	out_stream << "namespace" << std::endl;
	out_stream << item.get_name () << std::endl;
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& Namespace::get_name () const {
	//#UC START# *48AE518E026C_GET_ACCESSOR*
	return m_name;
	//#UC END# *48AE518E026C_GET_ACCESSOR*
}

void Namespace::set_name (const std::string& name) {
	//#UC START# *48AE518E026C_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48AE518E026C_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

