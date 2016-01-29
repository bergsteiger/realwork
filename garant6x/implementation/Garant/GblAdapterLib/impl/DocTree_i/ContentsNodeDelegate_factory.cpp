////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNodeDelegate_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DocTree_i::ContentsNodeDelegate
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNodeDelegate_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNodeDelegate.h"

namespace GblAdapterLib {

ContentsNodeDelegate_factory* ContentsNodeDelegate_factory::s_instance = 0;

ContentsNodeDelegate_factory::ContentsNodeDelegate_factory () {
}

void ContentsNodeDelegate_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ContentsNodeFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* ContentsNodeDelegate_factory::key () const {
	return "ContentsNodeDelegate";
}

ContentsNode* ContentsNodeDelegate_factory::make () {
	//#UC START# *4C778BE5009C4C9CA5D90231_4C77A470014D_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *4C778BE5009C4C9CA5D90231_4C77A470014D_IMPL*
}

ContentsNodeDelegate* ContentsNodeDelegateServantFactory::make () {
	if (ContentsNodeDelegate_factory::s_instance) {
		return dynamic_cast<ContentsNodeDelegate*>(ContentsNodeDelegate_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DocTree_i::ContentsNodeDelegate_factory");
	}
}

ContentsNodeDelegate* ContentsNodeDelegateServantFactory::make (TreeBase* owner_tree) {
	//#UC START# *4C9CA5D902314C9CA5D90231_4C9CA6C40109_IMPL*
	return new ContentsNodeDelegate (owner_tree);
	//#UC END# *4C9CA5D902314C9CA5D90231_4C9CA6C40109_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

