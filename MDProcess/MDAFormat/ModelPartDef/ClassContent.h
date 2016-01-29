////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/ModelPartDef/ClassContent.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::ClassContent
//
// ���������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_CLASSCONTENT_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_CLASSCONTENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/UserProperty.h"
#include "MDProcess/MDAFormat/ModelPartDef/Dependency.h"
#include "MDProcess/MDAFormat/ModelPartDef/Operation.h"
#include "MDProcess/MDAFormat/ModelPartDef/Attribute.h"
#include "MDProcess/MDAFormat/ModelPartDef/State.h"
#include "MDProcess/MDAFormat/ModelPartDef/SequenceStartObject.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// ���������� ������
class ClassContent {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const OperationList& get_operations () const;

	void set_operations (const OperationList& operations);

	const UserPropertyList& get_user_properties () const;

	void set_user_properties (const UserPropertyList& user_properties);

	const ClassList& get_nested_classes () const;

	void set_nested_classes (const ClassList& nested_classes);

	const DependencyList& get_dependencies () const;

	void set_dependencies (const DependencyList& dependencies);

	const AttributeList& get_atttributes () const;

	void set_atttributes (const AttributeList& atttributes);

	const SequenceStartObjectList& get_sequence_objects () const;

	void set_sequence_objects (const SequenceStartObjectList& sequence_objects);

	const StateList& get_states () const;

	void set_states (const StateList& states);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// ��������
	OperationList m_operations;

	// ���������������� ��������
	UserPropertyList m_user_properties;

	// ������ ��������� �������
	ClassList m_nested_classes;

	// ����� �����������
	DependencyList m_dependencies;

	// �������� ������
	AttributeList m_atttributes;

	// �������� �������-��������
	SequenceStartObjectList m_sequence_objects;

	// ���������
	StateList m_states;


}; //class ClassContent

std::ostream& operator << (std::ostream& out_stream, const ClassContent& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_CLASSCONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
