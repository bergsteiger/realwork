////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/DLLInit/DoneAdapterOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::DLLInit::DoneAdapterOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_DLLINIT_DONEADAPTEROPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_DLLINIT_DONEADAPTEROPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B3CA50128_CUSTOM_INCLUDES*
//#UC END# *445B3CA50128_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace DLLInit {

class DoneAdapterOperation; // self forward Var
typedef ::Core::Var<DoneAdapterOperation> DoneAdapterOperation_var;

class DoneAdapterOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (DoneAdapterOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~DoneAdapterOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B3CA50128*
//#UC END# *445B3CA50128*
}; // class DoneAdapterOperation

} // namespace DLLInit
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_DLLINIT_DONEADAPTEROPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////