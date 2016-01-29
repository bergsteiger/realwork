////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Tree/LoadTreeOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Tree::LoadTreeOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Tree/LoadTreeOperation.h"

//#UC START# *445B3A000271_CUSTOM_INCLUDES*
#include "Garant/GblAdapterTest/Common/autotest.h"
//#UC END# *445B3A000271_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Tree {

//#UC START# *445B3A000271*
//#UC END# *445B3A000271*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

LoadTreeOperation::~LoadTreeOperation () {
	//#UC START# *445B3A000271_DESTR_BODY*
	//#UC END# *445B3A000271_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void LoadTreeOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B3A000271*
	if (param->m_common_interface ()) {
			
		GblAdapter::ISearch_var search;
		param->m_common_interface ()->get_search (search.out ());	
		
		

		OperationInterfaces::IAttributeManager_var attributes;
		this->get_attribute_manager (attributes.out ());

		std::string tree_tag = attributes->get_string ("tree_tag");			
				
		GblAdapter::AttributeTag tag = GblAdapter::AttributeTag (tree_tag.c_str ());

		GblAdapter::INodeBase_var tree;
		search->get_attribute_tree (tag, tree.out ());	

		long count_nodes = attributes->get_long ("count_nodes", -1);
		bool full_load = attributes->get_bool ("count_nodes", true);
		LoadTreeTestTime<> tree_load_test (tree.in (), full_load, count_nodes);
		Core::Aptr<TestResult> test_result;

		tree_load_test.execute (test_result.out ());
	}
	this->execute_child_operations (param);
	//#UC END# *445B049B003E_445B3A000271*
}

} // namespace Tree
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////