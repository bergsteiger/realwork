////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/Namespace.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Namespace
//
// описание нэймспейса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Namespace.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const Namespace& item) {
	out_stream << "namespace" << std::endl;
	out_stream << item.get_name () << std::endl;
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& Namespace::get_name () const {
	//#UC START# *48AE505F0150_GET_ACCESSOR*
	return m_name;
	//#UC END# *48AE505F0150_GET_ACCESSOR*
}

void Namespace::set_name (const std::string& name) {
	//#UC START# *48AE505F0150_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48AE505F0150_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

