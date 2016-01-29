////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/ClassContent.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::ClassContent
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_CLASSCONTENT_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_CLASSCONTENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Property.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Dependency.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Attribute.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Parameter.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Operation.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ClassDiagram.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateDiagram.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SequenceStartObject.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SequenceDiagram.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/State.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class ClassContent {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const PropertyList& get_properties () const;

	void set_properties (const PropertyList& properties);

	const DependencyList& get_dependecies () const;

	void set_dependecies (const DependencyList& dependecies);

	const SequenceDiagramList& get_sequence_diags () const;

	void set_sequence_diags (const SequenceDiagramList& sequence_diags);

	const SequenceStartObjectList& get_sequence_start_objects () const;

	void set_sequence_start_objects (const SequenceStartObjectList& sequence_start_objects);

	const StateDiagramList& get_state_diags () const;

	void set_state_diags (const StateDiagramList& state_diags);

	const ClassDiagramList& get_class_diags () const;

	void set_class_diags (const ClassDiagramList& class_diags);

	const OperationList& get_operations () const;

	void set_operations (const OperationList& operations);

	const ParameterList& get_template_params () const;

	void set_template_params (const ParameterList& template_params);

	const AttributeList& get_attributres () const;

	void set_attributres (const AttributeList& attributres);

	const ClassList& get_nested_classes () const;

	void set_nested_classes (const ClassList& nested_classes);

	const StateList& get_states () const;

	void set_states (const StateList& states);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	PropertyList m_properties;

	DependencyList m_dependecies;

	SequenceDiagramList m_sequence_diags;

	SequenceStartObjectList m_sequence_start_objects;

	StateDiagramList m_state_diags;

	ClassDiagramList m_class_diags;

	OperationList m_operations;

	ParameterList m_template_params;

	AttributeList m_attributres;

	ClassList m_nested_classes;

	StateList m_states;


}; //class ClassContent

std::ostream& operator << (std::ostream& out_stream, const ClassContent& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_CLASSCONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
