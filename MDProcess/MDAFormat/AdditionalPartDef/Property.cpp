////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/Property.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Property
//
// совойство элемента, используется для хранения различных свойств в модели
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Property.h"


namespace MDAFormat {
namespace AdditionalPartDef {

// init ctor
Property::Property () : m_value("") {
	//#UC START# *48ABF3FC0130_DEF_INIT_CTOR*
	//#UC END# *48ABF3FC0130_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const Property& item) {
	out_stream << "property" << std::endl;
	out_stream << "\"" << item.get_name () << "\"" << std::endl;
	if (item.get_value () != "") {
		out_stream << "= " << "\"" << item.get_value () << "\"" << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& Property::get_name () const {
	//#UC START# *48ABF42A031D_GET_ACCESSOR*
	return m_name;
	//#UC END# *48ABF42A031D_GET_ACCESSOR*
}

void Property::set_name (const std::string& name) {
	//#UC START# *48ABF42A031D_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48ABF42A031D_SET_ACCESSOR*
}

const std::string& Property::get_value () const {
	//#UC START# *48ABF447023C_GET_ACCESSOR*
	return m_value;
	//#UC END# *48ABF447023C_GET_ACCESSOR*
}

void Property::set_value (const std::string& value) {
	//#UC START# *48ABF447023C_SET_ACCESSOR*
	m_value = value;
	//#UC END# *48ABF447023C_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

