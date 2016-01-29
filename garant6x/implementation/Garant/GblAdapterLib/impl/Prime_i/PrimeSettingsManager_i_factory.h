////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeSettingsManager_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Prime_i::PrimeSettingsManager_i
// Заголовк реализации фабрик интерфеса PrimeSettingsManager для серванта PrimeSettingsManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMESETTINGSMANAGER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMESETTINGSMANAGER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Prime/PrimeFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for PrimeSettingsManager_i
class PrimeSettingsManager_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public PrimeSettingsManagerAbstractFactory
{
public:
	PrimeSettingsManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	PrimeSettingsManager* make ();

};

typedef ::Core::Var<PrimeSettingsManager_i_factory> PrimeSettingsManager_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMESETTINGSMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

