////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodeBase_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"
//#UC START# *45F7D7F503C8CUSTOM_INLUDE*
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeServerTree.h"
//#UC END# *45F7D7F503C8CUSTOM_INLUDE*

namespace GblAdapterLib {

NodeBase_i_factory* NodeBase_i_factory::s_instance = 0;

NodeBase_i_factory::NodeBase_i_factory () {
}

void NodeBase_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* NodeBase_i_factory::key () const {
	return "NodeBase_i";
}

NodeBase* NodeBase_i_factory::make () /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901C545F7D7F503C8_45F6694A01B5_IMPL*
	//Core::GDS::StopWatchEx sw ("make_interface", "NodeBase_i::make_interface");
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45EEB95901C545F7D7F503C8_45F6694A01B5_IMPL*
}

NodeBase* NodeBase_i_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *45EEB95901C545F7D7F503C8_45FFF849002E_IMPL*
	// XXX: гнуснейший хак, чтоб не генерить зависимость пакета интерфейсов от пакета реализации
	TreeBase* tree = dynamic_cast<TreeBase*> (owner_tree);
	NodeBase_i_var ret = new NodeBase_i (tree, snode);
	return ret._retn ();
	//#UC END# *45EEB95901C545F7D7F503C8_45FFF849002E_IMPL*
}

NodeBase_i* NodeBase_iServantFactory::make () /*throw (CanNotFindData)*/ {
	if (NodeBase_i_factory::s_instance) {
		return dynamic_cast<NodeBase_i*>(NodeBase_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::NodeBase_i_factory");
	}
}

NodeBase_i* NodeBase_iServantFactory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	if (NodeBase_i_factory::s_instance) {
		return dynamic_cast<NodeBase_i*>(NodeBase_i_factory::s_instance->make (owner_tree, snode));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::NodeBase_i_factory");
	}
}

NodeBase_i* NodeBase_iServantFactory::make_servant (TreeBase* owner_tree, const GTree::Node& snode) {
	//#UC START# *45F7D7F503C845F7D7F503C8_45FFFAAD00DA_IMPL*
	return new NodeBase_i (owner_tree, snode);
	//#UC END# *45F7D7F503C845F7D7F503C8_45FFFAAD00DA_IMPL*
}

NodeBase_i* NodeBase_iServantFactory::make_servant () {
	//#UC START# *45F7D7F503C845F7D7F503C8_461DE04001F4_IMPL*
	return new NodeBase_i ();
	//#UC END# *45F7D7F503C845F7D7F503C8_461DE04001F4_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

