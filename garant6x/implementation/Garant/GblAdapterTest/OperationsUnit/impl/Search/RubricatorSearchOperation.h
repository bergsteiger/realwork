////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Search/RubricatorSearchOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Search::RubricatorSearchOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_SEARCH_RUBRICATORSEARCHOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_SEARCH_RUBRICATORSEARCHOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Base/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B271D01E4_CUSTOM_INCLUDES*
//#UC END# *445B271D01E4_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Search {

class RubricatorSearchOperation; // self forward Var
typedef ::Core::Var<RubricatorSearchOperation> RubricatorSearchOperation_var;

class RubricatorSearchOperation:
	virtual public Base::OperationBase
{
	SET_OBJECT_COUNTER (RubricatorSearchOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~RubricatorSearchOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B271D01E4*
//#UC END# *445B271D01E4*
}; // class RubricatorSearchOperation

} // namespace Search
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_SEARCH_RUBRICATORSEARCHOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////