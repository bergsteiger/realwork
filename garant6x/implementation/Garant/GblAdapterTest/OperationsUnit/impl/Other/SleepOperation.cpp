////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Other/SleepOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Other::SleepOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Other/SleepOperation.h"

//#UC START# *4461A3B5005D_CUSTOM_INCLUDES*
//#UC END# *4461A3B5005D_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Other {

//#UC START# *4461A3B5005D*
//#UC END# *4461A3B5005D*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
	const char* SleepOperation::ST_SLEEP_TIME = ""sleep_time"";

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SleepOperation::~SleepOperation () {
	//#UC START# *4461A3B5005D_DESTR_BODY*
	//#UC END# *4461A3B5005D_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void SleepOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_4461A3B5005D*
	OperationInterfaces::IAttributeManager_var attributes;
	this->get_attribute_manager (attributes.out ());

	long sleep_time = attributes->get_long (ST_SLEEP_TIME);
	ACE_OS::sleep (sleep_time);
	//#UC END# *445B049B003E_4461A3B5005D*
}

} // namespace Other
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////