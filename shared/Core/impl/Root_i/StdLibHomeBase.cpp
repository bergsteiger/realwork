////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/Root_i/StdLibHomeBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::Root_i::StdLibHomeBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/LibHome.h"
#include "shared/Core/impl/Root_i/StdLibHomeBase.h"
// by <<uses>> dependencies
#include "shared/Core/Params/Params.h"

namespace Core {
namespace Root_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StdLibHomeBase::StdLibHomeBase () : m_requested_status (Root::ES_EXECUTABLE)
//#UC START# *457EA17B0069_EMPTY_CTOR_457EA17B0069_BASE_INIT*
//#UC END# *457EA17B0069_EMPTY_CTOR_457EA17B0069_BASE_INIT*
{
	//#UC START# *457EA17B0069_EMPTY_CTOR_457EA17B0069_BODY*
	//#UC END# *457EA17B0069_EMPTY_CTOR_457EA17B0069_BODY*
}

StdLibHomeBase::~StdLibHomeBase () {
	//#UC START# *457EA17B0069_DESTR_BODY*
	//#UC END# *457EA17B0069_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвращает список зарегестированных executor'ов
StdLibHomeBase::Executors& StdLibHomeBase::get_executors () {
	//#UC START# *47C4ECAD0105*
	return m_executors;
	//#UC END# *47C4ECAD0105*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

Root::ExecutorStatus StdLibHomeBase::get_requested_status () const {
	//#UC START# *45E42660036E_GET_ACCESSOR*
	return m_requested_status;
	//#UC END# *45E42660036E_GET_ACCESSOR*
}

void StdLibHomeBase::set_requested_status (Root::ExecutorStatus requested_status) {
	//#UC START# *45E42660036E_SET_ACCESSOR*
	m_requested_status = requested_status;
	//#UC END# *45E42660036E_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Root::LibHome
// Текущий агригированный статус всех исполнителей библиотеки
Root::ExecutorStatus StdLibHomeBase::get_executors_status () const {
	//#UC START# *45802CFB01C5_457EA17B0069_GET*
	bool has_executable = false;
	bool has_idle = false;
	
	switch (m_requested_status) {
	case Root::ES_ERROR:
	case Root::ES_EXIT_REQUESTED:
		return m_requested_status;
	case Root::ES_IDLE:
		has_idle = true;
		break;
	}
	
	for (Executors::const_iterator it = m_executors.begin (); it != m_executors.end (); ++it) {
		Root::ExecutorStatus es = (*it)->get_current_status ();
		switch (es) {
		case Root::ES_ERROR:
		case Root::ES_EXIT_REQUESTED:
			return es;
		case Root::ES_EXECUTABLE:
			has_executable = true;
			break;
		case Root::ES_IDLE:
			has_idle = true;
			break;
		case Root::ES_FINISHED:
			break;
		default:
			GDS_ASSERT (0);
		}
	}
    	
	return has_executable ? Root::ES_EXECUTABLE : has_idle ? Root::ES_IDLE : Root::ES_FINISHED;
	//#UC END# *45802CFB01C5_457EA17B0069_GET*
}

// implemented method from Root::LibHome
// Запрашивает приложение о выходе
void StdLibHomeBase::exit_request () {
	//#UC START# *45E4262E03CD_457EA17B0069*
	m_requested_status = Root::ES_EXIT_REQUESTED;
	LOG_D (("StdLibHomeBase[%d]::exit_request(%d)", this, m_requested_status));
	//#UC END# *45E4262E03CD_457EA17B0069*
}

// implemented method from LibHomeLocal
// проверяет параметры библиотеки (наличие обязательных параметров)
bool StdLibHomeBase::check_params () const {
	//#UC START# *492FEBEF03D1_457EA17B0069*
	return true;
	//#UC END# *492FEBEF03D1_457EA17B0069*
}

// implemented method from LibHomeLocal
// вызвается фремворком для запсука всех исполнителей связанных с библиотекой
void StdLibHomeBase::execute () /*throw (Root::InvalidParams, Root::HomeManagerInitError)*/ {
	//#UC START# *492FEBE100ED_457EA17B0069*
	for (Executors::iterator it = m_executors.begin(); it != m_executors.end(); ++it) {
		(*it)->execute ();
	}
	//#UC END# *492FEBE100ED_457EA17B0069*
}

// implemented method from LibHomeLocal
// вызывается фреймворком для освобождения всех ресурсов билиотеки и выполнения де-
// инициализационных действий, перед удалением билиотеки
void StdLibHomeBase::finalize () {
	//#UC START# *492FEBE902F5_457EA17B0069*
	//#UC END# *492FEBE902F5_457EA17B0069*
}

// implemented method from LibHomeLocal
// вызывается фремфорком для инициализаци библиотекти
void StdLibHomeBase::initialize () {
	//#UC START# *492FEBED00B2_457EA17B0069*
	//#UC END# *492FEBED00B2_457EA17B0069*
}

// implemented method from LibHomeLocal
// выводит описание параметров библиотеки в стандартный поток
void StdLibHomeBase::print_usage () const {
	//#UC START# *492FEBF4002E_457EA17B0069*
	//#UC END# *492FEBF4002E_457EA17B0069*
}
} // namespace Root_i
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

