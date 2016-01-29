////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNodeDelegate_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserNodeDelegate
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNodeDelegate_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNodeDelegate.h"

namespace GblAdapterLib {

UserNodeDelegate_factory* UserNodeDelegate_factory::s_instance = 0;

UserNodeDelegate_factory::UserNodeDelegate_factory () {
}

void UserNodeDelegate_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ProfileNodeFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* UserNodeDelegate_factory::key () const {
	return "UserNodeDelegate";
}

ProfileNode* UserNodeDelegate_factory::make () {
	//#UC START# *45EED730037A49E57FD50219_4607D6CC038A_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45EED730037A49E57FD50219_4607D6CC038A_IMPL*
}

UserNodeDelegate* UserNodeDelegateServantFactory::make () {
	if (UserNodeDelegate_factory::s_instance) {
		return dynamic_cast<UserNodeDelegate*>(UserNodeDelegate_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Security_i::UserNodeDelegate_factory");
	}
}

UserNodeDelegate* UserNodeDelegateServantFactory::make (TreeBase* owner_tree) {
	//#UC START# *49E57FD5021949E57FD50219_49E58127026C_IMPL*
	return new UserNodeDelegate (owner_tree);
	//#UC END# *49E57FD5021949E57FD50219_49E58127026C_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

