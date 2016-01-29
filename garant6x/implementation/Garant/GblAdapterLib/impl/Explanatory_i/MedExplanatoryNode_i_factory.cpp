////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/MedExplanatoryNode_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Explanatory_i::MedExplanatoryNode_i
//
// Узел для словарной статьи мед. термина
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/MedExplanatoryNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Explanatory_i/MedExplanatoryNode_i.h"
//#UC START# *47CBBE6301C2CUSTOM_INLUDE*
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeServerTree.h"
//#UC END# *47CBBE6301C2CUSTOM_INLUDE*

namespace GblAdapterLib {

MedExplanatoryNode_i_factory* MedExplanatoryNode_i_factory::s_instance = 0;

MedExplanatoryNode_i_factory::MedExplanatoryNode_i_factory () {
}

void MedExplanatoryNode_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* MedExplanatoryNode_i_factory::key () const {
	return "MedExplanatoryDiction";
}

NodeBase* MedExplanatoryNode_i_factory::make () /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901C547CBBE6301C2_45F6694A01B5_IMPL*
	TreeBase_var node_tree = NodeServerTree<MedExplanatoryNode_i>::make_tree (this->key ());
	if (!node_tree) {
		return 0;
	}
	return dynamic_cast<NodeBase*>(node_tree->root());
	//#UC END# *45EEB95901C547CBBE6301C2_45F6694A01B5_IMPL*
}

NodeBase* MedExplanatoryNode_i_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *45EEB95901C547CBBE6301C2_45FFF849002E_IMPL*
	MedExplanatoryNode_i_var ret = new MedExplanatoryNode_i (dynamic_cast<TreeBase*> (owner_tree), snode);
	return ret._retn ();
	//#UC END# *45EEB95901C547CBBE6301C2_45FFF849002E_IMPL*
}

MedExplanatoryNode_i* MedExplanatoryNode_iServantFactory::make () /*throw (CanNotFindData)*/ {
	if (MedExplanatoryNode_i_factory::s_instance) {
		return dynamic_cast<MedExplanatoryNode_i*>(MedExplanatoryNode_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Explanatory_i::MedExplanatoryNode_i_factory");
	}
}

MedExplanatoryNode_i* MedExplanatoryNode_iServantFactory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	if (MedExplanatoryNode_i_factory::s_instance) {
		return dynamic_cast<MedExplanatoryNode_i*>(MedExplanatoryNode_i_factory::s_instance->make (owner_tree, snode));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Explanatory_i::MedExplanatoryNode_i_factory");
	}
}

MedExplanatoryNode_i* MedExplanatoryNode_iServantFactory::make_servant (TreeBase* owner_tree, const GTree::Node& snode) {
	//#UC START# *47CBBE6301C247CBBE6301C2_47CBC39401D1_IMPL*
	MedExplanatoryNode_i_var ret = new MedExplanatoryNode_i (owner_tree, snode);
	return ret._retn ();
	//#UC END# *47CBBE6301C247CBBE6301C2_47CBC39401D1_IMPL*
}

MedExplanatoryNode_i* MedExplanatoryNode_iServantFactory::make_servant () {
	//#UC START# *47CBBE6301C247CBBE6301C2_47CBC39F020E_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *47CBBE6301C247CBBE6301C2_47CBC39F020E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

