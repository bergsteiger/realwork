////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/Dependency.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::Dependency
//
// связь зависимости
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/Dependency.h"


namespace MDAFormat {
namespace ModelPartDef {

// init ctor
Dependency::Dependency () : m_stereotype("") {
	//#UC START# *48A12B8603DC_DEF_INIT_CTOR*
	//#UC END# *48A12B8603DC_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const Dependency& item) {
	out_stream << "dependency" << std::endl;
	if (item.get_stereotype () != "") {
		out_stream << "<<" << item.get_stereotype () << ">>" << std::endl;
	}
	out_stream << item.get_target_full_name () << std::endl;
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& Dependency::get_stereotype () const {
	//#UC START# *48A12BF60150_GET_ACCESSOR*
	return m_stereotype;
	//#UC END# *48A12BF60150_GET_ACCESSOR*
}

void Dependency::set_stereotype (const std::string& stereotype) {
	//#UC START# *48A12BF60150_SET_ACCESSOR*
	m_stereotype = stereotype;
	//#UC END# *48A12BF60150_SET_ACCESSOR*
}

const std::string& Dependency::get_target_full_name () const {
	//#UC START# *48A12C600230_GET_ACCESSOR*
	return m_target_full_name;
	//#UC END# *48A12C600230_GET_ACCESSOR*
}

void Dependency::set_target_full_name (const std::string& target_full_name) {
	//#UC START# *48A12C600230_SET_ACCESSOR*
	m_target_full_name = target_full_name;
	//#UC END# *48A12C600230_SET_ACCESSOR*
}



} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

