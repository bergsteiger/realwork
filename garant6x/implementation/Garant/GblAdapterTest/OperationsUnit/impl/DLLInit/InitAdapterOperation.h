////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/DLLInit/InitAdapterOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::DLLInit::InitAdapterOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_DLLINIT_INITADAPTEROPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_DLLINIT_INITADAPTEROPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B3C81002E_CUSTOM_INCLUDES*
//#UC END# *445B3C81002E_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace DLLInit {

class InitAdapterOperation; // self forward Var
typedef ::Core::Var<InitAdapterOperation> InitAdapterOperation_var;

class InitAdapterOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (InitAdapterOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~InitAdapterOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B3C81002E*
//#UC END# *445B3C81002E*
}; // class InitAdapterOperation

} // namespace DLLInit
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_DLLINIT_INITADAPTEROPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////