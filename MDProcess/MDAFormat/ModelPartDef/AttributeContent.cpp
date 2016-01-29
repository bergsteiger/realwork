////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/AttributeContent.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::AttributeContent
//
// вложенные в трибут элементы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/AttributeContent.h"
#include "MDProcess/MDAFormat/ModelPartDef/Attribute.h"


namespace MDAFormat {
namespace ModelPartDef {

std::ostream& operator << (std::ostream& out_stream, const AttributeContent& item) {
	out_stream << "{" << std::endl;
	if (item.keys ().empty () == false) {
		AttributeList::const_iterator it = item.get_keys ().begin ();
		AttributeList::const_iterator it_end = item.get_keys ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.user_properties ().empty () == false) {
		UserPropertyList::const_iterator it = item.get_user_properties ().begin ();
		UserPropertyList::const_iterator it_end = item.get_user_properties ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const AttributeList& AttributeContent::get_keys () const {
	//#UC START# *48A2ECD70245_GET_ACCESSOR*
	return m_keys;
	//#UC END# *48A2ECD70245_GET_ACCESSOR*
}

void AttributeContent::set_keys (const AttributeList& keys) {
	//#UC START# *48A2ECD70245_SET_ACCESSOR*
	m_keys = keys;
	//#UC END# *48A2ECD70245_SET_ACCESSOR*
}

const UserPropertyList& AttributeContent::get_user_properties () const {
	//#UC START# *48A2ED000048_GET_ACCESSOR*
	return m_user_properties;
	//#UC END# *48A2ED000048_GET_ACCESSOR*
}

void AttributeContent::set_user_properties (const UserPropertyList& user_properties) {
	//#UC START# *48A2ED000048_SET_ACCESSOR*
	m_user_properties = user_properties;
	//#UC END# *48A2ED000048_SET_ACCESSOR*
}



} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

