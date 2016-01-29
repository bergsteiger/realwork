////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/SetBookmarkOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::SetBookmarkOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/SetBookmarkOperation.h"

//#UC START# *445B373A008C_CUSTOM_INCLUDES*
#include "Garant/GblAdapterTest/Common/BookmarksHelper.h"
//#UC END# *445B373A008C_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

//#UC START# *445B373A008C*
//#UC END# *445B373A008C*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetBookmarkOperation::~SetBookmarkOperation () {
	//#UC START# *445B373A008C_DESTR_BODY*
	//#UC END# *445B373A008C_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void SetBookmarkOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B373A008C*
	GblAdapter::IDocument* doc_from_list = param->document ();
		
	if (doc_from_list) {

		unsigned long doc_count_nodes = DocumentHelper::count_nodes (doc_from_list);
		GblAdapter::ParaId para_id = DocumentHelper::get_para_id (doc_from_list, get_random (0, doc_count_nodes));

		GblAdapter::IBookmark_var bookmark;
		doc_from_list->create_bookmark (para_id, true, bookmark.out ());
					
		GblAdapter::INode_var my_doc;				
		FolderHelper::get_my_doc_folder (param->common_interface (), my_doc.out ());
					
		OperationInterfaces::IAttributeManager_var attributes;
		this->get_attribute_manager (attributes.out ());
		std::string bookmark_name  = attributes->get_string ("bookmark_name");
		if (bookmark_name != std::string ("")) {
			GblAdapterTest::BookmarksHelper::save_bookmark_to_folder (
				my_doc.in ()
				, bookmark.in ()
				, bookmark_name.c_str ()
				, bookmark_name.c_str ()
			);
		} else {
			LOG_E (("Attribute [""bookmark_name""] wasn't find"));
		}
	}
	this->execute_child_operations (param);	
	//#UC END# *445B049B003E_445B373A008C*
}

} // namespace Document
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////