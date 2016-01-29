////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/LoadMonitoringOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::LoadMonitoringOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/LoadMonitoringOperation.h"

//#UC START# *445B38FB0138_CUSTOM_INCLUDES*
#include "Garant/GblAdapterTest/Common/autotest.h"
//#UC END# *445B38FB0138_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

//#UC START# *445B38FB0138*
//#UC END# *445B38FB0138*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

LoadMonitoringOperation::~LoadMonitoringOperation () {
	//#UC START# *445B38FB0138_DESTR_BODY*
	//#UC END# *445B38FB0138_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void LoadMonitoringOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B38FB0138*
	GblAdapter::IMonitoringList* monitoring_list 
		= dynamic_cast<GblAdapter::IMonitoringList*> (param->list ());
	if (monitoring_list != 0) {
		GblAdapter::IDocument_var doc_from_list;
		monitoring_list->get_summary(doc_from_list.out());			
		DocumentHelper::load_doc<GblAdapterTest::CommonNodeOperation::NodeBaseIter> (
			doc_from_list.in (), false
		);
	}
	this->execute_child_operations (param);
	//#UC END# *445B049B003E_445B38FB0138*
}

} // namespace Document
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////