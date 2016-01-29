////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/LoadDocumentsByIDFromListOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::LoadDocumentsByIDFromListOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_DOCUMENT_LOADDOCUMENTSBYIDFROMLISTOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_DOCUMENT_LOADDOCUMENTSBYIDFROMLISTOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B399F002E_CUSTOM_INCLUDES*
//#UC END# *445B399F002E_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

class LoadDocumentsByIDFromListOperation; // self forward Var
typedef ::Core::Var<LoadDocumentsByIDFromListOperation> LoadDocumentsByIDFromListOperation_var;

class LoadDocumentsByIDFromListOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (LoadDocumentsByIDFromListOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~LoadDocumentsByIDFromListOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B399F002E*
//#UC END# *445B399F002E*
}; // class LoadDocumentsByIDFromListOperation

} // namespace Document
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_DOCUMENT_LOADDOCUMENTSBYIDFROMLISTOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////