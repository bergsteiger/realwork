////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/Root_i/StdLibHomeManager.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::Root_i::StdLibHomeManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/LibHome.h"
#include "shared/Core/impl/Root_i/StdLibHomeManager.h"

namespace Core {
namespace Root_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StdLibHomeManager::StdLibHomeManager ()
//#UC START# *457EA00F001B_457EA01F004A_457EA1410318_BASE_INIT*
//#UC END# *457EA00F001B_457EA01F004A_457EA1410318_BASE_INIT*
{
	//#UC START# *457EA00F001B_457EA01F004A_457EA1410318_BODY*
	this->registrate_lib_home (&Core::LibHomeFactory::get());
	//#UC END# *457EA00F001B_457EA01F004A_457EA1410318_BODY*
}

StdLibHomeManager::~StdLibHomeManager () {
	//#UC START# *457EA1410318_DESTR_BODY*
	//#UC END# *457EA1410318_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// for_all == false : Если хотябы одна компонента имеет статус status - то возвращатеся true, иначе
// false
// for_all == true : Если все компоненты имеют статус status - то возвращатеся true, иначе false
bool StdLibHomeManager::check_libs_status (Root::ExecutorStatus status, bool for_all) const {
	//#UC START# *45802D6B0290*
	for (LibHomes::const_iterator it = m_lib_homes.begin (); it != m_lib_homes.end (); ++it) {
		if ((*it)->get_executors_status () != status) {
			if (for_all) {
				return false;
			}
		} else {
			if (!for_all) {
				return true;
			}
		}
	}
		
	return for_all;
	//#UC END# *45802D6B0290*
}

// запуск на исполнение всех зарегестрированных домов библиотек
void StdLibHomeManager::execute_all_libhomes () /*throw (Root::InvalidParams, Root::HomeManagerInitError)*/ {
	//#UC START# *492FF0C60191*
	std::for_each (
		this->get_lib_homes().begin ()
		, this->get_lib_homes().end ()
		, std::mem_fun (&LibHomeLocal::execute)
	);
	//#UC END# *492FF0C60191*
}

// освободить ресурсы зарегистрированных библиотек (особождение осуществляется в порядке, обратном
// их регистрации!)
void StdLibHomeManager::finalize_all_libhomes () {
	//#UC START# *492FF02B0188*
	std::for_each (
		m_lib_homes.rbegin()
		, m_lib_homes.rend()
		, std::mem_fun (&LibHomeLocal::finalize)
	);
	//#UC END# *492FF02B0188*
}

// возвращает множество зарегестированных домов библиотек
StdLibHomeManager::LibHomes& StdLibHomeManager::get_lib_homes () {
	//#UC START# *47C4EC5701D2*
	return m_lib_homes;
	//#UC END# *47C4EC5701D2*
}

// инициализировать все зарегестрированные дома библиотек
void StdLibHomeManager::initialize_all_libhomes () {
	//#UC START# *492FF0A502BA*
	std::for_each (
		this->get_lib_homes().begin ()
		, this->get_lib_homes().end ()
		, std::mem_fun (&LibHomeLocal::initialize)
	);
	//#UC END# *492FF0A502BA*
}

// зарагистрировать все фабрики всех домов библиотек
void StdLibHomeManager::registrate_all_factories () {
	//#UC START# *492FF07D00AC*
	std::for_each (
		this->get_lib_homes().begin ()
		, this->get_lib_homes().end ()
		, std::mem_fun (&LibHomeLocal::registrate_all_factories)
	);
	//#UC END# *492FF07D00AC*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Root::LibHomeManager
// для каждого зарегистрированного дома библиотеки выполняет проверку параметров, возвращает true,
// если все проверки прошли успешно.
bool StdLibHomeManager::check_params () const {
	//#UC START# *492A891A014B_457EA1410318*
	bool res = true;
	for (LibHomes::const_iterator it = m_lib_homes.begin (); it != m_lib_homes.end (); ++it) {
		res &= (*it)->check_params ();
	}

	return res;
	//#UC END# *492A891A014B_457EA1410318*
}

// implemented method from Root::LibHomeManager
// запуск фремворка на исполнение. Инициализирует все билиотеки и запускает их исполнителей.
void StdLibHomeManager::execute () /*throw (Root::InvalidParams, Root::HomeManagerInitError)*/ {
	//#UC START# *457EA04C00F5_457EA1410318*
	//регистрируем все фабрики
	this->registrate_all_factories ();
	
	//запускаем инициализацию
	this->initialize_all_libhomes ();

	//запускаем на выполнение
	this->execute_all_libhomes ();

	LOG_D (("StdLibHomeManager completly executed"));
	//#UC END# *457EA04C00F5_457EA1410318*
}

// implemented method from Root::LibHomeManager
// останавливает работу фреймворка и освобождает все занятые ресурсы (особождение ресоров
// зарегистрированных библиотек осуществляется в порядке, обратном их регистрации!)
void StdLibHomeManager::finalize () {
	//#UC START# *4580427A009C_457EA1410318*
	// send all working threads signal to exit
	Core::ThreadPoolFactory::def().cancel_all_threads ();
	
	// waiting for any other working threads from Core-pool
	Core::ThreadPoolFactory::def().wait_for_busy ();

	// completly shutdown pool
	Core::ThreadPoolFactory::def().shutdown_all_threads ();
	
	this->finalize_all_libhomes ();
	
	LOG_D (("StdLibHomeManager completly finalized"));
	//#UC END# *4580427A009C_457EA1410318*
}

// implemented method from Root::LibHomeManager
// Выполняет де-инициализацию текущего потока посредствам запуска зарегистрированных инициализаторов
void StdLibHomeManager::finalize_thread () const {
	//#UC START# *4623691200CB_457EA1410318*
	for (ThreadInitializers::iterator it = m_thread_initializers.begin(); it != m_thread_initializers.end(); ++it) {
		const_cast<Root::ThreadInitializer_var& >(*it)->thread_finalize ();
	}
	//#UC END# *4623691200CB_457EA1410318*
}

// implemented method from Root::LibHomeManager
// Выполняет инициализацию текущего потока посредствам запуска зарегистрированных инициализаторов
void StdLibHomeManager::init_thread () const {
	//#UC START# *462368A20186_457EA1410318*
	for (ThreadInitializers::iterator it = m_thread_initializers.begin(); it != m_thread_initializers.end(); ++it) {
		const_cast<Root::ThreadInitializer_var& >(*it)->thread_init ();
	}
	//#UC END# *462368A20186_457EA1410318*
}

// implemented method from Root::LibHomeManager
// выводит описание параметров для всех зарегистрированных домов библиотек
void StdLibHomeManager::print_usage () const {
	//#UC START# *492A7F310057_457EA1410318*
	std::for_each (
		m_lib_homes.begin ()
		, m_lib_homes.end ()
		, std::mem_fun (&LibHomeLocal::print_usage)
	);
	//#UC END# *492A7F310057_457EA1410318*
}

// implemented method from Root::LibHomeManager
// регистрирует билиотеку в менеджере
void StdLibHomeManager::registrate_lib_home (Root::LibHome* lib) {
	//#UC START# *457EA0D40338_457EA1410318*
	//список не должен содержать дубликатов
	LibHomeLocal* lib_local = dynamic_cast<LibHomeLocal*> (lib);
	if (
		lib_local 
		&& std::find (m_lib_homes.begin (), m_lib_homes.end (), lib_local) == m_lib_homes.end ()
	) {
		this->m_lib_homes.push_back (lib_local);
	}
	//#UC END# *457EA0D40338_457EA1410318*
}

// implemented method from Root::LibHomeManager
// регистрирует пользовательский инициализатор потока
void StdLibHomeManager::registrate_thread_initializer (Root::ThreadInitializer* ti) {
	//#UC START# *4623587101D4_457EA1410318*
	this->m_thread_initializers.insert (Root::ThreadInitializer::_duplicate(ti));
	//#UC END# *4623587101D4_457EA1410318*
}

// implemented method from Root::LibHomeManager
// ждет завершения всех исполнителей (и их дочерних потоков), возвращает 0, если работа была
// завершена без ошибок (ни один из исполнителей не выставил статус ES_ERROR)
int StdLibHomeManager::wait_all () const {
	//#UC START# *457EA05E0338_457EA1410318*
	int ret = 0;
	LOG_D (("Now waiting for any exit signals"));
	bool blocking = true;
    while (blocking) {
		if (this->check_libs_status(Root::ES_ERROR, false)) {
			LOG_E (("Some libs home has error status"));
			blocking = false;
			ret = -1;
		}

		if (this->check_libs_status(Root::ES_EXIT_REQUESTED, false)) {
			LOG_D (("Some libs home request for exit"));
			blocking = false;
		}

		if (this->check_libs_status(Root::ES_FINISHED, true)) {
			LOG_D (("All libs home was sucsessfull finished"));
			blocking = false;
		}

		ACE_OS::sleep (1);
	}

	return ret;
	//#UC END# *457EA05E0338_457EA1410318*
}
} // namespace Root_i
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

