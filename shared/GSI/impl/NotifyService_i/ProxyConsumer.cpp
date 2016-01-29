////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GSI/impl/NotifyService_i/ProxyConsumer.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GSI::NotifyService_i::ProxyConsumer
//
// �������������� ���������� ���������, ������� ����� � �������� �����������. ������ ���������
// ��������:
// 1. ������-��� ������ ���� ����� �������� ���������� ����� ���� ��������� (����: �������
// ��������� - ���� ����, ����� ������ ��� �������)
// 2.  ���� ������ ���� ���������� �� ������� ������, �� ��� ��������� � ����� ������ ��������� -
// ���������� ��������. � ��� ��� �� ����� ������� �� �� �����, �.�. ������ ���������� �����
// m_mutex, �� ��������� ����������� � ����� ��������� ����� ������ ����� ���� ����� �������� �
// ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/impl/NotifyService_i/ProxyConsumer.h"
#include "shared/GSI/impl/NotifyService_i/Environment.h"
#include "shared/GSI/impl/NotifyService_i/Consumer_i.h"
// by <<uses>> dependencies
#include "shared/GSI/impl/NotifyService_i/NotifyService_i.h"
#include "shared/GSI/impl/NotifyService_i/NotifyService_iFactories.h"
// by <<friend>> dependencies
#include "shared/GSI/impl/NotifyService_i/Consumer_i.h"

namespace GSI {
namespace NotifyService_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// �����������, � ������� ����� ����������� � �������� �����������
ProxyConsumer::ProxyConsumer (Consumer_i* consumer)
//#UC START# *44F2D36603B9_BASE_INIT*
: m_real_consumer (consumer)
//#UC END# *44F2D36603B9_BASE_INIT*
{
	//#UC START# *44F2D36603B9_BODY*
	//#UC END# *44F2D36603B9_BODY*
}

ProxyConsumer::~ProxyConsumer () {
	//#UC START# *44A11A37004E_DESTR_BODY*
	if (0 != m_real_consumer) {
		GDS_ASSERT_MSG (false, ("NotifyService::ProxyConsumer::~ProxyConsumer: consumer not call stop_listen, try to continue"));
		this->stop_listen ();
	}
	//#UC END# *44A11A37004E_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// ������� ���������� ���������� ��� ��������� ���������� ���������
void ProxyConsumer::push_event (const CORBA::Any& event) {
	//#UC START# *44F2C316024A*
	GUARD (m_mutex);
	if (m_real_consumer) {
		Core::Var<Consumer_i> to_avoid_consumer_destruction_while_fire_event (Core::IObject::_duplicate (m_real_consumer)); 

		//ses: ����� ��� ����� �����
		// 1. ������-��� ������ ����� ���� ����� this ����� ���� ��������� (����: ������� ��������� - ���� ����, ����� ������ ��� �������)
		// 2. ���� ������ ���� ���������� �� ������� ������, �� ��� ��������� � ����� ������ ��������� - ���������� ��������.
		// � ��� ��� �� ����� ������� �� �� �����, �.�. ������ ���������� ����� m_mutex, �� ��������� �����������
		// � ����� ��������� ����� ������ ����� ���� ����� �������� � ���������
		// ������ ���� ������ �� ��������.

		try {
			m_real_consumer->fire_event (event);
		} catch (...) {
			GDS_ASSERT ((false, "Error in fire_event"));
		}
	}
	//#UC END# *44F2C316024A*
}

// ���������� ��������� ��������� �� ����������� ���������
void ProxyConsumer::stop_listen () {
	//#UC START# *44F2C3300315*
	{
		GUARD (m_mutex);
		m_real_consumer = 0;
	}
	ManagerLocalFactory::make ().unregister (this);
	//#UC END# *44F2C3300315*
}

} // namespace NotifyService_i
} // namespace GSI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

