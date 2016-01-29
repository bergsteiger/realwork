////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/List/RedactionLoadFromListOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::List::RedactionLoadFromListOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/List/RedactionLoadFromListOperation.h"

//#UC START# *445B360A0196_CUSTOM_INCLUDES*
#include "Garant/GblAdapterTest/Common/autotest.h"
//#UC END# *445B360A0196_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace List {

//#UC START# *445B360A0196*
//#UC END# *445B360A0196*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RedactionLoadFromListOperation::~RedactionLoadFromListOperation () {
	//#UC START# *445B360A0196_DESTR_BODY*
	//#UC END# *445B360A0196_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void RedactionLoadFromListOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B360A0196*
	const long idx = get_random (0, param->document_in_list ()) - 1;
	GblAdapter::IDocument_var doc_from_list;
	ListHelper::get_doc (param->list (), idx, doc_from_list.out ());

	GblAdapter::IDocument_var doc_redaction;
	long redaction_count = DocumentHelper::get_redaction_count (doc_from_list.in ());

	if (!doc_from_list.is_nil () && redaction_count > 0) {
		param->document (doc_from_list._sretn ());
		DocumentHelper::get_redaction (
			doc_from_list.in (), get_random (0, redaction_count -1), doc_redaction.out ()
		);
		if (!doc_from_list->is_same_view (doc_redaction.in ())) {			
			DocumentHelper::load_doc<GblAdapterTest::CommonNodeOperation::NodeBaseIter> (doc_redaction.in ());
		} else {
			LOG_D (("Document hasn't redaction"));
		}
	}
	//#UC END# *445B049B003E_445B360A0196*
}

} // namespace List
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////