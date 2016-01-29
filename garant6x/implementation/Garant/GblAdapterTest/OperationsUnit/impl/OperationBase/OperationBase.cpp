////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::OperationBase::OperationBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationBase.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B02F701F4_CUSTOM_INCLUDES*
#include "shared/Core/sys/assert.h"

static long get_random (long min, long max) {
	return ((ACE_OS::rand() % (long)(((max) + 1) - (min))) + (min));
}
//#UC END# *445B02F701F4_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace OperationBase {

//#UC START# *445B02F701F4*
//#UC END# *445B02F701F4*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// constructors and destructor

OperationBase::Initializer::~Initializer () {
	//#UC START# *445B03900157_DESTR_BODY*
	//#UC END# *445B03900157_DESTR_BODY*
}	


//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

bool OperationBase::need_exit (long min_operation_timeout, long max_operation_timeout, bool need_operation_sleep) {
	//#UC START# *4461F9FF01E4*
	if (ACE_Thread_Manager::instance ()->testcancel (ACE_Thread::self ()) != 0) {	
			return true;																		
	}																																																							
	if (need_operation_sleep) {													
		const long sleep_time = get_random (min_operation_timeout, max_operation_timeout);
		LOG_D (("Sleep [%d] seconds", sleep_time));											
		ACE_OS::sleep (sleep_time);															
	}	
	if (ACE_Thread_Manager::instance ()->testcancel (ACE_Thread::self ()) != 0) {	
		return true;																		
	}	
	return false;
	//#UC END# *4461F9FF01E4*
}

long OperationBase::build_random_data (char*& data, long min_size, long max_size) {
	//#UC START# *4462D6A101F4*
	ACE_OS::srand (time (0));		
	long size = get_random (min_size, max_size);	
	data = new char[size];
    for (long i = 0; i < size; ++i) {				
            char value = static_cast<char> (get_random (1, 255));
            data[i] = value;
    }
	return size;
	//#UC END# *4462D6A101F4*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

OperationBase::OperationBase ()
//#UC START# *445B02F701F4_BASE_INIT*
: m_child_operations (0)
//#UC END# *445B02F701F4_BASE_INIT*
{
	//#UC START# *445B02F701F4_BODY*
	
	//#UC END# *445B02F701F4_BODY*
}



OperationBase::~OperationBase () {
	//#UC START# *445B02F701F4_DESTR_BODY*
	//#UC END# *445B02F701F4_DESTR_BODY*
}	

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void OperationBase::execute_child_operations (OperationInterfaces::IOperationParam* param) {
	//#UC START# *4461F650033C*
	OperationList::iterator it = this->m_child_operations.begin ();
	long internal_operations_count = this->m_child_operations.size ();
	for (; it != this->m_child_operations.end (); ++it) {		
		if (
			OperationBase::need_exit (
				param->min_operation_timeout ()
				, param->max_operation_timeout ()
				, param->need_operation_sleep ()
			)
		) {
			return;
		}
		(*it)->execute (param);
	}	
	//#UC END# *4461F650033C*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IOperation
void OperationBase::add_operation (OperationInterfaces::IOperation* operation) {
	//#UC START# *4461F3E60242_445B02F701F4*
	this->m_child_operations.push_back (OperationList::value_type (operation));	
	//#UC END# *4461F3E60242_445B02F701F4*
}

// implemented method from IOperation
void OperationBase::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B02F701F4*
	this->execute_child_operations (param);
	//#UC END# *445B049B003E_445B02F701F4*
}

// implemented method from IOperation
void OperationBase::get_attribute_manager (OperationInterfaces::IAttributeManager*& attribute_manager) const {
	//#UC START# *44618B7F02BF_445B02F701F4*
	if (m_attribute_manager.is_nil ()) {
		m_attribute_manager = OperationInterfaces::IAttributeManagerFactory::create ();
	}
	GDS_ASSERT_MSG (!m_attribute_manager.is_nil (), "m_attribute_manager == NULL");
	attribute_manager = m_attribute_manager._sretn ();
	//#UC END# *44618B7F02BF_445B02F701F4*
}

// implemented method from IOperation
void OperationBase::set_attribute_manager (const OperationInterfaces::IAttributeManager* attribute_manager) {
	//#UC START# *44618B820280_445B02F701F4*
	m_attribute_manager = ::Core::IObject::_duplicate (attribute_manager);
	//#UC END# *44618B820280_445B02F701F4*
}
} // namespace OperationBase
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////