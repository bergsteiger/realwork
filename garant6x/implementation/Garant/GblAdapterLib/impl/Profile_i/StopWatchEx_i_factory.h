////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Profile_i/StopWatchEx_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Profile_i::StopWatchEx_i
// Заголовк реализации фабрик интерфеса StopWatchEx для серванта StopWatchEx_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PROFILE_I_STOPWATCHEX_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_PROFILE_I_STOPWATCHEX_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Profile/ProfileFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for StopWatchEx_i
class StopWatchEx_i_factory: virtual public ::Core::RefCountObjectBase, virtual public StopWatchExAbstractFactory {
public:
	StopWatchEx_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	StopWatchEx* make (const char* id, const char* context);

};

typedef ::Core::Var<StopWatchEx_i_factory> StopWatchEx_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PROFILE_I_STOPWATCHEX_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

