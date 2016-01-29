////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/Executor.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<LibExecutor::Class>> MDProcess::RosePackageLocking::LibSupport::Executor
//
// при старте сервера устанавливает обработчик Ctrl-C и загружает информацию о залочках из файла
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ROSEPACKAGELOCKING_LIBSUPPORT_EXECUTOR_H__
#define __MDPROCESS_ROSEPACKAGELOCKING_LIBSUPPORT_EXECUTOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/impl/Root_i/ExecutorBase.h"
namespace RosePackageLocking {

// при старте сервера устанавливает обработчик Ctrl-C и загружает информацию о залочках из файла

class Executor : virtual public Core::Root_i::ExecutorBase {
	SET_OBJECT_COUNTER (Executor)		

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods
private:
	REFCOUNT_SINGLETON(Executor)

public:
	static Executor& get () {
		return Singleton::instance();
	}		


private:
	static void handle_control (int sig);
	
	void execute_ ();	
	
	void finalize ();

}; // class Executor

} // namespace RosePackageLocking


#endif //__MDPROCESS_ROSEPACKAGELOCKING_LIBSUPPORT_EXECUTOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
