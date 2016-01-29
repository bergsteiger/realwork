////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/SequenceDiagramContent.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::SequenceDiagramContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SequenceDiagramContent.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const SequenceDiagramContent& item) {
	out_stream << "{" << std::endl;
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
const ObjectViewList& SequenceDiagramContent::get_object_views () const {
	//#UC START# *48AC08B501E4_GET_ACCESSOR*
	return m_object_views;
	//#UC END# *48AC08B501E4_GET_ACCESSOR*
}

void SequenceDiagramContent::set_object_views (const ObjectViewList& object_views) {
	//#UC START# *48AC08B501E4_SET_ACCESSOR*
	m_object_views = object_views;
	//#UC END# *48AC08B501E4_SET_ACCESSOR*
}

const MessageViewList& SequenceDiagramContent::get_message_views () const {
	//#UC START# *48AC08C10254_GET_ACCESSOR*
	return m_message_views;
	//#UC END# *48AC08C10254_GET_ACCESSOR*
}

void SequenceDiagramContent::set_message_views (const MessageViewList& message_views) {
	//#UC START# *48AC08C10254_SET_ACCESSOR*
	m_message_views = message_views;
	//#UC END# *48AC08C10254_SET_ACCESSOR*
}

const SelfMessageViewList& SequenceDiagramContent::get_self_message_views () const {
	//#UC START# *48AC08D40259_GET_ACCESSOR*
	return m_self_message_views;
	//#UC END# *48AC08D40259_GET_ACCESSOR*
}

void SequenceDiagramContent::set_self_message_views (const SelfMessageViewList& self_message_views) {
	//#UC START# *48AC08D40259_SET_ACCESSOR*
	m_self_message_views = self_message_views;
	//#UC END# *48AC08D40259_SET_ACCESSOR*
}

const ReturnMessageViewList& SequenceDiagramContent::get_return_message_views () const {
	//#UC START# *48AC08E302E2_GET_ACCESSOR*
	return m_return_message_views;
	//#UC END# *48AC08E302E2_GET_ACCESSOR*
}

void SequenceDiagramContent::set_return_message_views (const ReturnMessageViewList& return_message_views) {
	//#UC START# *48AC08E302E2_SET_ACCESSOR*
	m_return_message_views = return_message_views;
	//#UC END# *48AC08E302E2_SET_ACCESSOR*
}

const PropertyList& SequenceDiagramContent::get_properties () const {
	//#UC START# *48AC08FC002B_GET_ACCESSOR*
	return m_properties;
	//#UC END# *48AC08FC002B_GET_ACCESSOR*
}

void SequenceDiagramContent::set_properties (const PropertyList& properties) {
	//#UC START# *48AC08FC002B_SET_ACCESSOR*
	m_properties = properties;
	//#UC END# *48AC08FC002B_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

