////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Tree/LoadTreeOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Tree::LoadTreeOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_TREE_LOADTREEOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_TREE_LOADTREEOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B3A000271_CUSTOM_INCLUDES*
//#UC END# *445B3A000271_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Tree {

class LoadTreeOperation; // self forward Var
typedef ::Core::Var<LoadTreeOperation> LoadTreeOperation_var;

class LoadTreeOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (LoadTreeOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~LoadTreeOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B3A000271*
//#UC END# *445B3A000271*
}; // class LoadTreeOperation

} // namespace Tree
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_TREE_LOADTREEOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////