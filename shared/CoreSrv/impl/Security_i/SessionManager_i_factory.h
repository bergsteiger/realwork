////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/CoreSrv/impl/Security_i/SessionManager_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Security_i::SessionManager_i
// �������� ���������� ������ ��������� SessionManager ��� �������� SessionManager_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_SECURITY_I_SESSIONMANAGER_I_FCTR_H__
#define __SHARED_CORESRV_SECURITY_I_SESSIONMANAGER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/SecuritySrv/SecuritySrvFactories.h"

namespace CoreSrv {
namespace Security_i {

/// Interface-factory implementation for SessionManager_i
class SessionManager_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public SecuritySrv::SessionManagerAbstractFactory
{
public:
	SessionManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	SecuritySrv::SessionManager* get ();

};

typedef ::Core::Var<SessionManager_i_factory> SessionManager_i_factory_var;

} // namespace Security_i
} // namespace CoreSrv


#endif //__SHARED_CORESRV_SECURITY_I_SESSIONMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

