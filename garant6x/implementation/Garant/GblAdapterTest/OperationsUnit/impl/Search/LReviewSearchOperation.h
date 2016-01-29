////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Search/LReviewSearchOperation.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Search::LReviewSearchOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_SEARCH_LREVIEWSEARCHOPERATION_H__
#define __GARANT6X_OPERATIONSUNIT_SEARCH_LREVIEWSEARCHOPERATION_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Base/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B2A8B0399_CUSTOM_INCLUDES*
//#UC END# *445B2A8B0399_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Search {

class LReviewSearchOperation; // self forward Var
typedef ::Core::Var<LReviewSearchOperation> LReviewSearchOperation_var;

class LReviewSearchOperation:
	virtual public Base::OperationBase
{
	SET_OBJECT_COUNTER (LReviewSearchOperation)
	friend OperationInterfaces::IOperationFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~LReviewSearchOperation ();


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);


//#UC START# *445B2A8B0399*
//#UC END# *445B2A8B0399*
}; // class LReviewSearchOperation

} // namespace Search
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_SEARCH_LREVIEWSEARCHOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////