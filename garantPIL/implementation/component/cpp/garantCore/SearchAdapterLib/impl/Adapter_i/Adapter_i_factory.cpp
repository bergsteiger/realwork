////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/Adapter_i/Adapter_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garantCore::SearchAdapterLib::Adapter_i::Adapter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/impl/Adapter_i/Adapter_i_factory.h"
#include "garantCore/SearchAdapterLib/impl/Adapter_i/Adapter_i.h"

namespace SearchAdapterLib {
namespace Adapter_i {

Adapter_i_factory::Adapter_i_factory () {
}

void Adapter_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Adapter::IAdapterFactoryManager::register_factory (this, priority);
}

const char* Adapter_i_factory::key () const {
	return "Adapter_i";
}

Adapter::IAdapter* Adapter_i_factory::instance () {
	Adapter_i_var ret = new Adapter_i ();
	return ret._retn ();
}

} // namespace Adapter_i
} // namespace SearchAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

