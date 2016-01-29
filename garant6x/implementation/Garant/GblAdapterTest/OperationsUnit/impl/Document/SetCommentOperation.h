////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/SetCommentOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::SetCommentOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_DOCUMENT_SETCOMMENTOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_DOCUMENT_SETCOMMENTOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B36A3037A_CUSTOM_INCLUDES*
//#UC END# *445B36A3037A_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

class SetCommentOperation; // self forward Var
typedef ::Core::Var<SetCommentOperation> SetCommentOperation_var;

class SetCommentOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (SetCommentOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~SetCommentOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B36A3037A*
//#UC END# *445B36A3037A*
}; // class SetCommentOperation

} // namespace Document
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_DOCUMENT_SETCOMMENTOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////