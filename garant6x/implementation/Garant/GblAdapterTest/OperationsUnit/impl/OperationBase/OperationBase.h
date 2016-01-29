////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::OperationBase::OperationBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_OPERATIONBASE_OPERATIONBASE_H__
#define __GARANT6X_OPERATIONSUNIT_OPERATIONBASE_OPERATIONBASE_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfaces.h"

//#UC START# *445B02F701F4_CUSTOM_INCLUDES*
#include <list>

static long get_random (long min, long max);
//#UC END# *445B02F701F4_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace OperationBase {

class OperationBase; // self forward Var
typedef ::Core::Var<OperationBase> OperationBase_var;

class OperationBase:
	virtual public OperationInterfaces::IOperation
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (OperationBase)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
protected:

	class Initializer {
		SET_OBJECT_COUNTER (Initializer)
	//#UC START# *445B03900157*
	//#UC END# *445B03900157*
	public:
	// constructors and destructors
		virtual ~Initializer ();

	// self methods

	}; // class Initializer

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods
public:
	static bool need_exit (long min_operation_timeout, long max_operation_timeout, bool need_operation_sleep);

	static long build_random_data (char*& data, long min_size, long max_size);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	
	OperationBase ();
	virtual ~OperationBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:

	virtual void execute_child_operations (OperationInterfaces::IOperationParam* param);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	::Core::Var<OperationInterfaces::IAttributeManager> m_attribute_manager;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from IOperation
	virtual void add_operation (OperationInterfaces::IOperation* operation);

	// implemented method from IOperation
	virtual void execute (OperationInterfaces::IOperationParam* param);

	// implemented method from IOperation
	virtual void get_attribute_manager (OperationInterfaces::IAttributeManager*& attribute_manager) const;

	// implemented method from IOperation
	virtual void set_attribute_manager (const OperationInterfaces::IAttributeManager* attribute_manager);

//#UC START# *445B02F701F4*
private:
	typedef std::list<OperationInterfaces::IOperation_var> OperationList;
	OperationList m_child_operations;
//#UC END# *445B02F701F4*
}; // class OperationBase

} // namespace OperationBase
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_OPERATIONBASE_OPERATIONBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////