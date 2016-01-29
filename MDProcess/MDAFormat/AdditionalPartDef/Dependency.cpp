////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/Dependency.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Dependency
//
// описание связи
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Dependency.h"


namespace MDAFormat {
namespace AdditionalPartDef {

// init ctor
Dependency::Dependency () : m_stereotype("") {
	//#UC START# *48ABF486038C_DEF_INIT_CTOR*
	//#UC END# *48ABF486038C_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const Dependency& item) {
	out_stream << "dependency" << std::endl;
	if (item.get_stereotype () != "") {
		out_stream << "<<" << item.get_stereotype () << ">>" << std::endl;
	}
	out_stream << item.get_target_full_name () << std::endl;
	out_stream << "=> " << "\"" << item.get_guid () << "\"" << std::endl;
	if (item.properties ().empty () == false) {
		PropertyList::const_iterator it = item.get_properties ().begin ();
		PropertyList::const_iterator it_end = item.get_properties ().end ();
		out_stream << "{ ";
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		out_stream << " }" << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& Dependency::get_guid () const {
	//#UC START# *48ABF4FF0203_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48ABF4FF0203_GET_ACCESSOR*
}

void Dependency::set_guid (const std::string& guid) {
	//#UC START# *48ABF4FF0203_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48ABF4FF0203_SET_ACCESSOR*
}

const PropertyList& Dependency::get_properties () const {
	//#UC START# *48ABF54201CB_GET_ACCESSOR*
	return m_properties;
	//#UC END# *48ABF54201CB_GET_ACCESSOR*
}

void Dependency::set_properties (const PropertyList& properties) {
	//#UC START# *48ABF54201CB_SET_ACCESSOR*
	m_properties = properties;
	//#UC END# *48ABF54201CB_SET_ACCESSOR*
}

const std::string& Dependency::get_stereotype () const {
	//#UC START# *48ABF4A10189_GET_ACCESSOR*
	return m_stereotype;
	//#UC END# *48ABF4A10189_GET_ACCESSOR*
}

void Dependency::set_stereotype (const std::string& stereotype) {
	//#UC START# *48ABF4A10189_SET_ACCESSOR*
	m_stereotype = stereotype;
	//#UC END# *48ABF4A10189_SET_ACCESSOR*
}

const std::string& Dependency::get_target_full_name () const {
	//#UC START# *48ABF4DB0046_GET_ACCESSOR*
	return m_target_full_name;
	//#UC END# *48ABF4DB0046_GET_ACCESSOR*
}

void Dependency::set_target_full_name (const std::string& target_full_name) {
	//#UC START# *48ABF4DB0046_SET_ACCESSOR*
	m_target_full_name = target_full_name;
	//#UC END# *48ABF4DB0046_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

