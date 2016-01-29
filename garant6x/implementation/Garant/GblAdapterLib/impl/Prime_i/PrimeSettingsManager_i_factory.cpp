////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeSettingsManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Prime_i::PrimeSettingsManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeSettingsManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeSettingsManager_i.h"

namespace GblAdapterLib {

PrimeSettingsManager_i_factory::PrimeSettingsManager_i_factory () {
}

void PrimeSettingsManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	PrimeSettingsManagerFactoryManager::register_factory (this, priority);
}

const char* PrimeSettingsManager_i_factory::key () const {
	return "PrimeSettingsManager_i";
}

PrimeSettingsManager* PrimeSettingsManager_i_factory::make () {
	PrimeSettingsManager_i_var ret = new PrimeSettingsManager_i ();
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

