////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/CoreSrv/Security/Security.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::CoreSrv::Security
//
// ��������� ��������� ���������� ���������� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/Security/Security.h"
#include "shared/CoreSrv/Security/SecurityFactories.h"

namespace CoreSrv {

// factory interface wrapper for Session
Session& SessionFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return SessionFactoryManager::Singleton::instance ()->get ();
}

} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

