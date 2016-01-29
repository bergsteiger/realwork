////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmListEntry_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::PharmFirmList_i::PharmFirmListEntry_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmListEntry_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmListEntry_i.h"

namespace GblAdapterLib {

PharmFirmListEntry_i_factory* PharmFirmListEntry_i_factory::s_instance = 0;

PharmFirmListEntry_i_factory::PharmFirmListEntry_i_factory () {
}

void PharmFirmListEntry_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	PharmFirmListEntryFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* PharmFirmListEntry_i_factory::key () const {
	return "PharmFirmListEntry_i";
}

PharmFirmListEntry* PharmFirmListEntry_i_factory::make (GCD::ObjectID id) {
	PharmFirmListEntry_i_var ret = new PharmFirmListEntry_i (id);
	return ret._retn ();
}

PharmFirmListEntry_i* PharmFirmListEntry_iServantFactory::make (GCD::ObjectID id) {
	if (PharmFirmListEntry_i_factory::s_instance) {
		return dynamic_cast<PharmFirmListEntry_i*>(PharmFirmListEntry_i_factory::s_instance->make (id));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::PharmFirmList_i::PharmFirmListEntry_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

