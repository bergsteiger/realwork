////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/Attribute.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::Attribute
//
// атрибут
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/Attribute.h"


namespace MDAFormat {
namespace ModelPartDef {

// init ctor
Attribute::Attribute ()
	: m_visibility(VT_PUBLIC)
, m_visibility(AT_REGULAR)
, m_visibility(LT_AGREGATION)
, m_visibility("")
, m_visibility("")
, m_visibility("")
, m_visibility("")
, m_visibility("")
{
	//#UC START# *48A2EB6D0155_DEF_INIT_CTOR*
	//#UC END# *48A2EB6D0155_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const Attribute& item) {
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
	switch (item.get_link_type ()) {
		case LT_AGREGATION: out_stream << "agr" << std::endl;
			break;
		case LT_REFERENCE: out_stream << "ref" << std::endl;
			break;
		case LT_LINK: out_stream << "lnk" << std::endl;
			break;
		default: GDS_ASSERT_MSG(0,("Wrong enum value for link_type attr"));
	}
	out_stream << "attribute" << std::endl;
	if (item.get_stereotype () != "") {
		out_stream << "<<" << item.get_stereotype () << ">>" << std::endl;
	}
	if (item.get_name () != "") {
		out_stream << item.get_name () << std::endl;
	}
	if (item.get_target_type () != "") {
		out_stream << ": " << "\"" << item.get_target_type () << "\"" << std::endl;
	}
	if (item.get_init_value () != "") {
		out_stream << "= " << "\"" << item.get_init_value () << "\"" << std::endl;
	}
	if (item.get_target_stereotype () != "") {
		out_stream << "[" << item.get_target_stereotype () << "]" << std::endl;
	}
	if (item.set_exceptions ().empty () == false) {
		StringList::const_iterator it = item.get_set_exceptions ().begin ();
		StringList::const_iterator it_end = item.get_set_exceptions ().end ();
		out_stream << "throws set : ";
		for (; it != it_end; ++it) {
			out_stream << *it << std::endl;
			if (std::distance (it, it_end) > 1) {
				out_stream << ", ";
			}
		}
		
	}
	if (item.get_excpetions ().empty () == false) {
		StringList::const_iterator it = item.get_get_excpetions ().begin ();
		StringList::const_iterator it_end = item.get_get_excpetions ().end ();
		out_stream << "throws get : ";
		for (; it != it_end; ++it) {
			out_stream << *it << std::endl;
			if (std::distance (it, it_end) > 1) {
				out_stream << ", ";
			}
		}
		
	}
	if (item.get_content ().is_nil () == false) {
		out_stream << *item.get_content () << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const VisibilityType& Attribute::get_visibility () const {
	//#UC START# *48A2ED3E0000_GET_ACCESSOR*
	return m_visibility;
	//#UC END# *48A2ED3E0000_GET_ACCESSOR*
}

void Attribute::set_visibility (const VisibilityType& visibility) {
	//#UC START# *48A2ED3E0000_SET_ACCESSOR*
	m_visibility = visibility;
	//#UC END# *48A2ED3E0000_SET_ACCESSOR*
}

const AbstractionType& Attribute::get_abstractiveness () const {
	//#UC START# *48A2ED550241_GET_ACCESSOR*
	return m_abstractiveness;
	//#UC END# *48A2ED550241_GET_ACCESSOR*
}

void Attribute::set_abstractiveness (const AbstractionType& abstractiveness) {
	//#UC START# *48A2ED550241_SET_ACCESSOR*
	m_abstractiveness = abstractiveness;
	//#UC END# *48A2ED550241_SET_ACCESSOR*
}

const LinkType& Attribute::get_link_type () const {
	//#UC START# *48A2ED63018B_GET_ACCESSOR*
	return m_link_type;
	//#UC END# *48A2ED63018B_GET_ACCESSOR*
}

void Attribute::set_link_type (const LinkType& link_type) {
	//#UC START# *48A2ED63018B_SET_ACCESSOR*
	m_link_type = link_type;
	//#UC END# *48A2ED63018B_SET_ACCESSOR*
}

const std::string& Attribute::get_stereotype () const {
	//#UC START# *48A2EDE4006C_GET_ACCESSOR*
	return m_stereotype;
	//#UC END# *48A2EDE4006C_GET_ACCESSOR*
}

void Attribute::set_stereotype (const std::string& stereotype) {
	//#UC START# *48A2EDE4006C_SET_ACCESSOR*
	m_stereotype = stereotype;
	//#UC END# *48A2EDE4006C_SET_ACCESSOR*
}

const std::string& Attribute::get_name () const {
	//#UC START# *48A2EDE60136_GET_ACCESSOR*
	return m_name;
	//#UC END# *48A2EDE60136_GET_ACCESSOR*
}

void Attribute::set_name (const std::string& name) {
	//#UC START# *48A2EDE60136_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48A2EDE60136_SET_ACCESSOR*
}

const std::string& Attribute::get_target_type () const {
	//#UC START# *48A2EDEE01F6_GET_ACCESSOR*
	return m_target_type;
	//#UC END# *48A2EDEE01F6_GET_ACCESSOR*
}

void Attribute::set_target_type (const std::string& target_type) {
	//#UC START# *48A2EDEE01F6_SET_ACCESSOR*
	m_target_type = target_type;
	//#UC END# *48A2EDEE01F6_SET_ACCESSOR*
}

const std::string& Attribute::get_init_value () const {
	//#UC START# *48A2EE0E026C_GET_ACCESSOR*
	return m_init_value;
	//#UC END# *48A2EE0E026C_GET_ACCESSOR*
}

void Attribute::set_init_value (const std::string& init_value) {
	//#UC START# *48A2EE0E026C_SET_ACCESSOR*
	m_init_value = init_value;
	//#UC END# *48A2EE0E026C_SET_ACCESSOR*
}

const std::string& Attribute::get_target_stereotype () const {
	//#UC START# *48A2EE50011D_GET_ACCESSOR*
	return m_target_stereotype;
	//#UC END# *48A2EE50011D_GET_ACCESSOR*
}

void Attribute::set_target_stereotype (const std::string& target_stereotype) {
	//#UC START# *48A2EE50011D_SET_ACCESSOR*
	m_target_stereotype = target_stereotype;
	//#UC END# *48A2EE50011D_SET_ACCESSOR*
}

const StringList& Attribute::get_set_exceptions () const {
	//#UC START# *48A2EE8F02E4_GET_ACCESSOR*
	return m_set_exceptions;
	//#UC END# *48A2EE8F02E4_GET_ACCESSOR*
}

void Attribute::set_set_exceptions (const StringList& set_exceptions) {
	//#UC START# *48A2EE8F02E4_SET_ACCESSOR*
	m_set_exceptions = set_exceptions;
	//#UC END# *48A2EE8F02E4_SET_ACCESSOR*
}

const StringList& Attribute::get_get_excpetions () const {
	//#UC START# *48A2EEAB0173_GET_ACCESSOR*
	return m_get_excpetions;
	//#UC END# *48A2EEAB0173_GET_ACCESSOR*
}

void Attribute::set_get_excpetions (const StringList& get_excpetions) {
	//#UC START# *48A2EEAB0173_SET_ACCESSOR*
	m_get_excpetions = get_excpetions;
	//#UC END# *48A2EEAB0173_SET_ACCESSOR*
}

const Core::Box<AttributeContent>& Attribute::content () const {
	//#UC START# *48A2EED7030A_GET_ACCESSOR*
	return m_content;
	//#UC END# *48A2EED7030A_GET_ACCESSOR*
}

void Attribute::content (const Core::Box<AttributeContent>& content) {
	//#UC START# *48A2EED7030A_SET_ACCESSOR*
	m_content = content;
	//#UC END# *48A2EED7030A_SET_ACCESSOR*
}



} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

