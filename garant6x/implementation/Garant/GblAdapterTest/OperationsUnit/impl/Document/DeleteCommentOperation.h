////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/DeleteCommentOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::DeleteCommentOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_DOCUMENT_DELETECOMMENTOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_DOCUMENT_DELETECOMMENTOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B370300BB_CUSTOM_INCLUDES*
//#UC END# *445B370300BB_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

class DeleteCommentOperation; // self forward Var
typedef ::Core::Var<DeleteCommentOperation> DeleteCommentOperation_var;

class DeleteCommentOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (DeleteCommentOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~DeleteCommentOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B370300BB*
//#UC END# *445B370300BB*
}; // class DeleteCommentOperation

} // namespace Document
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_DOCUMENT_DELETECOMMENTOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////