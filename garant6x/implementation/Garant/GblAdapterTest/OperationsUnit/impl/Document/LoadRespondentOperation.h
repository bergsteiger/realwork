////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/LoadRespondentOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::LoadRespondentOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_DOCUMENT_LOADRESPONDENTOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_DOCUMENT_LOADRESPONDENTOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B3A6D0109_CUSTOM_INCLUDES*
//#UC END# *445B3A6D0109_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

class LoadRespondentOperation; // self forward Var
typedef ::Core::Var<LoadRespondentOperation> LoadRespondentOperation_var;

class LoadRespondentOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (LoadRespondentOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~LoadRespondentOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B3A6D0109*
//#UC END# *445B3A6D0109*
}; // class LoadRespondentOperation

} // namespace Document
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_DOCUMENT_LOADRESPONDENTOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////