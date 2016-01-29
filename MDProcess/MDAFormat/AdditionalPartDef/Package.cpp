////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/Package.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Package
//
// описание пакета во вспомогательной части
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Package.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const Package& item) {
	out_stream << "package" << std::endl;
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
const std::string& Package::get_name () const {
	//#UC START# *48ACE5DC0240_GET_ACCESSOR*
	return m_name;
	//#UC END# *48ACE5DC0240_GET_ACCESSOR*
}

void Package::set_name (const std::string& name) {
	//#UC START# *48ACE5DC0240_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48ACE5DC0240_SET_ACCESSOR*
}

const std::string& Package::get_guid () const {
	//#UC START# *48ACE5EB023C_GET_ACCESSOR*
	return m_guid;
	//#UC END# *48ACE5EB023C_GET_ACCESSOR*
}

void Package::set_guid (const std::string& guid) {
	//#UC START# *48ACE5EB023C_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *48ACE5EB023C_SET_ACCESSOR*
}

const Core::Box<PackageContent>& Package::content () const {
	//#UC START# *48ACE6DB01B9_GET_ACCESSOR*
	return m_content;
	//#UC END# *48ACE6DB01B9_GET_ACCESSOR*
}

void Package::content (const Core::Box<PackageContent>& content) {
	//#UC START# *48ACE6DB01B9_SET_ACCESSOR*
	m_content = content;
	//#UC END# *48ACE6DB01B9_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

