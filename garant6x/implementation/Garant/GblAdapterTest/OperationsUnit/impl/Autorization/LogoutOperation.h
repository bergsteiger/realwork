////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Autorization/LogoutOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Autorization::LogoutOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_AUTORIZATION_LOGOUTOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_AUTORIZATION_LOGOUTOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Base/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B1FE601E4_CUSTOM_INCLUDES*
//#UC END# *445B1FE601E4_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Autorization {

class LogoutOperation; // self forward Var
typedef ::Core::Var<LogoutOperation> LogoutOperation_var;

class LogoutOperation:
	virtual public Base::OperationBase
{
	SET_OBJECT_COUNTER (LogoutOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~LogoutOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B1FE601E4*
//#UC END# *445B1FE601E4*
}; // class LogoutOperation

} // namespace Autorization
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_AUTORIZATION_LOGOUTOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////