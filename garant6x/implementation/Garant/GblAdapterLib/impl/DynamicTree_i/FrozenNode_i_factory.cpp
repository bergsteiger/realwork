////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FrozenNode_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::FrozenNode_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FrozenNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FrozenNode_i.h"

namespace GblAdapterLib {

FrozenNode_i_factory* FrozenNode_i_factory::s_instance = 0;

FrozenNode_i_factory::FrozenNode_i_factory () {
}

void FrozenNode_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* FrozenNode_i_factory::key () const {
	return "FrozenNode_i";
}

NodeBase* FrozenNode_i_factory::make () /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901C5461A1F2903C8_45F6694A01B5_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45EEB95901C5461A1F2903C8_45F6694A01B5_IMPL*
}

NodeBase* FrozenNode_i_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *45EEB95901C5461A1F2903C8_45FFF849002E_IMPL*
	GDS_ASSERT (false);
	return 0;
	//#UC END# *45EEB95901C5461A1F2903C8_45FFF849002E_IMPL*
}

FrozenNode_i* FrozenNode_iServantFactory::make () /*throw (CanNotFindData)*/ {
	if (FrozenNode_i_factory::s_instance) {
		return dynamic_cast<FrozenNode_i*>(FrozenNode_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::FrozenNode_i_factory");
	}
}

FrozenNode_i* FrozenNode_iServantFactory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	if (FrozenNode_i_factory::s_instance) {
		return dynamic_cast<FrozenNode_i*>(FrozenNode_i_factory::s_instance->make (owner_tree, snode));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree_i::FrozenNode_i_factory");
	}
}

FrozenNode_i* FrozenNode_iServantFactory::make (const DefaultNodeBase* node_to_froze) {
	//#UC START# *461A1F2903C8461A1F2903C8_461A1F2903CE_IMPL*
	return new FrozenNode_i (node_to_froze);
	//#UC END# *461A1F2903C8461A1F2903C8_461A1F2903CE_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

