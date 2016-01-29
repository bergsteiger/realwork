////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/Operation.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::Operation
//
// операция класса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/Operation.h"


namespace MDAFormat {
namespace ModelPartDef {

// init ctor
Operation::Operation ()
	: m_abstractiveness(AT_REGULAR)
, m_abstractiveness(VT_PUBLIC)
, m_abstractiveness("")
, m_abstractiveness("")
, m_abstractiveness("")
{
	//#UC START# *48A2D82D03E3_DEF_INIT_CTOR*
	//#UC END# *48A2D82D03E3_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const Operation& item) {
	switch (item.get_visibility ()) {
		case VT_PUBLIC: out_stream << "public" << std::endl;
			break;
		case VT_PROTECTED: out_stream << "protected" << std::endl;
			break;
		case VT_PRIVATE: out_stream << "private" << std::endl;
			break;
		case VT_IMPLEMENTED: out_stream << "implemented" << std::endl;
			break;
		default: GDS_ASSERT_MSG(0,("Wrong enum value for visibility attr"));
	}
	switch (item.get_abstractiveness ()) {
		case AT_REGULAR: out_stream << "regular" << std::endl;
			break;
		case AT_ABSTRACT: out_stream << "abstract" << std::endl;
			break;
		case AT_FINAL: out_stream << "final" << std::endl;
			break;
		default: GDS_ASSERT_MSG(0,("Wrong enum value for abstractiveness attr"));
	}
	out_stream << "operation" << std::endl;
	if (item.get_stereotype () != "") {
		out_stream << "<<" << item.get_stereotype () << ">>" << std::endl;
	}
	out_stream << item.get_name () << std::endl;
	if (item.arguments ().empty () == false) {
		ArgumentList::const_iterator it = item.get_arguments ().begin ();
		ArgumentList::const_iterator it_end = item.get_arguments ().end ();
		out_stream << "( ";
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
			if (std::distance (it, it_end) > 1) {
				out_stream << ", ";
			}
		}
		out_stream << " )" << std::endl;
	}
	if (item.get_return_type () != "") {
		out_stream << ": " << "\"" << item.get_return_type () << "\"" << std::endl;
	}
	if (item.get_target_stereotype () != "") {
		out_stream << "[" << item.get_target_stereotype () << "]" << std::endl;
	}
	if (item.exceptions ().empty () == false) {
		StringList::const_iterator it = item.get_exceptions ().begin ();
		StringList::const_iterator it_end = item.get_exceptions ().end ();
		out_stream << "throws ";
		for (; it != it_end; ++it) {
			out_stream << *it << std::endl;
			if (std::distance (it, it_end) > 1) {
				out_stream << ", ";
			}
		}
		
	}
	if (item.user_properties ().empty () == false) {
		UserPropertyList::const_iterator it = item.get_user_properties ().begin ();
		UserPropertyList::const_iterator it_end = item.get_user_properties ().end ();
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
const AbstractionType& Operation::get_abstractiveness () const {
	//#UC START# *48A2D9BB0197_GET_ACCESSOR*
	return m_abstractiveness;
	//#UC END# *48A2D9BB0197_GET_ACCESSOR*
}

void Operation::set_abstractiveness (const AbstractionType& abstractiveness) {
	//#UC START# *48A2D9BB0197_SET_ACCESSOR*
	m_abstractiveness = abstractiveness;
	//#UC END# *48A2D9BB0197_SET_ACCESSOR*
}

const VisibilityType& Operation::get_visibility () const {
	//#UC START# *48A2DA680105_GET_ACCESSOR*
	return m_visibility;
	//#UC END# *48A2DA680105_GET_ACCESSOR*
}

void Operation::set_visibility (const VisibilityType& visibility) {
	//#UC START# *48A2DA680105_SET_ACCESSOR*
	m_visibility = visibility;
	//#UC END# *48A2DA680105_SET_ACCESSOR*
}

const std::string& Operation::get_stereotype () const {
	//#UC START# *48A2DAAA0315_GET_ACCESSOR*
	return m_stereotype;
	//#UC END# *48A2DAAA0315_GET_ACCESSOR*
}

void Operation::set_stereotype (const std::string& stereotype) {
	//#UC START# *48A2DAAA0315_SET_ACCESSOR*
	m_stereotype = stereotype;
	//#UC END# *48A2DAAA0315_SET_ACCESSOR*
}

const std::string& Operation::get_return_type () const {
	//#UC START# *48A2E40D03B8_GET_ACCESSOR*
	return m_return_type;
	//#UC END# *48A2E40D03B8_GET_ACCESSOR*
}

void Operation::set_return_type (const std::string& return_type) {
	//#UC START# *48A2E40D03B8_SET_ACCESSOR*
	m_return_type = return_type;
	//#UC END# *48A2E40D03B8_SET_ACCESSOR*
}

const std::string& Operation::get_target_stereotype () const {
	//#UC START# *48A2E4110020_GET_ACCESSOR*
	return m_target_stereotype;
	//#UC END# *48A2E4110020_GET_ACCESSOR*
}

void Operation::set_target_stereotype (const std::string& target_stereotype) {
	//#UC START# *48A2E4110020_SET_ACCESSOR*
	m_target_stereotype = target_stereotype;
	//#UC END# *48A2E4110020_SET_ACCESSOR*
}

const std::string& Operation::get_name () const {
	//#UC START# *48A2E4670070_GET_ACCESSOR*
	return m_name;
	//#UC END# *48A2E4670070_GET_ACCESSOR*
}

void Operation::set_name (const std::string& name) {
	//#UC START# *48A2E4670070_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48A2E4670070_SET_ACCESSOR*
}

const ArgumentList& Operation::get_arguments () const {
	//#UC START# *48A2E49E022B_GET_ACCESSOR*
	return m_arguments;
	//#UC END# *48A2E49E022B_GET_ACCESSOR*
}

void Operation::set_arguments (const ArgumentList& arguments) {
	//#UC START# *48A2E49E022B_SET_ACCESSOR*
	m_arguments = arguments;
	//#UC END# *48A2E49E022B_SET_ACCESSOR*
}

const StringList& Operation::get_exceptions () const {
	//#UC START# *48A2E505002D_GET_ACCESSOR*
	return m_exceptions;
	//#UC END# *48A2E505002D_GET_ACCESSOR*
}

void Operation::set_exceptions (const StringList& exceptions) {
	//#UC START# *48A2E505002D_SET_ACCESSOR*
	m_exceptions = exceptions;
	//#UC END# *48A2E505002D_SET_ACCESSOR*
}

const UserPropertyList& Operation::get_user_properties () const {
	//#UC START# *48A2E54C0086_GET_ACCESSOR*
	return m_user_properties;
	//#UC END# *48A2E54C0086_GET_ACCESSOR*
}

void Operation::set_user_properties (const UserPropertyList& user_properties) {
	//#UC START# *48A2E54C0086_SET_ACCESSOR*
	m_user_properties = user_properties;
	//#UC END# *48A2E54C0086_SET_ACCESSOR*
}



} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

