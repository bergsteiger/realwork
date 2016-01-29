
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/LinkSupport/ConfModelLinks/ConfModelLinks.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::LinkSupport::ConfModelLinks
//
// �����, �������������� ������� �� ���������� � �
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_LINKSUPPORT_CONFMODELLINKS_H__
#define __MDPROCESS_LINKSUPPORT_CONFMODELLINKS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/LinkSupport/ConfModelLinks/ConfModelLinksC.h"

namespace LinkSupport {
namespace ConfModelLinks {

/// factory interface for ShowOnModelMng
class ShowOnModelMngFactory {
public:
	// �������� ��������� ��������������� �����
	static ShowOnModelMng& get ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<ShowOnModelMngFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;

	// for cached factory get
	typedef ACE_Singleton <ShowOnModelMng_var, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectForGet;
	static CORBA::ULong s_cached_object_hash_for_get;

	static Core::Mutex s_mutex_for_get;
};

} // namespace ConfModelLinks
} // namespace LinkSupport


#endif //__MDPROCESS_LINKSUPPORT_CONFMODELLINKS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

