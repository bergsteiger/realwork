////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/SetBookmarkOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::SetBookmarkOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_DOCUMENT_SETBOOKMARKOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_DOCUMENT_SETBOOKMARKOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B373A008C_CUSTOM_INCLUDES*
//#UC END# *445B373A008C_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

class SetBookmarkOperation; // self forward Var
typedef ::Core::Var<SetBookmarkOperation> SetBookmarkOperation_var;

class SetBookmarkOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (SetBookmarkOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~SetBookmarkOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B373A008C*
//#UC END# *445B373A008C*
}; // class SetBookmarkOperation

} // namespace Document
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_DOCUMENT_SETBOOKMARKOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////