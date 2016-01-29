////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/ModelPartDef/StateAction.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::StateAction
//
// �������-��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_STATEACTION_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_STATEACTION_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// �������-��������
class StateAction {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const ActionType& get_type () const;

	void set_type (const ActionType& type);

	const std::string& get_name () const;

	void set_name (const std::string& name);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// ��� ��������
	ActionType m_type;

	// ��� ��������
	std::string m_name;


}; //class StateAction

std::ostream& operator << (std::ostream& out_stream, const StateAction& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_STATEACTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
