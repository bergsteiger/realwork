////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/Attribute.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Attribute
//
// описание атрибута
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Attribute.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const Attribute& item) {
	out_stream << "attribute" << std::endl;
	out_stream << item.get_name () << std::endl;
	out_stream << "=> " << "\"" << item.get_guid () << "\"" << std::endl;
	if (item.get_content ().is_nil () == false) {
		out_stream << *item.get_content () << std::endl;
	}
	out_stream << ";" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& Attribute::get_name () const {
	//#UC START# *48ABF60D0184_GET_ACCESSOR*
	return m_name;
	//#UC END# *48ABF60D0184_GET_ACCESSOR*
}

void Attribute::set_name (const std::string& name) {
	//#UC START# *48ABF60D0184_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48ABF60D0184_SET_ACCESSOR*
}

const std::string& Attribute::get_guid () const {
	//#UC START# *48AD3F490145_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48AD3F490145_GET_ACCESSOR*
}

void Attribute::set_guid (const std::string& guid) {
	//#UC START# *48AD3F490145_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48AD3F490145_SET_ACCESSOR*
}

const Core::Box<AttributeContent>& Attribute::content () const {
	//#UC START# *48ABF6970186_GET_ACCESSOR*
	return m_content;
	//#UC END# *48ABF6970186_GET_ACCESSOR*
}

void Attribute::content (const Core::Box<AttributeContent>& content) {
	//#UC START# *48ABF6970186_SET_ACCESSOR*
	m_content = content;
	//#UC END# *48ABF6970186_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

