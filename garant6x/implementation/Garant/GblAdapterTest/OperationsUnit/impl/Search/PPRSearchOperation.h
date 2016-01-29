////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Search/PPRSearchOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Search::PPRSearchOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_SEARCH_PPRSEARCHOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_SEARCH_PPRSEARCHOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Base/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B211E0000_CUSTOM_INCLUDES*
//#UC END# *445B211E0000_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Search {

class PPRSearchOperation; // self forward Var
typedef ::Core::Var<PPRSearchOperation> PPRSearchOperation_var;

class PPRSearchOperation:
	virtual public Base::OperationBase
{
	SET_OBJECT_COUNTER (PPRSearchOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~PPRSearchOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B211E0000*
//#UC END# *445B211E0000*
}; // class PPRSearchOperation

} // namespace Search
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_SEARCH_PPRSEARCHOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////