////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/LoadCorrespondentOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::LoadCorrespondentOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_DOCUMENT_LOADCORRESPONDENTOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_DOCUMENT_LOADCORRESPONDENTOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B3BD200CB_CUSTOM_INCLUDES*
//#UC END# *445B3BD200CB_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

class LoadCorrespondentOperation; // self forward Var
typedef ::Core::Var<LoadCorrespondentOperation> LoadCorrespondentOperation_var;

class LoadCorrespondentOperation:
	virtual public OperationBase
{
	SET_OBJECT_COUNTER (LoadCorrespondentOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~LoadCorrespondentOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B3BD200CB*
//#UC END# *445B3BD200CB*
}; // class LoadCorrespondentOperation

} // namespace Document
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_DOCUMENT_LOADCORRESPONDENTOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////