////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseTreeState.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseTreeState
//
// ����� ������������ � ���� ��������� ������ ��������� Rose
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSETREESTATE_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSETREESTATE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"


// ����� ������������ � ���� ��������� ������ ��������� Rose
class RoseTreeState {
	SET_OBJECT_COUNTER (RoseTreeState)

	// singleton declaration
	typedef ACE_Singleton <RoseTreeState, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <RoseTreeState, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static RoseTreeState* instance () {
		return Singleton::instance();
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	// default ctor
	RoseTreeState ();

	virtual ~RoseTreeState ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ���������� ���� ������������
	virtual bool is_changed () const;

	// ����� ���������� � ���������
	virtual void reset ();

	// ��������� ����� �����������
	virtual void set_changed (bool changed);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ���� ����������, ��� ������ ���� ����������
	bool m_changed;
}; // class RoseTreeState



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSETREESTATE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

