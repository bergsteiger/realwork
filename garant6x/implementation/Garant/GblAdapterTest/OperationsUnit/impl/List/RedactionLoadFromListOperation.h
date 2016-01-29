////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/List/RedactionLoadFromListOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::List::RedactionLoadFromListOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_LIST_REDACTIONLOADFROMLISTOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_LIST_REDACTIONLOADFROMLISTOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B360A0196_CUSTOM_INCLUDES*
//#UC END# *445B360A0196_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace List {

class RedactionLoadFromListOperation; // self forward Var
typedef ::Core::Var<RedactionLoadFromListOperation> RedactionLoadFromListOperation_var;

class RedactionLoadFromListOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (RedactionLoadFromListOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~RedactionLoadFromListOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B360A0196*
//#UC END# *445B360A0196*
}; // class RedactionLoadFromListOperation

} // namespace List
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_LIST_REDACTIONLOADFROMLISTOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////