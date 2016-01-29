////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Other/SleepOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Other::SleepOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_OTHER_SLEEPOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_OTHER_SLEEPOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *4461A3B5005D_CUSTOM_INCLUDES*
//#UC END# *4461A3B5005D_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Other {

class SleepOperation; // self forward Var
typedef ::Core::Var<SleepOperation> SleepOperation_var;

class SleepOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (SleepOperation)
	friend OperationInterfaces::IOperationFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
protected:

	static const char* ST_SLEEP_TIME;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~SleepOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *4461A3B5005D*
//#UC END# *4461A3B5005D*
}; // class SleepOperation

} // namespace Other
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_OTHER_SLEEPOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////