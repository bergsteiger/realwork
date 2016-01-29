////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/List/ExtructLoadFromListOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::List::ExtructLoadFromListOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_LIST_EXTRUCTLOADFROMLISTOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_LIST_EXTRUCTLOADFROMLISTOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B35E602EE_CUSTOM_INCLUDES*
//#UC END# *445B35E602EE_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace List {

class ExtructLoadFromListOperation; // self forward Var
typedef ::Core::Var<ExtructLoadFromListOperation> ExtructLoadFromListOperation_var;

class ExtructLoadFromListOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (ExtructLoadFromListOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~ExtructLoadFromListOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B35E602EE*
//#UC END# *445B35E602EE*
}; // class ExtructLoadFromListOperation

} // namespace List
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_LIST_EXTRUCTLOADFROMLISTOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////