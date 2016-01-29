////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/DocumentContextSearchOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::DocumentContextSearchOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_DOCUMENT_DOCUMENTCONTEXTSEARCHOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_DOCUMENT_DOCUMENTCONTEXTSEARCHOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *44630E3E009C_CUSTOM_INCLUDES*
//#UC END# *44630E3E009C_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

class DocumentContextSearchOperation; // self forward Var
typedef ::Core::Var<DocumentContextSearchOperation> DocumentContextSearchOperation_var;

class DocumentContextSearchOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (DocumentContextSearchOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~DocumentContextSearchOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *44630E3E009C*
//#UC END# *44630E3E009C*
}; // class DocumentContextSearchOperation

} // namespace Document
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_DOCUMENT_DOCUMENTCONTEXTSEARCHOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////