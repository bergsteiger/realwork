////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/ClassDef.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ViewPartDef::ClassDef
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/ClassDef.h"


namespace MDAFormat {
namespace ViewPartDef {

std::ostream& operator << (std::ostream& out_stream, const ClassDef& item) {
	out_stream << "class" << std::endl;
	out_stream << item.get_name () << " {" << std::endl;
	if (item.classes ().empty () == false) {
		ClassDefList::const_iterator it = item.get_classes ().begin ();
		ClassDefList::const_iterator it_end = item.get_classes ().end ();
		
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
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& ClassDef::get_name () const {
	//#UC START# *48915B9000C0_GET_ACCESSOR*
	return m_name;
	//#UC END# *48915B9000C0_GET_ACCESSOR*
}

void ClassDef::set_name (const std::string& name) {
	//#UC START# *48915B9000C0_SET_ACCESSOR*
	m_name = name;
	//#UC END# *48915B9000C0_SET_ACCESSOR*
}

const ClassDefList& ClassDef::get_classes () const {
	//#UC START# *48915C130337_GET_ACCESSOR*
	return m_classes;
	//#UC END# *48915C130337_GET_ACCESSOR*
}

void ClassDef::set_classes (const ClassDefList& classes) {
	//#UC START# *48915C130337_SET_ACCESSOR*
	m_classes = classes;
	//#UC END# *48915C130337_SET_ACCESSOR*
}

const ClassDiagramList& ClassDef::get_class_diags () const {
	//#UC START# *48915C2801B8_GET_ACCESSOR*
	return m_class_diags;
	//#UC END# *48915C2801B8_GET_ACCESSOR*
}

void ClassDef::set_class_diags (const ClassDiagramList& class_diags) {
	//#UC START# *48915C2801B8_SET_ACCESSOR*
	m_class_diags = class_diags;
	//#UC END# *48915C2801B8_SET_ACCESSOR*
}

const SequenceDiagramList& ClassDef::get_sequence_diags () const {
	//#UC START# *48915C370107_GET_ACCESSOR*
	return m_sequence_diags;
	//#UC END# *48915C370107_GET_ACCESSOR*
}

void ClassDef::set_sequence_diags (const SequenceDiagramList& sequence_diags) {
	//#UC START# *48915C370107_SET_ACCESSOR*
	m_sequence_diags = sequence_diags;
	//#UC END# *48915C370107_SET_ACCESSOR*
}

const StateDiagramList& ClassDef::get_state_diags () const {
	//#UC START# *48915C50038A_GET_ACCESSOR*
	return m_state_diags;
	//#UC END# *48915C50038A_GET_ACCESSOR*
}

void ClassDef::set_state_diags (const StateDiagramList& state_diags) {
	//#UC START# *48915C50038A_SET_ACCESSOR*
	m_state_diags = state_diags;
	//#UC END# *48915C50038A_SET_ACCESSOR*
}



} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

