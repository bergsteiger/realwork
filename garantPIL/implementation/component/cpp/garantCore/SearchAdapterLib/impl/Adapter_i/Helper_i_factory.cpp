////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/Adapter_i/Helper_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garantCore::SearchAdapterLib::Adapter_i::Helper_i
//
// Реализация интерфейса IHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/impl/Adapter_i/Helper_i_factory.h"
#include "garantCore/SearchAdapterLib/impl/Adapter_i/Helper_i.h"

namespace SearchAdapterLib {
namespace Adapter_i {

Helper_i_factory::Helper_i_factory () {
}

void Helper_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Adapter::IHelperFactoryManager::register_factory (this, priority);
}

const char* Helper_i_factory::key () const {
	return "Helper_i";
}

Adapter::IHelper* Helper_i_factory::make (Morpho::Def::ICache* cache) {
	Helper_i_var ret = new Helper_i (cache);
	return ret._retn ();
}

} // namespace Adapter_i
} // namespace SearchAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

