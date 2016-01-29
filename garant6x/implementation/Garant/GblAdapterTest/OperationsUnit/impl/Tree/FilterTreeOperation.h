////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Tree/FilterTreeOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Tree::FilterTreeOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_TREE_FILTERTREEOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_TREE_FILTERTREEOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B3A1703A9_CUSTOM_INCLUDES*
//#UC END# *445B3A1703A9_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Tree {

class FilterTreeOperation; // self forward Var
typedef ::Core::Var<FilterTreeOperation> FilterTreeOperation_var;

class FilterTreeOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (FilterTreeOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~FilterTreeOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B3A1703A9*
//#UC END# *445B3A1703A9*
}; // class FilterTreeOperation

} // namespace Tree
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_TREE_FILTERTREEOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////