////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/UnderControl_i/ControlManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::UnderControl_i::ControlManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UnderControl_i/ControlManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UnderControl_i/ControlManager_i.h"

namespace GblAdapterLib {

ControlManager_i_factory* ControlManager_i_factory::s_instance = 0;

ControlManager_i_factory::ControlManager_i_factory () {
}

void ControlManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ControlManagerFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* ControlManager_i_factory::key () const {
	return "ControlManager_i";
}

ControlManager* ControlManager_i_factory::make () {
	ControlManager_i_var ret = new ControlManager_i ();
	return ret._retn ();
}

ControlManager_i& ControlManager_iServantFactory::make () {
	try {
		return dynamic_cast<ControlManager_i&> (ControlManagerFactory::make ());
	} catch (std::bad_cast& ) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::UnderControl_i::ControlManager_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

