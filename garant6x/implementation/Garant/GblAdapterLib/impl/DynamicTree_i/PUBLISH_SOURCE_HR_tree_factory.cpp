////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PUBLISH_SOURCE_HR_tree_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::PUBLISH_SOURCE_HR_tree
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PUBLISH_SOURCE_HR_tree_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/PUBLISH_SOURCE_HR_tree.h"

namespace GblAdapterLib {

PUBLISH_SOURCE_HR_tree_factory::PUBLISH_SOURCE_HR_tree_factory () {
}

void PUBLISH_SOURCE_HR_tree_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	NodeBaseFactoryManager::register_factory (this, priority);
}

const char* PUBLISH_SOURCE_HR_tree_factory::key () const {
	return AT_PUBLISH_SOURCE_HR;
}

NodeBase* PUBLISH_SOURCE_HR_tree_factory::make () /*throw (CanNotFindData)*/ {
	//#UC START# *45EEB95901C54DB15B5B00A5_45F6694A01B5_IMPL*
	return make_filtered_tree_and_root (this->key ());
	//#UC END# *45EEB95901C54DB15B5B00A5_45F6694A01B5_IMPL*
}

NodeBase* PUBLISH_SOURCE_HR_tree_factory::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) {
	//#UC START# *45EEB95901C54DB15B5B00A5_45FFF849002E_IMPL*
	GDS_ASSERT (false);
	return 0; 
	//#UC END# *45EEB95901C54DB15B5B00A5_45FFF849002E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

