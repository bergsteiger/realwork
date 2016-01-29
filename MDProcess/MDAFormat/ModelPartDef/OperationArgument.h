////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/ModelPartDef/OperationArgument.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::OperationArgument
//
// �������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_OPERATIONARGUMENT_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_OPERATIONARGUMENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// �������� ��������
class OperationArgument {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	OperationArgument ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const ArgumentQualifier& get_qualifier () const;

	void set_qualifier (const ArgumentQualifier& qualifier);

	const std::string& get_name () const;

	void set_name (const std::string& name);

	const std::string& get_target_full_name () const;

	void set_target_full_name (const std::string& target_full_name);

	const std::string& get_init_value () const;

	void set_init_value (const std::string& init_value);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// ������������ ��������� ��������
	ArgumentQualifier m_qualifier;

	// ��� ���������
	std::string m_name;

	// ������ ��� ���� ���������
	std::string m_target_full_name;

	// ������� �� ��������� ��� ���������
	std::string m_init_value;


}; //class OperationArgument

std::ostream& operator << (std::ostream& out_stream, const OperationArgument& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_OPERATIONARGUMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
