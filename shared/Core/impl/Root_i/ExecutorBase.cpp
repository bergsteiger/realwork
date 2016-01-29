////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/Root_i/ExecutorBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::Root_i::ExecutorBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/LibHome.h"
#include "shared/Core/impl/Root_i/ExecutorBase.h"

namespace Core {
namespace Root_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ExecutorBase::ExecutorBase () : m_current_status (Root::ES_EXECUTABLE)
//#UC START# *457EA7260163_45804B19003E_457EA8370328_BASE_INIT*
//#UC END# *457EA7260163_45804B19003E_457EA8370328_BASE_INIT*
{
	//#UC START# *457EA7260163_45804B19003E_457EA8370328_BODY*
	//#UC END# *457EA7260163_45804B19003E_457EA8370328_BODY*
}

ExecutorBase::~ExecutorBase () {
	//#UC START# *457EA8370328_DESTR_BODY*
	//#UC END# *457EA8370328_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// устанавливает статус
void ExecutorBase::set_current_status (Root::ExecutorStatus current_status) {
	//#UC START# *47C4F1320307*
	GUARD(m_guard);
	m_current_status = current_status;
	//#UC END# *47C4F1320307*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Root::Executor
// текущий статус исполнителя
Root::ExecutorStatus ExecutorBase::get_current_status () const {
	//#UC START# *45803B2501E4_457EA8370328_GET*
	GUARD(m_guard);
	return m_current_status;
	//#UC END# *45803B2501E4_457EA8370328_GET*
}

// implemented method from Root::Executor
// поток выполнения бизнес логики исполнителя, вызывается фреймворком
void ExecutorBase::execute_ () {
	//#UC START# *457EA76E01FF_457EA8370328*
	this->set_current_status (Root::ES_FINISHED);
	//#UC END# *457EA76E01FF_457EA8370328*
}
} // namespace Root_i
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

