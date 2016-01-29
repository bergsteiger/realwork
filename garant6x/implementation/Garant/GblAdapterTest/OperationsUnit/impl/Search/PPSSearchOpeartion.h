////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Search/PPSSearchOpeartion.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Search::PPSSearchOpeartion
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_SEARCH_PPSSEARCHOPEARTION_H__
#define __GARANT6X_OPERATIONSUNIT_SEARCH_PPSSEARCHOPEARTION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Base/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B271B0109_CUSTOM_INCLUDES*
//#UC END# *445B271B0109_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Search {

class PPSSearchOpeartion; // self forward Var
typedef ::Core::Var<PPSSearchOpeartion> PPSSearchOpeartion_var;

class PPSSearchOpeartion:
	virtual public Base::OperationBase
{
	SET_OBJECT_COUNTER (PPSSearchOpeartion)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~PPSSearchOpeartion ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B271B0109*
//#UC END# *445B271B0109*
}; // class PPSSearchOpeartion

} // namespace Search
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_SEARCH_PPSSEARCHOPEARTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////