////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/StateDiagram.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::StateDiagram
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/StateDiagram.h"


namespace MDAFormat {
namespace ViewPartDef {

// init ctor
StateDiagram::StateDiagram () : m_zoom(100) {
	//#UC START# *489156BA03D0_DEF_INIT_CTOR*
	//#UC END# *489156BA03D0_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const StateDiagram& item) {
	out_stream << "state_diagram" << std::endl;
	out_stream << "\"" << item.get_name () << "\"" << " {" << std::endl;
	if (item.state_views ().empty () == false) {
		StateViewList::const_iterator it = item.get_state_views ().begin ();
		StateViewList::const_iterator it_end = item.get_state_views ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.transition_views ().empty () == false) {
		TransitionViewList::const_iterator it = item.get_transition_views ().begin ();
		TransitionViewList::const_iterator it_end = item.get_transition_views ().end ();
		
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
	if (item.get_zoom () != 100) {
		out_stream << "zoom = " << item.get_zoom () << " ;" << std::endl;
	}
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& StateDiagram::get_name () const {
	//#UC START# *489156E103D0_GET_ACCESSOR*
	return m_name;
	//#UC END# *489156E103D0_GET_ACCESSOR*
}

void StateDiagram::set_name (const std::string& name) {
	//#UC START# *489156E103D0_SET_ACCESSOR*
	m_name = name;
	//#UC END# *489156E103D0_SET_ACCESSOR*
}

const StateViewList& StateDiagram::get_state_views () const {
	//#UC START# *489157140141_GET_ACCESSOR*
	return m_state_views;
	//#UC END# *489157140141_GET_ACCESSOR*
}

void StateDiagram::set_state_views (const StateViewList& state_views) {
	//#UC START# *489157140141_SET_ACCESSOR*
	m_state_views = state_views;
	//#UC END# *489157140141_SET_ACCESSOR*
}

const TransitionViewList& StateDiagram::get_transition_views () const {
	//#UC START# *4891572801C9_GET_ACCESSOR*
	return m_transition_views;
	//#UC END# *4891572801C9_GET_ACCESSOR*
}

void StateDiagram::set_transition_views (const TransitionViewList& transition_views) {
	//#UC START# *4891572801C9_SET_ACCESSOR*
	m_transition_views = transition_views;
	//#UC END# *4891572801C9_SET_ACCESSOR*
}

const NoteViewList& StateDiagram::get_note_views () const {
	//#UC START# *4891574902C4_GET_ACCESSOR*
	return m_note_views;
	//#UC END# *4891574902C4_GET_ACCESSOR*
}

void StateDiagram::set_note_views (const NoteViewList& note_views) {
	//#UC START# *4891574902C4_SET_ACCESSOR*
	m_note_views = note_views;
	//#UC END# *4891574902C4_SET_ACCESSOR*
}

int StateDiagram::get_zoom () const {
	//#UC START# *489FF8CC014D_GET_ACCESSOR*
	return m_zoom;
	//#UC END# *489FF8CC014D_GET_ACCESSOR*
}

void StateDiagram::set_zoom (int zoom) {
	//#UC START# *489FF8CC014D_SET_ACCESSOR*
	m_zoom = zoom;
	//#UC END# *489FF8CC014D_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

