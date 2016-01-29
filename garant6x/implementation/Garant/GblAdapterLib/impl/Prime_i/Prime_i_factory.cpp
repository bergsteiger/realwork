////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/Prime_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Prime_i::Prime_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/Prime_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/Prime_i.h"

namespace GblAdapterLib {

Prime_i_factory::Prime_i_factory () {
}

void Prime_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	PrimeFactoryManager::register_factory (this, priority);
}

const char* Prime_i_factory::key () const {
	return "Prime_i";
}

Prime* Prime_i_factory::make (PrimeKey key, const char* name, GblFoldersAdap::SavedQueryData query) {
	Prime_i_var ret = new Prime_i (key, name, query);
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

