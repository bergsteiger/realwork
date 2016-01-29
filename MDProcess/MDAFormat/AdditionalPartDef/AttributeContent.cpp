////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/AttributeContent.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::AttributeContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AttributeContent.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Attribute.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const AttributeContent& item) {
	out_stream << "{" << std::endl;
	if (item.attributes ().empty () == false) {
		AttributeList::const_iterator it = item.get_attributes ().begin ();
		AttributeList::const_iterator it_end = item.get_attributes ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.properties ().empty () == false) {
		PropertyList::const_iterator it = item.get_properties ().begin ();
		PropertyList::const_iterator it_end = item.get_properties ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const AttributeList& AttributeContent::get_attributes () const {
	//#UC START# *48ABF6AA0375_GET_ACCESSOR*
	return m_attributes;
	//#UC END# *48ABF6AA0375_GET_ACCESSOR*
}

void AttributeContent::set_attributes (const AttributeList& attributes) {
	//#UC START# *48ABF6AA0375_SET_ACCESSOR*
	m_attributes = attributes;
	//#UC END# *48ABF6AA0375_SET_ACCESSOR*
}

const PropertyList& AttributeContent::get_properties () const {
	//#UC START# *48ABF6B9000D_GET_ACCESSOR*
	return m_properties;
	//#UC END# *48ABF6B9000D_GET_ACCESSOR*
}

void AttributeContent::set_properties (const PropertyList& properties) {
	//#UC START# *48ABF6B9000D_SET_ACCESSOR*
	m_properties = properties;
	//#UC END# *48ABF6B9000D_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

