////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLibDesktop/impl/Start_i/Desktop_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLibDesktop::Start_i::Desktop
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLibDesktop/impl/Start_i/Desktop_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLibDesktop/impl/Start_i/Desktop.h"

namespace GblAdapterLibDesktop {
namespace Start_i {

Desktop_factory::Desktop_factory () {
}

void Desktop_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	GblAdapterLib::ComponentManagerFactoryManager::register_factory (this, priority);
}

const char* Desktop_factory::key () const {
	return "Desktop";
}

GblAdapterLib::ComponentManager* Desktop_factory::make () {
	Desktop_var ret = new Desktop ();
	return ret._retn ();
}

} // namespace Start_i
} // namespace GblAdapterLibDesktop

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

