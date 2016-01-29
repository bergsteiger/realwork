////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/AdditionalPartDef/OperationContent.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::OperationContent
//
// ���� ��� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_OPERATIONCONTENT_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_OPERATIONCONTENT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Property.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Parameter.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// ���� ��� ������������
class OperationContent {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const PropertyList& get_properties () const;

	void set_properties (const PropertyList& properties);

	const ParameterList& get_parameters () const;

	void set_parameters (const ParameterList& parameters);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// �������������� ��������
	PropertyList m_properties;

	// ��������� ��������
	ParameterList m_parameters;


}; //class OperationContent

std::ostream& operator << (std::ostream& out_stream, const OperationContent& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_OPERATIONCONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
