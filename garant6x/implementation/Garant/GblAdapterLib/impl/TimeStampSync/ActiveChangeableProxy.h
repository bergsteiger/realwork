////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/ActiveChangeableProxy.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::TimeStampSync::ActiveChangeableProxy
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_TIMESTAMPSYNC_ACTIVECHANGEABLEPROXY_H__
#define __GARANT6X_GBLADAPTERLIB_TIMESTAMPSYNC_ACTIVECHANGEABLEPROXY_H__

#include "shared/CoreSrv/sys/std_inc.h"

//#UC START# *4614E05A0222_CUSTOM_INCLUDES*
#include "garantServer/src/Global/Core/TimeStampSyncC.h"

namespace GblAdapterLib {
	class ActiveChangeable;
}
//#UC END# *4614E05A0222_CUSTOM_INCLUDES*

namespace GblAdapterLib {
namespace TimeStampSync {

class ActiveChangeableProxy;
typedef Core::Var<ActiveChangeableProxy> ActiveChangeableProxy_var;
typedef Core::Var<const ActiveChangeableProxy> ActiveChangeableProxy_cvar;

class ActiveChangeableProxy :
	virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ActiveChangeableProxy)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~ActiveChangeableProxy ();


//#UC START# *4614E05A0222*
public:
	ActiveChangeableProxy (const ::TimeStampSync::TimeStampObjectID& id, GblAdapterLib::ActiveChangeable* active_changeable);
	
	void update_cache (const CORBA::Any* hint);
	void acquire_update_mutex ();
	void release_update_mutex ();	

	void disable ();

private:
	GblAdapterLib::ActiveChangeable* m_active_changeable;
	Core::Mutex m_mutex;
//#UC END# *4614E05A0222*
}; // class ActiveChangeableProxy

} // namespace TimeStampSync
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_TIMESTAMPSYNC_ACTIVECHANGEABLEPROXY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

