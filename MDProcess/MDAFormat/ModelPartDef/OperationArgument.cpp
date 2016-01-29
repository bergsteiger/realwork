////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/OperationArgument.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::OperationArgument
//
// параметр операции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/OperationArgument.h"


namespace MDAFormat {
namespace ModelPartDef {

// init ctor
OperationArgument::OperationArgument ()
	: m_qualifier(AQ_IN)
m_qualifier("")
, m_qualifier("")
{
	//#UC START# *48A2DB2500B3_DEF_INIT_CTOR*
	//#UC END# *48A2DB2500B3_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const OperationArgument& item) {
	switch (item.get_qualifier ()) {
		case AQ_IN: out_stream << "in" << std::endl;
			break;
		case AQ_INOUT: out_stream << "inout" << std::endl;
			break;
		case AQ_OUT: out_stream << "out" << std::endl;
			break;
		default: GDS_ASSERT_MSG(0,("Wrong enum value for qualifier attr"));
	}
	out_stream << item.get_name () << std::endl;
	if (item.get_target_full_name () != "") {
		out_stream << ": " << item.get_target_full_name () << std::endl;
	}
	if (item.get_init_value () != "") {
		out_stream << "= " << "\"" << item.get_init_value () << "\"" << std::endl;
	}

	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const ArgumentQualifier& OperationArgument::get_qualifier () const {
	//#UC START# *48A2DBCD0143_GET_ACCESSOR*
	return m_qualifier;
	//#UC END# *48A2DBCD0143_GET_ACCESSOR*
}

void OperationArgument::set_qualifier (const ArgumentQualifier& qualifier) {
	//#UC START# *48A2DBCD0143_SET_ACCESSOR*
	m_qualifier = qualifier;
	//#UC END# *48A2DBCD0143_SET_ACCESSOR*
}

const std::string& OperationArgument::get_name () const {
	//#UC START# *48A2DC7000D6_GET_ACCESSOR*
	return m_name;
	//#UC END# *48A2DC7000D6_GET_ACCESSOR*
}

void OperationArgument::set_name (const std::string& name) {
	//#UC START# *48A2DC7000D6_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48A2DC7000D6_SET_ACCESSOR*
}

const std::string& OperationArgument::get_target_full_name () const {
	//#UC START# *48A2DC86002B_GET_ACCESSOR*
	return m_target_full_name;
	//#UC END# *48A2DC86002B_GET_ACCESSOR*
}

void OperationArgument::set_target_full_name (const std::string& target_full_name) {
	//#UC START# *48A2DC86002B_SET_ACCESSOR*
	m_target_full_name = target_full_name;
	//#UC END# *48A2DC86002B_SET_ACCESSOR*
}

const std::string& OperationArgument::get_init_value () const {
	//#UC START# *48A2DE8F02D5_GET_ACCESSOR*
	return m_init_value;
	//#UC END# *48A2DE8F02D5_GET_ACCESSOR*
}

void OperationArgument::set_init_value (const std::string& init_value) {
	//#UC START# *48A2DE8F02D5_SET_ACCESSOR*
	m_init_value = init_value;
	//#UC END# *48A2DE8F02D5_SET_ACCESSOR*
}



} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

