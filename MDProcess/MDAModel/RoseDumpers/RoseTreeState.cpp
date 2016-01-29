////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseTreeState.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseTreeState
//
// ����� ������������ � ���� ��������� ������ ��������� Rose
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseTreeState.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// default ctor
RoseTreeState::RoseTreeState ()
//#UC START# *46C2E8C70138_BASE_INIT*
//#UC END# *46C2E8C70138_BASE_INIT*
{
	//#UC START# *46C2E8C70138_BODY*
	m_changed = false;
	//#UC END# *46C2E8C70138_BODY*
}

RoseTreeState::~RoseTreeState () {
	//#UC START# *46C2E22A02CE_DESTR_BODY*
	//#UC END# *46C2E22A02CE_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// ���������� ���� ������������
bool RoseTreeState::is_changed () const {
	//#UC START# *46CC11D1003E*
	return m_changed;
	//#UC END# *46CC11D1003E*
}

// ����� ���������� � ���������
void RoseTreeState::reset () {
	//#UC START# *46C2E30103B9*
	m_changed = false;
	//#UC END# *46C2E30103B9*
}

// ��������� ����� �����������
void RoseTreeState::set_changed (bool changed) {
	//#UC START# *46CC1169002E*
	/*if (changed) {
		LOG_D (("RoseTreeState changed"));
	}*/
	m_changed = changed;
	//#UC END# *46CC1169002E*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

