////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/StateAction.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::StateAction
//
// элемент-действие
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/StateAction.h"


namespace MDAFormat {
namespace ModelPartDef {

std::ostream& operator << (std::ostream& out_stream, const StateAction& item) {
	switch (item.get_type ()) {
		case AT_ENTRY: out_stream << "entry" << std::endl;
			break;
		case AT_EXIT: out_stream << "exit" << std::endl;
			break;
		case AT_DO: out_stream << "do" << std::endl;
			break;
		default: GDS_ASSERT_MSG(0,("Wrong enum value for type attr"));
	}
	out_stream << "action" << std::endl;
	out_stream << "\"" << item.get_name () << "\"" << std::endl;
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const ActionType& StateAction::get_type () const {
	//#UC START# *48ABA07002B2_GET_ACCESSOR*
	return m_type;
	//#UC END# *48ABA07002B2_GET_ACCESSOR*
}

void StateAction::set_type (const ActionType& type) {
	//#UC START# *48ABA07002B2_SET_ACCESSOR*
	m_type = type;
	//#UC END# *48ABA07002B2_SET_ACCESSOR*
}

const std::string& StateAction::get_name () const {
	//#UC START# *48ABA0870351_GET_ACCESSOR*
	return m_name;
	//#UC END# *48ABA0870351_GET_ACCESSOR*
}

void StateAction::set_name (const std::string& name) {
	//#UC START# *48ABA0870351_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48ABA0870351_SET_ACCESSOR*
}



} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

