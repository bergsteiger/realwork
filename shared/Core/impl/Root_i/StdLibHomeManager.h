////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/Root_i/StdLibHomeManager.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::Root_i::StdLibHomeManager
// Заголовок реализации класса серванта для интерфеса LibHomeManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_ROOT_I_STDLIBHOMEMANAGER_H__
#define __SHARED_CORE_ROOT_I_STDLIBHOMEMANAGER_H__

#include "ace/ACE.h"
#include <vector>
#include "shared/Core/data/unsorted_containers.h"
#include "shared/Core/Root/Root.h"
#include "shared/Core/impl/Root_i/Root_i.h"

namespace Core {
namespace Root_i {

class StdLibHomeManager; // self forward Var
typedef ::Core::Var<StdLibHomeManager> StdLibHomeManager_var;
typedef ::Core::Var<const StdLibHomeManager> StdLibHomeManager_cvar;

class StdLibHomeManager_factory;

class StdLibHomeManager:
	virtual public Root::LibHomeManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (StdLibHomeManager)
	friend class StdLibHomeManager_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
protected:
	// массив билиотек
	typedef std::vector < LibHomeLocal* > LibHomes;

private:
	// Массив инициализаторов потока
	typedef boost::unordered_set <Root::ThreadInitializer_var
		, Core::hash<Root::ThreadInitializer_var>
		, Core::equal_to<Root::ThreadInitializer_var> > ThreadInitializers;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StdLibHomeManager ();

	virtual ~StdLibHomeManager ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// for_all == false : Если хотябы одна компонента имеет статус status - то возвращатеся true,
	// иначе false
	// for_all == true : Если все компоненты имеют статус status - то возвращатеся true, иначе false
	virtual bool check_libs_status (Root::ExecutorStatus status, bool for_all) const;

	// запуск на исполнение всех зарегестрированных домов библиотек
	virtual void execute_all_libhomes () /*throw (Root::InvalidParams, Root::HomeManagerInitError)*/;

	// освободить ресурсы зарегистрированных библиотек (особождение осуществляется в порядке, обратном
	// их регистрации!)
	virtual void finalize_all_libhomes ();

	// возвращает множество зарегестированных домов библиотек
	LibHomes& get_lib_homes ();

	// инициализировать все зарегестрированные дома библиотек
	virtual void initialize_all_libhomes ();

	// зарагистрировать все фабрики всех домов библиотек
	virtual void registrate_all_factories ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	LibHomes m_lib_homes;

	mutable ThreadInitializers m_thread_initializers;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Root::LibHomeManager
	// для каждого зарегистрированного дома библиотеки выполняет проверку параметров, возвращает true,
	// если все проверки прошли успешно.
	virtual bool check_params () const;

	// implemented method from Root::LibHomeManager
	// запуск фремворка на исполнение. Инициализирует все билиотеки и запускает их исполнителей.
	virtual void execute () /*throw (Root::InvalidParams, Root::HomeManagerInitError)*/;

	// implemented method from Root::LibHomeManager
	// останавливает работу фреймворка и освобождает все занятые ресурсы (особождение ресоров
	// зарегистрированных библиотек осуществляется в порядке, обратном их регистрации!)
	virtual void finalize ();

	// implemented method from Root::LibHomeManager
	// Выполняет де-инициализацию текущего потока посредствам запуска зарегистрированных
	// инициализаторов
	virtual void finalize_thread () const;

	// implemented method from Root::LibHomeManager
	// Выполняет инициализацию текущего потока посредствам запуска зарегистрированных инициализаторов
	virtual void init_thread () const;

	// implemented method from Root::LibHomeManager
	// выводит описание параметров для всех зарегистрированных домов библиотек
	virtual void print_usage () const;

	// implemented method from Root::LibHomeManager
	// регистрирует билиотеку в менеджере
	virtual void registrate_lib_home (Root::LibHome* lib);

	// implemented method from Root::LibHomeManager
	// регистрирует пользовательский инициализатор потока
	virtual void registrate_thread_initializer (Root::ThreadInitializer* ti);

	// implemented method from Root::LibHomeManager
	// ждет завершения всех исполнителей (и их дочерних потоков), возвращает 0, если работа была
	// завершена без ошибок (ни один из исполнителей не выставил статус ES_ERROR)
	virtual int wait_all () const;
}; // class StdLibHomeManager

} // namespace Root_i
} // namespace Core


#endif //__SHARED_CORE_ROOT_I_STDLIBHOMEMANAGER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
