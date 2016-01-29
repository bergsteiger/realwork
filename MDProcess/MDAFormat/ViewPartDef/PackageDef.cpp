////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/PackageDef.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::PackageDef
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/PackageDef.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const PackageDef& item) {
	out_stream << "package" << std::endl;
	out_stream << item.get_name () << " {" << std::endl;
	if (item.class_diags ().empty () == false) {
		ClassDiagramList::const_iterator it = item.get_class_diags ().begin ();
		ClassDiagramList::const_iterator it_end = item.get_class_diags ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.packages ().empty () == false) {
		PackageDefList::const_iterator it = item.get_packages ().begin ();
		PackageDefList::const_iterator it_end = item.get_packages ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.classes ().empty () == false) {
		ClassDefList::const_iterator it = item.get_classes ().begin ();
		ClassDefList::const_iterator it_end = item.get_classes ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const ClassDiagramList& PackageDef::get_class_diags () const {
	//#UC START# *489061F501CA_GET_ACCESSOR*
	return m_class_diags;
	//#UC END# *489061F501CA_GET_ACCESSOR*
}

void PackageDef::set_class_diags (const ClassDiagramList& class_diags) {
	//#UC START# *489061F501CA_SET_ACCESSOR*
	m_class_diags = class_diags;
	//#UC END# *489061F501CA_SET_ACCESSOR*
}

const std::string& PackageDef::get_name () const {
	//#UC START# *48915A6E015B_GET_ACCESSOR*
	return m_name;
	//#UC END# *48915A6E015B_GET_ACCESSOR*
}

void PackageDef::set_name (const std::string& name) {
	//#UC START# *48915A6E015B_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48915A6E015B_SET_ACCESSOR*
}

const PackageDefList& PackageDef::get_packages () const {
	//#UC START# *48915A8B0004_GET_ACCESSOR*
	return m_packages;
	//#UC END# *48915A8B0004_GET_ACCESSOR*
}

void PackageDef::set_packages (const PackageDefList& packages) {
	//#UC START# *48915A8B0004_SET_ACCESSOR*
	m_packages = packages;
	//#UC END# *48915A8B0004_SET_ACCESSOR*
}

const ClassDefList& PackageDef::get_classes () const {
	//#UC START# *48915AD40219_GET_ACCESSOR*
	return m_classes;
	//#UC END# *48915AD40219_GET_ACCESSOR*
}

void PackageDef::set_classes (const ClassDefList& classes) {
	//#UC START# *48915AD40219_SET_ACCESSOR*
	m_classes = classes;
	//#UC END# *48915AD40219_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

