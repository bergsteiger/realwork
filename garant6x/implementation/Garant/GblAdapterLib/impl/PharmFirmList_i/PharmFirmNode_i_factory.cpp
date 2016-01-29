////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmNode_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::PharmFirmList_i::PharmFirmNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmNode_i.h"
//#UC START# *47E8EB4B0169CUSTOM_INLUDE*
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeServerTree.h"
//#UC END# *47E8EB4B0169CUSTOM_INLUDE*

namespace GblAdapterLib {

PharmFirmNode_i_factory* PharmFirmNode_i_factory::s_instance = 0;

PharmFirmNode_i_factory::PharmFirmNode_i_factory () {
}

void PharmFirmNode_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* PharmFirmNode_i_factory::key () const {
	return AT_PHARM_FIRM;
}

NodeBase* PharmFirmNode_i_factory::make () /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901C547E8EB4B0169_45F6694A01B5_IMPL*
	TreeBase_var node_tree = NodeServerTree<PharmFirmNode_i>::make_tree (this->key ());
	if (!node_tree) {
		return 0;
	}
	return dynamic_cast<NodeBase*>(node_tree->root());
	//#UC END# *45EEB95901C547E8EB4B0169_45F6694A01B5_IMPL*
}

NodeBase* PharmFirmNode_i_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *45EEB95901C547E8EB4B0169_45FFF849002E_IMPL*
	PharmFirmNode_i_var ret = new PharmFirmNode_i (dynamic_cast<TreeBase*> (owner_tree), snode);
	return ret._retn ();
	//#UC END# *45EEB95901C547E8EB4B0169_45FFF849002E_IMPL*
}

PharmFirmNode_i* PharmFirmNode_iServantFactory::make () /*throw (CanNotFindData)*/ {
	if (PharmFirmNode_i_factory::s_instance) {
		return dynamic_cast<PharmFirmNode_i*>(PharmFirmNode_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::PharmFirmList_i::PharmFirmNode_i_factory");
	}
}

PharmFirmNode_i* PharmFirmNode_iServantFactory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	if (PharmFirmNode_i_factory::s_instance) {
		return dynamic_cast<PharmFirmNode_i*>(PharmFirmNode_i_factory::s_instance->make (owner_tree, snode));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::PharmFirmList_i::PharmFirmNode_i_factory");
	}
}

PharmFirmNode_i* PharmFirmNode_iServantFactory::make_servant (TreeBase* owner_tree, const GTree::Node& snode) {
	//#UC START# *47E8EB4B016947E8EB4B0169_47E8EBB70168_IMPL*
	PharmFirmNode_i_var ret = new PharmFirmNode_i (owner_tree, snode);
	return ret._retn ();
	//#UC END# *47E8EB4B016947E8EB4B0169_47E8EBB70168_IMPL*
}

PharmFirmNode_i* PharmFirmNode_iServantFactory::make_servant () {
	//#UC START# *47E8EB4B016947E8EB4B0169_47E8EBCF01ED_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *47E8EB4B016947E8EB4B0169_47E8EBCF01ED_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

