////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/AdditionalPartDef/Parameter.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::Parameter
//
// �������� ��������� (�������� ��� ���������� ���������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_PARAMETER_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_PARAMETER_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ParameterContent.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// �������� ��������� (�������� ��� ���������� ���������)
class Parameter {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	const Core::Box<ParameterContent>& content () const;

	void content (const Core::Box<ParameterContent>& content);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// ��� ���������
	std::string m_name;

	// ���� ��������
	std::string m_guid;

	// �������������� ��������
	Core::Box<ParameterContent> m_content;


}; //class Parameter

std::ostream& operator << (std::ostream& out_stream, const Parameter& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_PARAMETER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
