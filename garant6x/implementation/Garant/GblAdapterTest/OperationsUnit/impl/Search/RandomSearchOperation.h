////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Search/RandomSearchOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Search::RandomSearchOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_SEARCH_RANDOMSEARCHOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_SEARCH_RANDOMSEARCHOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Base/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B2AAF02FD_CUSTOM_INCLUDES*
//#UC END# *445B2AAF02FD_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Search {

class RandomSearchOperation; // self forward Var
typedef ::Core::Var<RandomSearchOperation> RandomSearchOperation_var;

class RandomSearchOperation:
	virtual public Base::OperationBase
{
	SET_OBJECT_COUNTER (RandomSearchOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~RandomSearchOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B2AAF02FD*
//#UC END# *445B2AAF02FD*
}; // class RandomSearchOperation

} // namespace Search
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_SEARCH_RANDOMSEARCHOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////