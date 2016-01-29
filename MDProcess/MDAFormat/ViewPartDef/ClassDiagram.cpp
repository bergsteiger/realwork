////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/ClassDiagram.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::ClassDiagram
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/ClassDiagram.h"


namespace MDAFormat {
namespace ViewPartDef {

// init ctor
ClassDiagram::ClassDiagram () : m_zoom(100) {
	//#UC START# *48905C62037A_DEF_INIT_CTOR*
	//#UC END# *48905C62037A_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const ClassDiagram& item) {
	out_stream << "class_diagram" << std::endl;
	out_stream << item.get_name () << " {" << std::endl;
	if (item.get_zoom () != 100) {
		out_stream << "zoom = " << item.get_zoom () << " ;" << std::endl;
	}
	if (item.class_views ().empty () == false) {
		ClassViewList::const_iterator it = item.get_class_views ().begin ();
		ClassViewList::const_iterator it_end = item.get_class_views ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.package_views ().empty () == false) {
		PackageViewList::const_iterator it = item.get_package_views ().begin ();
		PackageViewList::const_iterator it_end = item.get_package_views ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.note_views ().empty () == false) {
		NoteViewList::const_iterator it = item.get_note_views ().begin ();
		NoteViewList::const_iterator it_end = item.get_note_views ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.inherit_views ().empty () == false) {
		InheritViewList::const_iterator it = item.get_inherit_views ().begin ();
		InheritViewList::const_iterator it_end = item.get_inherit_views ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.realize_views ().empty () == false) {
		RealizeViewList::const_iterator it = item.get_realize_views ().begin ();
		RealizeViewList::const_iterator it_end = item.get_realize_views ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.association_views ().empty () == false) {
		AssociationViewList::const_iterator it = item.get_association_views ().begin ();
		AssociationViewList::const_iterator it_end = item.get_association_views ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.class_diags ().empty () == false) {
		ClassDiagramViewList::const_iterator it = item.get_class_diags ().begin ();
		ClassDiagramViewList::const_iterator it_end = item.get_class_diags ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.sequence_diags ().empty () == false) {
		SequenceDiagramViewList::const_iterator it = item.get_sequence_diags ().begin ();
		SequenceDiagramViewList::const_iterator it_end = item.get_sequence_diags ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.state_diags ().empty () == false) {
		StateDiagramViewList::const_iterator it = item.get_state_diags ().begin ();
		StateDiagramViewList::const_iterator it_end = item.get_state_diags ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.dependencies ().empty () == false) {
		DependencyViewList::const_iterator it = item.get_dependencies ().begin ();
		DependencyViewList::const_iterator it_end = item.get_dependencies ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& ClassDiagram::get_name () const {
	//#UC START# *48905C860162_GET_ACCESSOR*
	return m_name;
	//#UC END# *48905C860162_GET_ACCESSOR*
}

void ClassDiagram::set_name (const std::string& name) {
	//#UC START# *48905C860162_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48905C860162_SET_ACCESSOR*
}

int ClassDiagram::get_zoom () const {
	//#UC START# *48905CA401F2_GET_ACCESSOR*
	return m_zoom;
	//#UC END# *48905CA401F2_GET_ACCESSOR*
}

void ClassDiagram::set_zoom (int zoom) {
	//#UC START# *48905CA401F2_SET_ACCESSOR*
	m_zoom = zoom;
	//#UC END# *48905CA401F2_SET_ACCESSOR*
}

const ClassViewList& ClassDiagram::get_class_views () const {
	//#UC START# *4890617401C0_GET_ACCESSOR*
	return m_class_views;
	//#UC END# *4890617401C0_GET_ACCESSOR*
}

void ClassDiagram::set_class_views (const ClassViewList& class_views) {
	//#UC START# *4890617401C0_SET_ACCESSOR*
	m_class_views = class_views;
	//#UC END# *4890617401C0_SET_ACCESSOR*
}

const PackageViewList& ClassDiagram::get_package_views () const {
	//#UC START# *489161E401A2_GET_ACCESSOR*
	return m_package_views;
	//#UC END# *489161E401A2_GET_ACCESSOR*
}

void ClassDiagram::set_package_views (const PackageViewList& package_views) {
	//#UC START# *489161E401A2_SET_ACCESSOR*
	m_package_views = package_views;
	//#UC END# *489161E401A2_SET_ACCESSOR*
}

const NoteViewList& ClassDiagram::get_note_views () const {
	//#UC START# *4890618E026B_GET_ACCESSOR*
	return m_note_views;
	//#UC END# *4890618E026B_GET_ACCESSOR*
}

void ClassDiagram::set_note_views (const NoteViewList& note_views) {
	//#UC START# *4890618E026B_SET_ACCESSOR*
	m_note_views = note_views;
	//#UC END# *4890618E026B_SET_ACCESSOR*
}

const InheritViewList& ClassDiagram::get_inherit_views () const {
	//#UC START# *48914C960003_GET_ACCESSOR*
	return m_inherit_views;
	//#UC END# *48914C960003_GET_ACCESSOR*
}

void ClassDiagram::set_inherit_views (const InheritViewList& inherit_views) {
	//#UC START# *48914C960003_SET_ACCESSOR*
	m_inherit_views = inherit_views;
	//#UC END# *48914C960003_SET_ACCESSOR*
}

const RealizeViewList& ClassDiagram::get_realize_views () const {
	//#UC START# *4891507902C9_GET_ACCESSOR*
	return m_realize_views;
	//#UC END# *4891507902C9_GET_ACCESSOR*
}

void ClassDiagram::set_realize_views (const RealizeViewList& realize_views) {
	//#UC START# *4891507902C9_SET_ACCESSOR*
	m_realize_views = realize_views;
	//#UC END# *4891507902C9_SET_ACCESSOR*
}

const AssociationViewList& ClassDiagram::get_association_views () const {
	//#UC START# *4891509003CA_GET_ACCESSOR*
	return m_association_views;
	//#UC END# *4891509003CA_GET_ACCESSOR*
}

void ClassDiagram::set_association_views (const AssociationViewList& association_views) {
	//#UC START# *4891509003CA_SET_ACCESSOR*
	m_association_views = association_views;
	//#UC END# *4891509003CA_SET_ACCESSOR*
}

const ClassDiagramViewList& ClassDiagram::get_class_diags () const {
	//#UC START# *48915E9F008C_GET_ACCESSOR*
	return m_class_diags;
	//#UC END# *48915E9F008C_GET_ACCESSOR*
}

void ClassDiagram::set_class_diags (const ClassDiagramViewList& class_diags) {
	//#UC START# *48915E9F008C_SET_ACCESSOR*
	m_class_diags = class_diags;
	//#UC END# *48915E9F008C_SET_ACCESSOR*
}

const SequenceDiagramViewList& ClassDiagram::get_sequence_diags () const {
	//#UC START# *48915EBE02A1_GET_ACCESSOR*
	return m_sequence_diags;
	//#UC END# *48915EBE02A1_GET_ACCESSOR*
}

void ClassDiagram::set_sequence_diags (const SequenceDiagramViewList& sequence_diags) {
	//#UC START# *48915EBE02A1_SET_ACCESSOR*
	m_sequence_diags = sequence_diags;
	//#UC END# *48915EBE02A1_SET_ACCESSOR*
}

const StateDiagramViewList& ClassDiagram::get_state_diags () const {
	//#UC START# *48915ED303BC_GET_ACCESSOR*
	return m_state_diags;
	//#UC END# *48915ED303BC_GET_ACCESSOR*
}

void ClassDiagram::set_state_diags (const StateDiagramViewList& state_diags) {
	//#UC START# *48915ED303BC_SET_ACCESSOR*
	m_state_diags = state_diags;
	//#UC END# *48915ED303BC_SET_ACCESSOR*
}

const DependencyViewList& ClassDiagram::get_dependencies () const {
	//#UC START# *48BBCA7F0054_GET_ACCESSOR*
	return m_dependencies;
	//#UC END# *48BBCA7F0054_GET_ACCESSOR*
}

void ClassDiagram::set_dependencies (const DependencyViewList& dependencies) {
	//#UC START# *48BBCA7F0054_SET_ACCESSOR*
	m_dependencies = dependencies;
	//#UC END# *48BBCA7F0054_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

