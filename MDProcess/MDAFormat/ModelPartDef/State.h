////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/ModelPartDef/State.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::State
//
// �������-���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_STATE_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_STATE_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/StateAction.h"
#include "MDProcess/MDAFormat/ModelPartDef/Transition.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// �������-���������
class State {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	State ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const StateType& get_type () const;

	void set_type (const StateType& type);

	const std::string& get_name () const;

	void set_name (const std::string& name);

	const StateActionList& get_actions () const;

	void set_actions (const StateActionList& actions);

	const TransitionList& get_transitions () const;

	void set_transitions (const TransitionList& transitions);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// ��� ���������
	StateType m_type;

	// ��� ���������
	std::string m_name;

	// ������ ��������
	StateActionList m_actions;

	// ������ ���������
	TransitionList m_transitions;


}; //class State

std::ostream& operator << (std::ostream& out_stream, const State& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_STATE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
