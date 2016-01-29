////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/LoadMonitoringOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::LoadMonitoringOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_DOCUMENT_LOADMONITORINGOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_DOCUMENT_LOADMONITORINGOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B38FB0138_CUSTOM_INCLUDES*
//#UC END# *445B38FB0138_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

class LoadMonitoringOperation; // self forward Var
typedef ::Core::Var<LoadMonitoringOperation> LoadMonitoringOperation_var;

class LoadMonitoringOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (LoadMonitoringOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~LoadMonitoringOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B38FB0138*
//#UC END# *445B38FB0138*
}; // class LoadMonitoringOperation

} // namespace Document
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_DOCUMENT_LOADMONITORINGOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////