////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/SequenceDiagram.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::SequenceDiagram
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/SequenceDiagram.h"


namespace MDAFormat {
namespace ViewPartDef {

// init ctor
SequenceDiagram::SequenceDiagram () : m_zoom(100) {
	//#UC START# *489150F50366_DEF_INIT_CTOR*
	//#UC END# *489150F50366_DEF_INIT_CTOR*
}

std::ostream& operator << (std::ostream& out_stream, const SequenceDiagram& item) {
	out_stream << "sequence_diagram" << std::endl;
	out_stream << item.get_name () << " {" << std::endl;
	if (item.get_zoom () != 100) {
		out_stream << "zoom = " << item.get_zoom () << " ;" << std::endl;
	}
	if (item.object_views ().empty () == false) {
		ObjectViewList::const_iterator it = item.get_object_views ().begin ();
		ObjectViewList::const_iterator it_end = item.get_object_views ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.message_views ().empty () == false) {
		MessageViewList::const_iterator it = item.get_message_views ().begin ();
		MessageViewList::const_iterator it_end = item.get_message_views ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.self_message_views ().empty () == false) {
		SelfMessageViewList::const_iterator it = item.get_self_message_views ().begin ();
		SelfMessageViewList::const_iterator it_end = item.get_self_message_views ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.return_message_views ().empty () == false) {
		ReturnMessageViewList::const_iterator it = item.get_return_message_views ().begin ();
		ReturnMessageViewList::const_iterator it_end = item.get_return_message_views ().end ();
		
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
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& SequenceDiagram::get_name () const {
	//#UC START# *48915110029D_GET_ACCESSOR*
	return m_name;
	//#UC END# *48915110029D_GET_ACCESSOR*
}

void SequenceDiagram::set_name (const std::string& name) {
	//#UC START# *48915110029D_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48915110029D_SET_ACCESSOR*
}

int SequenceDiagram::get_zoom () const {
	//#UC START# *4891513103D0_GET_ACCESSOR*
	return m_zoom;
	//#UC END# *4891513103D0_GET_ACCESSOR*
}

void SequenceDiagram::set_zoom (int zoom) {
	//#UC START# *4891513103D0_SET_ACCESSOR*
	m_zoom = zoom;
	//#UC END# *4891513103D0_SET_ACCESSOR*
}

const ObjectViewList& SequenceDiagram::get_object_views () const {
	//#UC START# *4891515402FB_GET_ACCESSOR*
	return m_object_views;
	//#UC END# *4891515402FB_GET_ACCESSOR*
}

void SequenceDiagram::set_object_views (const ObjectViewList& object_views) {
	//#UC START# *4891515402FB_SET_ACCESSOR*
	m_object_views = object_views;
	//#UC END# *4891515402FB_SET_ACCESSOR*
}

const MessageViewList& SequenceDiagram::get_message_views () const {
	//#UC START# *4891516A0148_GET_ACCESSOR*
	return m_message_views;
	//#UC END# *4891516A0148_GET_ACCESSOR*
}

void SequenceDiagram::set_message_views (const MessageViewList& message_views) {
	//#UC START# *4891516A0148_SET_ACCESSOR*
	m_message_views = message_views;
	//#UC END# *4891516A0148_SET_ACCESSOR*
}

const SelfMessageViewList& SequenceDiagram::get_self_message_views () const {
	//#UC START# *489151780238_GET_ACCESSOR*
	return m_self_message_views;
	//#UC END# *489151780238_GET_ACCESSOR*
}

void SequenceDiagram::set_self_message_views (const SelfMessageViewList& self_message_views) {
	//#UC START# *489151780238_SET_ACCESSOR*
	m_self_message_views = self_message_views;
	//#UC END# *489151780238_SET_ACCESSOR*
}

const ReturnMessageViewList& SequenceDiagram::get_return_message_views () const {
	//#UC START# *489151900081_GET_ACCESSOR*
	return m_return_message_views;
	//#UC END# *489151900081_GET_ACCESSOR*
}

void SequenceDiagram::set_return_message_views (const ReturnMessageViewList& return_message_views) {
	//#UC START# *489151900081_SET_ACCESSOR*
	m_return_message_views = return_message_views;
	//#UC END# *489151900081_SET_ACCESSOR*
}

const NoteViewList& SequenceDiagram::get_note_views () const {
	//#UC START# *489151D902E4_GET_ACCESSOR*
	return m_note_views;
	//#UC END# *489151D902E4_GET_ACCESSOR*
}

void SequenceDiagram::set_note_views (const NoteViewList& note_views) {
	//#UC START# *489151D902E4_SET_ACCESSOR*
	m_note_views = note_views;
	//#UC END# *489151D902E4_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

