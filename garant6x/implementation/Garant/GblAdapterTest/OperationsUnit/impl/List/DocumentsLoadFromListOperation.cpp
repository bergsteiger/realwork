////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/List/DocumentsLoadFromListOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::List::DocumentsLoadFromListOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/List/DocumentsLoadFromListOperation.h"

//#UC START# *445B3573032C_CUSTOM_INCLUDES*
#include "Garant/GblAdapterTest/Common/autotest.h"
//#UC END# *445B3573032C_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace List {

//#UC START# *445B3573032C*
//#UC END# *445B3573032C*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DocumentsLoadFromListOperation::~DocumentsLoadFromListOperation () {
	//#UC START# *445B3573032C_DESTR_BODY*
	//#UC END# *445B3573032C_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void DocumentsLoadFromListOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B3573032C*
	GblAdapter::IMonitoringList* monitoring_list 
		= dynamic_cast<GblAdapter::IMonitoringList*> (operation_param_in->m_list.in ());
	if (monitoring_list == 0) {			

		OperationInterfaces::IAttributeManager_var attributes;
		this->get_attribute_manager (attributes.out ());

		long load_document_from_list = attributes->get_long ("count");		
		const long count = (
			(load_document_from_list > 0)
			&& (param->document_in_list () > load_document_from_list)
		) ? load_document_from_list : param->document_in_list ();

		for (long i = 0; i < count; ++i) {
			GblAdapter::IDocument* document = 0;
			ListHelper::get_doc (
				param->list (), i, document
			);
			param->document (document);
			if (!param->document ()) {
				DocumentHelper::load_doc<GblAdapterTest::CommonNodeOperation::NodeBaseIter> (
					param->document ()
				);			
			}
			this->execute_child_operations (param);
		}			
	}
	//#UC END# *445B049B003E_445B3573032C*
}

} // namespace List
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////