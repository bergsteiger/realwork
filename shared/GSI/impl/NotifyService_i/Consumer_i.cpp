////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GSI/impl/NotifyService_i/Consumer_i.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GSI::NotifyService_i::Consumer_i
//
// �������� ���������� ���������, �� ���� ���������� ����� ����������
// ����� ����������� � ����� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/impl/NotifyService_i/Consumer_i.h"
#include "shared/GSI/impl/NotifyService_i/Environment.h"
// by <<uses>> dependencies
#include "shared/GSI/impl/NotifyService_i/NotifyService_i.h"
#include "shared/GSI/impl/NotifyService_i/NotifyService_iFactories.h"

namespace GSI {
namespace NotifyService_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Consumer_i::~Consumer_i () {
	//#UC START# *46BBFE100399_DESTR_BODY*
	//#UC END# *46BBFE100399_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// �������, �� ������� ��������� ��������� ������� ��������� ��� ����
void Consumer_i::start_listen_common () {
	//#UC START# *46BBFE2403D8*
	m_proxy_for_common_notifies = ManagerLocalFactory::make ().subscribe_for_common (this);
	//#UC END# *46BBFE2403D8*
}

// �������, �� ������� ��������� ��������� ������� ������������
void Consumer_i::start_listen_personal (NotifyService::PersonalID prs_id) {
	//#UC START# *46BBFE2602CE*
	m_proxy_for_personal_notifies = ManagerLocalFactory::make ().subscribe_for_personal (this, prs_id);	
	//#UC END# *46BBFE2602CE*
}

// ������� �� ������� ���������� ���������� ������� ��������� ��� ����
void Consumer_i::stop_listen_common () {
	//#UC START# *46BBFE2801A5*
	if (m_proxy_for_common_notifies.in ()) {
		m_proxy_for_common_notifies->stop_listen ();
		m_proxy_for_common_notifies = 0;
	}
	//#UC END# *46BBFE2801A5*
}

// ������� �� ������� ���������� ���������� ������� ������������ ���������
void Consumer_i::stop_listen_personal () {
	//#UC START# *46BBFE2A003E*
	if (m_proxy_for_personal_notifies.in ()) {
		m_proxy_for_personal_notifies->stop_listen ();
		m_proxy_for_personal_notifies = 0;
	}
	//#UC END# *46BBFE2A003E*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from NotifyService::Consumer
// ��� ��������� ��������� ���������� ����������� ���� �����.
void Consumer_i::fire_event (const CORBA::Any& event) {
	//#UC START# *44A119280119_46BBFE100399*
	GDS_ASSERT_MSG (0, ("Consumer_i::fire_notify: must be implemented in children"));
	//#UC END# *44A119280119_46BBFE100399*
}
} // namespace NotifyService_i
} // namespace GSI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

