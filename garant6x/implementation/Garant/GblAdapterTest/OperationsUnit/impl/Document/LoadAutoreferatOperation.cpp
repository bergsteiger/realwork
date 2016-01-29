////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/LoadAutoreferatOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::LoadAutoreferatOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/LoadAutoreferatOperation.h"

//#UC START# *445B393601F4_CUSTOM_INCLUDES*
#include "Garant/GblAdapterTest/Common/autotest.h"
//#UC END# *445B393601F4_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

//#UC START# *445B393601F4*
//#UC END# *445B393601F4*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

LoadAutoreferatOperation::~LoadAutoreferatOperation () {
	//#UC START# *445B393601F4_DESTR_BODY*
	//#UC END# *445B393601F4_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void LoadAutoreferatOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B393601F4*	
	const const GblAdapter::ICommon* common_interface = param->common_interface ();
	long monitoring_idx = get_random (
		0, DocumentHelper::get_count_monitoring (common_interface) - 1
	);		
	long period_idx = get_random (
		0
		, DocumentHelper::get_count_period (
			common_interface, monitoring_idx
		) - 1
	);
	GblAdapter::IDocument_var annotation_doc;
	DocumentHelper::get_autoreferat (
		common_interface
		, annotation_doc.out ()
		, monitoring_idx
		, period_idx
	);				
	
	DocumentHelper::load_doc<GblAdapterTest::CommonNodeOperation::NodeBaseIter> (annotation_doc.in ());

	this->execute_child_operations (param);
	//#UC END# *445B049B003E_445B393601F4*
}

} // namespace Document
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////