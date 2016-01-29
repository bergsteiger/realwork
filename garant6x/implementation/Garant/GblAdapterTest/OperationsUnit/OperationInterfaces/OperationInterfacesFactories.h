////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"
// C++ Interface Factories header files (.h)
// Generated from UML model, root element: <<Interface::Category>> garant6x::OperationsUnit::OperationInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_OPERATIONINTERFACES_FCTR_H__
#define __GARANT6X_OPERATIONSUNIT_OPERATIONINTERFACES_FCTR_H__

#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfaces.h"

namespace OperationsUnit {
namespace OperationInterfaces {

////////////////////////////////////////////////////////////////////////////////////
// factory class for IOperationParam

class IOperationParamFactory {
public:
	static IOperationParam* create ();
};


////////////////////////////////////////////////////////////////////////////////////
// factory class for IAttributeManager

class IAttributeManagerFactory {
public:
	static IAttributeManager* create ();
};


////////////////////////////////////////////////////////////////////////////////////
// factory class for IOperation

class IOperationFactory {
public:
	static IOperation* create (const char* operation_name);
};

} // namespace OperationInterfaces
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_OPERATIONINTERFACES_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////