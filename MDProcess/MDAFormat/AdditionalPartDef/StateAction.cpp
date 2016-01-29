////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/StateAction.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::StateAction
//
// действие связанное с переходом
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateAction.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const StateAction& item) {
	switch (item.get_type ()) {
		case ModelPartDef::AT_ENTRY: out_stream << "entry" << std::endl;
			break;
		case ModelPartDef::AT_EXIT: out_stream << "exit" << std::endl;
			break;
		case ModelPartDef::AT_DO: out_stream << "do" << std::endl;
			break;
		default: GDS_ASSERT_MSG(0,("Wrong enum value for type attr"));
	}
	out_stream << "action" << std::endl;
	out_stream << "\"" << item.get_name () << "\"" << std::endl;
	out_stream << "\"" << item.get_guid () << "\"" << std::endl;
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
const std::string& StateAction::get_name () const {
	//#UC START# *48BBCD0D000D_GET_ACCESSOR*
	return m_name;
	//#UC END# *48BBCD0D000D_GET_ACCESSOR*
}

void StateAction::set_name (const std::string& name) {
	//#UC START# *48BBCD0D000D_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48BBCD0D000D_SET_ACCESSOR*
}

const std::string& StateAction::get_guid () const {
	//#UC START# *48BBCD1B03CA_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48BBCD1B03CA_GET_ACCESSOR*
}

void StateAction::set_guid (const std::string& guid) {
	//#UC START# *48BBCD1B03CA_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48BBCD1B03CA_SET_ACCESSOR*
}

const PropertyList& StateAction::get_properties () const {
	//#UC START# *48BBCD9F02F7_GET_ACCESSOR*
	return m_properties;
	//#UC END# *48BBCD9F02F7_GET_ACCESSOR*
}

void StateAction::set_properties (const PropertyList& properties) {
	//#UC START# *48BBCD9F02F7_SET_ACCESSOR*
	m_properties = properties;
	//#UC END# *48BBCD9F02F7_SET_ACCESSOR*
}

const ModelPartDef::ActionType& StateAction::get_type () const {
	//#UC START# *48BBCD7403AC_GET_ACCESSOR*
	return m_type;
	//#UC END# *48BBCD7403AC_GET_ACCESSOR*
}

void StateAction::set_type (const ModelPartDef::ActionType& type) {
	//#UC START# *48BBCD7403AC_SET_ACCESSOR*
	m_type = type;
	//#UC END# *48BBCD7403AC_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

