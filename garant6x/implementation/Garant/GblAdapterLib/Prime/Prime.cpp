////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Prime/Prime.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Prime
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Prime/Prime.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Prime/PrimeFactories.h"

namespace GblAdapterLib {

// factory interface wrapper for Prime
Prime* PrimeFactory::make (
	PrimeKey key
	, const char* name
	, GblFoldersAdap::SavedQueryData query
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return PrimeFactoryManager::Singleton::instance ()->make (key, name, query);
}


const char* UnknownExportError::uid () const /*throw ()*/ {
	return "FF78F730-8F08-45DA-9CE1-3124651BDB7A";
}

const char* UnknownExportError::what () const throw () {
	//#UC START# *496DF8D80017_WHAT_IMPL*
	return "UnknownExportError ()";
	//#UC END# *496DF8D80017_WHAT_IMPL*
}

// factory interface wrapper for PrimeManager
PrimeManager& PrimeManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return PrimeManagerFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for PrimeSettingsManager
PrimeSettingsManager* PrimeSettingsManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return PrimeSettingsManagerFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for PrimeContractData
PrimeContractData* PrimeContractDataFactory::get_contract_data (
	Query* query
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return PrimeContractDataFactoryManager::Singleton::instance ()->get_contract_data (query);
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

