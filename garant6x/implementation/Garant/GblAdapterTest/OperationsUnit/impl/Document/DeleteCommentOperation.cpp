////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/DeleteCommentOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::DeleteCommentOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/DeleteCommentOperation.h"

//#UC START# *445B370300BB_CUSTOM_INCLUDES*
#include "Garant/GblAdapterTest/Common/CommentsHelper.h"
//#UC END# *445B370300BB_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

//#UC START# *445B370300BB*
//#UC END# *445B370300BB*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DeleteCommentOperation::~DeleteCommentOperation () {
	//#UC START# *445B370300BB_DESTR_BODY*
	//#UC END# *445B370300BB_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void DeleteCommentOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B370300BB*
	GblAdapter::IDocument* doc_from_list = param->document ();
		
	if (doc_from_list) {		
		GblAdapterTest::CommentsHelper::delete_all_comments (doc_from_list);			
	}

	this->execute_child_operations (param);
	//#UC END# *445B049B003E_445B370300BB*
}

} // namespace Document
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////