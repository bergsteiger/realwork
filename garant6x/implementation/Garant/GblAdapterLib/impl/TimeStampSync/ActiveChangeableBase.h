////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/ActiveChangeableBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::TimeStampSync::ActiveChangeableBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_TIMESTAMPSYNC_ACTIVECHANGEABLEBASE_H__
#define __GARANT6X_GBLADAPTERLIB_TIMESTAMPSYNC_ACTIVECHANGEABLEBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/TimeStampSyncInterface/TimeStampSyncInterface.h"

//#UC START# *4614EBAD0222_CUSTOM_INCLUDES*
#include "garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/ActiveChangeableProxy.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/TimeStampObjectManager.h"
//#UC END# *4614EBAD0222_CUSTOM_INCLUDES*

namespace GblAdapterLib {
namespace TimeStampSync {

class ActiveChangeableBase;
typedef Core::Var<ActiveChangeableBase> ActiveChangeableBase_var;
typedef Core::Var<const ActiveChangeableBase> ActiveChangeableBase_cvar;

class ActiveChangeableBase :
	virtual public ActiveChangeable
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ActiveChangeableBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~ActiveChangeableBase ();


//#UC START# *4614EBAD0222*
public:
	void register_object (const ::TimeStampSync::TimeStampObjectID& id);
	void unregister_object ();
	bool is_registered ();
	
private:
	ActiveChangeableProxy_var m_proxy;
//#UC END# *4614EBAD0222*
}; // class ActiveChangeableBase

} // namespace TimeStampSync
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_TIMESTAMPSYNC_ACTIVECHANGEABLEBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

