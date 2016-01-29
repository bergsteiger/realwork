////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/NewsLine_i/NewsLineNode_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::NewsLine_i::NewsLineNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/NewsLine_i/NewsLineNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/NewsLine_i/NewsLineNode_i.h"
//#UC START# *4601093D02EECUSTOM_INLUDE*
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeServerTree.h"
//#UC END# *4601093D02EECUSTOM_INLUDE*

namespace GblAdapterLib {

NewsLineNode_i_factory* NewsLineNode_i_factory::s_instance = 0;

NewsLineNode_i_factory::NewsLineNode_i_factory () {
}

void NewsLineNode_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* NewsLineNode_i_factory::key () const {
	return "AT_NEWS_LINE";
}

NodeBase* NewsLineNode_i_factory::make () /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901C54601093D02EE_45F6694A01B5_IMPL*
	TreeBase_var node_tree = NodeServerTree<NewsLineNode_i>::make_tree (this->key ());
	if (!node_tree) {
		return 0;
	}
	return dynamic_cast<NodeBase*>(node_tree->root ());
	//#UC END# *45EEB95901C54601093D02EE_45F6694A01B5_IMPL*
}

NodeBase* NewsLineNode_i_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *45EEB95901C54601093D02EE_45FFF849002E_IMPL*
	NewsLineNode_i_var ret = new NewsLineNode_i (dynamic_cast<TreeBase*> (owner_tree), snode);
	return ret._retn ();
	//#UC END# *45EEB95901C54601093D02EE_45FFF849002E_IMPL*
}

NewsLineNode_i* NewsLineNode_iServantFactory::make () /*throw (CanNotFindData)*/ {
	if (NewsLineNode_i_factory::s_instance) {
		return dynamic_cast<NewsLineNode_i*>(NewsLineNode_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::NewsLine_i::NewsLineNode_i_factory");
	}
}

NewsLineNode_i* NewsLineNode_iServantFactory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	if (NewsLineNode_i_factory::s_instance) {
		return dynamic_cast<NewsLineNode_i*>(NewsLineNode_i_factory::s_instance->make (owner_tree, snode));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::NewsLine_i::NewsLineNode_i_factory");
	}
}

NewsLineNode_i* NewsLineNode_iServantFactory::make_servant (TreeBase* owner_tree, const GTree::Node& snode) {
	//#UC START# *4601093D02EE4601093D02EE_462DC325033C_IMPL*
	return new NewsLineNode_i (owner_tree, snode);
	//#UC END# *4601093D02EE4601093D02EE_462DC325033C_IMPL*
}

NewsLineNode_i* NewsLineNode_iServantFactory::make_servant () {
	//#UC START# *4601093D02EE4601093D02EE_462DC341034B_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *4601093D02EE4601093D02EE_462DC341034B_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

