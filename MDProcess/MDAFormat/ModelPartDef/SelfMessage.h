////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/ModelPartDef/SelfMessage.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::SelfMessage
//
// ������� �������-���������, ���������� ���������, ���������� �������� �� ����� ����.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_SELFMESSAGE_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_SELFMESSAGE_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// ������� �������-���������, ���������� ���������, ���������� �������� �� ����� ����.
class SelfMessage {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_operation () const;

	void set_operation (const std::string& operation);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// ��� ���������� �������� � �����������
	std::string m_operation;


}; //class SelfMessage

std::ostream& operator << (std::ostream& out_stream, const SelfMessage& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_SELFMESSAGE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
