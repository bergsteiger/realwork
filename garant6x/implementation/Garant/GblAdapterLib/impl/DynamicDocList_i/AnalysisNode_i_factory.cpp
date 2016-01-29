////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/AnalysisNode_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::AnalysisNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/AnalysisNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/AnalysisNode_i.h"

namespace GblAdapterLib {

AnalysisNode_i_factory* AnalysisNode_i_factory::s_instance = 0;

AnalysisNode_i_factory::AnalysisNode_i_factory () {
}

void AnalysisNode_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* AnalysisNode_i_factory::key () const {
	return "AnalysisNode";
}

NodeBase* AnalysisNode_i_factory::make () /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901C54A9E6EDC03D7_45F6694A01B5_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45EEB95901C54A9E6EDC03D7_45F6694A01B5_IMPL*
}

NodeBase* AnalysisNode_i_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *45EEB95901C54A9E6EDC03D7_45FFF849002E_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45EEB95901C54A9E6EDC03D7_45FFF849002E_IMPL*
}

AnalysisNode_i* AnalysisNode_iServantFactory::make () /*throw (CanNotFindData)*/ {
	if (AnalysisNode_i_factory::s_instance) {
		return dynamic_cast<AnalysisNode_i*>(AnalysisNode_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicDocList_i::AnalysisNode_i_factory");
	}
}

AnalysisNode_i* AnalysisNode_iServantFactory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	if (AnalysisNode_i_factory::s_instance) {
		return dynamic_cast<AnalysisNode_i*>(AnalysisNode_i_factory::s_instance->make (owner_tree, snode));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicDocList_i::AnalysisNode_i_factory");
	}
}

AnalysisNode_i* AnalysisNode_iServantFactory::make (TreeBase* owner_tree, const GTree::Node& node) {
	//#UC START# *4A9E6EDC03D74A9E6EDC03D7_4A9F8A1501E0_IMPL*
	return new AnalysisNode_i (owner_tree, node);
	//#UC END# *4A9E6EDC03D74A9E6EDC03D7_4A9F8A1501E0_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

