////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Profile_i/StopWatch_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Profile_i::StopWatch_i
// Заголовк реализации фабрик интерфеса StopWatch для серванта StopWatch_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PROFILE_I_STOPWATCH_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_PROFILE_I_STOPWATCH_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Profile/ProfileFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for StopWatch_i
class StopWatch_i_factory: virtual public ::Core::RefCountObjectBase, virtual public StopWatchAbstractFactory {
public:
	StopWatch_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	StopWatch* make (const char* context);

};

typedef ::Core::Var<StopWatch_i_factory> StopWatch_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PROFILE_I_STOPWATCH_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

