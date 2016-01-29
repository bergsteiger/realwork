////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FilteredTreeNode_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::FilteredTreeNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FilteredTreeNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FilteredTreeNode_i.h"

namespace GblAdapterLib {

FilteredTreeNode_i_factory* FilteredTreeNode_i_factory::s_instance = 0;

FilteredTreeNode_i_factory::FilteredTreeNode_i_factory () {
}

void FilteredTreeNode_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* FilteredTreeNode_i_factory::key () const {
	return "FilteredTreeNode_i";
}

NodeBase* FilteredTreeNode_i_factory::make () /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901C54DB15A950379_45F6694A01B5_IMPL*
	return make_filtered_tree_and_root (this->key ());
	//#UC END# *45EEB95901C54DB15A950379_45F6694A01B5_IMPL*
}

NodeBase* FilteredTreeNode_i_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *45EEB95901C54DB15A950379_45FFF849002E_IMPL*
	FilteredTreeNode_i_var ret = new FilteredTreeNode_i (dynamic_cast <TreeBase*> (owner_tree), snode);
	return ret._retn ();
	//#UC END# *45EEB95901C54DB15A950379_45FFF849002E_IMPL*
}

FilteredTreeNode_i* FilteredTreeNode_iServantFactory::make () /*throw (CanNotFindData)*/ {
	if (FilteredTreeNode_i_factory::s_instance) {
		return dynamic_cast<FilteredTreeNode_i*>(FilteredTreeNode_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::FilteredTreeNode_i_factory");
	}
}

FilteredTreeNode_i* FilteredTreeNode_iServantFactory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	if (FilteredTreeNode_i_factory::s_instance) {
		return dynamic_cast<FilteredTreeNode_i*>(FilteredTreeNode_i_factory::s_instance->make (owner_tree, snode));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::FilteredTreeNode_i_factory");
	}
}

FilteredTreeNode_i* FilteredTreeNode_iServantFactory::make (TreeBase* owner_tree, const GTree::Node& snode) {
	//#UC START# *4DB15A9503794DB15A950379_4DB162C303D3_IMPL*
	return new FilteredTreeNode_i (owner_tree, snode);
	//#UC END# *4DB15A9503794DB15A950379_4DB162C303D3_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

