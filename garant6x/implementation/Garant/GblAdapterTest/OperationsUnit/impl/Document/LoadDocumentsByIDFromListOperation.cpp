////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/LoadDocumentsByIDFromListOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::LoadDocumentsByIDFromListOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/LoadDocumentsByIDFromListOperation.h"

//#UC START# *445B399F002E_CUSTOM_INCLUDES*
#include "Garant/GblAdapterTest/Common/HelperFunctions.h"
#include "Garant/GblAdapterTest/Common/autotest.h"

//#UC END# *445B399F002E_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

//#UC START# *445B399F002E*
//#UC END# *445B399F002E*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

LoadDocumentsByIDFromListOperation::~LoadDocumentsByIDFromListOperation () {
	//#UC START# *445B399F002E_DESTR_BODY*
	//#UC END# *445B399F002E_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void LoadDocumentsByIDFromListOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B399F002E*
	if (param->common_interface ()) {
		OperationInterfaces::IAttributeManager_var attributes;
		this->get_attribute_manager (attributes.out ());

		std::string documents_list_str = attributes->get_string ("documents_list");
		std::list<long> documents_list;
		if (documents_list_str != std::string ("")) {
			string_to_list (documents_list_str, documents_list, ';');
		}

		for (
			std::list<long>::iterator list_it = documents_list.begin ()
			; list_it != documents_list.end ()
			; ++list_it
		) {			
			GblAdapter::IDocument_var document;
			DocumentHelper::get_doc_by_number (
				*list_it
				, param->common_interface ()
				, document.out ()
			);	
			param->document (document._sretn ());
			if (param->document ()) {
				DocumentHelper::load_doc<GblAdapterTest::CommonNodeOperation::NodeBaseIter> (
					param->document ()
				);			
			}
			this->execute_child_operations (param);
		}			
	}			
	//#UC END# *445B049B003E_445B399F002E*
}

} // namespace Document
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////