////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/DeleteBookmarkOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::DeleteBookmarkOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/DeleteBookmarkOperation.h"

//#UC START# *445B37D40109_CUSTOM_INCLUDES*
#include "Garant/GblAdapterTest/Common/BookmarksHelper.h"
//#UC END# *445B37D40109_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

//#UC START# *445B37D40109*
//#UC END# *445B37D40109*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DeleteBookmarkOperation::~DeleteBookmarkOperation () {
	//#UC START# *445B37D40109_DESTR_BODY*
	//#UC END# *445B37D40109_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void DeleteBookmarkOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B37D40109*
	GblAdapter::INode_var my_doc;				
	FolderHelper::get_my_doc_folder (param->common_interface (), my_doc.out ());
	
	OperationInterfaces::IAttributeManager_var attributes;
	this->get_attribute_manager (attributes.out ());
	std::string bookmark_name  = attributes->get_string ("bookmark_name");

	if (bookmark_name != std::string ("")) {			
		BookmarksHelper::delete_bookmark (my_doc.in (), bookmark_name.c_str ());
	} else {
		LOG_E (("Attribute [""bookmark_name""] wasn't find"));
	}	
	this->execute_child_operations (param);
	//#UC END# *445B049B003E_445B37D40109*
}

} // namespace Document
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////