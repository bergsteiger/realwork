////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeManager_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Prime_i::PrimeManager_i
// Заголовк реализации фабрик интерфеса PrimeManager для серванта PrimeManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMEMANAGER_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMEMANAGER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Prime/PrimeFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for PrimeManager_i
class PrimeManager_i_factory: virtual public ::Core::RefCountObjectBase, virtual public PrimeManagerAbstractFactory {
public:
	PrimeManager_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	PrimeManager* make ();

};

typedef ::Core::Var<PrimeManager_i_factory> PrimeManager_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMEMANAGER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

