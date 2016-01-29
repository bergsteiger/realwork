////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/List/ExtructLoadFromListOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::List::ExtructLoadFromListOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/List/ExtructLoadFromListOperation.h"

//#UC START# *445B35E602EE_CUSTOM_INCLUDES*
#include "Garant/GblAdapterTest/Common/autotest.h"
//#UC END# *445B35E602EE_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace List {

//#UC START# *445B35E602EE*
//#UC END# *445B35E602EE*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ExtructLoadFromListOperation::~ExtructLoadFromListOperation () {
	//#UC START# *445B35E602EE_DESTR_BODY*
	//#UC END# *445B35E602EE_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void ExtructLoadFromListOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B35E602EE*
	GblAdapter::IDocument_var doc_from_list;
	const long idx = get_random (0, operation_param_in->document_in_list) - 1;
	ListHelper::get_doc (param->list (), idx, doc_from_list.out ());

	GblAdapter::IDocument_var doc_extruct;
	DocumentHelper::get_extruct (doc_from_list.in (), doc_extruct.out ());

	if (!doc_from_list.is_nil ()) {
		param->document (doc_from_list._sretn ());
		if (!doc_from_list->is_same_view (doc_extruct.in ())) {
			DocumentHelper::load_doc<GblAdapterTest::CommonNodeOperation::NodeBaseIter> (doc_extruct.in ());
		} else {
			LOG_D (("Document hasn't extruct"));
		}
	}
	this->execute_child_operations (param);
	//#UC END# *445B049B003E_445B35E602EE*
}

} // namespace List
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////