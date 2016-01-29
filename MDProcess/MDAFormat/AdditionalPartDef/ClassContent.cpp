////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/ClassContent.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::ClassContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ClassContent.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Class.h"


namespace MDAFormat {
namespace AdditionalPartDef {

std::ostream& operator << (std::ostream& out_stream, const ClassContent& item) {
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
	if (item.sequence_start_objects ().empty () == false) {
		SequenceStartObjectList::const_iterator it = item.get_sequence_start_objects ().begin ();
		SequenceStartObjectList::const_iterator it_end = item.get_sequence_start_objects ().end ();
		
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
	if (item.operations ().empty () == false) {
		OperationList::const_iterator it = item.get_operations ().begin ();
		OperationList::const_iterator it_end = item.get_operations ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.template_params ().empty () == false) {
		ParameterList::const_iterator it = item.get_template_params ().begin ();
		ParameterList::const_iterator it_end = item.get_template_params ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	if (item.attributres ().empty () == false) {
		AttributeList::const_iterator it = item.get_attributres ().begin ();
		AttributeList::const_iterator it_end = item.get_attributres ().end ();
		
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
	if (item.states ().empty () == false) {
		StateList::const_iterator it = item.get_states ().begin ();
		StateList::const_iterator it_end = item.get_states ().end ();
		
		for (; it != it_end; ++it) {
			out_stream << **it << std::endl;
		}
		
	}
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const PropertyList& ClassContent::get_properties () const {
	//#UC START# *48AC097B014C_GET_ACCESSOR*
	return m_properties;
	//#UC END# *48AC097B014C_GET_ACCESSOR*
}

void ClassContent::set_properties (const PropertyList& properties) {
	//#UC START# *48AC097B014C_SET_ACCESSOR*
	m_properties = properties;
	//#UC END# *48AC097B014C_SET_ACCESSOR*
}

const DependencyList& ClassContent::get_dependecies () const {
	//#UC START# *48AC09870135_GET_ACCESSOR*
	return m_dependecies;
	//#UC END# *48AC09870135_GET_ACCESSOR*
}

void ClassContent::set_dependecies (const DependencyList& dependecies) {
	//#UC START# *48AC09870135_SET_ACCESSOR*
	m_dependecies = dependecies;
	//#UC END# *48AC09870135_SET_ACCESSOR*
}

const SequenceDiagramList& ClassContent::get_sequence_diags () const {
	//#UC START# *48AC09940064_GET_ACCESSOR*
	return m_sequence_diags;
	//#UC END# *48AC09940064_GET_ACCESSOR*
}

void ClassContent::set_sequence_diags (const SequenceDiagramList& sequence_diags) {
	//#UC START# *48AC09940064_SET_ACCESSOR*
	m_sequence_diags = sequence_diags;
	//#UC END# *48AC09940064_SET_ACCESSOR*
}

const SequenceStartObjectList& ClassContent::get_sequence_start_objects () const {
	//#UC START# *48AC09AD01D0_GET_ACCESSOR*
	return m_sequence_start_objects;
	//#UC END# *48AC09AD01D0_GET_ACCESSOR*
}

void ClassContent::set_sequence_start_objects (const SequenceStartObjectList& sequence_start_objects) {
	//#UC START# *48AC09AD01D0_SET_ACCESSOR*
	m_sequence_start_objects = sequence_start_objects;
	//#UC END# *48AC09AD01D0_SET_ACCESSOR*
}

const StateDiagramList& ClassContent::get_state_diags () const {
	//#UC START# *48AC09D40393_GET_ACCESSOR*
	return m_state_diags;
	//#UC END# *48AC09D40393_GET_ACCESSOR*
}

void ClassContent::set_state_diags (const StateDiagramList& state_diags) {
	//#UC START# *48AC09D40393_SET_ACCESSOR*
	m_state_diags = state_diags;
	//#UC END# *48AC09D40393_SET_ACCESSOR*
}

const ClassDiagramList& ClassContent::get_class_diags () const {
	//#UC START# *48AC0A0F0311_GET_ACCESSOR*
	return m_class_diags;
	//#UC END# *48AC0A0F0311_GET_ACCESSOR*
}

void ClassContent::set_class_diags (const ClassDiagramList& class_diags) {
	//#UC START# *48AC0A0F0311_SET_ACCESSOR*
	m_class_diags = class_diags;
	//#UC END# *48AC0A0F0311_SET_ACCESSOR*
}

const OperationList& ClassContent::get_operations () const {
	//#UC START# *48AC0A280001_GET_ACCESSOR*
	return m_operations;
	//#UC END# *48AC0A280001_GET_ACCESSOR*
}

void ClassContent::set_operations (const OperationList& operations) {
	//#UC START# *48AC0A280001_SET_ACCESSOR*
	m_operations = operations;
	//#UC END# *48AC0A280001_SET_ACCESSOR*
}

const ParameterList& ClassContent::get_template_params () const {
	//#UC START# *48AC0A3A01FE_GET_ACCESSOR*
	return m_template_params;
	//#UC END# *48AC0A3A01FE_GET_ACCESSOR*
}

void ClassContent::set_template_params (const ParameterList& template_params) {
	//#UC START# *48AC0A3A01FE_SET_ACCESSOR*
	m_template_params = template_params;
	//#UC END# *48AC0A3A01FE_SET_ACCESSOR*
}

const AttributeList& ClassContent::get_attributres () const {
	//#UC START# *48AC0A4C02B5_GET_ACCESSOR*
	return m_attributres;
	//#UC END# *48AC0A4C02B5_GET_ACCESSOR*
}

void ClassContent::set_attributres (const AttributeList& attributres) {
	//#UC START# *48AC0A4C02B5_SET_ACCESSOR*
	m_attributres = attributres;
	//#UC END# *48AC0A4C02B5_SET_ACCESSOR*
}

const ClassList& ClassContent::get_nested_classes () const {
	//#UC START# *48AC0A6600AA_GET_ACCESSOR*
	return m_nested_classes;
	//#UC END# *48AC0A6600AA_GET_ACCESSOR*
}

void ClassContent::set_nested_classes (const ClassList& nested_classes) {
	//#UC START# *48AC0A6600AA_SET_ACCESSOR*
	m_nested_classes = nested_classes;
	//#UC END# *48AC0A6600AA_SET_ACCESSOR*
}

const StateList& ClassContent::get_states () const {
	//#UC START# *48ACEA2A0251_GET_ACCESSOR*
	return m_states;
	//#UC END# *48ACEA2A0251_GET_ACCESSOR*
}

void ClassContent::set_states (const StateList& states) {
	//#UC START# *48ACEA2A0251_SET_ACCESSOR*
	m_states = states;
	//#UC END# *48ACEA2A0251_SET_ACCESSOR*
}



} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

