////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/DocumentContextSearchOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::DocumentContextSearchOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/DocumentContextSearchOperation.h"

//#UC START# *44630E3E009C_CUSTOM_INCLUDES*
//#UC END# *44630E3E009C_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

//#UC START# *44630E3E009C*
//#UC END# *44630E3E009C*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DocumentContextSearchOperation::~DocumentContextSearchOperation () {
	//#UC START# *44630E3E009C_DESTR_BODY*
	//#UC END# *44630E3E009C_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void DocumentContextSearchOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_44630E3E009C*
	if (!operation_param_in->m_document.is_nil ()) {
		OperationInterfaces::IAttributeManager_var attributes;
		this->get_attribute_manager (attributes.out ());
		std::string filter_text = attributes->get_string ("context");

		std::string search_position = attributes->get_string ("search_position");
		GblAdapter::ContextPlace pos;
		if (stricmp (search_position.c_str (), "CP_ANY") == 0) {
			pos = GblAdapter::CP_ANY;
		} else if (stricmp (search_position.c_str (), "CP_BEGIN_OF_WORD") == 0) {
			pos = GblAdapter::CP_BEGIN_OF_WORD;
		} else if (stricmp (search_position.c_str (), "CP_BEGIN_OF_PHRASE") == 0) {
			pos = GblAdapter::CP_BEGIN_OF_PHRASE;
		} else if (stricmp (search_position.c_str (), "CP_WHOLE_WORD") == 0) {
			pos = GblAdapter::CP_WHOLE_WORD;
		}
		GblAdapter::INodeBase_var root;
		GblAdapter::IFilterFactory_var filter_factory;
		param->document()->get_tag_structure_root (root.out ());
		root->get_filter_factory (filter_factory.out ());
		
		GblAdapter::IContextFilter_var context_filter;
		filter_factory->get_context_filter (context_filter.out ());			
					
		context_filter->set_context (filter_text.c_str ());
		context_filter->set_order (GblAdapter::FO_ANY);
		context_filter->set_area (GblAdapter::SA_ALL_LEVEL);
		context_filter->set_place (pos);
		
		GblAdapter::IFilterList_var filter_list;
		filter_list = GblAdapter::FilterList_i::make_interface (1);		
		filter_list->get_data_ptr (0)->filter = context_filter._sretn ();	
		
		GblAdapter::IFindIterator_var find_iterator;
		GblAdapter::INodeBase_var first_child;
		root->get_first_child (first_child.out ());

		GblAdapter::NodePosition position;
		position.pos = 0;
		position.node = first_child._sretn ();
		root->find (filter_list.in (), position, find_iterator.out ());

		while (find_iterator->is_good ()) {
			GblAdapter::IFindPositionList_var position_list;
			find_iterator->get_position (position_list.out ());
			for (long index = 0; index < position_list->get_count (); index++) {
				GblAdapter::FindPosition* find_position = position_list->get_data_ptr (index);					
			}
			find_iterator->next ();
		}
		this->execute_child_operations (param);
	}
	//#UC END# *445B049B003E_44630E3E009C*
}

} // namespace Document
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////