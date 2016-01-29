////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Rubricator_i/RubricatorNode_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Rubricator_i::RubricatorNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Rubricator_i/RubricatorNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Rubricator_i/RubricatorNode_i.h"
//#UC START# *45F5869600A0CUSTOM_INLUDE*
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeServerTree.h"
//#UC END# *45F5869600A0CUSTOM_INLUDE*

namespace GblAdapterLib {

RubricatorNode_i_factory* RubricatorNode_i_factory::s_instance = 0;

RubricatorNode_i_factory::RubricatorNode_i_factory () {
}

void RubricatorNode_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* RubricatorNode_i_factory::key () const {
	return "MainMenu";
}

NodeBase* RubricatorNode_i_factory::make () /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901C545F5869600A0_45F6694A01B5_IMPL*
	TreeBase_var node_tree = NodeServerTree<RubricatorNode_i>::make_tree (this->key ());
	return node_tree.is_nil () ? 0 : dynamic_cast<NodeBase*> (node_tree->root ());
	//#UC END# *45EEB95901C545F5869600A0_45F6694A01B5_IMPL*
}

NodeBase* RubricatorNode_i_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *45EEB95901C545F5869600A0_45FFF849002E_IMPL*
	RubricatorNode_i_var ret = new RubricatorNode_i (owner_tree, snode);
	return ret._retn ();
	//#UC END# *45EEB95901C545F5869600A0_45FFF849002E_IMPL*
}

RubricatorNode_i* RubricatorNode_iServantFactory::make () /*throw (CanNotFindData)*/ {
	if (RubricatorNode_i_factory::s_instance) {
		return dynamic_cast<RubricatorNode_i*>(RubricatorNode_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Rubricator_i::RubricatorNode_i_factory");
	}
}

RubricatorNode_i* RubricatorNode_iServantFactory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	if (RubricatorNode_i_factory::s_instance) {
		return dynamic_cast<RubricatorNode_i*>(RubricatorNode_i_factory::s_instance->make (owner_tree, snode));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Rubricator_i::RubricatorNode_i_factory");
	}
}

RubricatorNode_i* RubricatorNode_iServantFactory::make_servant () {
	//#UC START# *45F5869600A045F5869600A0_462F2CB303A9_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45F5869600A045F5869600A0_462F2CB303A9_IMPL*
}

RubricatorNode_i* RubricatorNode_iServantFactory::make_servant (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *45F5869600A045F5869600A0_462F2CCB034B_IMPL*
	RubricatorNode_i_var ret = new RubricatorNode_i (owner_tree, snode);
	return ret._retn ();
	//#UC END# *45F5869600A045F5869600A0_462F2CCB034B_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

