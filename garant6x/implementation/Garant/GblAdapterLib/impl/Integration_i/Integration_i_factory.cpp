////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Integration_i/Integration_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Integration_i::Integration_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Integration_i/Integration_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Integration_i/Integration_i.h"

namespace GblAdapterLib {
namespace Integration_i {

Integration_i_factory::Integration_i_factory () {
}

void Integration_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	IntegrationFactoryManager::register_factory (this, priority);
}

const char* Integration_i_factory::key () const {
	return "Integration_i";
}

Integration* Integration_i_factory::make () {
	Integration_i_var ret = new Integration_i ();
	return ret._retn ();
}

} // namespace Integration_i
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

