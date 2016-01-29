////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/DLLInit/DoneAdapterOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::DLLInit::DoneAdapterOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/DLLInit/DoneAdapterOperation.h"

//#UC START# *445B3CA50128_CUSTOM_INCLUDES*
#include "Garant/GblAdapterTest/Common/autotest.h"
//#UC END# *445B3CA50128_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace DLLInit {

//#UC START# *445B3CA50128*
//#UC END# *445B3CA50128*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DoneAdapterOperation::~DoneAdapterOperation () {
	//#UC START# *445B3CA50128_DESTR_BODY*
	//#UC END# *445B3CA50128_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void DoneAdapterOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B3CA50128*
	AutoAdapterInitSingl::close ();
	this->execute_child_operations (param);
	//#UC END# *445B049B003E_445B3CA50128*
}

} // namespace DLLInit
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////