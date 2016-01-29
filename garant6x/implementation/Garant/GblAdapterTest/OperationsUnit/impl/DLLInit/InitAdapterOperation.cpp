////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/DLLInit/InitAdapterOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::DLLInit::InitAdapterOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/DLLInit/InitAdapterOperation.h"

//#UC START# *445B3C81002E_CUSTOM_INCLUDES*
#include "Garant/GblAdapterTest/Common/autotest.h"
//#UC END# *445B3C81002E_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace DLLInit {

//#UC START# *445B3C81002E*
//#UC END# *445B3C81002E*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

InitAdapterOperation::~InitAdapterOperation () {
	//#UC START# *445B3C81002E_DESTR_BODY*
	//#UC END# *445B3C81002E_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void InitAdapterOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B3C81002E*
	AutoAdapterInitSingl::instance ();
	this->execute_child_operations (param);
	//#UC END# *445B049B003E_445B3C81002E*
}

} // namespace DLLInit
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////