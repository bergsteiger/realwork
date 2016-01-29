////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/LoadAutoreferatOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::LoadAutoreferatOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_DOCUMENT_LOADAUTOREFERATOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_DOCUMENT_LOADAUTOREFERATOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B393601F4_CUSTOM_INCLUDES*
//#UC END# *445B393601F4_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

class LoadAutoreferatOperation; // self forward Var
typedef ::Core::Var<LoadAutoreferatOperation> LoadAutoreferatOperation_var;

class LoadAutoreferatOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (LoadAutoreferatOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~LoadAutoreferatOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B393601F4*
//#UC END# *445B393601F4*
}; // class LoadAutoreferatOperation

} // namespace Document
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_DOCUMENT_LOADAUTOREFERATOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////