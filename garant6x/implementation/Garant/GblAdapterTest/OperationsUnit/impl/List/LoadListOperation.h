////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/List/LoadListOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::List::LoadListOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_LIST_LOADLISTOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_LIST_LOADLISTOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B352A02CE_CUSTOM_INCLUDES*
//#UC END# *445B352A02CE_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace List {

class LoadListOperation; // self forward Var
typedef ::Core::Var<LoadListOperation> LoadListOperation_var;

class LoadListOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (LoadListOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~LoadListOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B352A02CE*
//#UC END# *445B352A02CE*
}; // class LoadListOperation

} // namespace List
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_LIST_LOADLISTOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////