////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseProperty.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseProperty
//
// Свойство
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseProperty.h"

namespace RoseInternal {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseProperty::~RoseProperty () {
	//#UC START# *4A9DE8DF02B3_DESTR_BODY*
	//#UC END# *4A9DE8DF02B3_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const std::string& RoseProperty::get_name () const {
	//#UC START# *4A9DE8FB00A2_GET_ACCESSOR*
	return m_name;
	//#UC END# *4A9DE8FB00A2_GET_ACCESSOR*
}

void RoseProperty::set_name (const std::string& name) {
	//#UC START# *4A9DE8FB00A2_SET_ACCESSOR*
	m_name = name;
	//#UC END# *4A9DE8FB00A2_SET_ACCESSOR*
}

const std::string& RoseProperty::get_tool_name () const {
	//#UC START# *4A9DE91403BC_GET_ACCESSOR*
	return m_tool_name;
	//#UC END# *4A9DE91403BC_GET_ACCESSOR*
}

void RoseProperty::set_tool_name (const std::string& tool_name) {
	//#UC START# *4A9DE91403BC_SET_ACCESSOR*
	m_tool_name = tool_name;
	//#UC END# *4A9DE91403BC_SET_ACCESSOR*
}

const std::string& RoseProperty::get_type () const {
	//#UC START# *4A9DE90A03E4_GET_ACCESSOR*
	return m_type;
	//#UC END# *4A9DE90A03E4_GET_ACCESSOR*
}

void RoseProperty::set_type (const std::string& type) {
	//#UC START# *4A9DE90A03E4_SET_ACCESSOR*
	m_type = type;
	//#UC END# *4A9DE90A03E4_SET_ACCESSOR*
}

const std::string& RoseProperty::get_value () const {
	//#UC START# *4A9DE90302F8_GET_ACCESSOR*
	return m_value;
	//#UC END# *4A9DE90302F8_GET_ACCESSOR*
}

void RoseProperty::set_value (const std::string& value) {
	//#UC START# *4A9DE90302F8_SET_ACCESSOR*
	m_value = value;
	//#UC END# *4A9DE90302F8_SET_ACCESSOR*
}


} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

