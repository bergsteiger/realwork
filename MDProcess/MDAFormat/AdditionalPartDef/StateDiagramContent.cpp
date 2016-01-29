////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/StateDiagramContent.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::StateDiagramContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateDiagramContent.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const StateDiagramContent& item) {
	out_stream << "{" << std::endl;
	if (item.transition_views ().empty () == false) {
		TransitionViewList::const_iterator it = item.get_transition_views ().begin ();
		TransitionViewList::const_iterator it_end = item.get_transition_views ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.state_views ().empty () == false) {
		StateViewList::const_iterator it = item.get_state_views ().begin ();
		StateViewList::const_iterator it_end = item.get_state_views ().end ();
		
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
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const TransitionViewList& StateDiagramContent::get_transition_views () const {
	//#UC START# *48AC00BC0099_GET_ACCESSOR*
	return m_transition_views;
	//#UC END# *48AC00BC0099_GET_ACCESSOR*
}

void StateDiagramContent::set_transition_views (const TransitionViewList& transition_views) {
	//#UC START# *48AC00BC0099_SET_ACCESSOR*
	m_transition_views = transition_views;
	//#UC END# *48AC00BC0099_SET_ACCESSOR*
}

const StateViewList& StateDiagramContent::get_state_views () const {
	//#UC START# *48AC00EB013F_GET_ACCESSOR*
	return m_state_views;
	//#UC END# *48AC00EB013F_GET_ACCESSOR*
}

void StateDiagramContent::set_state_views (const StateViewList& state_views) {
	//#UC START# *48AC00EB013F_SET_ACCESSOR*
	m_state_views = state_views;
	//#UC END# *48AC00EB013F_SET_ACCESSOR*
}

const NoteViewList& StateDiagramContent::get_note_views () const {
	//#UC START# *48AC00FE0125_GET_ACCESSOR*
	return m_note_views;
	//#UC END# *48AC00FE0125_GET_ACCESSOR*
}

void StateDiagramContent::set_note_views (const NoteViewList& note_views) {
	//#UC START# *48AC00FE0125_SET_ACCESSOR*
	m_note_views = note_views;
	//#UC END# *48AC00FE0125_SET_ACCESSOR*
}

const PropertyList& StateDiagramContent::get_properties () const {
	//#UC START# *48AC01050385_GET_ACCESSOR*
	return m_properties;
	//#UC END# *48AC01050385_GET_ACCESSOR*
}

void StateDiagramContent::set_properties (const PropertyList& properties) {
	//#UC START# *48AC01050385_SET_ACCESSOR*
	m_properties = properties;
	//#UC END# *48AC01050385_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

