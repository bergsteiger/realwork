////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Search/SendConsultationQueryOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Search::SendConsultationQueryOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_SEARCH_SENDCONSULTATIONQUERYOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_SEARCH_SENDCONSULTATIONQUERYOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B3CFB000F_CUSTOM_INCLUDES*
//#UC END# *445B3CFB000F_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Search {

class SendConsultationQueryOperation; // self forward Var
typedef ::Core::Var<SendConsultationQueryOperation> SendConsultationQueryOperation_var;

class SendConsultationQueryOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (SendConsultationQueryOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~SendConsultationQueryOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B3CFB000F*
//#UC END# *445B3CFB000F*
}; // class SendConsultationQueryOperation

} // namespace Search
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_SEARCH_SENDCONSULTATIONQUERYOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////