////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfoNode_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Complect_i::ComplectInfoNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfoNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfoNode_i.h"
//#UC START# *457452CE02CECUSTOM_INLUDE*
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeServerTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
//#UC END# *457452CE02CECUSTOM_INLUDE*

namespace GblAdapterLib {

ComplectInfoNode_i_factory* ComplectInfoNode_i_factory::s_instance = 0;

ComplectInfoNode_i_factory::ComplectInfoNode_i_factory () {
}

void ComplectInfoNode_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ComplectInfoNodeFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* ComplectInfoNode_i_factory::key () const {
	return "ComplectInfoNode_i";
}

ComplectInfoNode* ComplectInfoNode_i_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *4574514C030D457452CE02CE_4756A8290044_IMPL*
	return new ComplectInfoNode_i (dynamic_cast<TreeBase*> (owner_tree), snode);
	//#UC END# *4574514C030D457452CE02CE_4756A8290044_IMPL*
}

ComplectInfoNode_i* ComplectInfoNode_iServantFactory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	if (ComplectInfoNode_i_factory::s_instance) {
		return dynamic_cast<ComplectInfoNode_i*>(ComplectInfoNode_i_factory::s_instance->make (owner_tree, snode));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Complect_i::ComplectInfoNode_i_factory");
	}
}

ComplectInfoNode_i* ComplectInfoNode_iServantFactory::make () {
	//#UC START# *457452CE02CE457452CE02CE_4756B62902B3_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *457452CE02CE457452CE02CE_4756B62902B3_IMPL*
}

ComplectInfoNode_i* ComplectInfoNode_iServantFactory::make_servant (TreeBase* owner_tree, const GTree::Node& snode) {
	//#UC START# *457452CE02CE457452CE02CE_462892F202CE_IMPL*
	return new ComplectInfoNode_i (owner_tree, snode);
	//#UC END# *457452CE02CE457452CE02CE_462892F202CE_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

