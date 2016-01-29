////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/PrefixTree_i/PrefixNode_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::PrefixTree_i::PrefixNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PrefixTree_i/PrefixNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PrefixTree_i/PrefixNode_i.h"
//#UC START# *460A7164034BCUSTOM_INLUDE*
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeServerTree.h"
//#UC END# *460A7164034BCUSTOM_INLUDE*

namespace GblAdapterLib {

PrefixNode_i_factory* PrefixNode_i_factory::s_instance = 0;

PrefixNode_i_factory::PrefixNode_i_factory () {
}

void PrefixNode_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* PrefixNode_i_factory::key () const {
	return "CRTree";
}

NodeBase* PrefixNode_i_factory::make () /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901C5460A7164034B_45F6694A01B5_IMPL*
	TreeBase_var node_tree = NodeServerTree<PrefixNode_i>::make_tree (this->key ());
	if (!node_tree) {
		return 0;
	}
	return dynamic_cast<NodeBase*> (node_tree->root());
	//#UC END# *45EEB95901C5460A7164034B_45F6694A01B5_IMPL*
}

NodeBase* PrefixNode_i_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *45EEB95901C5460A7164034B_45FFF849002E_IMPL*
	TreeBase* tree = dynamic_cast <TreeBase*> (owner_tree);
	PrefixNode_i_var ret = new PrefixNode_i (tree, snode);
	return ret._retn ();
	//#UC END# *45EEB95901C5460A7164034B_45FFF849002E_IMPL*
}

PrefixNode_i* PrefixNode_iServantFactory::make () /*throw (CanNotFindData)*/ {
	if (PrefixNode_i_factory::s_instance) {
		return dynamic_cast<PrefixNode_i*>(PrefixNode_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::PrefixTree_i::PrefixNode_i_factory");
	}
}

PrefixNode_i* PrefixNode_iServantFactory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	if (PrefixNode_i_factory::s_instance) {
		return dynamic_cast<PrefixNode_i*>(PrefixNode_i_factory::s_instance->make (owner_tree, snode));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::PrefixTree_i::PrefixNode_i_factory");
	}
}

PrefixNode_i* PrefixNode_iServantFactory::make_servant (TreeBase* owner_tree, const GTree::Node& snode) {
	//#UC START# *460A7164034B460A7164034B_460A73FD0213_IMPL*
	return new PrefixNode_i (owner_tree, snode);
	//#UC END# *460A7164034B460A7164034B_460A73FD0213_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

