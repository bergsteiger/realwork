////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/Package.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::Package
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/Package.h"


namespace MDAFormat {
namespace ModelPartDef {

// init ctor
Package::Package () : m_native(false), m_global(false), m_visibility(VT_PUBLIC) {
	//#UC START# *48A156D80096_DEF_INIT_CTOR*
	//#UC END# *48A156D80096_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const Package& item) {
	if(item.get_native ()) {
		out_stream << "native " << std::endl;
	}
	if(item.get_global ()) {
		out_stream << "global " << std::endl;
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
	out_stream << "package" << std::endl;
	out_stream << "<<" << item.get_stereotype () << ">>" << std::endl;
	out_stream << item.get_name () << " {" << std::endl;
	if (item.nested_packages ().empty () == false) {
		PackageList::const_iterator it = item.get_nested_packages ().begin ();
		PackageList::const_iterator it_end = item.get_nested_packages ().end ();
		
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
	if (item.dependencies ().empty () == false) {
		DependencyList::const_iterator it = item.get_dependencies ().begin ();
		DependencyList::const_iterator it_end = item.get_dependencies ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.classes ().empty () == false) {
		ClassList::const_iterator it = item.get_classes ().begin ();
		ClassList::const_iterator it_end = item.get_classes ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	out_stream << "} ;" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& Package::get_stereotype () const {
	//#UC START# *48A1571A00C7_GET_ACCESSOR*
	return m_stereotype;
	//#UC END# *48A1571A00C7_GET_ACCESSOR*
}

void Package::set_stereotype (const std::string& stereotype) {
	//#UC START# *48A1571A00C7_SET_ACCESSOR*
	m_stereotype = stereotype;
	//#UC END# *48A1571A00C7_SET_ACCESSOR*
}

const std::string& Package::get_name () const {
	//#UC START# *48A15A4302F1_GET_ACCESSOR*
	return m_name;
	//#UC END# *48A15A4302F1_GET_ACCESSOR*
}

void Package::set_name (const std::string& name) {
	//#UC START# *48A15A4302F1_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48A15A4302F1_SET_ACCESSOR*
}

bool Package::get_native () const {
	//#UC START# *48A15B7B0315_GET_ACCESSOR*
	return m_native;
	//#UC END# *48A15B7B0315_GET_ACCESSOR*
}

void Package::set_native (bool native) {
	//#UC START# *48A15B7B0315_SET_ACCESSOR*
	m_native = native;
	//#UC END# *48A15B7B0315_SET_ACCESSOR*
}

bool Package::get_global () const {
	//#UC START# *48A15BCF0025_GET_ACCESSOR*
	return m_global;
	//#UC END# *48A15BCF0025_GET_ACCESSOR*
}

void Package::set_global (bool global) {
	//#UC START# *48A15BCF0025_SET_ACCESSOR*
	m_global = global;
	//#UC END# *48A15BCF0025_SET_ACCESSOR*
}

const VisibilityType& Package::get_visibility () const {
	//#UC START# *48A15BF70008_GET_ACCESSOR*
	return m_visibility;
	//#UC END# *48A15BF70008_GET_ACCESSOR*
}

void Package::set_visibility (const VisibilityType& visibility) {
	//#UC START# *48A15BF70008_SET_ACCESSOR*
	m_visibility = visibility;
	//#UC END# *48A15BF70008_SET_ACCESSOR*
}

const PackageList& Package::get_nested_packages () const {
	//#UC START# *48A15C4D0373_GET_ACCESSOR*
	return m_nested_packages;
	//#UC END# *48A15C4D0373_GET_ACCESSOR*
}

void Package::set_nested_packages (const PackageList& nested_packages) {
	//#UC START# *48A15C4D0373_SET_ACCESSOR*
	m_nested_packages = nested_packages;
	//#UC END# *48A15C4D0373_SET_ACCESSOR*
}

const UserPropertyList& Package::get_user_properties () const {
	//#UC START# *48A15C770217_GET_ACCESSOR*
	return m_user_properties;
	//#UC END# *48A15C770217_GET_ACCESSOR*
}

void Package::set_user_properties (const UserPropertyList& user_properties) {
	//#UC START# *48A15C770217_SET_ACCESSOR*
	m_user_properties = user_properties;
	//#UC END# *48A15C770217_SET_ACCESSOR*
}

const DependencyList& Package::get_dependencies () const {
	//#UC START# *48A15CB6008D_GET_ACCESSOR*
	return m_dependencies;
	//#UC END# *48A15CB6008D_GET_ACCESSOR*
}

void Package::set_dependencies (const DependencyList& dependencies) {
	//#UC START# *48A15CB6008D_SET_ACCESSOR*
	m_dependencies = dependencies;
	//#UC END# *48A15CB6008D_SET_ACCESSOR*
}

const ClassList& Package::get_classes () const {
	//#UC START# *48A2D11C01A9_GET_ACCESSOR*
	return m_classes;
	//#UC END# *48A2D11C01A9_GET_ACCESSOR*
}

void Package::set_classes (const ClassList& classes) {
	//#UC START# *48A2D11C01A9_SET_ACCESSOR*
	m_classes = classes;
	//#UC END# *48A2D11C01A9_SET_ACCESSOR*
}



} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

