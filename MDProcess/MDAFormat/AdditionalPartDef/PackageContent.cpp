////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/PackageContent.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::PackageContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/PackageContent.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Package.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const PackageContent& item) {
	out_stream << "{" << std::endl;
	if (item.properties ().empty () == false) {
		PropertyList::const_iterator it = item.get_properties ().begin ();
		PropertyList::const_iterator it_end = item.get_properties ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.dependecies ().empty () == false) {
		DependencyList::const_iterator it = item.get_dependecies ().begin ();
		DependencyList::const_iterator it_end = item.get_dependecies ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.sequence_diags ().empty () == false) {
		SequenceDiagramList::const_iterator it = item.get_sequence_diags ().begin ();
		SequenceDiagramList::const_iterator it_end = item.get_sequence_diags ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.state_diags ().empty () == false) {
		StateDiagramList::const_iterator it = item.get_state_diags ().begin ();
		StateDiagramList::const_iterator it_end = item.get_state_diags ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.class_diags ().empty () == false) {
		ClassDiagramList::const_iterator it = item.get_class_diags ().begin ();
		ClassDiagramList::const_iterator it_end = item.get_class_diags ().end ();
		
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
	if (item.packages ().empty () == false) {
		PackageList::const_iterator it = item.get_packages ().begin ();
		PackageList::const_iterator it_end = item.get_packages ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const PropertyList& PackageContent::get_properties () const {
	//#UC START# *48ACE6510370_GET_ACCESSOR*
	return m_properties;
	//#UC END# *48ACE6510370_GET_ACCESSOR*
}

void PackageContent::set_properties (const PropertyList& properties) {
	//#UC START# *48ACE6510370_SET_ACCESSOR*
	m_properties = properties;
	//#UC END# *48ACE6510370_SET_ACCESSOR*
}

const DependencyList& PackageContent::get_dependecies () const {
	//#UC START# *48ACE6580383_GET_ACCESSOR*
	return m_dependecies;
	//#UC END# *48ACE6580383_GET_ACCESSOR*
}

void PackageContent::set_dependecies (const DependencyList& dependecies) {
	//#UC START# *48ACE6580383_SET_ACCESSOR*
	m_dependecies = dependecies;
	//#UC END# *48ACE6580383_SET_ACCESSOR*
}

const SequenceDiagramList& PackageContent::get_sequence_diags () const {
	//#UC START# *48ACE65D004E_GET_ACCESSOR*
	return m_sequence_diags;
	//#UC END# *48ACE65D004E_GET_ACCESSOR*
}

void PackageContent::set_sequence_diags (const SequenceDiagramList& sequence_diags) {
	//#UC START# *48ACE65D004E_SET_ACCESSOR*
	m_sequence_diags = sequence_diags;
	//#UC END# *48ACE65D004E_SET_ACCESSOR*
}

const StateDiagramList& PackageContent::get_state_diags () const {
	//#UC START# *48ACE66301A6_GET_ACCESSOR*
	return m_state_diags;
	//#UC END# *48ACE66301A6_GET_ACCESSOR*
}

void PackageContent::set_state_diags (const StateDiagramList& state_diags) {
	//#UC START# *48ACE66301A6_SET_ACCESSOR*
	m_state_diags = state_diags;
	//#UC END# *48ACE66301A6_SET_ACCESSOR*
}

const ClassDiagramList& PackageContent::get_class_diags () const {
	//#UC START# *48ACE66902B7_GET_ACCESSOR*
	return m_class_diags;
	//#UC END# *48ACE66902B7_GET_ACCESSOR*
}

void PackageContent::set_class_diags (const ClassDiagramList& class_diags) {
	//#UC START# *48ACE66902B7_SET_ACCESSOR*
	m_class_diags = class_diags;
	//#UC END# *48ACE66902B7_SET_ACCESSOR*
}

const ClassList& PackageContent::get_classes () const {
	//#UC START# *48ACE67001B4_GET_ACCESSOR*
	return m_classes;
	//#UC END# *48ACE67001B4_GET_ACCESSOR*
}

void PackageContent::set_classes (const ClassList& classes) {
	//#UC START# *48ACE67001B4_SET_ACCESSOR*
	m_classes = classes;
	//#UC END# *48ACE67001B4_SET_ACCESSOR*
}

const PackageList& PackageContent::get_packages () const {
	//#UC START# *48ACE6730112_GET_ACCESSOR*
	return m_packages;
	//#UC END# *48ACE6730112_GET_ACCESSOR*
}

void PackageContent::set_packages (const PackageList& packages) {
	//#UC START# *48ACE6730112_SET_ACCESSOR*
	m_packages = packages;
	//#UC END# *48ACE6730112_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

