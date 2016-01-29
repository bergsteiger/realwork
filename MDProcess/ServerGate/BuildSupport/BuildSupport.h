
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/ServerGate/BuildSupport/BuildSupport.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::BuildSupport
//
// ����� ��������� ����������� ��� �������� ������ � �
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SERVERGATE_BUILDSUPPORT_H__
#define __MDPROCESS_SERVERGATE_BUILDSUPPORT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/BuildSupport/BuildSupportC.h"
#include "MDProcess/ServerGate/Contents/Contents.h"

namespace ServerGate {
namespace BuildSupport {

/// factory interface for BuildManager
class BuildManagerFactory {
public:
	// �������� ������� ������.
	static BuildManager& get ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<BuildManagerFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;

	// for cached factory get
	typedef ACE_Singleton <BuildManager_var, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectForGet;
	static CORBA::ULong s_cached_object_hash_for_get;

	static Core::Mutex s_mutex_for_get;
};

} // namespace BuildSupport
} // namespace ServerGate


#endif //__MDPROCESS_SERVERGATE_BUILDSUPPORT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

