////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/ModelPartDef/Transition.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::Transition
//
// �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_TRANSITION_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_TRANSITION_H__

#include "shared/Core/sys/std_inc.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// �������
class Transition {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	Transition ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_stereotype () const;

	void set_stereotype (const std::string& stereotype);

	const std::string& get_target_name () const;

	void set_target_name (const std::string& target_name);

	const std::string& get_condition () const;

	void set_condition (const std::string& condition);

	const std::string& get_guard () const;

	void set_guard (const std::string& guard);

	const std::string& get_action () const;

	void set_action (const std::string& action);

	const std::string& get_event () const;

	void set_event (const std::string& event);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	std::string m_stereotype;

	// ��� ��������� � ������� ���������
	std::string m_target_name;

	// ��� ���������������� �������
	std::string m_condition;

	// "������� ��������� � ���������
	std::string m_guard;

	// �������� ��������� � ���������
	std::string m_action;

	// ��� �������� �������
	std::string m_event;


}; //class Transition

std::ostream& operator << (std::ostream& out_stream, const Transition& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_TRANSITION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
