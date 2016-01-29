////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Autorization/LoginOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Autorization::LoginOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_AUTORIZATION_LOGINOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_AUTORIZATION_LOGINOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Base/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B1E6A0196_CUSTOM_INCLUDES*
//#UC END# *445B1E6A0196_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Autorization {

class LoginOperation; // self forward Var
typedef ::Core::Var<LoginOperation> LoginOperation_var;

class LoginOperation:
	virtual public Base::OperationBase
{
	SET_OBJECT_COUNTER (LoginOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~LoginOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B1E6A0196*
//#UC END# *445B1E6A0196*
}; // class LoginOperation

} // namespace Autorization
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_AUTORIZATION_LOGINOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////