////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeContractData_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Prime_i::PrimeContractData_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeContractData_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeContractData_i.h"

namespace GblAdapterLib {

PrimeContractData_i_factory::PrimeContractData_i_factory () {
}

void PrimeContractData_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	PrimeContractDataFactoryManager::register_factory (this, priority);
}

const char* PrimeContractData_i_factory::key () const {
	return "PrimeContractData_i";
}

PrimeContractData* PrimeContractData_i_factory::get_contract_data (Query* query) {
	PrimeContractData_i_var ret = new PrimeContractData_i (query);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

