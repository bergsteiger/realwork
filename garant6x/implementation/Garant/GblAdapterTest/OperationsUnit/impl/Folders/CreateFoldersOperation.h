////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Folders/CreateFoldersOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Folders::CreateFoldersOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_FOLDERS_CREATEFOLDERSOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_FOLDERS_CREATEFOLDERSOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Base/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B2B210399_CUSTOM_INCLUDES*
//#UC END# *445B2B210399_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Folders {

class CreateFoldersOperation; // self forward Var
typedef ::Core::Var<CreateFoldersOperation> CreateFoldersOperation_var;

class CreateFoldersOperation:
	virtual public Base::OperationBase
{
	SET_OBJECT_COUNTER (CreateFoldersOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~CreateFoldersOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B2B210399*
//#UC END# *445B2B210399*
}; // class CreateFoldersOperation

} // namespace Folders
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_FOLDERS_CREATEFOLDERSOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////