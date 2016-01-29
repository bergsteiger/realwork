////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNode_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNode_i.h"

namespace GblAdapterLib {

UserNode_i_factory* UserNode_i_factory::s_instance = 0;

UserNode_i_factory::UserNode_i_factory () {
}

void UserNode_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ProfileNodeFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* UserNode_i_factory::key () const {
	return "UserNode_i";
}

ProfileNode* UserNode_i_factory::make () {
	//#UC START# *45EED730037A49E46F4802D4_4607D6CC038A_IMPL*
	return new UserNode_i ();
	//#UC END# *45EED730037A49E46F4802D4_4607D6CC038A_IMPL*
}

UserNode_i* UserNode_iServantFactory::make () {
	if (UserNode_i_factory::s_instance) {
		return dynamic_cast<UserNode_i*>(UserNode_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Security_i::UserNode_i_factory");
	}
}

UserNode_i* UserNode_iServantFactory::make (TreeBase* owner_tree, const GTree::Node& snode) {
	//#UC START# *49E46F4802D449E46F4802D4_49E470470021_IMPL*
	return new UserNode_i (owner_tree, snode);
	//#UC END# *49E46F4802D449E46F4802D4_49E470470021_IMPL*
}

UserNode_i* UserNode_iServantFactory::servant_make () {
	//#UC START# *49E46F4802D449E46F4802D4_49E470640058_IMPL*
	return new UserNode_i ();
	//#UC END# *49E46F4802D449E46F4802D4_49E470640058_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

