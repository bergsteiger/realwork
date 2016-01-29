////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Tree/FilterTreeOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Tree::FilterTreeOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Tree/FilterTreeOperation.h"

//#UC START# *445B3A1703A9_CUSTOM_INCLUDES*
#include "Garant/GblAdapterTest/Common/autotest.h"
//#UC END# *445B3A1703A9_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Tree {

//#UC START# *445B3A1703A9*
//#UC END# *445B3A1703A9*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FilterTreeOperation::~FilterTreeOperation () {
	//#UC START# *445B3A1703A9_DESTR_BODY*
	//#UC END# *445B3A1703A9_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void FilterTreeOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B3A1703A9*
	if (param->common_interface ()) {
		
		OperationInterfaces::IAttributeManager_var attributes;
		this->get_attribute_manager (attributes.out ());
		std::string tree_tag = attributes->get_string ("tree_tag");			
		GblAdapter::AttributeTag tag = GblAdapter::AttributeTag (tree_tag.c_str ());
					
		std::string filter_text = attributes->get_string ("filter_text");		
		
		//wpAnyPathWord = 0// в любой части слова
		//wpAtBeginWord = 1// с начала слова
		//wpAtBeginString = 2// с начала строки

		TestTimeFilterTree<>::WordPosition word_position 
			= (TestTimeFilterTree<>::WordPosition)attributes->get_long ("word_position");
		
		//FO_SEQUENCE = 0 // 
		//FO_ANY = 1 // 
		GblAdapter::FindOrder find_order 
			= (GblAdapter::FindOrder)attributes->get_long ("find_order");
		
		//SA_ONE_LEVEL = 0// 
		//SA_ALL_LEVEL = 1// 
		GblAdapter::SearchArea search_area 
			= (GblAdapter::SearchArea)attributes->get_long ("search_area");

		TestTimeFilterTree<> tree_filter_test (
			tag
			, (GblAdapter::SimpleQuery)filter_text.c_str ()
			, word_position
			, find_order
			, search_area
			, param->user_login ()
			, param->user_password ()
		);

		Core::Aptr<TestResult> test_result;
		tree_filter_test.execute (test_result.out ());
	}
	this->execute_child_operations (param);
	//#UC END# *445B049B003E_445B3A1703A9*
}

} // namespace Tree
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////