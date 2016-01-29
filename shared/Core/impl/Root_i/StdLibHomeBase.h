////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/Root_i/StdLibHomeBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::Root_i::StdLibHomeBase
// Заголовок реализации класса серванта для интерфеса LibHomeLocal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_ROOT_I_STDLIBHOMEBASE_H__
#define __SHARED_CORE_ROOT_I_STDLIBHOMEBASE_H__

#include "ace/ACE.h"
#include "shared/Core/data/unsorted_containers.h"
#include "shared/Core/Root/Root.h"
#include "shared/Core/impl/Root_i/Root_i.h"

namespace Core {
namespace Root_i {

class StdLibHomeBase; // self forward Var
typedef ::Core::Var<StdLibHomeBase> StdLibHomeBase_var;
typedef ::Core::Var<const StdLibHomeBase> StdLibHomeBase_cvar;

class StdLibHomeBase:
	virtual public LibHomeLocal
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (StdLibHomeBase)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
protected:
	// массив исполнителей
	typedef boost::unordered_set <Root::Executor*> Executors;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StdLibHomeBase ();

	virtual ~StdLibHomeBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// возвращает список зарегестированных executor'ов
	Executors& get_executors ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Executors m_executors;

	// Запрошенный (из вне) статус для передачи менеджеру
	Root::ExecutorStatus m_requested_status;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
protected:
	Root::ExecutorStatus get_requested_status () const;

	void set_requested_status (Root::ExecutorStatus requested_status);

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Root::LibHome
	// Текущий агригированный статус всех исполнителей библиотеки
	virtual Root::ExecutorStatus get_executors_status () const;

	// implemented method from Root::LibHome
	// Запрашивает приложение о выходе
	virtual void exit_request ();

	// implemented method from LibHomeLocal
	// проверяет параметры библиотеки (наличие обязательных параметров)
	virtual bool check_params () const;

	// implemented method from LibHomeLocal
	// вызвается фремворком для запсука всех исполнителей связанных с библиотекой
	virtual void execute () /*throw (Root::InvalidParams, Root::HomeManagerInitError)*/;

	// implemented method from LibHomeLocal
	// вызывается фреймворком для освобождения всех ресурсов билиотеки и выполнения де-
	// инициализационных действий, перед удалением билиотеки
	virtual void finalize ();

	// implemented method from LibHomeLocal
	// вызывается фремфорком для инициализаци библиотекти
	virtual void initialize ();

	// implemented method from LibHomeLocal
	// выводит описание параметров библиотеки в стандартный поток
	virtual void print_usage () const;
}; // class StdLibHomeBase

} // namespace Root_i
} // namespace Core


#endif //__SHARED_CORE_ROOT_I_STDLIBHOMEBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
