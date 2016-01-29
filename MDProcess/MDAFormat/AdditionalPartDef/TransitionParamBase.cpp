////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/TransitionParamBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::TransitionParamBase
//
// базовое описание формата параметров перехода
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/TransitionParamBase.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const TransitionParamBase& item) {
	out_stream << "\"" << item.get_name () << "\"" << std::endl;
	out_stream << "=> " << "\"" << item.get_guid () << "\"" << std::endl;

	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& TransitionParamBase::get_name () const {
	//#UC START# *48BBCE97016F_GET_ACCESSOR*
	return m_name;
	//#UC END# *48BBCE97016F_GET_ACCESSOR*
}

void TransitionParamBase::set_name (const std::string& name) {
	//#UC START# *48BBCE97016F_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48BBCE97016F_SET_ACCESSOR*
}

const std::string& TransitionParamBase::get_guid () const {
	//#UC START# *48BBCE9E02D4_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48BBCE9E02D4_GET_ACCESSOR*
}

void TransitionParamBase::set_guid (const std::string& guid) {
	//#UC START# *48BBCE9E02D4_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48BBCE9E02D4_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

