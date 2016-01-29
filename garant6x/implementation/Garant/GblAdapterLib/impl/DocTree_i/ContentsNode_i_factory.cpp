////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNode_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DocTree_i::ContentsNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/ContentsNode_i.h"

namespace GblAdapterLib {

ContentsNode_i_factory* ContentsNode_i_factory::s_instance = 0;

ContentsNode_i_factory::ContentsNode_i_factory () {
}

void ContentsNode_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ContentsNodeFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* ContentsNode_i_factory::key () const {
	return "ContentsNode_i";
}

ContentsNode* ContentsNode_i_factory::make () {
	//#UC START# *4C778BE5009C4C778CFA0134_4C77A470014D_IMPL*
	return new ContentsNode_i ();
	//#UC END# *4C778BE5009C4C778CFA0134_4C77A470014D_IMPL*
}

ContentsNode_i* ContentsNode_iServantFactory::make () {
	if (ContentsNode_i_factory::s_instance) {
		return dynamic_cast<ContentsNode_i*>(ContentsNode_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DocTree_i::ContentsNode_i_factory");
	}
}

ContentsNode_i* ContentsNode_iServantFactory::make (TreeBase* owner_tree, const GTree::Node& snode) {
	//#UC START# *4C778CFA01344C778CFA0134_4C77B3A50193_IMPL*
	return new ContentsNode_i (owner_tree, snode);
	//#UC END# *4C778CFA01344C778CFA0134_4C77B3A50193_IMPL*
}

ContentsNode_i* ContentsNode_iServantFactory::make_servant () {
	//#UC START# *4C778CFA01344C778CFA0134_4C77D2FF02C2_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *4C778CFA01344C778CFA0134_4C77D2FF02C2_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

