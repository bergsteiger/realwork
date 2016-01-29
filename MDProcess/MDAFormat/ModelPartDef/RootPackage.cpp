////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/RootPackage.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::RootPackage
//
// рутовый пакет
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/RootPackage.h"


namespace MDAFormat {
namespace ModelPartDef {

std::ostream& operator << (std::ostream& out_stream, const RootPackage& item) {
	if (item.namepsaces ().empty () == false) {
		NamespaceList::const_iterator it = item.get_namepsaces ().begin ();
		NamespaceList::const_iterator it_end = item.get_namepsaces ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	out_stream << item.get_root () << std::endl;

	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const NamespaceList& RootPackage::get_namepsaces () const {
	//#UC START# *48AD2A4B0054_GET_ACCESSOR*
	return m_namepsaces;
	//#UC END# *48AD2A4B0054_GET_ACCESSOR*
}

void RootPackage::set_namepsaces (const NamespaceList& namepsaces) {
	//#UC START# *48AD2A4B0054_SET_ACCESSOR*
	m_namepsaces = namepsaces;
	//#UC END# *48AD2A4B0054_SET_ACCESSOR*
}

const Package& RootPackage::get_root () const {
	//#UC START# *48AD2A65033C_GET_ACCESSOR*
	return m_root;
	//#UC END# *48AD2A65033C_GET_ACCESSOR*
}

void RootPackage::set_root (const Package& root) {
	//#UC START# *48AD2A65033C_SET_ACCESSOR*
	m_root = root;
	//#UC END# *48AD2A65033C_SET_ACCESSOR*
}

const std::string& RootPackage::get_file_name () const {
	return m_file_name;
}

void RootPackage::set_file_name (const std::string& file_name) {
	m_file_name = file_name;
}

} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

