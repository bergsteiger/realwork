////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/List/LoadListOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::List::LoadListOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/List/LoadListOperation.h"

//#UC START# *445B352A02CE_CUSTOM_INCLUDES*
#include "Garant/GblAdapterTest/Common/autotest.h"
//#UC END# *445B352A02CE_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace List {

//#UC START# *445B352A02CE*
//#UC END# *445B352A02CE*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

LoadListOperation::~LoadListOperation () {
	//#UC START# *445B352A02CE_DESTR_BODY*
	//#UC END# *445B352A02CE_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void LoadListOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B352A02CE*
	long count = ListHelper::load_list (param->list ());
	param->document_in_list (count);
		
	this->execute_child_operations (param);	
	//#UC END# *445B049B003E_445B352A02CE*
}

} // namespace List
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////