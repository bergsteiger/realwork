////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/List/DocumentsLoadFromListOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::List::DocumentsLoadFromListOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_LIST_DOCUMENTSLOADFROMLISTOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_LIST_DOCUMENTSLOADFROMLISTOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B3573032C_CUSTOM_INCLUDES*
//#UC END# *445B3573032C_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace List {

class DocumentsLoadFromListOperation; // self forward Var
typedef ::Core::Var<DocumentsLoadFromListOperation> DocumentsLoadFromListOperation_var;

class DocumentsLoadFromListOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (DocumentsLoadFromListOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~DocumentsLoadFromListOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B3573032C*
//#UC END# *445B3573032C*
}; // class DocumentsLoadFromListOperation

} // namespace List
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_LIST_DOCUMENTSLOADFROMLISTOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////