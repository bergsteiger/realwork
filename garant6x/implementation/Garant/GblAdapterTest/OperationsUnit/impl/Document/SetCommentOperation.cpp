////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/SetCommentOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::SetCommentOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/SetCommentOperation.h"

//#UC START# *445B36A3037A_CUSTOM_INCLUDES*
#include "Garant/GblAdapterTest/Common/CommentsHelper.h"
//#UC END# *445B36A3037A_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

//#UC START# *445B36A3037A*
//#UC END# *445B36A3037A*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetCommentOperation::~SetCommentOperation () {
	//#UC START# *445B36A3037A_DESTR_BODY*
	//#UC END# *445B36A3037A_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void SetCommentOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B36A3037A*
	GblAdapter::IDocument* doc_from_list = param->document ();
		
	if (doc_from_list) {

		unsigned long doc_count_nodes = DocumentHelper::count_nodes (doc_from_list);
		unsigned long ordinal_number = get_random (0, doc_count_nodes);

							
		GblAdapter::INodeBase_var tag_root;		
		doc_from_list->get_tag_structure_root (tag_root.out ());
		
		GblAdapter::INodeBase_var node_for_comment_past;	
		DocumentHelper::get_node_for_comment_past (tag_root.in (), ordinal_number, node_for_comment_past.out ());

		GblAdapter::IDocTagNode* doc_node = dynamic_cast<GblAdapter::IDocTagNode*> (node_for_comment_past.in ());
				
		if (doc_node) {		
			OperationInterfaces::IAttributeManager_var attributes;
			this->get_attribute_manager (attributes.out ());
			std::string comment_text = attributes->get_string ("comment_text");
			if (comment_text != std::string ("")) {
				
				CommentsHelper::set_comment (doc_node, comment_text.c_str ());
			} else {
				LOG_E (("Attribute [""comment_text""] wasn't find"));
			}
		}
	}
	this->execute_child_operations (param);	
	//#UC END# *445B049B003E_445B36A3037A*
}

} // namespace Document
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////