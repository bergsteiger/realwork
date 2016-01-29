////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/DeleteBookmarkOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::DeleteBookmarkOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_DOCUMENT_DELETEBOOKMARKOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_DOCUMENT_DELETEBOOKMARKOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B37D40109_CUSTOM_INCLUDES*
//#UC END# *445B37D40109_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

class DeleteBookmarkOperation; // self forward Var
typedef ::Core::Var<DeleteBookmarkOperation> DeleteBookmarkOperation_var;

class DeleteBookmarkOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (DeleteBookmarkOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~DeleteBookmarkOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B37D40109*
//#UC END# *445B37D40109*
}; // class DeleteBookmarkOperation

} // namespace Document
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_DOCUMENT_DELETEBOOKMARKOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////