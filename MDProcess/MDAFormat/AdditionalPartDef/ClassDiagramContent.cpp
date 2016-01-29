////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/ClassDiagramContent.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::ClassDiagramContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ClassDiagramContent.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const ClassDiagramContent& item) {
	out_stream << "{" << std::endl;
	if (item.class_views ().empty () == false) {
		ClassViewList::const_iterator it = item.get_class_views ().begin ();
		ClassViewList::const_iterator it_end = item.get_class_views ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.inherite_views ().empty () == false) {
		InheriteViewList::const_iterator it = item.get_inherite_views ().begin ();
		InheriteViewList::const_iterator it_end = item.get_inherite_views ().end ();
		
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
	if (item.note_views ().empty () == false) {
		NoteViewList::const_iterator it = item.get_note_views ().begin ();
		NoteViewList::const_iterator it_end = item.get_note_views ().end ();
		
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
	if (item.class_diagram_views ().empty () == false) {
		ClassDiagramViewList::const_iterator it = item.get_class_diagram_views ().begin ();
		ClassDiagramViewList::const_iterator it_end = item.get_class_diagram_views ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.sequence_diagram_views ().empty () == false) {
		SequenceDiagramViewList::const_iterator it = item.get_sequence_diagram_views ().begin ();
		SequenceDiagramViewList::const_iterator it_end = item.get_sequence_diagram_views ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.state_diagram_views ().empty () == false) {
		StateDiagramViewList::const_iterator it = item.get_state_diagram_views ().begin ();
		StateDiagramViewList::const_iterator it_end = item.get_state_diagram_views ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const ClassViewList& ClassDiagramContent::get_class_views () const {
	//#UC START# *48ABFBD60144_GET_ACCESSOR*
	return m_class_views;
	//#UC END# *48ABFBD60144_GET_ACCESSOR*
}

void ClassDiagramContent::set_class_views (const ClassViewList& class_views) {
	//#UC START# *48ABFBD60144_SET_ACCESSOR*
	m_class_views = class_views;
	//#UC END# *48ABFBD60144_SET_ACCESSOR*
}

const InheriteViewList& ClassDiagramContent::get_inherite_views () const {
	//#UC START# *48ABFBE1007A_GET_ACCESSOR*
	return m_inherite_views;
	//#UC END# *48ABFBE1007A_GET_ACCESSOR*
}

void ClassDiagramContent::set_inherite_views (const InheriteViewList& inherite_views) {
	//#UC START# *48ABFBE1007A_SET_ACCESSOR*
	m_inherite_views = inherite_views;
	//#UC END# *48ABFBE1007A_SET_ACCESSOR*
}

const RealizeViewList& ClassDiagramContent::get_realize_views () const {
	//#UC START# *48ABFBF1034C_GET_ACCESSOR*
	return m_realize_views;
	//#UC END# *48ABFBF1034C_GET_ACCESSOR*
}

void ClassDiagramContent::set_realize_views (const RealizeViewList& realize_views) {
	//#UC START# *48ABFBF1034C_SET_ACCESSOR*
	m_realize_views = realize_views;
	//#UC END# *48ABFBF1034C_SET_ACCESSOR*
}

const AssociationViewList& ClassDiagramContent::get_association_views () const {
	//#UC START# *48ABFBFE0035_GET_ACCESSOR*
	return m_association_views;
	//#UC END# *48ABFBFE0035_GET_ACCESSOR*
}

void ClassDiagramContent::set_association_views (const AssociationViewList& association_views) {
	//#UC START# *48ABFBFE0035_SET_ACCESSOR*
	m_association_views = association_views;
	//#UC END# *48ABFBFE0035_SET_ACCESSOR*
}

const NoteViewList& ClassDiagramContent::get_note_views () const {
	//#UC START# *48ABFC1200BC_GET_ACCESSOR*
	return m_note_views;
	//#UC END# *48ABFC1200BC_GET_ACCESSOR*
}

void ClassDiagramContent::set_note_views (const NoteViewList& note_views) {
	//#UC START# *48ABFC1200BC_SET_ACCESSOR*
	m_note_views = note_views;
	//#UC END# *48ABFC1200BC_SET_ACCESSOR*
}

const PropertyList& ClassDiagramContent::get_properties () const {
	//#UC START# *48ABFC4302AF_GET_ACCESSOR*
	return m_properties;
	//#UC END# *48ABFC4302AF_GET_ACCESSOR*
}

void ClassDiagramContent::set_properties (const PropertyList& properties) {
	//#UC START# *48ABFC4302AF_SET_ACCESSOR*
	m_properties = properties;
	//#UC END# *48ABFC4302AF_SET_ACCESSOR*
}

const ClassDiagramViewList& ClassDiagramContent::get_class_diagram_views () const {
	//#UC START# *48AD630003BC_GET_ACCESSOR*
	return m_class_diagram_views;
	//#UC END# *48AD630003BC_GET_ACCESSOR*
}

void ClassDiagramContent::set_class_diagram_views (const ClassDiagramViewList& class_diagram_views) {
	//#UC START# *48AD630003BC_SET_ACCESSOR*
	m_class_diagram_views = class_diagram_views;
	//#UC END# *48AD630003BC_SET_ACCESSOR*
}

const SequenceDiagramViewList& ClassDiagramContent::get_sequence_diagram_views () const {
	//#UC START# *48AD63130266_GET_ACCESSOR*
	return m_sequence_diagram_views;
	//#UC END# *48AD63130266_GET_ACCESSOR*
}

void ClassDiagramContent::set_sequence_diagram_views (const SequenceDiagramViewList& sequence_diagram_views) {
	//#UC START# *48AD63130266_SET_ACCESSOR*
	m_sequence_diagram_views = sequence_diagram_views;
	//#UC END# *48AD63130266_SET_ACCESSOR*
}

const StateDiagramViewList& ClassDiagramContent::get_state_diagram_views () const {
	//#UC START# *48AD632500B4_GET_ACCESSOR*
	return m_state_diagram_views;
	//#UC END# *48AD632500B4_GET_ACCESSOR*
}

void ClassDiagramContent::set_state_diagram_views (const StateDiagramViewList& state_diagram_views) {
	//#UC START# *48AD632500B4_SET_ACCESSOR*
	m_state_diagram_views = state_diagram_views;
	//#UC END# *48AD632500B4_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

