////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ExternalOperation_i/ExternalOperation_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ExternalOperation_i::ExternalOperation_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ExternalOperation_i/ExternalOperation_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ExternalOperation_i/ExternalOperation_i.h"

namespace GblAdapterLib {

ExternalOperation_i_factory::ExternalOperation_i_factory () {
}

void ExternalOperation_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ExternalOperationFactoryManager::register_factory (this, priority);
}

const char* ExternalOperation_i_factory::key () const {
	return "ExternalOperation_i";
}

ExternalOperation* ExternalOperation_i_factory::make (ObjectId id) {
	ExternalOperation_i_var ret = new ExternalOperation_i (id);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

