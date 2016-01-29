////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Search/SendConsultationQueryOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Search::SendConsultationQueryOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Search/SendConsultationQueryOperation.h"

//#UC START# *445B3CFB000F_CUSTOM_INCLUDES*
//#UC END# *445B3CFB000F_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Search {

//#UC START# *445B3CFB000F*
//#UC END# *445B3CFB000F*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SendConsultationQueryOperation::~SendConsultationQueryOperation () {
	//#UC START# *445B3CFB000F_DESTR_BODY*
	//#UC END# *445B3CFB000F_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void SendConsultationQueryOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B3CFB000F*
	if (!operation_param_in->m_common_interface.is_nil ()) {
			
						
		GblAdapter::ISearch_var search;
		param->common_interface ()->get_search (search.out ());
		
		GblAdapter::IQuery_var query;
		search->create_query (GblAdapter::QT_HANDYCRAFT_CONSULT, query.out ());
		
		OperationInterfaces::IAttributeManager_var attributes;
		this->get_attribute_manager (attributes.out ());

		long max_packet_size = attributes->get_long ("max_packet_size", 1024*1024);
		long min_packet_size = attributes->get_long ("min_packet_size", 512);

		GblAdapter::IQueryContextAttribute_var context_attr;

		query->get_context_attribute (
			(GblAdapter::AttributeTag) "AT_CONSULTATION_TEXT", context_attr.out ()
		);

		//std::string consult_data;
		Core::Aptr<char> consult_data;
		long packet_size = OperationBase::build_random_data (consult_data.out (), min_packet_size, max_packet_size);

		context_attr->add_value (GblAdapter::QLO_OR, consult_data.in ());	
		{				
			Core::GDS::StopWatch sw ("Sent handycraft consult");
			query->send_query ();
			LOG_D (("Sent handycraft consult, packet size: %d", ACE_OS::strlen (consult_data.in ())));
			//LOG_D (("packet content: %s", consult_data.in ()));
		}		
		
		this->execute_child_operations (param);	
	}
	//#UC END# *445B049B003E_445B3CFB000F*
}

} // namespace Search
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////