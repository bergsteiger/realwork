////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Profile/Profile.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Profile
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PROFILE_H__
#define __GARANT6X_GBLADAPTERLIB_PROFILE_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace GblAdapterLib {

class StopWatch;
typedef ::Core::Var<StopWatch> StopWatch_var;
typedef ::Core::Var<const StopWatch> StopWatch_cvar;
class StopWatch
	: virtual public ::Core::IObject
{
};

/// factory interface for StopWatch
class StopWatchFactory {
public:
	static StopWatch* make (const char* context)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class StopWatchEx;
typedef ::Core::Var<StopWatchEx> StopWatchEx_var;
typedef ::Core::Var<const StopWatchEx> StopWatchEx_cvar;
class StopWatchEx
	: virtual public ::Core::IObject
{
};

/// factory interface for StopWatchEx
class StopWatchExFactory {
public:
	static StopWatchEx* make (const char* id, const char* context)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::StopWatch> {
	typedef GblAdapterLib::StopWatchFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::StopWatchEx> {
	typedef GblAdapterLib::StopWatchExFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_PROFILE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
