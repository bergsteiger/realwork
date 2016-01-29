////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/ModelPartDef/ReturnMessage.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::ReturnMessage
//
// ������� �������-���������, ���������� ������������ ��������� �� ������ �������� � �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_RETURNMESSAGE_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_RETURNMESSAGE_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// ������� �������-���������, ���������� ������������ ��������� �� ������ �������� � �������
class ReturnMessage {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_result () const;

	void set_result (const std::string& result);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// ������������ ���������
	std::string m_result;


}; //class ReturnMessage

std::ostream& operator << (std::ostream& out_stream, const ReturnMessage& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_RETURNMESSAGE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
