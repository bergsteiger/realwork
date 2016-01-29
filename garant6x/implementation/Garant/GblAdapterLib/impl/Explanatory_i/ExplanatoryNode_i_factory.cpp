////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/ExplanatoryNode_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Explanatory_i::ExplanatoryNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/ExplanatoryNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/ExplanatoryNode_i.h"
//#UC START# *45FFE376004ECUSTOM_INLUDE*
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeServerTree.h"
//#UC END# *45FFE376004ECUSTOM_INLUDE*

namespace GblAdapterLib {

ExplanatoryNode_i_factory* ExplanatoryNode_i_factory::s_instance = 0;

ExplanatoryNode_i_factory::ExplanatoryNode_i_factory () {
}

void ExplanatoryNode_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* ExplanatoryNode_i_factory::key () const {
	return "ExplanatoryDiction";
}

NodeBase* ExplanatoryNode_i_factory::make () /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901C545FFE376004E_45F6694A01B5_IMPL*
	TreeBase_var node_tree = NodeServerTree<ExplanatoryNode_i>::make_tree (this->key ());
	if (!node_tree) {
		return 0;
	}
	return dynamic_cast<NodeBase*>(node_tree->root());
	//#UC END# *45EEB95901C545FFE376004E_45F6694A01B5_IMPL*
}

NodeBase* ExplanatoryNode_i_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *45EEB95901C545FFE376004E_45FFF849002E_IMPL*
	ExplanatoryNode_i_var ret = new ExplanatoryNode_i (dynamic_cast<TreeBase*> (owner_tree), snode);
	return ret._retn ();
	//#UC END# *45EEB95901C545FFE376004E_45FFF849002E_IMPL*
}

ExplanatoryNode_i* ExplanatoryNode_iServantFactory::make () /*throw (CanNotFindData)*/ {
	if (ExplanatoryNode_i_factory::s_instance) {
		return dynamic_cast<ExplanatoryNode_i*>(ExplanatoryNode_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Explanatory_i::ExplanatoryNode_i_factory");
	}
}

ExplanatoryNode_i* ExplanatoryNode_iServantFactory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	if (ExplanatoryNode_i_factory::s_instance) {
		return dynamic_cast<ExplanatoryNode_i*>(ExplanatoryNode_i_factory::s_instance->make (owner_tree, snode));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Explanatory_i::ExplanatoryNode_i_factory");
	}
}

ExplanatoryNode_i* ExplanatoryNode_iServantFactory::make_servant (TreeBase* owner_tree, const GTree::Node& snode) {
	//#UC START# *45FFE376004E45FFE376004E_462C9D940109_IMPL*
	ExplanatoryNode_i_var ret = new ExplanatoryNode_i (owner_tree, snode);
	return ret._retn ();
	//#UC END# *45FFE376004E45FFE376004E_462C9D940109_IMPL*
}

ExplanatoryNode_i* ExplanatoryNode_iServantFactory::make_servant () {
	//#UC START# *45FFE376004E45FFE376004E_462CA5AE01D4_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45FFE376004E45FFE376004E_462CA5AE01D4_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

