////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/UserProperty.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::UserProperty
//
// пользовательское свойство
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/UserProperty.h"


namespace MDAFormat {
namespace ModelPartDef {

// init ctor
UserProperty::UserProperty () : m_value("") {
	//#UC START# *48A12A8F0268_DEF_INIT_CTOR*
	//#UC END# *48A12A8F0268_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const UserProperty& item) {
	out_stream << "up" << std::endl;
	out_stream << "\"" << item.get_name () << "\"" << std::endl;
	if (item.get_value () != "") {
		out_stream << "= " << "\"" << item.get_value () << "\"" << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& UserProperty::get_name () const {
	//#UC START# *48A12ABD02A8_GET_ACCESSOR*
	return m_name;
	//#UC END# *48A12ABD02A8_GET_ACCESSOR*
}

void UserProperty::set_name (const std::string& name) {
	//#UC START# *48A12ABD02A8_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48A12ABD02A8_SET_ACCESSOR*
}

const std::string& UserProperty::get_value () const {
	//#UC START# *48A12AE90082_GET_ACCESSOR*
	return m_value;
	//#UC END# *48A12AE90082_GET_ACCESSOR*
}

void UserProperty::set_value (const std::string& value) {
	//#UC START# *48A12AE90082_SET_ACCESSOR*
	m_value = value;
	//#UC END# *48A12AE90082_SET_ACCESSOR*
}



} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

