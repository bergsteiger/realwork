////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/TimeStampSyncInterface/TimeStampSyncInterface.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::TimeStampSyncInterface
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_TIMESTAMPSYNCINTERFACE_H__
#define __GARANT6X_GBLADAPTERLIB_TIMESTAMPSYNCINTERFACE_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace GblAdapterLib {

class ActiveChangeable;
typedef ::Core::Var<ActiveChangeable> ActiveChangeable_var;
typedef ::Core::Var<const ActiveChangeable> ActiveChangeable_cvar;
// объект, который может менять своё состояние
class ActiveChangeable
	: virtual public ::Core::IObject
{
public:
	virtual void acquire_update_mutex () = 0;

	virtual void release_update_mutex () = 0;

	virtual void update_cache (const CORBA::Any& hint) = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_TIMESTAMPSYNCINTERFACE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
