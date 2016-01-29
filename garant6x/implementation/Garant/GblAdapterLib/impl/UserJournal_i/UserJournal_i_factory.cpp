////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/UserJournal_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::UserJournal_i::UserJournal_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/UserJournal_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/UserJournal_i/UserJournal_i.h"

namespace GblAdapterLib {

UserJournal_i_factory::UserJournal_i_factory () {
}

void UserJournal_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	UserJournalFactoryManager::register_factory (this, priority);
}

const char* UserJournal_i_factory::key () const {
	return "UserJournal_i";
}

UserJournal* UserJournal_i_factory::make () {
	return Core::IObject::_duplicate (UserJournal_i::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

