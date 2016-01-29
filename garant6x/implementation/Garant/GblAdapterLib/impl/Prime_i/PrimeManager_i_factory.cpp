////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Prime_i::PrimeManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeManager_i.h"

namespace GblAdapterLib {

PrimeManager_i_factory::PrimeManager_i_factory () {
}

void PrimeManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	PrimeManagerFactoryManager::register_factory (this, priority);
}

const char* PrimeManager_i_factory::key () const {
	return "PrimeManager_i";
}

PrimeManager* PrimeManager_i_factory::make () {
	PrimeManager_i_var ret = new PrimeManager_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

