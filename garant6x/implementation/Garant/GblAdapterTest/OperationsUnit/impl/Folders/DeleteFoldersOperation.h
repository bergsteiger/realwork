////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Folders/DeleteFoldersOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Folders::DeleteFoldersOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_FOLDERS_DELETEFOLDERSOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_FOLDERS_DELETEFOLDERSOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Base/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B2B3200FA_CUSTOM_INCLUDES*
//#UC END# *445B2B3200FA_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Folders {

class DeleteFoldersOperation; // self forward Var
typedef ::Core::Var<DeleteFoldersOperation> DeleteFoldersOperation_var;

class DeleteFoldersOperation:
	virtual public Base::OperationBase
{
	SET_OBJECT_COUNTER (DeleteFoldersOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~DeleteFoldersOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B2B3200FA*
//#UC END# *445B2B3200FA*
}; // class DeleteFoldersOperation

} // namespace Folders
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_FOLDERS_DELETEFOLDERSOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////