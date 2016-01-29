////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/ClassContent.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::ClassContent
//
// содержимое класса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/ClassContent.h"
#include "MDProcess/MDAFormat/ModelPartDef/Class.h"


namespace MDAFormat {
namespace ModelPartDef {

std::ostream& operator << (std::ostream& out_stream, const ClassContent& item) {
	if (item.operations ().empty () == false) {
		OperationList::const_iterator it = item.get_operations ().begin ();
		OperationList::const_iterator it_end = item.get_operations ().end ();
		
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
	if (item.nested_classes ().empty () == false) {
		ClassList::const_iterator it = item.get_nested_classes ().begin ();
		ClassList::const_iterator it_end = item.get_nested_classes ().end ();
		
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
	if (item.atttributes ().empty () == false) {
		AttributeList::const_iterator it = item.get_atttributes ().begin ();
		AttributeList::const_iterator it_end = item.get_atttributes ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.sequence_objects ().empty () == false) {
		SequenceStartObjectList::const_iterator it = item.get_sequence_objects ().begin ();
		SequenceStartObjectList::const_iterator it_end = item.get_sequence_objects ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.states ().empty () == false) {
		StateList::const_iterator it = item.get_states ().begin ();
		StateList::const_iterator it_end = item.get_states ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}

	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const OperationList& ClassContent::get_operations () const {
	//#UC START# *48A2E6AF01B4_GET_ACCESSOR*
	return m_operations;
	//#UC END# *48A2E6AF01B4_GET_ACCESSOR*
}

void ClassContent::set_operations (const OperationList& operations) {
	//#UC START# *48A2E6AF01B4_SET_ACCESSOR*
	m_operations = operations;
	//#UC END# *48A2E6AF01B4_SET_ACCESSOR*
}

const UserPropertyList& ClassContent::get_user_properties () const {
	//#UC START# *48A2E6B101E1_GET_ACCESSOR*
	return m_user_properties;
	//#UC END# *48A2E6B101E1_GET_ACCESSOR*
}

void ClassContent::set_user_properties (const UserPropertyList& user_properties) {
	//#UC START# *48A2E6B101E1_SET_ACCESSOR*
	m_user_properties = user_properties;
	//#UC END# *48A2E6B101E1_SET_ACCESSOR*
}

const ClassList& ClassContent::get_nested_classes () const {
	//#UC START# *48A2E6B40345_GET_ACCESSOR*
	return m_nested_classes;
	//#UC END# *48A2E6B40345_GET_ACCESSOR*
}

void ClassContent::set_nested_classes (const ClassList& nested_classes) {
	//#UC START# *48A2E6B40345_SET_ACCESSOR*
	m_nested_classes = nested_classes;
	//#UC END# *48A2E6B40345_SET_ACCESSOR*
}

const DependencyList& ClassContent::get_dependencies () const {
	//#UC START# *48A2E6B7018B_GET_ACCESSOR*
	return m_dependencies;
	//#UC END# *48A2E6B7018B_GET_ACCESSOR*
}

void ClassContent::set_dependencies (const DependencyList& dependencies) {
	//#UC START# *48A2E6B7018B_SET_ACCESSOR*
	m_dependencies = dependencies;
	//#UC END# *48A2E6B7018B_SET_ACCESSOR*
}

const AttributeList& ClassContent::get_atttributes () const {
	//#UC START# *48A2EF1203D2_GET_ACCESSOR*
	return m_atttributes;
	//#UC END# *48A2EF1203D2_GET_ACCESSOR*
}

void ClassContent::set_atttributes (const AttributeList& atttributes) {
	//#UC START# *48A2EF1203D2_SET_ACCESSOR*
	m_atttributes = atttributes;
	//#UC END# *48A2EF1203D2_SET_ACCESSOR*
}

const SequenceStartObjectList& ClassContent::get_sequence_objects () const {
	//#UC START# *48ABA8E201E7_GET_ACCESSOR*
	return m_sequence_objects;
	//#UC END# *48ABA8E201E7_GET_ACCESSOR*
}

void ClassContent::set_sequence_objects (const SequenceStartObjectList& sequence_objects) {
	//#UC START# *48ABA8E201E7_SET_ACCESSOR*
	m_sequence_objects = sequence_objects;
	//#UC END# *48ABA8E201E7_SET_ACCESSOR*
}

const StateList& ClassContent::get_states () const {
	//#UC START# *48ABA939028D_GET_ACCESSOR*
	return m_states;
	//#UC END# *48ABA939028D_GET_ACCESSOR*
}

void ClassContent::set_states (const StateList& states) {
	//#UC START# *48ABA939028D_SET_ACCESSOR*
	m_states = states;
	//#UC END# *48ABA939028D_SET_ACCESSOR*
}



} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

