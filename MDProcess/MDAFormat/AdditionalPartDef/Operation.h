////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/AdditionalPartDef/Operation.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Operation
//
// �������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_OPERATION_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_OPERATION_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/OperationContent.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// �������� ��������
class Operation {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	const Core::Box<OperationContent>& content () const;

	void content (const Core::Box<OperationContent>& content);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// ��� ��������
	std::string m_name;

	// ���� ��������
	std::string m_guid;

	Core::Box<OperationContent> m_content;


}; //class Operation

std::ostream& operator << (std::ostream& out_stream, const Operation& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_OPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
