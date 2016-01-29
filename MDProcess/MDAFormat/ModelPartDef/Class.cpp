////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/Class.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::Class
//
// Описание класса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/Class.h"


namespace MDAFormat {
namespace ModelPartDef {

// init ctor
Class::Class () : m_native(false), m_abstractiveness(AT_REGULAR), m_visibility(VT_PUBLIC) {
	//#UC START# *48A2CD1C02F8_DEF_INIT_CTOR*
	//#UC END# *48A2CD1C02F8_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const Class& item) {
	if (item.template_params ().empty () == false) {
		ArgumentList::const_iterator it = item.get_template_params ().begin ();
		ArgumentList::const_iterator it_end = item.get_template_params ().end ();
		out_stream << "template < ";
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
			if (std::distance (it, it_end) > 1) {
				out_stream << ", ";
			}
		}
		out_stream << " >" << std::endl;
	}
	if(item.get_native ()) {
		out_stream << "native " << std::endl;
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
	out_stream << "class" << std::endl;
	out_stream << "<<" << item.get_stereotype () << ">>" << std::endl;
	out_stream << item.get_name () << std::endl;
	if (item.extends_list ().empty () == false) {
		StringList::const_iterator it = item.get_extends_list ().begin ();
		StringList::const_iterator it_end = item.get_extends_list ().end ();
		out_stream << "extends ";
		for (; it != it_end; ++it) {
			out_stream << *it << std::endl;
			if (std::distance (it, it_end) > 1) {
				out_stream << ", ";
			}
		}
		
	}
	if (item.implements_list ().empty () == false) {
		StringList::const_iterator it = item.get_implements_list ().begin ();
		StringList::const_iterator it_end = item.get_implements_list ().end ();
		out_stream << "implements ";
		for (; it != it_end; ++it) {
			out_stream << *it << std::endl;
			if (std::distance (it, it_end) > 1) {
				out_stream << ", ";
			}
		}
		
	}
	out_stream << "{ " << item.get_content () << " }" << std::endl;
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
bool Class::get_native () const {
	//#UC START# *48A2CD4603B0_GET_ACCESSOR*
	return m_native;
	//#UC END# *48A2CD4603B0_GET_ACCESSOR*
}

void Class::set_native (bool native) {
	//#UC START# *48A2CD4603B0_SET_ACCESSOR*
	m_native = native;
	//#UC END# *48A2CD4603B0_SET_ACCESSOR*
}

const AbstractionType& Class::get_abstractiveness () const {
	//#UC START# *48A2CE2601AB_GET_ACCESSOR*
	return m_abstractiveness;
	//#UC END# *48A2CE2601AB_GET_ACCESSOR*
}

void Class::set_abstractiveness (const AbstractionType& abstractiveness) {
	//#UC START# *48A2CE2601AB_SET_ACCESSOR*
	m_abstractiveness = abstractiveness;
	//#UC END# *48A2CE2601AB_SET_ACCESSOR*
}

const VisibilityType& Class::get_visibility () const {
	//#UC START# *48A2CF120127_GET_ACCESSOR*
	return m_visibility;
	//#UC END# *48A2CF120127_GET_ACCESSOR*
}

void Class::set_visibility (const VisibilityType& visibility) {
	//#UC START# *48A2CF120127_SET_ACCESSOR*
	m_visibility = visibility;
	//#UC END# *48A2CF120127_SET_ACCESSOR*
}

const std::string& Class::get_stereotype () const {
	//#UC START# *48A2CF46011E_GET_ACCESSOR*
	return m_stereotype;
	//#UC END# *48A2CF46011E_GET_ACCESSOR*
}

void Class::set_stereotype (const std::string& stereotype) {
	//#UC START# *48A2CF46011E_SET_ACCESSOR*
	m_stereotype = stereotype;
	//#UC END# *48A2CF46011E_SET_ACCESSOR*
}

const std::string& Class::get_name () const {
	//#UC START# *48A2CF7400AB_GET_ACCESSOR*
	return m_name;
	//#UC END# *48A2CF7400AB_GET_ACCESSOR*
}

void Class::set_name (const std::string& name) {
	//#UC START# *48A2CF7400AB_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48A2CF7400AB_SET_ACCESSOR*
}

const StringList& Class::get_extends_list () const {
	//#UC START# *48A2E72300B3_GET_ACCESSOR*
	return m_extends_list;
	//#UC END# *48A2E72300B3_GET_ACCESSOR*
}

void Class::set_extends_list (const StringList& extends_list) {
	//#UC START# *48A2E72300B3_SET_ACCESSOR*
	m_extends_list = extends_list;
	//#UC END# *48A2E72300B3_SET_ACCESSOR*
}

const StringList& Class::get_implements_list () const {
	//#UC START# *48A2E7A60013_GET_ACCESSOR*
	return m_implements_list;
	//#UC END# *48A2E7A60013_GET_ACCESSOR*
}

void Class::set_implements_list (const StringList& implements_list) {
	//#UC START# *48A2E7A60013_SET_ACCESSOR*
	m_implements_list = implements_list;
	//#UC END# *48A2E7A60013_SET_ACCESSOR*
}

const ArgumentList& Class::get_template_params () const {
	//#UC START# *48A2EB1601AA_GET_ACCESSOR*
	return m_template_params;
	//#UC END# *48A2EB1601AA_GET_ACCESSOR*
}

void Class::set_template_params (const ArgumentList& template_params) {
	//#UC START# *48A2EB1601AA_SET_ACCESSOR*
	m_template_params = template_params;
	//#UC END# *48A2EB1601AA_SET_ACCESSOR*
}

const ClassContent& Class::get_content () const {
	//#UC START# *48A2E69402B7_GET_ACCESSOR*
	return m_content;
	//#UC END# *48A2E69402B7_GET_ACCESSOR*
}

void Class::set_content (const ClassContent& content) {
	//#UC START# *48A2E69402B7_SET_ACCESSOR*
	m_content = content;
	//#UC END# *48A2E69402B7_SET_ACCESSOR*
}



} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

